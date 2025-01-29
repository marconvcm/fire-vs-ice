class_name archer extends EnemyBase
var normal_arrow=preload("normal_arrow.tscn")
var normal_arrow_speed=10
var special_arrow=preload("lobbed_fireball.tscn")
var target=null
@onready var normaltimer=$NormalTimer
@onready var specialtimer=$SpecialTimer
@onready var specialcooldowntimer=$SpecialCooldownTimer


func is_target_visible()->bool:
    $RayCast3D.target_position=target.global_position-self.global_position
    return $RayCast3D.get_collider()==target
func _process(_delta):
    if target!=null and is_target_visible():
        if normaltimer.is_stopped():
            fire_normal_arrow()

func _on_activation_area_body_entered(collidingbody):
    target=collidingbody
    normaltimer.start()
    

func fire_normal_arrow():
    var fired_arrow=normal_arrow.instantiate()
    fired_arrow.look_at_from_position(self.global_position, target.global_position)
    fired_arrow.linear_velocity=$RayCast3D.target_position.normalized()*normal_arrow_speed
    add_sibling(fired_arrow)
    normaltimer.start()
    
func fire_special_arrow():
    pass
