class_name Player extends Actor
var lobbed_fireball=preload("lobbed_fireball.tscn")
var shot_fireball=preload("shot_fireball.tscn")
const lobbing_angle=45;
const lobbing_speed=10;
var lobbing_cost=5;
const shooting_speed=20;
var shooting_cost=1;
var rage_cost=10;
var rage_damage=10;
var radius:float=1.0
var raging:bool = false
@onready var heat = $Heat
@onready var ragetimer=$RageTimer
@onready var shoottimer=$ShootTimer
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
    if PlayerInput.is_shoot_pressed() and shoottimer.is_stopped() and if_enough_heat(shooting_cost):
        lose_heat(shooting_cost)
        shoot_fireball()
        shoottimer.start()
    if PlayerInput.is_rage_pressed() and !raging and if_enough_heat(rage_cost):
        rage_start()
    if raging and !PlayerInput.is_rage_pressed():
        rage_end()

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
    
func rage_start()->void:
    raging=true
    heat.deplete(rage_cost)
    var area=$RageAoEArea
    area.get_child(1).visible=true
    for target_body in area.get_overlapping_bodies():
        if target_body.has_method("takeDamage"):
            target_body.takeDamage(rage_damage)
            
func rage_end()->void:
    raging=false
    var area=$RageAoEArea
    area.get_child(1).visible=false

func if_enough_heat(damage:int)->bool:
    return (heat.value>damage)
    
func lose_heat(damage:int)->void:
    heat.deplete(damage)

func die()->void:
    $GameOver.visible=true
    #probably put a death animation and some other things here
    get_tree().paused=true
