class_name LobbedFireball extends RigidBody3D
func fire( facing:Vector3, speed:float ) -> void:
    facing=facing.normalized();
    self.linear_velocity=(speed/sqrt(2))*(facing+Vector3(0,1,0));
