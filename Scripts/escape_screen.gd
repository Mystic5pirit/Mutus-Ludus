extends Node2D

@onready var canvas_layer = $CanvasLayer



func _input(_event):
	if Input.is_action_just_pressed("Pause"):
		if not get_tree().paused:
			get_tree().paused = true
			visible = true
			canvas_layer.visible = true
		else:
			get_tree().paused = false
			visible = false
			canvas_layer.visible = false

func _on_button_button_pressed():
	get_tree().paused = false
	visible = false
	canvas_layer.visible = false
