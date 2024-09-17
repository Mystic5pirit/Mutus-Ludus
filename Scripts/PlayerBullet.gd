extends RigidBody2D

@onready var sprite_holder = $SpriteHolder
@onready var sprite = $SpriteHolder/Drop

const AERIAL_DROP = preload("res://blend_files/aerial_drop.png")
const LANDED_DROP = preload("res://blend_files/landed_drop.png")

@onready var drop_size = sqrt(get_meta("ink_level") * 2)

var time_since_shot: float = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite_holder.scale.x = drop_size
	sprite_holder.scale.y = drop_size
	collision_mask = 256
	await get_tree().create_timer(.1).timeout
	collision_mask = 257


var time_since_land: float = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time_since_shot += delta
	if is_on_floor:
		sprite_holder.scale.x = lerpf(sprite_holder.scale.x, drop_size, clampf(time_since_land * 3, 0, 1))
		sprite_holder.scale.y = lerpf(sprite_holder.scale.y, drop_size, clampf(time_since_land * 3, 0, 1))
		time_since_land += delta



var is_on_floor: bool = false

func _on_body_entered(_body):
	sprite.texture = LANDED_DROP
	sprite_holder.scale.x *= 1.5
	sprite_holder.scale.y *= 0.5
	is_on_floor = true
	time_since_land = 0






func _on_body_exited(_body):
	is_on_floor = false
	sprite_holder.scale.x = drop_size
	sprite_holder.scale.y = drop_size
	sprite.texture = AERIAL_DROP

