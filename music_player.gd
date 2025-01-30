extends AudioStreamPlayer


var menutrack=preload("res://Resources/pirate_menu.mp3")
var exploretrack=preload("res://Resources/pirate_exploration.mp3")
var fighttrack=preload("res://Resources/pirate_gameplay.mp3")
var bosstrack=preload("res://Resources/pirate_finalboss.mp3")

func _ready():
    stream=menutrack
    bus="Music"
    process_mode=Node.PROCESS_MODE_ALWAYS
    play()

func menu():
    stream=menutrack
    play()

func explore():
    stream=exploretrack
    play()

func fight():
    stream=fighttrack
    play()
    
func boss():
    stream=bosstrack
    play()
