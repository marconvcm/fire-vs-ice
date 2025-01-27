class_name mimic extends EnemyBase
#This enemy stays still until either they are hit by the player or the player enters the enemy's activation range.
#Mimic can be deactivated if the player leaves the deactivation range and is out of the mimic's line of sight
var state:int=0
var target=null
var contactdamage=50
var explodedamage=200
var target_position=null
@onready var navi = $NavigationAgent3D

#states: 0=hiding, 1=activated/chasing, 2=looking for player, 3=returning to hiding spot
func _ready():
    $GiveUpTimer.timeout.connect(state_transition, 3)
    $ExplodeTimer.timeout.connect(explode)
    navi.velocity_computed.connect(Callable(_on_velocity_computed))
    health=5

func _process(_delta):
    match state:
        0:#if currently hiding
            pass
        1:
            if target!=null:
                set_movement_target(target.global_position)
        2:
            if is_target_visible():
                state_transition(1)
        3:
            if target!=null:
                set_movement_target(target.global_position)
        _:
            pass

func _physics_process(_delta):
    if target!=null and (state==1||state==3):
        var next_path_position: Vector3 = navi.get_next_path_position()
        var new_velocity: Vector3 = global_position.direction_to(next_path_position)*speed
        _on_velocity_computed(new_velocity)

func _on_activation_area_body_shape_entered(_body_rid, collidingbody, _body_shape_index, local_shape_index):
    match state:
        0: #if hiding, only activate at lower radius
            if local_shape_index==0:
                target=collidingbody
                state_transition(1)
        1: #if already chasing, no need to care about collision
            pass
        _: #otherwise start chasing
            target=collidingbody
            state_transition(1)#start chasing


func _on_activation_area_body_shape_exited(_body_rid, _body, _body_shape_index, local_shape_index):
    match state:
        1: #if already chasing, stop chasing when escaping larger radius
            if local_shape_index==1:#if deactivation shape area exited
                state_transition(2)
        _:
            pass

func state_transition(newstate:int):
    #can put code triggering animations and the like depending on involved states here
    state=newstate
    
func is_target_visible():
    $RayCast3D.target_position=target.global_position-self.global_position
    return $RayCast3D.get_collider()==target
    
func prepareToDie():
    dying=true
    $ExplodeTimer.start()

func explode():
    pass

func begin_hiding():
    pass
    
func end_hiding():
    pass

func set_movement_target(movement_target: Vector3):
    navi.set_target_position(movement_target)
    
func _on_velocity_computed(safe_velocity: Vector3):
    velocity=safe_velocity
    move_and_slide()
