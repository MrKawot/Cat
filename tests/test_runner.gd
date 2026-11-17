extends SceneTree

var checks: int = 0
var failures: int = 0

func _initialize() -> void:
	call_deferred("run")

func verify(condition: bool, description: String) -> void:
	checks += 1
	if not condition:
		failures += 1
		printerr("FAIL: "+description)
	else:
		print("PASS: "+description)

func run() -> void:
	var arena: CatArena = load("res://scenes/main.tscn").instantiate() as CatArena
	root.add_child(arena)
	arena.set_process(false)
	verify(arena.phase == "title", "Title scene instantiates")
	arena.new_run()
	var p: CatPlayer = arena.player
	verify(arena.enemies.size() == 6 and p.health == 100, "Run spawns warrior and six enemies")
	for direction: Vector2 in [Vector2.UP,Vector2.DOWN,Vector2.LEFT,Vector2.RIGHT,Vector2(1,1).normalized(),Vector2(-1,1).normalized(),Vector2(1,-1).normalized(),Vector2(-1,-1).normalized()]:
		p.world = Vector2.ZERO
		p.tick(0.1,direction)
		verify(p.world.dot(direction) > 0 and p.facing.dot(direction) > 0.99,"Movement and orientation: "+str(direction))
	p.world = Vector2(480,0)
	p.tick(1,Vector2.RIGHT)
	verify(p.world.x <= 488,"Wall collision")
	p.world = Vector2(-330,-150)
	for i: int in range(30): p.tick(1.0/60,Vector2.RIGHT)
	verify(p.world.distance_to(Vector2(-230,-150)) >= 87.9,"Obstacle collision")
	verify(CatIso.unproject_direction(Vector2.RIGHT).is_equal_approx(Vector2(1,-1).normalized()),"Screen-to-world isometric mapping")
	# Empty target attack must remain valid and manually triggered.
	for enemy: CatEnemy in arena.enemies: enemy.world = Vector2(-450,-450)
	p.world = Vector2(350,350)
	p.state = CatPlayer.State.IDLE
	p.attack_cd = 0
	verify(arena.select_target() == null,"No target outside range")
	arena.perform_attack()
	verify(p.state == CatPlayer.State.ATTACK,"Manual attack without target")
	verify(not p.attack(Vector2.RIGHT),"Attack cooldown")
	p.tick(0.3,Vector2.ZERO)
	p.attack(Vector2.RIGHT)
	verify(p.combo == 2,"Second combo strike")
	p.tick(0.3,Vector2.ZERO)
	p.attack(Vector2.RIGHT)
	verify(p.combo == 3,"Third combo strike")
	p.tick(1.1,Vector2.ZERO)
	verify(p.combo == 0,"Combo expires")
	p.world = Vector2.ZERO
	p.facing = Vector2.RIGHT
	var enemy: CatEnemy = arena.enemies[0]
	enemy.world = Vector2(70,0)
	enemy.state = CatEnemy.State.SEEK
	verify(arena.select_target() == enemy,"Target assistance chooses nearby forward enemy")
	arena.perform_attack()
	verify(enemy.health < 65 and p.charge > 0,"Real damage and ultimate charging")
	var enemy_health: float = enemy.health
	p.tick(0.5,Vector2.ZERO)
	verify(enemy.health == enemy_health,"No automatic attack")
	verify(p.dodge(Vector2.RIGHT),"Dodge starts")
	verify(not p.dodge(Vector2.RIGHT),"No infinite dodge")
	verify(not p.receive_damage(13),"Early dodge invulnerability")
	p.tick(0.21,Vector2.ZERO)
	verify(p.receive_damage(13),"Dodge invulnerability expires before movement")
	p.tick(1,Vector2.ZERO)
	verify(p.dodge_cd == 0,"Dodge recovers")
	p.state = CatPlayer.State.IDLE
	p.charge = 99
	verify(not p.transform(),"Incomplete ultimate rejected")
	p.charge = 100
	verify(p.transform() and p.charge == 0,"Ultimate activates and consumes gauge")
	verify(not p.transform(),"Repeated transformation rejected")
	p.tick(11.9,Vector2.ZERO)
	verify(p.form == CatPlayer.Form.ULTIMATE,"Ultimate lasts twelve seconds")
	p.tick(0.11,Vector2.ZERO)
	verify(p.form == CatPlayer.Form.NORMAL,"Ultimate returns to normal")
	p.charge = 100
	p.transform()
	p.hurt_left = 0
	var health_before: float = p.health
	p.receive_damage(10)
	verify(is_equal_approx(health_before-p.health,6.5),"Titan reduces damage but remains vulnerable")
	p.hurt_left = 0
	p.receive_damage(1000)
	verify(p.state == CatPlayer.State.DEAD and p.form == CatPlayer.Form.NORMAL and p.ultimate_left == 0,"Death cancels transformation")
	verify(arena.phase == "defeat" and arena.overlay.visible,"Defeat screen")
	arena.new_run()
	p = arena.player
	verify(arena.phase == "combat" and p.health == 100 and arena.kills == 0 and p.charge == 0,"Restart resets run")
	p.world = Vector2.ZERO
	enemy = arena.enemies[0]
	enemy.world = Vector2(60,0)
	enemy.state = CatEnemy.State.SEEK
	enemy.tick(0,p,true)
	verify(enemy.state == CatEnemy.State.WINDUP and p.health == 100,"Enemy telegraph precedes damage")
	enemy.tick(0.76,p,true)
	verify(p.health < 100,"Enemy attack deals damage")
	arena.new_run()
	p = arena.player
	p.world = Vector2.ZERO
	p.facing = Vector2.RIGHT
	for foe: CatEnemy in arena.enemies:
		foe.world = Vector2(50,0)
		foe.health = 1
	arena.perform_attack()
	verify(arena.kills == 6 and arena.phase == "victory" and arena.overlay.visible,"Combat reaches victory")
	arena.new_run()
	arena.toggle_pause()
	verify(arena.phase == "pause", "Pause")
	arena.toggle_pause()
	verify(arena.phase == "combat", "Resume")
	# Exercise touch index ownership, analog magnitude, release and cancellation.
	var touch: InputEventScreenTouch = InputEventScreenTouch.new()
	touch.index = 2
	touch.pressed = true
	touch.position = arena.controls.center+Vector2(47.5,0)
	arena.controls._input(touch)
	verify(is_equal_approx(arena.controls.movement.x,0.5),"Analog joystick half deflection")
	var other: InputEventScreenTouch = InputEventScreenTouch.new()
	other.index = 3
	other.pressed = false
	arena.controls._input(other)
	verify(arena.controls.finger == 2,"Second finger cannot cancel joystick")
	touch.pressed = false
	arena.controls._input(touch)
	verify(arena.controls.movement == Vector2.ZERO and arena.controls.finger == -1,"Joystick release")
	touch.pressed = true
	arena.controls._input(touch)
	var attack_touch: InputEventScreenTouch = InputEventScreenTouch.new()
	attack_touch.index = 4
	attack_touch.pressed = true
	attack_touch.position = Vector2(1700,850)
	arena.controls._input(attack_touch)
	verify(arena.controls.finger == 2 and arena.attack_held,"Simultaneous joystick and second-finger attack")
	attack_touch.pressed = false
	arena.controls._input(attack_touch)
	verify(not arena.attack_held and arena.controls.finger == 2,"Attack finger release preserves joystick")
	arena.controls.reset()
	verify(CatIso.move_world(Vector2(-350,-150),Vector2(400,0)).x < -310,"Swept motion prevents obstacle tunneling")
	# Deterministic full arena simulation: AI can defeat an idle player.
	arena.new_run()
	for step: int in range(3600):
		if arena.phase != "combat": break
		arena._process(1.0/60)
	verify(arena.phase == "defeat", "Integrated 60 Hz AI simulation reaches defeat")
	# Full combat without changing enemy health: scripted manual commands.
	arena.new_run()
	p = arena.player
	for step: int in range(7200):
		if arena.phase != "combat": break
		var nearest: CatEnemy = null
		var nearest_distance: float = INF
		for foe: CatEnemy in arena.enemies:
			if foe.state != CatEnemy.State.DEAD and p.world.distance_to(foe.world) < nearest_distance:
				nearest = foe
				nearest_distance = p.world.distance_to(foe.world)
		if nearest == null: break
		var direction: Vector2 = (nearest.world-p.world).normalized()
		p.tick(1.0/60,direction if nearest_distance > 100 else Vector2.ZERO)
		p.facing = direction
		arena.perform_attack()
		if p.charge == 100: arena.perform_transform()
		var reserved: bool = false
		for foe: CatEnemy in arena.enemies:
			if foe.state == CatEnemy.State.WINDUP: reserved = true
		for foe: CatEnemy in arena.enemies:
			foe.tick(1.0/60,p,not reserved)
			if foe.state == CatEnemy.State.WINDUP: reserved = true
	verify(arena.phase == "victory", "Full combat simulation wins against undamaged enemies")
	print("RESULT: %d checks, %d failures" % [checks,failures])
	arena.queue_free()
	await process_frame
	quit(1 if failures > 0 else 0)
