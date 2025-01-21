class_name Actor extends CharacterBody3D

const GRAVITY = 9.8

@export var gravity_scale = 1.2
@export var speed = 5.0
@export var speed_scale = 1.0
@export var debug_root: Node3D
@export var body: MeshInstance3D

var camera_rotation = Vector3.ZERO
var current_looking_direction = Vector3.ZERO
var facing = Vector3.ZERO    

func _ready():
    pass

func is_moving() -> bool:
    return velocity.length() > 0

func has_any_strength() -> bool:
    return get_move_axis().length() > 0 or get_aim_axis().length() > 0

func is_falling() -> bool:
    return not is_on_floor()

func get_gravity_strength() -> Vector3:
    return Vector3.ZERO if is_on_floor() else Vector3.DOWN * GRAVITY * gravity_scale

func get_move_axis() -> Vector3:
    return Vector3.ZERO

func get_aim_axis() -> Vector3:
    return Vector3.ZERO

func get_moving_direction() -> Vector3:
    return global_transform.origin - get_move_axis()

func get_looking_direction() -> Vector3:
    
    var direction = Vector3.ZERO 
    
    if get_aim_axis().length() > 0:
        direction = global_transform.origin - (get_aim_axis() * 100)
        facing=get_aim_axis()
    else:
        direction = get_moving_direction()
        if get_move_axis().length()>0:
            facing=get_move_axis()

    current_looking_direction = current_looking_direction.lerp(direction, speed_scale / 4)
    
    return current_looking_direction

func _physics_process(_delta: float) -> void:
    var move_strength = get_move_axis()
    var looking_direction = get_looking_direction()
    var moving_direction = get_moving_direction()
    var gravity_strength = get_gravity_strength()

    velocity = (move_strength * speed_scale * speed) + gravity_strength

    DebugPlugin.instance.watch("velocity", velocity)
    DebugPlugin.instance.watch("current_looking_direction", current_looking_direction)
    DebugPlugin.instance.watch("facing",facing)

    if has_any_strength():
        body.look_at(looking_direction)

    if move_strength.length() > 0:
        debug_root.look_at(moving_direction, Vector3.UP)

    move_and_slide()
