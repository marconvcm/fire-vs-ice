extends AudioStreamPlayer

var track1=preload("res://Resources/pirate_finalboss.mp3")

func _ready():
	stream=track1
	bus="Music"
	process_mode=Node.PROCESS_MODE_ALWAYS
	play()
