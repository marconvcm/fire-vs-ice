class_name Player extends Actor
var lobbed_fireball=preload("lobbed_fireball.tscn")
var shot_fireball=preload("shot_fireball.tscn")
const lobbing_angle=45;
const lobbing_speed=10;
var lobbing_cost=5;
const shooting_speed=20;
var shooting_cost=1;
var radius:float=1.0
@onready var heat = $Heat
var maxheat:float = 1000.0

func _ready():
    heat.set_max_value(maxheat)
    heat.set_enabled(true)
    heat.set_rate(1.0)
    heat.set_depletable(true)
    heat.set_value(maxheat)
    heat.value_empty.connect(die)
    
func get_move_axis() -> Vector3:
    return PlayerInput.get_axis().normalized().rotated(Vector3.UP, camera_rotation.y)

func get_aim_axis() -> Vector3:
    return PlayerInput.get_aim_direction().normalized().rotated(Vector3.UP, camera_rotation.y)

func _process(_delta: float) -> void:
    if heat.value<0:
        die()
    if PlayerInput.is_pause_just_pressed():
        get_tree().paused=true
    if PlayerInput.is_right_modifier_pressed():
        speed_scale = lerp(speed_scale, 2.0, 0.1)
    else:
        speed_scale = lerp(speed_scale, 1.0, 0.1)
    if PlayerInput.is_lob_released() and if_enough_heat(lobbing_cost):
        lose_heat(lobbing_cost)
        lob_fireball()
    if PlayerInput.is_shoot_released() and if_enough_heat(shooting_cost):
        lose_heat(shooting_cost)
        shoot_fireball()
    if PlayerInput.is_rage_pressed():
        pass

func lob_fireball():
    var fireballInst=lobbed_fireball.instantiate()
    fireballInst.position=self.position+facing*radius
    fireballInst.linear_velocity=self.velocity
    fireballInst.fire(facing,lobbing_speed)
    add_sibling(fireballInst)
    
func shoot_fireball()->void:
    var fireballInst=shot_fireball.instantiate()
    fireballInst.position=self.position+facing*radius
    fireballInst.linear_velocity=self.velocity
    fireballInst.fire(facing,shooting_speed)
    add_sibling(fireballInst)
    
func if_enough_heat(damage:int)->bool:
    return (heat.value>damage)
    
func lose_heat(damage:int)->void:
    heat.deplete(damage)

func die()->void:
    #put AV feedback for death here
    get_tree().reload_current_scene()
