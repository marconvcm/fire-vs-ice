class_name Player extends Actor
var lobbed_fireball=preload("lobbed_fireball.tscn")
var shot_fireball=preload("shot_fireball.tscn")
const lobbing_angle=45;
const lobbing_speed=10;
var lobbing_cost=5;
const shooting_speed=20;
var shooting_cost=1;
var rage_cost=30;
var rage_cost_per_second=15;
var rage_start_damage=10;
var rage_damage_per_second=5
var radius:float=1.0
var raging:bool = false
var max_lob_charged:bool=false
@onready var heat = $Heat
@onready var shoottimer=$ShootTimer
@onready var lobtimer=$LobTimer
@onready var rage_area=$RageAoEArea
var maxheat:float = 1000.0
var dash_cost=10
var dashlength=5
var dashwidth=2
var dashspeed=5*speed
var dashstartpoint=null
@onready var dashdurationtimer=$DashDurationTimer
@onready var dashcooldowntimer=$DashCooldownTimer
var dash_rage_area=preload("dash_damage_area.tscn")
var current_dash_rage_area=null
@onready var animator=$AnimationPlayer

func _ready():
    heat.set_max_value(maxheat)
    heat.set_enabled(true)
    heat.set_rate(1.0)
    heat.set_depletable(true)
    heat.set_value(maxheat)
    heat.value_empty.connect(die)
    lobtimer.timeout.connect(maxLobChargeReached)
    dashdurationtimer.timeout.connect(dashend)
    
func get_move_axis() -> Vector3:
    return PlayerInput.get_axis().normalized().rotated(Vector3.UP, camera_rotation.y)

func get_aim_axis() -> Vector3:
    return PlayerInput.get_aim_direction().normalized().rotated(Vector3.UP, camera_rotation.y)

func _process(delta: float) -> void:
    if heat.value<0:
        die()
    if PlayerInput.is_pause_just_pressed():
        get_tree().paused=true
        
    var animationdirection=PlayerInput.get_aim_direction().normalized()
    if animationdirection==Vector3.ZERO:
        animationdirection=PlayerInput.get_axis().normalized()
    if abs(animationdirection.z)>=abs(animationdirection.x):
        if animationdirection.z>0:
            animator.play("Front Idle")
        else:
            animator.play("Back Idle")
    else:
        if animationdirection.x>0:
            animator.play("Right Idle")
        elif animationdirection.x!=0:
            animator.play("Left Idle")
            
    if raging and !PlayerInput.is_rage_pressed():
        rage_end()
    if PlayerInput.is_rage_pressed() and !raging and if_enough_heat(rage_cost):
        rage_start()    
    if raging:
        lose_heat(rage_cost_per_second*delta)
        rage_damage(rage_damage_per_second*delta)
    
    if PlayerInput.is_dash_just_pressed() and dashcooldowntimer.is_stopped() and if_enough_heat(dash_cost):
        lose_heat(dash_cost)
        dashstart()
    
    if PlayerInput.is_run_pressed():
        speed_scale = lerp(speed_scale, 2.0, 0.1)
    else:
        speed_scale = lerp(speed_scale, 1.0, 0.1)
        
    if PlayerInput.is_lob_pressed() and !max_lob_charged and lobtimer.is_stopped():
        lobtimer.start()
    if PlayerInput.is_lob_released():
        var strength= (lobtimer.get_wait_time()-lobtimer.get_time_left())/lobtimer.get_wait_time()
        if raging:
            strength*=2
        lose_heat(lobbing_cost)
        lob_fireball(strength)
        
    if PlayerInput.is_shoot_pressed() and shoottimer.is_stopped() and if_enough_heat(shooting_cost):
        lose_heat(shooting_cost)
        shoot_fireball()
        shoottimer.start()

func _physics_process(delta):
    if is_dashing():
        var gravity_strength=get_gravity_strength()
        velocity=facing*dashspeed+gravity_strength
        move_and_slide()
        if current_dash_rage_area!=null:
            var dash_distance=self.global_position-dashstartpoint
            current_dash_rage_area.grow(dash_distance)
    else:
        super._physics_process(delta)
        

func lob_fireball(strength:float):
    var fireballInst=lobbed_fireball.instantiate()
    fireballInst.set_strength(strength)
    fireballInst.position=self.position+facing*radius
    fireballInst.linear_velocity=self.velocity
    fireballInst.fire(facing,lobbing_speed)
    add_sibling(fireballInst)
    max_lob_charged=false
    lobtimer.stop()
    
func shoot_fireball()->void:
    var fireballInst=shot_fireball.instantiate()
    fireballInst.position=self.position+facing*radius
    fireballInst.linear_velocity=self.velocity
    fireballInst.fire(facing,shooting_speed)
    if raging:
        fireballInst.damage*=2
    add_sibling(fireballInst)
    
func rage_start()->void:
    raging=true
    lose_heat(rage_cost)
    rage_area.get_child(1).visible=true
    rage_damage(rage_start_damage)

            
func rage_damage(damage:float)->void:
    for target_body in rage_area.get_overlapping_bodies():
        if target_body.has_method("takeDamage"):
            target_body.takeDamage(damage)
            
func rage_end()->void:
    raging=false
    var area=$RageAoEArea
    area.get_child(1).visible=false

func if_enough_heat(damage:float)->bool:
    return (heat.value>damage)
    
func lose_heat(damage:float)->void:
    heat.deplete(damage)

func die()->void:
    $GameOver.visible=true
    #probably put a death animation and some other things here
    get_tree().paused=true

func maxLobChargeReached():
    max_lob_charged=true

func dashstart():
    #facing is locked due to not changing the physics process from default actor class, use that for direction
    dashstartpoint=self.global_position
    dashdurationtimer.start()
    dashcooldowntimer.start()
    set_collision_mask_value(3,0)
    set_collision_mask_value(4,0)
    if raging:
        current_dash_rage_area=dash_rage_area.instantiate()
        current_dash_rage_area.position=self.position
        if facing.z>=0:
            current_dash_rage_area.rotation=Vector3(0, asin(facing.x),0)
        else:
            current_dash_rage_area.rotation=Vector3(0, PI-asin(facing.x),0)
        add_sibling(current_dash_rage_area)
    
func dashend():
    dashstartpoint=null
    set_collision_mask_value(3,1)
    set_collision_mask_value(4,1)
    current_dash_rage_area=null

func is_dashing()->bool:
    return dashstartpoint!=null

func takeDamage(damage: float)->void:
    lose_heat(damage)
