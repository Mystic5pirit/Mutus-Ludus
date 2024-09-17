extends AnimationPlayer


@export var audio_stream_player: AudioStreamPlayer

func _ready():
	animation_finished.connect(_on_animation_finished)

func _on_animation_finished(_anim_name):
	play("action")
	audio_stream_player.play()

