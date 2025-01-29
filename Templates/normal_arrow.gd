extends RigidBody3D
var damage=50

func _on_body_entered(body):
    print("Hit")
    if body.has_method("takeDamage"):
        body.takeDamage(damage)
    self.queue_free()
