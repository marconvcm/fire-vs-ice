extends AudioStreamPlayer

var track1=preload("Resources/pirate_doomstufftest.mp3")

func _ready():
    stream=track1
    bus="Music"
    process_mode=Node.PROCESS_MODE_ALWAYS
    play()
