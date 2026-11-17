class_name CatForestVisuals
extends Node2D

var clock: float = 0.0
var reduced: bool = false
var bursts: Array[Dictionary] = []

func _process(delta: float) -> void:
	clock += delta
	for i: int in range(bursts.size()-1,-1,-1):
		bursts[i]["life"] = float(bursts[i]["life"])-delta
		if float(bursts[i]["life"]) <= 0: bursts.remove_at(i)
	queue_redraw()

func burst(point: Vector2, gold: bool = false) -> void:
	if bursts.size() < 14:
		bursts.append({"position":point,"life":0.45,"gold":gold})

func _draw() -> void:
	if not reduced:
		for i: int in range(30):
			var point: Vector2 = Vector2(fposmod(i*127.7+sin(clock*0.3+i)*36,1770)+75,fposmod(i*89.3-clock*7,820)+120)
			var alpha: float = (sin(clock*1.4+i*0.7)*0.5+0.5)*0.65
			draw_circle(point,5,Color(0.6,1,0.77,alpha*0.07))
			draw_circle(point,1.6,Color(0.82,1,0.65,alpha))
	for effect: Dictionary in bursts:
		var progress: float = 1.0-float(effect["life"])/0.45
		var point: Vector2 = effect["position"]
		var color: Color = Color("ffd277") if bool(effect["gold"]) else Color("a7f0d1")
		color.a = 1-progress
		for i: int in range(9):
			var angle: float = i*TAU/9+0.3
			var end: Vector2 = point+Vector2(cos(angle),sin(angle)*0.65)*progress*85
			draw_line(end,end+Vector2(cos(angle),sin(angle)*0.65)*(1-progress)*14,color,2.4,true)
		draw_arc(point,progress*45,0,TAU,32,Color(color,0.25*(1-progress)),2,true)
