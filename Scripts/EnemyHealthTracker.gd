extends Node

signal enemy_died()

@export var health: float = 12

@export var sprite: Node
@export var enemy_bullet_detection: Node2D

func _ready():

	enemy_bullet_detection.take_damage.connect(_on_enemy_bullet_detection_take_damage)


func _on_enemy_bullet_detection_take_damage(amount):
	health -= amount

	if health > 0:
		sprite.modulate = Color.html("5D6087")
		await get_tree().create_timer(.2).timeout
		sprite.modulate = Color.WHITE
	else:
		emit_signal("enemy_died")
		get_parent().queue_free()

