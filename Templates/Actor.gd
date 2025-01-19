class_name Actor extends CharacterBody3D

const GRAVITY = 9.8

@export var gravity_scale = 1.2
@export var speed = 5.0
@export var speed_scale = 1.0
@export var debug_root: Node3D
@export var body: MeshInstance3D

var camera_rotation = Vector3.ZERO

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
    return global_transform.origin - (get_aim_axis() * 100)

func _physics_process(_delta: float) -> void:
    var move_strength = get_move_axis()
    var aim_strength = get_aim_axis()
    var looking_direction = get_looking_direction()
    var moving_direction = get_moving_direction()
    var gravity_strength = get_gravity_strength()

    velocity = (move_strength * speed_scale * speed) + gravity_strength

    if has_any_strength():
        body.look_at(looking_direction if aim_strength.length() > 0 else moving_direction, Vector3.UP)

    if move_strength.length() > 0:
        debug_root.look_at(moving_direction, Vector3.UP)

    move_and_slide()