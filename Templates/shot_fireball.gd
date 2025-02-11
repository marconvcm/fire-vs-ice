class_name ShotFireball extends RigidBody3D
var damage=1;
func fire( facing:Vector3, speed:float ) -> void:
    facing=facing.normalized();
    self.linear_velocity+=speed*facing;


func _ready():
    $AnimatedSprite3D.play()
    pass
    
func _on_body_entered(body):
    if body.has_method("takeDamage"):
        body.takeDamage(damage);
    else:
        var bodyobject=body.get_parent()
        if bodyobject is burnable:
            bodyobject.burn(false)
    self.queue_free()
