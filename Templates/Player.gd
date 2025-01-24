class_name Player extends Actor
var lobbed_fireball=preload("lobbed_fireball.tscn")
var shot_fireball=preload("shot_fireball.tscn")
const lobbing_angle=45;
const lobbing_speed=10;
const shooting_speed=20;
var radius:float=1.0
var heat:float = 1000
const heatlossrateindex=[0,0.5,1,3,10]#yes this is currently pretty arbitrary
func get_move_axis() -> Vector3:
    return PlayerInput.get_axis().normalized().rotated(Vector3.UP, camera_rotation.y)

func get_aim_axis() -> Vector3:
    return PlayerInput.get_aim_direction().normalized().rotated(Vector3.UP, camera_rotation.y)

func _process(_delta: float) -> void:
    if PlayerInput.is_pause_just_pressed():
        get_tree().paused=true
    if PlayerInput.is_right_modifier_pressed():
        speed_scale = lerp(speed_scale, 2.0, 0.1)
    else:
        speed_scale = lerp(speed_scale, 1.0, 0.1)
    if PlayerInput.is_lob_released():
        var fireballInst=lobbed_fireball.instantiate()
        fireballInst.position=self.position+facing*radius
        fireballInst.linear_velocity=self.velocity
        fireballInst.fire(facing,lobbing_speed)
        add_sibling(fireballInst)
    if PlayerInput.is_shoot_released():
        var fireballInst=shot_fireball.instantiate()
        fireballInst.position=self.position+facing*radius
        fireballInst.linear_velocity=self.velocity
        fireballInst.fire(facing,shooting_speed)
        add_sibling(fireballInst)
    if PlayerInput.is_rage_pressed():
        pass
