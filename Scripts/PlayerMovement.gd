extends CharacterBody2D

@onready var sprite_holder = $SpriteHolder
@onready var sprite = $SpriteHolder/Drop

@onready var bullet_collider = $Area2D/BulletCollider

@onready var bullet_shooter = $BulletShooter


const AERIAL_DROP = preload("res://blend_files/aerial_drop.png")
const LANDED_DROP = preload("res://blend_files/landed_drop.png")
const LANDED_DROP_LEFT_MOVING = preload("res://blend_files/landed_drop_left_moving.png")
const LANDED_DROP_RIGHT_MOVING = preload("res://blend_files/landed_drop_right_moving.png")


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


var time_since_jump: float = 0
var time_since_land: float = 0
var just_landed: bool = false
var double_jumped: bool = false
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		sprite_holder.scale.x = lerpf(sprite_holder.scale.x, 1.0, clampf(time_since_jump * 3, 0, 1))
		sprite_holder.scale.y = lerpf(sprite_holder.scale.y, 1.0, clampf(time_since_jump * 3, 0, 1))
		time_since_jump += delta
		if  not just_landed:
			just_landed = true
			sprite.texture = AERIAL_DROP
			bullet_collider.position.y = 0
			bullet_collider.scale.y = 1
	else:
		if just_landed:
			sprite.texture = LANDED_DROP
			sprite_holder.scale.x *= 1.5
			sprite_holder.scale.y *= 0.5
			bullet_collider.position.y = 5
			bullet_collider.scale.y = .7
			double_jumped = false
			just_landed = false
			time_since_land = 0
		else:
			sprite_holder.scale.x = lerpf(sprite_holder.scale.x, 1.0, clampf(time_since_land * 3, 0, 1))
			sprite_holder.scale.y = lerpf(sprite_holder.scale.y, 1.0, clampf(time_since_land * 3, 0, 1))
			time_since_land += delta
	
	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor() and not Input.is_action_pressed("Down"):
		jump()
	# Double Jump
	elif Input.is_action_just_pressed("Jump") and not double_jumped and not Input.is_action_pressed("Down") and InkLevel.inkLevel > InkLevel.threshold:
		jump()
		bullet_shooter.fire(Vector2.DOWN, 0.5).collision_mask = 257
		double_jumped = true
	elif Input.is_action_just_pressed("Jump") and Input.is_action_pressed("Down") and is_on_floor():
		var other_collider = get_last_slide_collision()
		if other_collider:
			if other_collider.get_collider_shape().one_way_collision:
				position.y += 1
		else: 
			jump()
	


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * SPEED
		if is_on_floor():
			if direction < 0:
				sprite.texture = LANDED_DROP_LEFT_MOVING
			else:
				sprite.texture = LANDED_DROP_RIGHT_MOVING
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.x == 0 and is_on_floor():
			sprite.texture = LANDED_DROP

	move_and_slide()

func jump():
	sprite_holder.scale.x = 0.75
	sprite_holder.scale.y = 1.25
	velocity.y = JUMP_VELOCITY
	time_since_jump = 0
