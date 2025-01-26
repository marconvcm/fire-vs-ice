class_name mimic extends EnemyBase
#This enemy stays still until either they are hit by the player or the player enters the enemy's activation range.
#Mimic can be deactivated if the player leaves the deactivation range and is out of the mimic's line of sight
var state:int=0
var target=null
const runspeed=10
var contactdamage=50
var explodedamage=200

#states: 0=hiding, 1=activated/chasing, 2=looking for player, 3=returning to hiding spot
func _ready():
    $GiveUpTimer.timeout.connect(state_transition, 3)
    $ExplodeTimer.timeout.connect(explode)
    health=5

func _process(_delta):
    match state:
        0:#if currently hiding
            pass
        1:
            if target!=null:
                velocity=runspeed*Vector3(0,0,0) +get_gravity_strength()#need to update for actual motion, probably using navigation agents
                move_and_slide()
        2:
            if is_target_visible():
                state_transition(1)
        3:
            pass
        _:
            pass


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
