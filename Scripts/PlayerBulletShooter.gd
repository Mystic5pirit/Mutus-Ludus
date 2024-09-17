extends Node2D

@onready var bullet = preload("res://Scenes/bullet.tscn")

@export var bullet_speed = 700

func _input(_event):
	if Input.is_action_just_pressed("Shoot") and InkLevel.inkLevel > InkLevel.threshold:
		fire(get_local_mouse_position().normalized().rotated(get_global_transform().get_rotation()), 0.5)
	

func fire(direction: Vector2, amount: float, speed: float = bullet_speed):
	InkLevel.DecreaseLevel(amount)
	var new_bullet = bullet.instantiate()
	new_bullet.set_meta("ink_level", amount)
	call_deferred("add_child", new_bullet)
	new_bullet.call_deferred("reparent", get_tree().get_first_node_in_group("Level"))
	new_bullet.linear_velocity = direction * speed
	return(new_bullet)
