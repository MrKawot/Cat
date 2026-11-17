class_name CatArt
extends RefCounted

const ATLAS: Texture2D = preload("res://assets/art/forest_atlas.png")
const FLOOR: Texture2D = preload("res://assets/art/forest_arena.png")
const TITLE_FONT: Font = preload("res://assets/fonts/Cinzel.ttf")
const BODY_FONT: Font = preload("res://assets/fonts/OpenSans-Semibold.ttf")
static var tiles: Dictionary = {}

static func tile(index: int) -> AtlasTexture:
	if not tiles.has(index):
		var texture: AtlasTexture = AtlasTexture.new()
		texture.atlas = ATLAS
		texture.region = Rect2((index%3)*512,(index/3)*512,512,512)
		texture.filter_clip = true
		tiles[index] = texture
	return tiles[index] as AtlasTexture

static func panel(background: Color, border: Color, radius: int = 12) -> StyleBoxFlat:
	var box: StyleBoxFlat = StyleBoxFlat.new()
	box.bg_color = background
	box.border_color = border
	box.set_border_width_all(2)
	box.set_corner_radius_all(radius)
	box.shadow_color = Color(0.005,0.02,0.025,0.45)
	box.shadow_size = 12
	return box
