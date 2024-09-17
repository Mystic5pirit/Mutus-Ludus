extends RichTextLabel

var time = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	var minutes: int = floor(time/60)
	var seconds: int = floor(time) - (minutes * 60)
	@warning_ignore("narrowing_conversion")
	var centiseconds: int = fmod(time,1) * 100
	
	text = str(minutes) + ":" + str(seconds).pad_zeros(2) + "." + str(centiseconds).pad_decimals(0).pad_zeros(2)
	pass
