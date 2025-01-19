class_name GimbalCamera extends Camera3D

@export var sensitivity: float = 0.1
@export var target: Node3D
@export var gimbal: Node3D
@export var moving_fov: float = 25.0
@export var idle_fov: float = 20.0

var min_position: Vector3 = Vector3(-50, 0, -16)
var max_position: Vector3 = Vector3(50, 16, 16)

func _physics_process(_delta: float) -> void:
   target.camera_rotation = rotation
   gimbal.position = gimbal.position.lerp(target.global_position, sensitivity).clamp(min_position, max_position)

   DebugPlugin.instance.watch_node("target.is_moving()", target.is_moving())

   if target.is_moving():
      fov = lerp(fov, moving_fov, sensitivity)
   else:
      fov = lerp(fov, idle_fov, sensitivity)
   look_at_from_position(gimbal.global_position, target.position, Vector3.UP)