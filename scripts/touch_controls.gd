class_name CatTouchControls
extends Control

signal attack_changed(held: bool)
signal dodge_requested
signal ultimate_requested

var action_fingers: Dictionary = {}
var movement: Vector2 = Vector2.ZERO
var finger: int = -1
var center: Vector2 = Vector2(200, 865)
var knob: Vector2 = Vector2.ZERO

func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_IGNORE

func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		var touch: InputEventScreenTouch = event as InputEventScreenTouch
		if touch.pressed and touch.position.distance_to(center) < 150 and finger == -1:
			finger = touch.index
			_update_stick(touch.position)
		elif touch.pressed:
			if Rect2(1640,810,205,150).has_point(touch.position):
				action_fingers[touch.index] = "attack"
				attack_changed.emit(true)
			elif Rect2(1390,940,225,80).has_point(touch.position):
				dodge_requested.emit()
			elif Rect2(1450,755,155,145).has_point(touch.position):
				ultimate_requested.emit()
		elif not touch.pressed and touch.index == finger:
			finger = -1
			movement = Vector2.ZERO
			knob = Vector2.ZERO
			queue_redraw()
		if not touch.pressed and action_fingers.has(touch.index):
			action_fingers.erase(touch.index)
			if action_fingers.is_empty():
				attack_changed.emit(false)
	elif event is InputEventScreenDrag:
		var drag: InputEventScreenDrag = event as InputEventScreenDrag
		if drag.index == finger:
			_update_stick(drag.position)

func reset() -> void:
	action_fingers.clear()
	attack_changed.emit(false)
	finger = -1
	movement = Vector2.ZERO
	knob = Vector2.ZERO
	queue_redraw()

func _update_stick(point: Vector2) -> void:
	knob = (point-center).limit_length(95)
	movement = knob/95
	if movement.length() < 0.12:
		movement = Vector2.ZERO
	queue_redraw()

func _draw() -> void:
	draw_circle(center+Vector2(0,5),115,Color(0,0,0,0.18))
	draw_circle(center,110,Color(0.02,0.08,0.085,0.50))
	draw_arc(center,110,0,TAU,64,Color(0.78,0.75,0.54,0.55),2,true)
	draw_arc(center,100,0,TAU,64,Color(0.7,0.85,0.72,0.18),1,true)
	for i: int in range(8):
		var direction: Vector2 = Vector2.from_angle(i*TAU/8)
		draw_line(center+direction*91,center+direction*98,Color(0.8,0.79,0.59,0.4),2,true)
	draw_circle(center+knob,43,Color(0.12,0.25,0.24,0.9))
	draw_arc(center+knob,43,0,TAU,32,Color(0.88,0.78,0.53,0.8),2,true)
	draw_circle(center+knob,31,Color(0.4,0.6,0.5,0.12))
	for offset: Vector2 in [Vector2(-9,-7),Vector2(9,-7),Vector2(0,-13)]:
		draw_circle(center+knob+offset,3.5,Color("c8bb88"))
	draw_circle(center+knob+Vector2(0,6),7,Color("c8bb88"))
