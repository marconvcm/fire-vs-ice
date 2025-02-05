extends RigidBody3D
var damage=50

func _on_body_entered(body):
    if body.has_method("takeDamage"):
        body.takeDamage(damage)
    self.queue_free()

#note to self: tweak placement/rotation of arrow sprite based on orientation
