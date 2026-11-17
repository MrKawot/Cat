class_name CatArena
extends Node2D

const PlayerScript = preload("res://scripts/player.gd")
const EnemyScript = preload("res://scripts/enemy.gd")
const ControlsScript = preload("res://scripts/touch_controls.gd")
var player: CatPlayer
var enemies: Array[CatEnemy] = []
var controls: CatTouchControls
var hud: CanvasLayer
var health_bar: ProgressBar
var ultimate_bar: ProgressBar
var status_label: Label
var ultimate_button: Button
var dodge_button: Button
var message: Label
var overlay: PanelContainer
var overlay_title: Label
var overlay_body: Label
var resume_button: Button
var phase: String = "title"
var kills: int = 0
var pressure: float = 0.0
var elapsed: float = 0.0
var attack_held: bool = false
var reduced_effects: bool = false
var effects: Array[Dictionary] = []
var checkpoint: Label
var forest_fx: CatForestVisuals
var overlay_shade: ColorRect
var hero_portrait: TextureRect
var reticle: Node2D

func _ready() -> void:
	for center: Vector2 in [Vector2(-230,-150),Vector2(220,160)]:
		var obstacle: Node2D = Node2D.new()
		obstacle.set_script(preload("res://scripts/obstacle.gd"))
		obstacle.position = CatIso.project(center)
		obstacle.z_index = int(obstacle.position.y)
		add_child(obstacle)
	forest_fx = CatForestVisuals.new()
	forest_fx.z_index = 1800
	add_child(forest_fx)
	_build_ui()
	new_run()
	phase = "title"
	_show_overlay("CAT MORPH", "LES SEPT ÉVEILS\n\nUne forêt oubliée. Six esprits corrompus.\nUn gardien prêt à révéler sa vraie nature.\n\nCombattez, esquivez, puis libérez\nla puissance du Titan Félin.")

func new_run() -> void:
	if is_instance_valid(player):
		player.queue_free()
	for enemy: CatEnemy in enemies:
		enemy.queue_free()
	enemies.clear()
	effects.clear()
	player = PlayerScript.new()
	add_child(player)
	player.reduced_effects = reduced_effects
	player.died.connect(_on_defeat)
	player.struck.connect(func(_damage: float) -> void: _effect(player.world,"−13",Color("ff8b77")))
	for point: Vector2 in [Vector2(-320,-320),Vector2(-80,-350),Vector2(340,-240),Vector2(360,340),Vector2(-350,300),Vector2(-360,0)]:
		var enemy: CatEnemy = EnemyScript.new()
		enemy.world = point
		add_child(enemy)
		enemies.append(enemy)
	kills = 0
	elapsed = 0
	pressure = 0
	phase = "combat"
	attack_held = false
	controls.reset()
	overlay.hide()
	player.tick(0,Vector2.ZERO)
	_update_hud()

func _process(delta: float) -> void:
	forest_fx.reduced = reduced_effects or phase != "combat"
	if phase != "combat":
		return
	elapsed += delta
	pressure = maxf(0,pressure-delta)
	var screen_move: Vector2 = controls.movement
	var keyboard: Vector2 = Vector2(float(_key(KEY_D) or _key(KEY_RIGHT))-float(_key(KEY_A) or _key(KEY_Q) or _key(KEY_LEFT)),float(_key(KEY_S) or _key(KEY_DOWN))-float(_key(KEY_W) or _key(KEY_Z) or _key(KEY_UP)))
	if keyboard.length() > 0:
		screen_move = keyboard.normalized()
	var movement: Vector2 = CatIso.unproject_direction(screen_move) * minf(1,screen_move.length())
	player.tick(delta,movement)
	if attack_held or _key(KEY_J):
		perform_attack()
	var reserved: bool = false
	for enemy: CatEnemy in enemies:
		if enemy.state == CatEnemy.State.WINDUP:
			reserved = true
	for enemy: CatEnemy in enemies:
		var allowed: bool = not reserved and pressure == 0 and player.state != CatPlayer.State.DEAD
		enemy.tick(delta,player,allowed)
		if enemy.state == CatEnemy.State.WINDUP:
			reserved = true
			pressure = 0.45
	for i: int in range(effects.size()-1,-1,-1):
		effects[i]["life"] = float(effects[i]["life"])-delta
		if float(effects[i]["life"]) <= 0:
			effects.remove_at(i)
	_update_hud()
	queue_redraw()

func _key(code: Key) -> bool:
	return Input.is_physical_key_pressed(code)

func _unhandled_key_input(event: InputEvent) -> void:
	if not event is InputEventKey or not event.is_pressed() or event.is_echo():
		return
	var key_event: InputEventKey = event as InputEventKey
	if key_event.physical_keycode == KEY_ESCAPE:
		toggle_pause()
	if phase != "combat":
		return
	match key_event.physical_keycode:
		KEY_SPACE: perform_dodge()
		KEY_K: perform_transform()

func _notification(what: int) -> void:
	if what == NOTIFICATION_APPLICATION_FOCUS_OUT and phase == "combat":
		toggle_pause()

func select_target() -> CatEnemy:
	var best: CatEnemy = null
	var best_score: float = INF
	for enemy: CatEnemy in enemies:
		if enemy.state == CatEnemy.State.DEAD:
			continue
		var difference: Vector2 = enemy.world-player.world
		var alignment: float = player.facing.dot(difference.normalized())
		var score: float = difference.length() + (1-alignment)*90
		if difference.length() < player.data.attack_range * (1.5 if player.form == CatPlayer.Form.ULTIMATE else 1.0) and alignment > -0.2 and score < best_score:
			best = enemy
			best_score = score
	return best

func perform_attack() -> void:
	if phase != "combat":
		return
	var target: CatEnemy = select_target()
	var direction: Vector2 = player.facing
	if target != null:
		direction = direction.lerp((target.world-player.world).normalized(),0.5).normalized()
	if not player.attack(direction):
		return
	var is_titan: bool = player.form == CatPlayer.Form.ULTIMATE
	var reach: float = player.data.attack_range * (1.5 if is_titan else 1.0)
	for enemy: CatEnemy in enemies:
		var difference: Vector2 = enemy.world-player.world
		if enemy.state == CatEnemy.State.DEAD or difference.length() > reach or difference.normalized().dot(player.facing) < 0.15:
			continue
		var damage: float = player.data.damage * (1.65 if player.combo == 3 else 1.0) * (1.8 if is_titan else 1.0)
		var actual_damage: float = minf(enemy.health,damage)
		var killed: bool = enemy.receive_damage(damage,difference.normalized())
		_effect(enemy.world,str(int(damage)),Color("ffe1a3"))
		forest_fx.burst(CatIso.project(enemy.world)-Vector2(0,55),is_titan)
		if player.form == CatPlayer.Form.NORMAL:
			player.charge = minf(100,player.charge+actual_damage*0.6+(8 if killed else 0))
		if killed:
			kills += 1
	if kills == enemies.size():
		phase = "victory"
		_show_overlay("L’AUBE VOUS APPARTIENT", "Les six esprits sont apaisés.\n\nExpédition accomplie • %.1f secondes\nLe Gardien Écarlate peut enfin souffler." % elapsed)

func perform_dodge() -> void:
	if phase == "combat":
		var direction: Vector2 = CatIso.unproject_direction(controls.movement) if controls.movement.length() > 0.1 else player.facing
		if not player.dodge(direction):
			message.text = "Esquive en récupération"

func perform_transform() -> void:
	if phase == "combat":
		if player.transform():
			_effect(player.world,"TITAN FÉLIN",Color("ffcf73"))
		else:
			message.text = "Éveil : jauge complète requise"

func _on_defeat() -> void:
	phase = "defeat"
	_show_overlay("UNE VIE, UN NOUVEL ÉVEIL", "Le Gardien est tombé.\nLes esprits de la forêt attendent votre retour.\n\nRecommencez et utilisez les cercles rouges pour esquiver.")

func toggle_pause() -> void:
	if phase == "combat":
		phase = "pause"
		attack_held = false
		controls.reset()
		_show_overlay("UN INSTANT DE CALME", "Combat en pause\n\nDéplacement : ZQSD / WASD / flèches\nAttaque : J • Esquive : Espace • Éveil : K\nPause : Échap\n\nSur écran tactile : joystick gauche et boutons droits.")
	elif phase == "pause":
		phase = "combat"
		overlay.hide()

func _effect(point: Vector2, text_value: String, color: Color) -> void:
	if effects.size() < 40:
		effects.append({"point":CatIso.project(point),"text":text_value,"color":color,"life":0.7})

func _update_hud() -> void:
	health_bar.value = player.health
	ultimate_bar.value = player.charge if player.form == CatPlayer.Form.NORMAL else player.ultimate_left/12*100
	status_label.text = "LE GARDIEN ÉCARLATE    %d / 100" % int(player.health)
	checkpoint.text = "FORÊT DES MURMURES\nEsprits apaisés   %d / 6" % kills
	ultimate_button.text = "ÉVEIL\n%d %%" % int(player.charge) if player.form == CatPlayer.Form.NORMAL else "TITAN\n%.1f s" % player.ultimate_left
	dodge_button.text = "ESQUIVE" if player.dodge_cd == 0 else "%.1f s" % player.dodge_cd
	(ultimate_button as CatActionButton).readiness = ultimate_bar.value/100.0
	(dodge_button as CatActionButton).cooldown = player.dodge_cd/player.data.dodge_cooldown

func _build_ui() -> void:
	hud = CanvasLayer.new()
	add_child(hud)
	var ui: Control = Control.new()
	ui.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	ui.mouse_filter = Control.MOUSE_FILTER_IGNORE
	hud.add_child(ui)
	var theme: Theme = Theme.new()
	theme.default_font = CatArt.BODY_FONT
	ui.theme = theme
	controls = ControlsScript.new()
	ui.add_child(controls)
	controls.attack_changed.connect(func(held: bool) -> void:
		attack_held = held
		if held: perform_attack())
	controls.dodge_requested.connect(perform_dodge)
	controls.ultimate_requested.connect(perform_transform)
	var status_panel: Panel = Panel.new()
	status_panel.position = Vector2(52,40)
	status_panel.size = Vector2(555,130)
	status_panel.add_theme_stylebox_override("panel",CatArt.panel(Color(0.025,0.07,0.08,0.92),Color("8b825d"),18))
	status_panel.mouse_filter = Control.MOUSE_FILTER_IGNORE
	ui.add_child(status_panel)
	var portrait: TextureRect = TextureRect.new()
	portrait.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	portrait.texture = CatArt.tile(0)
	portrait.position = Vector2(60,32)
	portrait.size = Vector2(126,126)
	portrait.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	portrait.mouse_filter = Control.MOUSE_FILTER_IGNORE
	ui.add_child(portrait)
	portrait.set_deferred("size",Vector2(126,126))
	status_label = _label(ui,"",Vector2(195,59),19,Color("f4e6c4"))
	health_bar = _bar(ui,Vector2(195,96),Vector2(375,19),Color("c96858"))
	ultimate_bar = _bar(ui,Vector2(195,130),Vector2(375,8),Color("efd08b"))
	checkpoint = _label(ui,"",Vector2(735,44),23,Color("ede6ce"))
	checkpoint.add_theme_constant_override("outline_size",5)
	checkpoint.add_theme_color_override("font_outline_color",Color("102528"))
	_button(ui,"Ⅱ",Vector2(1745,45),Vector2(100,80),toggle_pause)
	_label(ui,"01   /   LE SANCTUAIRE DES RONCES",Vector2(70,206),17,Color("d6dec4"))
	message = _label(ui,"",Vector2(650,1028),19,Color("e7e5cd"))
	if not OS.has_feature("mobile"):
		message.text = "ZQSD / WASD   ·   J Attaque   ·   Espace Esquive   ·   K Éveil"
	var attack: CatActionButton = _action(ui,"ATTAQUER","sword",Vector2(1640,810),Vector2(205,150))
	attack.button_down.connect(func() -> void: attack_held = true; perform_attack())
	attack.button_up.connect(func() -> void: attack_held = false)
	dodge_button = _action(ui,"ESQUIVE","dodge",Vector2(1390,940),Vector2(225,80))
	dodge_button.pressed.connect(perform_dodge)
	ultimate_button = _action(ui,"ÉVEIL","sun",Vector2(1450,755),Vector2(155,145))
	ultimate_button.pressed.connect(perform_transform)
	overlay_shade = ColorRect.new()
	overlay_shade.color = Color(0.005,0.02,0.025,0.58)
	overlay_shade.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	ui.add_child(overlay_shade)
	overlay = PanelContainer.new()
	overlay.position = Vector2(345,190)
	overlay.size = Vector2(1230,730)
	var panel_style: StyleBoxFlat = CatArt.panel(Color(0.025,0.075,0.085,0.97),Color("b9a16b"),24)
	panel_style.content_margin_top = 35
	panel_style.content_margin_bottom = 30
	panel_style.content_margin_left = 28
	panel_style.content_margin_right = 40
	overlay.add_theme_stylebox_override("panel",panel_style)
	ui.add_child(overlay)
	overlay.visibility_changed.connect(func() -> void: overlay_shade.visible = overlay.visible)
	var row: HBoxContainer = HBoxContainer.new()
	row.add_theme_constant_override("separation",30)
	overlay.add_child(row)
	hero_portrait = TextureRect.new()
	hero_portrait.texture = CatArt.tile(0)
	hero_portrait.custom_minimum_size = Vector2(390,0)
	hero_portrait.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	hero_portrait.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	hero_portrait.mouse_filter = Control.MOUSE_FILTER_IGNORE
	row.add_child(hero_portrait)
	var column: VBoxContainer = VBoxContainer.new()
	column.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	column.add_theme_constant_override("separation",22)
	row.add_child(column)
	var caption: Label = Label.new()
	caption.text = "LE GARDIEN ÉCARLATE"
	caption.add_theme_font_size_override("font_size",18)
	caption.add_theme_color_override("font_color",Color("80b6a6"))
	column.add_child(caption)
	overlay_title = Label.new()
	overlay_title.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	overlay_title.add_theme_font_override("font",CatArt.TITLE_FONT)
	overlay_title.add_theme_font_size_override("font_size",48)
	overlay_title.add_theme_color_override("font_color",Color("f0ce8b"))
	column.add_child(overlay_title)
	overlay_body = Label.new()
	overlay_body.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	overlay_body.add_theme_font_size_override("font_size",23)
	overlay_body.add_theme_color_override("font_color",Color("ccdbcf"))
	overlay_body.size_flags_vertical = Control.SIZE_EXPAND_FILL
	column.add_child(overlay_body)
	resume_button = Button.new()
	resume_button.custom_minimum_size = Vector2(0,76)
	resume_button.add_theme_font_size_override("font_size",23)
	resume_button.add_theme_color_override("font_color",Color("183331"))
	resume_button.add_theme_stylebox_override("normal",CatArt.panel(Color("d7b778"),Color("ffe4a4"),10))
	resume_button.add_theme_stylebox_override("hover",CatArt.panel(Color("f0d49b"),Color("ffedc3"),10))
	resume_button.add_theme_stylebox_override("pressed",CatArt.panel(Color("a99364"),Color("ffe4a4"),10))
	resume_button.pressed.connect(func() -> void:
		if phase == "pause": toggle_pause()
		else: new_run())
	column.add_child(resume_button)
	var reduced: CheckButton = CheckButton.new()
	reduced.text = "Réduire les effets lumineux"
	reduced.add_theme_font_size_override("font_size",18)
	reduced.toggled.connect(func(enabled: bool) -> void:
		reduced_effects = enabled
		player.reduced_effects = enabled)
	column.add_child(reduced)

func _action(parent: Node, caption: String, symbol: String, point: Vector2, dimensions: Vector2) -> CatActionButton:
	var button: CatActionButton = CatActionButton.new()
	button.text = caption
	button.symbol = symbol
	button.position = point
	button.size = dimensions
	parent.add_child(button)
	return button

func _show_overlay(title: String, body: String) -> void:
	overlay_title.text = title
	overlay_body.text = body
	resume_button.text = "REPRENDRE" if phase == "pause" else ("ENTRER DANS LA FORÊT" if phase == "title" else "NOUVELLE EXPÉDITION")
	overlay.show()

func _label(parent: Node, value: String, point: Vector2, font_size: int, color: Color) -> Label:
	var label: Label = Label.new()
	label.text = value
	label.position = point
	label.add_theme_font_size_override("font_size",font_size)
	label.add_theme_font_override("font",CatArt.BODY_FONT)
	label.add_theme_color_override("font_color",color)
	parent.add_child(label)
	return label

func _bar(parent: Node, point: Vector2, dimensions: Vector2, color: Color) -> ProgressBar:
	var bar: ProgressBar = ProgressBar.new()
	bar.position = point
	bar.size = dimensions
	bar.show_percentage = false
	bar.add_theme_stylebox_override("background",_box(Color("102728"),Color("6b785f"),5))
	bar.add_theme_stylebox_override("fill",_box(color,color,3))
	parent.add_child(bar)
	return bar

func _button(parent: Node, text_value: String, point: Vector2, dimensions: Vector2, callback: Callable) -> Button:
	var button: Button = Button.new()
	button.text = text_value
	button.position = point
	button.size = dimensions
	button.add_theme_font_size_override("font_size",22)
	button.add_theme_color_override("font_color",Color("f3dfb7"))
	button.add_theme_stylebox_override("normal",_box(Color("213e42"),Color("9c8a63"),18))
	button.add_theme_stylebox_override("hover",_box(Color("355858"),Color("d9bd81"),18))
	button.add_theme_stylebox_override("pressed",_box(Color("607264"),Color("ffe2a0"),18))
	button.pressed.connect(callback)
	parent.add_child(button)
	return button

func _box(color: Color, border: Color, radius: int) -> StyleBoxFlat:
	var box: StyleBoxFlat = StyleBoxFlat.new()
	box.bg_color = color
	box.border_color = border
	box.set_border_width_all(2)
	box.set_corner_radius_all(radius)
	box.content_margin_top = 0
	box.content_margin_bottom = 0
	box.content_margin_left = 0
	box.content_margin_right = 0
	return box

func _draw() -> void:
	draw_texture_rect(CatArt.FLOOR,Rect2(0,0,1920,1080),false)
	# A thin rune perimeter marks the actual collision boundary over the painting.
	var bounds: PackedVector2Array = PackedVector2Array()
	for point: Vector2 in [Vector2(-510,-510),Vector2(510,-510),Vector2(510,510),Vector2(-510,510),Vector2(-510,-510)]:
		bounds.append(CatIso.project(point))
	draw_polyline(bounds,Color(0.7,0.88,0.62,0.23),2,true)
	for effect: Dictionary in effects:
		var point: Vector2 = effect["point"]
		point.y -= (0.7-float(effect["life"]))*70+150
		draw_string_outline(CatArt.BODY_FONT,point,str(effect["text"]),HORIZONTAL_ALIGNMENT_CENTER,-1,30,5,Color("1e2926"))
		draw_string(CatArt.BODY_FONT,point,str(effect["text"]),HORIZONTAL_ALIGNMENT_CENTER,-1,30,effect["color"])
