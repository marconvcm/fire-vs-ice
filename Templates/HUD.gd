class_name HUD extends Control

@export var player: Player = null
@onready var heat_gauge: Gauge = $HeatGauge

func _ready():
    #This node assumes that the heat active value is the first child of the player, which is true on the prefab
    heat_gauge.connect_active_value(player.get_child(0))
