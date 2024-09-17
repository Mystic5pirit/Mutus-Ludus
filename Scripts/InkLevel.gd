extends Node2D

@export var inkLevel: float = 6
@export var threshold: float = 0.5

signal InkIncreased(amount: float)
signal InkDecreased(amount: float)
signal InkLevelChanged()
signal InkLevelReachedZero()

func IncreaseLevel(amount: float):
	inkLevel += amount
	emit_signal("InkLevelChanged")


func DecreaseLevel(amount: float):
	inkLevel -= amount
	emit_signal("InkLevelChanged")
	if inkLevel <= 0:
		emit_signal("InkLevelReachedZero")

