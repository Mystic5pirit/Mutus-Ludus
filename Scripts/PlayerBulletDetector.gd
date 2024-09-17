extends Area2D

@export var invincibility_time: float
var invincible: bool = false

@export var bullet_shooter: Node2D
@export var splash_spread: float
@export var splash_count: int
@export var splash_speed: float

func _ready():
	splash_spread = deg_to_rad(splash_spread)

func _on_body_entered(body:PhysicsBody2D):
	if (body.collision_layer == 4 and body.time_since_shot > 0.5) or body.collision_layer == 64:
		InkLevel.IncreaseLevel(body.get_meta("ink_level"))
		body.queue_free()
	elif body.collision_layer == 8:
		body.queue_free()
		if not invincible:
			var hit_direction = (body.bullet_velocity).normalized()
			var splash_direction = hit_direction.reflect(Vector2.RIGHT)
			for num in splash_count:
				bullet_shooter.fire(splash_direction.rotated(randf_range(-0.5 * splash_spread, 0.5 * splash_spread)), body.get_meta("damage_amount")/splash_count, splash_speed)
			
			
			invincible = true
			await get_tree().create_timer(invincibility_time).timeout
			invincible = false




