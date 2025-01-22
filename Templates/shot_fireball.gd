class_name ShotFireball extends RigidBody3D
func fire( facing:Vector3, speed:float ) -> void:
    facing=facing.normalized();
    self.linear_velocity+=speed*facing;


func _on_body_entered(body):
    self.queue_free()
