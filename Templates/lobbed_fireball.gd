class_name LobbedFireball extends RigidBody3D
func fire( facing:Vector2, speed:float ) -> void:
    facing=facing.normalized();
    self.linear_velocity=(speed/sqrt(2))*Vector3(facing.x, 1, facing.y);
