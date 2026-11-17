class_name CatPlayer
extends Node2D

signal struck(damage: float)
signal died

enum State { IDLE, MOVE, ATTACK, DODGE, CAST, TRANSFORM, HURT, DEAD }
enum Form { NORMAL, ULTIMATE }

var data: CatCharacterData = preload("res://data/warrior.tres")
var world: Vector2 = Vector2(40, 180)
var facing: Vector2 = Vector2(-1, 0)
var health: float = 100.0
var charge: float = 0.0
var state: State = State.IDLE
var form: Form = Form.NORMAL
var state_time: float = 0.0
var attack_cd: float = 0.0
var dodge_cd: float = 0.0
var ultimate_left: float = 0.0
var combo: int = 0
var combo_left: float = 0.0
var hurt_left: float = 0.0
var dodge_direction: Vector2 = Vector2.ZERO
var animation_time: float = 0.0
var reduced_effects: bool = false
var art: CatActorArt
var transform_flash: float = 0.0

func _ready() -> void:
	art = CatActorArt.new()
	add_child(art)

func _sync_art() -> void:
	if not is_instance_valid(art): return
	art.direction = facing
	art.clock = animation_time
	art.moving = state == State.MOVE
	art.attacking = state == State.ATTACK
	art.dodging = state == State.DODGE
	art.titan = form == Form.ULTIMATE
	art.dead = state == State.DEAD
	art.hit = hurt_left > 0.35
	art.reduced = reduced_effects
	art.attack_progress = 1.0-state_time/0.2
	art.transform_flash = transform_flash
	art.queue_redraw()

func tick(delta: float, movement: Vector2) -> void:
	animation_time += delta
	transform_flash = maxf(0,transform_flash-delta*1.8)
	state_time = maxf(0, state_time - delta)
	attack_cd = maxf(0, attack_cd - delta)
	dodge_cd = maxf(0, dodge_cd - delta)
	combo_left = maxf(0, combo_left - delta)
	hurt_left = maxf(0, hurt_left - delta)
	if combo_left == 0:
		combo = 0
	if form == Form.ULTIMATE:
		ultimate_left = maxf(0, ultimate_left - delta)
		if ultimate_left == 0:
			form = Form.NORMAL
	if state == State.DEAD:
		_sync_art()
		return
	if state == State.DODGE:
		world = CatIso.move_world(world, dodge_direction * 1050 * delta)
	elif state_time == 0:
		state = State.MOVE if movement.length() > 0.1 else State.IDLE
		if movement.length() > 0.1:
			facing = movement.normalized()
			world = CatIso.move_world(world, movement.limit_length() * data.speed * delta)
	position = CatIso.project(world)
	z_index = int(position.y)
	_sync_art()

func attack(target_direction: Vector2) -> bool:
	if state in [State.DEAD, State.DODGE, State.HURT] or attack_cd > 0:
		return false
	if target_direction.length() > 0.01:
		facing = target_direction.normalized()
	combo = combo % 3 + 1
	combo_left = 1.05
	state = State.ATTACK
	state_time = 0.2
	attack_cd = 0.28 if combo < 3 else 0.46
	return true

func dodge(direction: Vector2) -> bool:
	if state == State.DEAD or dodge_cd > 0:
		return false
	dodge_direction = direction.normalized() if direction.length() > 0.1 else facing
	facing = dodge_direction
	state = State.DODGE
	state_time = data.dodge_duration
	dodge_cd = data.dodge_cooldown
	return true

func transform() -> bool:
	if state == State.DEAD or form != Form.NORMAL or charge < 100:
		return false
	charge = 0
	form = Form.ULTIMATE
	ultimate_left = data.ultimate_duration
	transform_flash = 1.0
	# Transformation is an overlay; it never locks locomotion or attacks.
	return true

func receive_damage(amount: float) -> bool:
	if state == State.DEAD or hurt_left > 0:
		return false
	if state == State.DODGE and state_time > data.dodge_duration - data.invulnerability_duration:
		return false
	health = maxf(0, health - amount * (0.65 if form == Form.ULTIMATE else 1.0))
	hurt_left = 0.5
	struck.emit(amount)
	if health == 0:
		state = State.DEAD
		form = Form.NORMAL
		ultimate_left = 0
		died.emit()
	else:
		state = State.HURT
		state_time = 0.12
	return true

