extends CharacterBody2D


@export var base_speed: int
@onready var bullet_velocity := Vector2(base_speed, 0)

@export var sprite: Sprite2D
@export var possible_sprites: Array[Texture]

func _ready():
	sprite.texture = possible_sprites[randi_range(0,possible_sprites.size() - 1)]

func _physics_process(delta):
	move_and_collide(bullet_velocity * delta)

	
func set_bullet_velocity(new_velocity: Vector2):
	bullet_velocity = new_velocity
	

