extends Node2D

@onready var tutorial: PackedScene = preload("res://Tutorial/tutorial.tscn")
@onready var level_1: PackedScene = preload("res://Level 1/level_1.tscn")
@onready var credits: PackedScene = preload("res://Scenes/credits.tscn")

func _ready():
	InkLevel.inkLevel = 6


func _on_tutorial_button_button_pressed():
	get_tree().change_scene_to_packed(tutorial)


func _on_level_1_button_button_pressed():
	get_tree().change_scene_to_packed(level_1)

func _on_credits_button_button_pressed():
	get_tree().change_scene_to_packed(credits)
