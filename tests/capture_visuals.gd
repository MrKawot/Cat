extends SceneTree

# Rendered visual fixtures, not an Android device or performance test.
func _initialize() -> void:
	call_deferred("capture")

func snap(path: String) -> void:
	await process_frame
	await process_frame
	await RenderingServer.frame_post_draw
	var image: Image = root.get_texture().get_image()
	var error: Error = image.save_png(path)
	if error != OK:
		printerr("Screenshot failed: ",path)
		quit(1)
	print("Captured: ",path)

func capture() -> void:
	var arena: CatArena = load("res://scenes/main.tscn").instantiate() as CatArena
	root.add_child(arena)
	arena.set_process(false)
	DirAccess.make_dir_recursive_absolute("res://docs/screenshots")
	await snap("res://docs/screenshots/graphics-title.png")
	arena.new_run()
	arena.player.facing = Vector2(1,-0.3)
	arena.player.tick(0,Vector2.ZERO)
	for enemy: CatEnemy in arena.enemies:
		enemy.tick(0,arena.player,false)
	await snap("res://docs/screenshots/graphics-combat.png")
	arena.player.charge = 100
	arena.perform_transform()
	arena.player.tick(0.12,Vector2.ZERO)
	arena._update_hud()
	await snap("res://docs/screenshots/graphics-titan-staged.png")
	arena.queue_free()
	await process_frame
	quit()
