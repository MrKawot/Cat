class_name CatEnemy
extends Node2D

enum State { SPAWN, SEEK, APPROACH, WINDUP, ATTACK, RECOVER, STUN, DEAD }
var world: Vector2 = Vector2.ZERO
var health: float = 65.0
var state: State = State.SPAWN
var timer: float = 0.5
var locked_target: Vector2 = Vector2.ZERO
var hit_flash: float = 0.0
var age: float = 0.0
var death_left: float = 0.0
var art: CatActorArt
var direction: Vector2 = Vector2.RIGHT

func _ready() -> void:
	art = CatActorArt.new()
	art.warrior = false
	add_child(art)

func _sync_art() -> void:
	if not is_instance_valid(art): return
	art.direction = direction
	art.clock = age
	art.moving = state == State.APPROACH
	art.attacking = state == State.ATTACK
	art.hit = hit_flash > 0
	art.queue_redraw()

func tick(delta: float, player: CatPlayer, attack_allowed: bool) -> bool:
	age += delta
	timer = maxf(0, timer - delta)
	hit_flash = maxf(0, hit_flash - delta)
	var attacked: bool = false
	if state == State.DEAD:
		death_left = maxf(0,death_left-delta)
		visible = death_left > 0
		if is_instance_valid(art):
			art.dead = true
			art.fade = death_left/0.45
			art.queue_redraw()
		return false
	var distance: float = world.distance_to(player.world)
	direction = world.direction_to(player.world)
	match state:
		State.SPAWN, State.RECOVER, State.STUN:
			if timer == 0:
				state = State.SEEK
		State.SEEK, State.APPROACH:
			if distance > 95:
				state = State.APPROACH
				world = CatIso.move_world(world, world.direction_to(player.world) * minf(112 * delta,distance))
			elif attack_allowed:
				state = State.WINDUP
				timer = 0.75
				locked_target = player.world
		State.WINDUP:
			if timer == 0:
				state = State.ATTACK
				timer = 0.12
				if world.distance_to(player.world) < 135 and player.world.distance_to(locked_target) < 85:
					player.receive_damage(13)
				attacked = true
		State.ATTACK:
			if timer == 0:
				state = State.RECOVER
				timer = 0.85
	position = CatIso.project(world)
	z_index = int(position.y)
	_sync_art()
	queue_redraw()
	return attacked

func receive_damage(amount: float, direction: Vector2) -> bool:
	if state == State.DEAD:
		return false
	health = maxf(0, health - amount)
	world = CatIso.move_world(world, direction * 25)
	hit_flash = 0.12
	state = State.STUN if health > 0 else State.DEAD
	timer = 0.18
	if health == 0:
		death_left = 0.45
	return health == 0

func _draw() -> void:
	if state == State.WINDUP:
		var progress: float = 1.0-timer/0.75
		var target: Vector2 = CatIso.project(locked_target)-position
		draw_set_transform(target,0,Vector2(1,0.5))
		draw_circle(Vector2.ZERO,80,Color(0.85,0.16,0.12,0.08+progress*0.14))
		draw_arc(Vector2.ZERO,80,0,TAU,48,Color(1,0.4,0.25,0.8),3,true)
		draw_arc(Vector2.ZERO,80,-PI/2,-PI/2+TAU*progress,48,Color(1,0.75,0.4),6,true)
		draw_set_transform(Vector2.ZERO)
	if health < 65 and state != State.DEAD:
		draw_style_box(CatArt.panel(Color("102b2c"),Color("66816b"),3),Rect2(-30,-135,60,7))
		draw_rect(Rect2(-28,-133,56*health/65.0,3),Color("eb9175"))
