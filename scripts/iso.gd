class_name CatIso
extends RefCounted

const ORIGIN: Vector2 = Vector2(960, 530)

static func project(point: Vector2) -> Vector2:
	return ORIGIN + Vector2(point.x - point.y, (point.x + point.y) * 0.5) * 0.85

static func unproject_direction(direction: Vector2) -> Vector2:
	return Vector2(direction.x * 0.5 + direction.y, direction.y - direction.x * 0.5).normalized()

static func constrain(point: Vector2, radius: float = 22.0) -> Vector2:
	var p: Vector2 = point.clamp(Vector2(-510 + radius, -510 + radius), Vector2(510 - radius, 510 - radius))
	for center: Vector2 in [Vector2(-230, -150), Vector2(220, 160)]:
		var delta: Vector2 = p - center
		if delta.length() < 66.0 + radius:
			p = center + delta.normalized() * (66.0 + radius) if delta.length() > 0.01 else center + Vector2(66 + radius, 0)
	return p

static func move_world(from: Vector2, motion: Vector2) -> Vector2:
	var steps: int = maxi(1,ceili(motion.length()/12.0))
	var point: Vector2 = from
	for i: int in range(steps):
		point = constrain(point+motion/steps)
	return point
