extends CanvasLayer

var master=AudioServer.get_bus_index("Master")
var music=AudioServer.get_bus_index("Music")
var sfx=AudioServer.get_bus_index("SFX")

func _ready():
    $"PanelContainer/TabContainer/Basic Options/Master Volume Slider".value=db_to_linear(master)
    $"PanelContainer/TabContainer/Basic Options/Music Volume Slider".value=db_to_linear(music)
    $"PanelContainer/TabContainer/Basic Options/SFX Volume Slider".value=db_to_linear(sfx)
func _process(_delta):
    if PlayerInput.is_pause_just_pressed():
        if self.visible:
            self.visible=false
            get_tree().paused=false
        else:
            self.visible=true
    pass


func _on_master_volume_slider_value_changed(value):
    AudioServer.set_bus_volume_db(master, linear_to_db(value))


func _on_music_volume_slider_value_changed(value):
    AudioServer.set_bus_volume_db(music, linear_to_db(value))


func _on_sfx_volume_slider_value_changed(value):
    AudioServer.set_bus_volume_db(sfx, linear_to_db(value))


func _on_reset_button_pressed():
    get_tree().paused=false
    get_tree().reload_current_scene()
    


func _on_debug_pressed():
    get_tree().paused=false
    get_tree().change_scene_to_file("Level/Debug.tscn")


func _on_debug_2_pressed():
    get_tree().paused=false
    get_tree().change_scene_to_file("Level/Debug2.tscn")
