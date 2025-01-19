class_name DebugPanel extends Control

var watch_list_panel = {}

@onready var vbox = $VBox
@onready var panel_prototype = $VBox/Panel

func _ready():
   pass

func watch(key, value):
   add_watch_panel(key, value)

func add_watch_panel(key, value):
   var panel

   if not watch_list_panel.has(key):
      panel = panel_prototype.duplicate()
      panel.visible = true
      watch_list_panel[key] = panel
      vbox.add_child(panel)
   else:
      panel = watch_list_panel[key]

   panel.get_node("Label").text = key
   panel.get_node("Value").text = str(value)

func unwatch(key):
   if watch_list_panel.has(key):
      watch_list_panel[key].queue_free()
      watch_list_panel.erase(key)