extends Node2D

func _draw() -> void:
	for i: int in range(3):
		draw_set_transform(Vector2(0,6),0,Vector2(1,0.42))
		draw_circle(Vector2.ZERO,61-i*7,Color(0.01,0.03,0.025,0.15))
	draw_set_transform(Vector2.ZERO)
	draw_texture_rect(CatArt.tile(4),Rect2(-85,-191,170,210),false)
