extends Node
@onready var mainmenu=$MainMenuLayer
@onready var options=$OptionsMenuLayer
@onready var credits=$CreditsMenuLayer

var master=AudioServer.get_bus_index("Master")
var music=AudioServer.get_bus_index("Music")
var sfx=AudioServer.get_bus_index("SFX")

func _ready():
    $"OptionsMenuLayer/VBoxContainer/Master Volume Slider".value=PlayerPrefsAndData.MasterVolume
    $"OptionsMenuLayer/VBoxContainer/Music Volume Slider".value=PlayerPrefsAndData.MusicVolume
    $"OptionsMenuLayer/VBoxContainer/SFX Volume Slider".value=PlayerPrefsAndData.SFXVolume
    MusicPlayer.menu()
    $MainMenuLayer/VBoxContainer/Play.grab_focus()

func _on_play_pressed():
    get_tree().change_scene_to_file("res://Level/map_1_revised_feb_6.tscn")

func _on_options_pressed():
    mainmenu.visible=false
    options.visible=true
    $"OptionsMenuLayer/VBoxContainer/Master Volume Slider".grab_focus()

func _on_credits_pressed():
    mainmenu.visible=false
    credits.visible=true
    $"CreditsMenuLayer/VBoxContainer/Credits Back Button".grab_focus()

func _on_options_back_button_pressed():
    PlayerPrefsAndData.writePrefs()
    options.visible=false
    mainmenu.visible=true
    $MainMenuLayer/VBoxContainer/Play.grab_focus()

func _on_credits_back_button_pressed():
    credits.visible=false
    mainmenu.visible=true
    $MainMenuLayer/VBoxContainer/Play.grab_focus()

func _on_master_volume_slider_value_changed(value):
    AudioServer.set_bus_volume_db(master, linear_to_db(value))
    PlayerPrefsAndData.MasterVolume=value


func _on_music_volume_slider_value_changed(value):
    AudioServer.set_bus_volume_db(music, linear_to_db(value))
    PlayerPrefsAndData.MusicVolume=value


func _on_sfx_volume_slider_value_changed(value):
    AudioServer.set_bus_volume_db(sfx, linear_to_db(value))
    PlayerPrefsAndData.SFXVolume=value
