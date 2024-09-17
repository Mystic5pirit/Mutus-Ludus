extends Node2D

@export var y_time_offset: float
@export var text: String
@onready var rich_text_label = $RichTextLabel
@onready var texture_button = $TextureButton

signal button_pressed()

var base_y_position: float
# Called when the node enters the scene tree for the first time.
func _ready():
	base_y_position = position.y
	rich_text_label.text = "[center]" + text
	texture_button.button_up.connect(_on_texture_button_button_up)
	

var time_since_start: float = 0
var clockwise: bool = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if clockwise:
		rotate(delta / 30)
	else: 
		rotate(-1 * delta/ 30)
	
	if rotation_degrees > 1:
		clockwise = false
	elif rotation_degrees < -1:
		clockwise = true
	
	position.y = base_y_position + (sin(time_since_start * 2 + y_time_offset) * 5)
	time_since_start += delta
	
func _on_texture_button_button_up():
	button_pressed.emit()
