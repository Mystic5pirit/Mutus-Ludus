extends Node2D

@export var delay_amount: float = 1

var bullet = preload("res://Scenes/bullet.tscn")

@export var enemy_bullet_detection: Area2D

func _ready():
	enemy_bullet_detection.take_damage.connect(_on_enemy_bullet_detection_take_damage)

func _on_enemy_bullet_detection_take_damage(amount):
	await get_tree().create_timer(delay_amount).timeout
	var new_bullet = bullet.instantiate()
	new_bullet.set_meta("ink_level", amount * 2)
	new_bullet.collision_layer = 64
	add_child(new_bullet)
	new_bullet.reparent(get_tree().root)
	new_bullet.global_rotation = 0
	new_bullet.linear_velocity = Vector2.DOWN
