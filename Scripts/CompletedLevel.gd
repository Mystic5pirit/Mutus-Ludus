extends Node2D

@onready var canvas_layer = $CanvasLayer

@export var enemies: Array[Node2D]

func _ready():
	for enemy in enemies:
		enemy.get_node("EnemyHealthTracker").enemy_died.connect(_on_enemy_died)

var dead_enemies: int = 0

func _on_enemy_died():
	dead_enemies += 1
	if dead_enemies >= enemies.size():
		get_tree().paused = true
		visible = true
		canvas_layer.visible = true


func _on_next_level_button_button_pressed():
	pass # Replace with function body.


func _on_main_menu_button_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://MainMenu/main_menu.tscn")
