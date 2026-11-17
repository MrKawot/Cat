class_name CatActionButton
extends Button

@export var symbol: String = "sword"
var cooldown: float = 0.0
var readiness: float = 0.0

func _ready() -> void:
	add_theme_stylebox_override("normal",StyleBoxEmpty.new())
	add_theme_stylebox_override("hover",StyleBoxEmpty.new())
	add_theme_stylebox_override("pressed",StyleBoxEmpty.new())
	add_theme_stylebox_override("focus",StyleBoxEmpty.new())
	add_theme_color_override("font_color",Color(0,0,0,0))
	add_theme_color_override("font_hover_color",Color(0,0,0,0))
	add_theme_color_override("font_focus_color",Color(0,0,0,0))
	add_theme_color_override("font_pressed_color",Color(0,0,0,0))

func _process(_delta: float) -> void:
	queue_redraw()

func _draw() -> void:
	var center: Vector2 = size/2
	var radius: float = minf(size.x,size.y)*0.45
	var gold: Color = Color("efcd8b")
	var active: bool = is_pressed()
	var fill: Color = Color("325b58") if active else Color(0.035,0.10,0.12,0.92)
	if symbol == "sun" and readiness >= 1:
		draw_circle(center,radius+9,Color(1,0.75,0.3,0.1))
	draw_circle(center+Vector2(0,5),radius+4,Color(0,0,0,0.3))
	draw_circle(center,radius,fill)
	draw_arc(center,radius,0,TAU,64,gold,2.5,true)
	draw_arc(center,radius-7,0,TAU,64,Color(0.8,0.71,0.49,0.25),1,true)
	if symbol == "sun":
		draw_arc(center,radius+4,-PI/2,-PI/2+maxf(0.01,readiness)*TAU,64,Color("ffdf91"),4,true)
	var icon_center: Vector2 = center-Vector2(0,10 if radius > 50 else 6)
	if symbol == "sword":
		draw_line(icon_center+Vector2(-17,18),icon_center+Vector2(20,-24),gold,8,true)
		draw_line(icon_center+Vector2(-23,4),icon_center+Vector2(-1,24),gold,5,true)
		draw_line(icon_center+Vector2(-21,24),icon_center+Vector2(-31,35),Color("a89162"),7,true)
		draw_colored_polygon(PackedVector2Array([icon_center+Vector2(15,-24),icon_center+Vector2(28,-33),icon_center+Vector2(24,-17)]),Color("fff0c4"))
	elif symbol == "dodge":
		for i: int in range(2):
			var offset: Vector2 = icon_center+Vector2(i*18-14,0)
			draw_polyline(PackedVector2Array([offset+Vector2(-7,-10),offset+Vector2(5,0),offset+Vector2(-7,10)]),gold,4,true)
	else:
		draw_arc(icon_center,14,0,TAU,32,gold,3,true)
		for i: int in range(8):
			var vector: Vector2 = Vector2.from_angle(i*TAU/8)
			draw_line(icon_center+vector*20,icon_center+vector*27,gold,3,true)
	if cooldown > 0:
		draw_arc(center,radius-3,-PI/2,-PI/2+minf(1,cooldown)*TAU,48,Color(0.06,0.10,0.12,0.85),radius*0.4,true)
	var caption: String = text.get_slice("\n",0)
	var font_size: int = 15 if radius < 50 else 17
	var width: float = CatArt.BODY_FONT.get_string_size(caption,HORIZONTAL_ALIGNMENT_LEFT,-1,font_size).x
	draw_string(CatArt.BODY_FONT,Vector2(center.x-width/2,center.y+radius*0.64),caption,HORIZONTAL_ALIGNMENT_LEFT,-1,font_size,gold)
