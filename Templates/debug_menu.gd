extends CanvasLayer

var master=AudioServer.get_bus_index("Master")
var music=AudioServer.get_bus_index("Music")
var sfx=AudioServer.get_bus_index("SFX")

func _ready():
    $"PanelContainer/TabContainer/Basic Options/Master Volume Slider".value=PlayerPrefsAndData.MasterVolume
    $"PanelContainer/TabContainer/Basic Options/Music Volume Slider".value=PlayerPrefsAndData.MusicVolume
    $"PanelContainer/TabContainer/Basic Options/SFX Volume Slider".value=PlayerPrefsAndData.SFXVolume
func _process(_delta):
    if PlayerInput.is_pause_just_pressed():
        if self.visible:
            self.visible=false
            unpause()
        else:
            self.visible=true
            $"PanelContainer/TabContainer/Basic Options/Reset Button".grab_focus()
    pass


func _on_master_volume_slider_value_changed(value):
    AudioServer.set_bus_volume_db(master, linear_to_db(value))
    PlayerPrefsAndData.MasterVolume=value


func _on_music_volume_slider_value_changed(value):
    AudioServer.set_bus_volume_db(music, linear_to_db(value))
    PlayerPrefsAndData.MusicVolume=value


func _on_sfx_volume_slider_value_changed(value):
    AudioServer.set_bus_volume_db(sfx, linear_to_db(value))
    PlayerPrefsAndData.SFXVolume=value


func _on_reset_button_pressed():
    unpause()
    get_tree().reload_current_scene()
    


func _on_debug_pressed():
    unpause()
    get_tree().change_scene_to_file("Level/Debug.tscn")


func _on_debug_2_pressed():
    unpause()
    get_tree().change_scene_to_file("Level/Debug2.tscn")


func _on_level_1_pressed():
    unpause()
    get_tree().change_scene_to_file("Level/level_1_editable.tscn")


func _on_main_menu_pressed():
    unpause()
    get_tree().change_scene_to_file("res://Templates/main_menu.tscn")

func unpause():
    PlayerPrefsAndData.writePrefs()
    get_tree().paused=false


func _on_level_1_final_pressed():
    unpause()
    get_tree().change_scene_to_file("res://Models/map_1_revised_feb_6.tscn")#note: clean up file locations later
