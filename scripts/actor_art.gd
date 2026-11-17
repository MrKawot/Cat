class_name CatActorArt
extends Node2D

var warrior: bool = true
var direction: Vector2 = Vector2.RIGHT
var moving: bool = false
var attacking: bool = false
var dodging: bool = false
var titan: bool = false
var dead: bool = false
var hit: bool = false
var reduced: bool = false
var clock: float = 0.0
var attack_progress: float = 0.0
var transform_flash: float = 0.0
var fade: float = 1.0

func _draw() -> void:
	var screen_direction: Vector2 = Vector2(direction.x-direction.y,(direction.x+direction.y)*0.5).normalized()
	var mirrored: bool = screen_direction.x < -0.05
	var back: bool = screen_direction.y < -0.2
	var bob: float = sin(clock * (17 if warrior else 14)) * (5 if moving else 1.2)
	var squash: float = sin(clock*17)*0.035 if moving else sin(clock*3)*0.012
	var size_factor: float = (1.3 if titan else 1.0)
	var body_size: float = 224.0 if warrior else 157.0
	var selected_tile: int = (1 if back else 0) if warrior else 3
	if attacking and warrior and not back:
		selected_tile = 2
	if dead:
		bob = 8
	# Layered soft contact shadow, no expensive lights or shader passes.
	for i: int in range(4):
		draw_set_transform(Vector2(0,4),0,Vector2(1,0.32))
		draw_circle(Vector2.ZERO,(37.0-i*5)*size_factor,Color(0.005,0.015,0.015,0.09*fade))
	draw_set_transform(Vector2.ZERO)
	if titan:
		var pulse: float = 0.65 + sin(clock*6)*0.15
		for i: int in range(3):
			draw_set_transform(Vector2(0,3),0,Vector2(1,0.45))
			draw_arc(Vector2.ZERO,58+i*12,0,TAU,48,Color(1,0.72,0.25,pulse/(i+1)),3,true)
		for i: int in range(8):
			var angle: float = clock*0.8+i*TAU/8
			var point: Vector2 = Vector2(cos(angle)*64,sin(angle)*27-50-fmod(clock*24+i*18,100))
			draw_set_transform(Vector2.ZERO)
			draw_circle(point,2.4,Color(1,0.85,0.48,0.75))
	if dodging:
		for i: int in range(3,0,-1):
			draw_set_transform(-screen_direction*i*18+Vector2(0,bob),0,Vector2(-1 if mirrored else 1,1)*size_factor)
			draw_texture_rect(CatArt.tile(selected_tile),Rect2(-body_size/2,-body_size*0.87,body_size,body_size),false,Color(0.7,0.94,1,0.12*fade))
	var lean: float = sin(attack_progress*PI)*0.16 * (-1 if mirrored else 1) if attacking else 0.0
	if dead:
		lean = -0.65
	draw_set_transform(Vector2(0,bob),lean,Vector2((-1 if mirrored else 1)*(1+squash),1-squash)*size_factor)
	var tint: Color = Color(1.25,1.13,0.85,fade) if titan else Color(1,1,1,fade)
	if hit and not reduced:
		tint = Color(1.7,1.35,1.2,fade)
	draw_texture_rect(CatArt.tile(selected_tile),Rect2(-body_size/2,-body_size*0.87,body_size,body_size),false,tint)
	draw_set_transform(Vector2.ZERO)
	if attacking and warrior:
		var attack_angle: float = screen_direction.angle()
		var radius: float = 118*size_factor
		var start: float = attack_angle-1.25+attack_progress*0.9
		draw_set_transform(Vector2(0,-45),0,Vector2(1,0.7))
		for layer: int in range(4):
			draw_arc(Vector2.ZERO,radius-layer*5,start,start+1.6,26,Color(1,0.78+layer*0.04,0.4+layer*0.15,(1-attack_progress)*0.7),6-layer,true)
	draw_set_transform(Vector2.ZERO)
	if transform_flash > 0 and not reduced:
		draw_set_transform(Vector2(0,-40),0,Vector2(1,0.65))
		draw_arc(Vector2.ZERO,(1-transform_flash)*180+30,0,TAU,64,Color(1,0.85,0.48,transform_flash),5,true)
		draw_set_transform(Vector2.ZERO)
