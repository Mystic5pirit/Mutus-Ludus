extends Node2D

@export var EnemyBulletShooter: Node2D

func fire(repetitions: int, time_between_firing: float, arc_of_fire: float):
	EnemyBulletShooter.fire(repetitions, time_between_firing, arc_of_fire)
