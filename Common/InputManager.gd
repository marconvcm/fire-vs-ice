class_name InputManager extends Node

#region Virtual functions to be overridden by child classes

func get_axis() -> Vector3:
    return Vector3(get_horizontal_axis(), 0, get_vertical_axis())

func get_horizontal_axis() -> float:
    return Input.get_axis("MoveLeft", "MoveRight")

func get_vertical_axis() -> float:
    return Input.get_axis("MoveUp", "MoveDown")

func get_modifier_strength(key: String) -> float:
    return Input.get_action_strength(key)

func is_action_pressed(action: String) -> bool:
    return Input.is_action_pressed(action)

func is_action_released(action: String) -> bool:
    return Input.is_action_just_released(action)

func is_action_just_pressed(action: String)->bool:
    return Input.is_action_just_pressed(action)

func get_digital() -> Vector2:
    var x = sign(Input.get_action_strength("DigitalRight") - Input.get_action_strength("DigitalLeft"))
    var y = sign(Input.get_action_strength("DigitalDown") - Input.get_action_strength("DigitalUp"))
    return Vector2(x, y)

func get_aim_vertical_axis() -> float:
    return Input.get_axis("AimVertical+", "AimVertical-")

func get_aim_horizontal_axis() -> float:
    return Input.get_axis("AimHorizontal-", "AimHorizontal+")

func get_aim_direction() -> Vector3:
    return Vector3(get_aim_horizontal_axis(), 0, get_aim_vertical_axis())

#endregion

#region Helper functions for common actions

func is_pause_pressed() -> bool:
    return self.is_action_pressed("Pause")
    
func is_pause_released() -> bool:
    return self.is_action_released("Pause")
    
func is_pause_just_pressed() -> bool:
    return self.is_action_just_pressed("Pause")

func is_main_action_pressed() -> bool:
    return self.is_action_pressed("MainAction")

func is_main_action_released() -> bool:
    return self.is_action_released("MainAction")

func is_secondary_action_pressed() -> bool:
    return self.is_action_pressed("SecondaryAction")

func is_secondary_action_released() -> bool:
    return self.is_action_released("SecondaryAction")

func is_aux1_action_pressed() -> bool:
    return self.is_action_pressed("Aux1Action")

func is_aux1_action_released() -> bool:
    return self.is_action_released("Aux1Action")

func is_aux2_action_pressed() -> bool:
    return self.is_action_pressed("Aux2Action")

func is_aux2_action_released() -> bool:
    return self.is_action_released("Aux2Action")

func is_left_modifier_pressed() -> bool:
    return self.is_action_pressed("LeftModifier")

func is_left_modifier_released() -> bool:
    return self.is_action_released("LeftModifier")

func is_right_modifier_pressed() -> bool:
    return self.is_action_pressed("RightModifier")

func is_right_modifier_released() -> bool:
    return self.is_action_released("RightModifier")

func left_modifier_strength() -> float:
    return self.get_modifier_strength("LeftModifier")

func right_modifier_strength() -> float:
    return self.get_modifier_strength("RightModifier")

#endregion
