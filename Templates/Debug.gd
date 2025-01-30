extends Node3D

@onready var player: Player = $Player
@onready var hud: HUD = $HUD
@onready var debug_plugin: DebugPlugin = $DebugPlugin

func _ready():
    MusicPlayer.boss()
