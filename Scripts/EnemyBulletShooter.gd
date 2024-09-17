extends Node2D

@export var bullet: PackedScene
@export var target: Node2D
@export var bullet_damage: float

func fire(repetitions: int, time_between_firing: float, arc_of_fire: float):
	arc_of_fire = deg_to_rad(arc_of_fire)
	for times in repetitions:
		var new_bullet = bullet.instantiate()
		add_child(new_bullet)
		new_bullet.reparent(get_tree().get_first_node_in_group("Level"))
		new_bullet.set_meta("damage_amount", 0.5)
		var bullet_speed = new_bullet.base_speed
		var bullet_velocity = (target.get_global_transform().get_origin() - get_global_transform().get_origin()).normalized().rotated(randf_range(-0.5 * arc_of_fire, 0.5 * arc_of_fire)) * bullet_speed
		new_bullet.set_bullet_velocity(bullet_velocity)
		await get_tree().create_timer(time_between_firing).timeout
