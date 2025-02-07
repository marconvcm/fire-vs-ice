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

func is_lob_pressed() -> bool:
    return self.is_action_pressed("Lob")

func is_lob_released() -> bool:
    return self.is_action_released("Lob")

func is_shoot_pressed() -> bool:
    return self.is_action_pressed("Shoot")

func is_shoot_just_pressed() -> bool:
    return self.is_action_just_pressed("Shoot")

func is_shoot_released() -> bool:
    return self.is_action_released("Shoot")

func is_shoot_just_released() -> bool:
    return self.is_action_just_pressed("Shoot")

func is_dash_just_pressed() -> bool:
    return self.is_action_just_pressed("Dash")

func is_dash_released() -> bool:
    return self.is_action_released("Dash")

func is_rage_pressed() -> bool:
    return self.is_action_pressed("Rage")

func is_rage_released() -> bool:
    return self.is_action_released("Rage")

func is_run_pressed() -> bool:
    return self.is_action_pressed("Run")

func is_run_released() -> bool:
    return self.is_action_released("Run")
#
#func left_modifier_strength() -> float:
    #return self.get_modifier_strength("LeftModifier")
#
#func right_modifier_strength() -> float:
    #return self.get_modifier_strength("RightModifier")

#endregion
