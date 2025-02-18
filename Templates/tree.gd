extends burnable
@export var spriteindex=1
#Note: this script should be attached to the sphere mesh that 

func _ready():
    $AnimatedSprite3D.set_animation(str(spriteindex))
