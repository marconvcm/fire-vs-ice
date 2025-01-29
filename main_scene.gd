extends Node

func _ready():
    ProjectSettings.load_resource_pack("res://2Dgraphics.pck")
    ProjectSettings.load_resource_pack("res://3Dgraphics.pck")
    ProjectSettings.load_resource_pack("res://audio.pck")
    get_tree().change_scene_to_file("res://Templates/main_menu.tscn")
