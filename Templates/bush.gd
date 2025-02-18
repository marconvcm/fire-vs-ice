extends burnable
@export var spriteindex=1
#Note: this script should be attached to the sphere mesh that 

func _ready():
    $StaticBody3D/AnimatedSprite3D.set_animation(str(spriteindex))

func restore():
    #has it's own version to explicitly not make itself visible on restoration
    hitbox.set_collision_layer_value(6,true)
