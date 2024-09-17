extends Sprite2D

func _ready():
	InkLevel.InkLevelChanged.connect(_on_ink_level_change)
	_on_ink_level_change()
	
func _on_ink_level_change():
	region_rect.size.x = (InkLevel.inkLevel/24) * 4320
	
