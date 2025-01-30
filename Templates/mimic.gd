class_name mimic extends EnemyBase
#This enemy stays still until either they are hit by the player or the player enters the enemy's activation range.
#Mimic can be deactivated if the player leaves the deactivation range and is out of the mimic's line of sight
var state:int=0
var target=null
var contactdamage=50
var explodedamage=200
var target_position=null
@onready var home_position=self.global_position
@onready var navi = $NavigationAgent3D
var mimicprojectile=preload("res://Templates/mimic_projectile.tscn")
var projectilespeed=40
#states: 0=hiding, 1=activated/chasing, 2=looking for player, 3=returning to hiding spot
func _ready():
    $GiveUpTimer.timeout.connect(giveup)
    navi.velocity_computed.connect(Callable(_on_velocity_computed))
    health=5
    speed=2
    $ShotTimer.timeout.connect(shoot)

func _process(_delta):
    match state:
        0:#if currently hiding
            pass
        1:
            if target!=null:
                set_movement_target(target.global_position)
        2:
            if is_target_visible():
                set_movement_target(target.global_position)
                if !$GiveUpTimer.is_stopped(): $GiveUpTimer.stop()
            else:
                if $GiveUpTimer.is_stopped(): $GiveUpTimer.start()
                
        3:
            pass#code handled once in state change code
        _:
            pass

func _physics_process(_delta):
    if (target!=null and (!state==0)) or state==3:
        var next_path_position: Vector3 = navi.get_next_path_position()
        var new_velocity: Vector3 = global_position.direction_to(next_path_position)*speed+get_gravity_strength()
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
    if newstate==1:
        end_hiding()
    if newstate==3:
        target=null
        set_movement_target(home_position)
        navi.navigation_finished.connect(hide)
        $ShotTimer.stop()
    if newstate==0:
        begin_hiding()
    
func is_target_visible():
    $RayCast3D.target_position=target.global_position-self.global_position
    return $RayCast3D.get_collider()==target

func begin_hiding():
    #hide 2D sprite
    #show 3D version
    navi.navigation_finished.disconnect(end_hiding)
    
func end_hiding():
    #hide 3D version
    #show 2D sprite
    $ShotTimer.start()
    

func set_movement_target(movement_target: Vector3):
    navi.set_target_position(movement_target)
    
func _on_velocity_computed(safe_velocity: Vector3):
    velocity=safe_velocity
    move_and_slide()

func giveup():
    state_transition(3)
    
func shoot():
    if target!=null and is_target_visible():
        var fired_shot=mimicprojectile.instantiate()
        fired_shot.look_at_from_position(self.global_position, target.global_position)
        fired_shot.linear_velocity=$RayCast3D.target_position.normalized()*projectilespeed
        add_sibling(fired_shot)
