class_name DebugPlugin extends Node

const FloorTagScenePath = "res://Templates/FloorTag.tscn"

static var instance : DebugPlugin

@export var world : Node3D
@export var panel : DebugPanel
@export var debug_enabled : bool = true

func _ready():
   if debug_enabled:
      if world == null:
         print_debug("DebugPlugin.World is not set!")
         return
      if instance == null:
         instance = self
      else:
         print_debug("DebugPlugin instance already exists! parent: " + str(instance.get_parent()))
         return   

func watch(key: String, value: Variant):
   if debug_enabled:
      panel.watch(key, value)
