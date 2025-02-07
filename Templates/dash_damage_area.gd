extends Area3D

var damage_per_second=5

func _on_timer_timeout():
    self.queue_free()

func grow(dash_distance:Vector3):
    $DashDamageAreaShape.shape.size.z=dash_distance.length() + 2
    $DashDamageAreaShape.position.z=dash_distance.length()/2
    $MeshInstance3D.mesh.size.y=dash_distance.length() + 2
    $MeshInstance3D.position.z=dash_distance.length()/2

func _process(delta):
    for body in self.get_overlapping_bodies():
        if body.has_method("takeDamage"):
            body.takeDamage(damage_per_second*delta)
        else:
            var bodyobject=body.get_parent()
            if bodyobject is burnable:
                bodyobject.burn(false)
    
