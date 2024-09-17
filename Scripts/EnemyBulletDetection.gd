extends Area2D

signal take_damage(amount)

func _on_body_entered(body:PhysicsBody2D):
	if body.collision_layer == 4:
		emit_signal("take_damage", body.get_meta("ink_level"))
		body.queue_free()



