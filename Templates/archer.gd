class_name archer extends EnemyBase
var normal_arrow=preload("normal_arrow.tscn")
var normal_arrow_speed=20
var special_arrow=preload("special_arrow.tscn")
var special_arrow_speed=40
var target=null
var charging:bool=false
var shots_between_specials=2
var shot_index=0
@onready var normaltimer=$NormalTimer
@onready var specialtimer=$SpecialTimer
var normal_arrow_sound=preload("res://Resources/SFX/Bowpull.mp3")
var special_arrow_sound=preload("res://Resources/SFX/big_bow.mp3")

func _ready():
    specialtimer.timeout.connect(fire_special_arrow)

func is_target_visible()->bool:
    $RayCast3D.target_position=target.global_position-self.global_position
    return $RayCast3D.get_collider()==target
func _process(_delta):
    if target!=null and is_target_visible():
        if normaltimer.is_stopped() and !charging:
            if shot_index==shots_between_specials:
                charge_special_arrow()
            else:
                fire_normal_arrow()

func _on_activation_area_body_entered(collidingbody):
    target=collidingbody
    
func fire_normal_arrow():
    var fired_arrow=normal_arrow.instantiate()
    fired_arrow.look_at_from_position(self.global_position, target.global_position)
    fired_arrow.linear_velocity=$RayCast3D.target_position.normalized()*normal_arrow_speed
    add_sibling(fired_arrow)
    normaltimer.start()
    shot_index+=1
    
func charge_special_arrow():
    charging=true
    specialtimer.start()    
    
func fire_special_arrow():
    var fired_arrow=special_arrow.instantiate()
    fired_arrow.look_at_from_position(self.global_position, target.global_position)
    fired_arrow.linear_velocity=$RayCast3D.target_position.normalized()*normal_arrow_speed
    add_sibling(fired_arrow)
    normaltimer.start()
    shot_index=0
    charging=false
    
