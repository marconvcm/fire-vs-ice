class_name Player extends Actor
var lobbed_fireball=preload("lobbed_fireball.tscn")
func get_move_axis() -> Vector3:
    return PlayerInput.get_axis().normalized().rotated(Vector3.UP, camera_rotation.y)

func get_aim_axis() -> Vector3:
    return PlayerInput.get_aim_direction().normalized().rotated(Vector3.UP, camera_rotation.y)

func _process(_delta: float) -> void:
    if PlayerInput.is_right_modifier_pressed():
        speed_scale = lerp(speed_scale, 2.0, 0.1)
    else:
        speed_scale = lerp(speed_scale, 1.0, 0.1)
    if PlayerInput.is_main_action_released():
        var fireballInst=lobbed_fireball.instantiate()
        fireballInst.position=self.position
        add_sibling(fireballInst)
