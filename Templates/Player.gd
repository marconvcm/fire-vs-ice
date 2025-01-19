class_name Player extends Actor

func get_move_axis() -> Vector3:
   return PlayerInput.get_axis().normalized().rotated(Vector3.UP, camera_rotation.y)

func get_aim_axis() -> Vector3:
   return PlayerInput.get_aim_direction().normalized()