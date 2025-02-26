extends burnable
@export var spriteindex=1
@onready var sprite=$StaticBody3D/AnimatedSprite3D
#Note: this script should be attached to the sphere mesh that 

func _ready():
    sprite.set_animation(str(spriteindex))

func burn(touching:bool)->float:
    play_burning_animation()
    #disable()
    if touching: 
        return heatvalue
    else:
        return 0#might let it reduce heat loss over time or something

#turns off collision
func disable():
    hitbox.set_collision_layer_value(6,false)
    pass

#turns collision back on after a reload
func restore():
    hitbox.set_collision_layer_value(6,true)

func play_burning_animation():
    sprite.set_animation("burning")
    sprite.play()
    pass
