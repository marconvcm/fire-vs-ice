extends burnable
@export var spriteindex=1

func _ready():
    $StaticBody3D/AnimatedSprite3D.set_animation(str(spriteindex))
