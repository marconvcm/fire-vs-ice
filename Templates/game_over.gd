extends CanvasLayer

func _on_retry_button_pressed():
    get_tree().paused=false
    get_tree().reload_current_scene()

func _on_menu_button_pressed():
    pass # Replace with function body.
