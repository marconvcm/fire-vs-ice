class_name burnable extends MeshInstance3D
@export var heatvalue:float = 100
@onready var hitbox=self.get_child(0)

func burn(touching:bool)->float:
    play_burning_animation()
    disable()
    if touching: 
        return heatvalue
    else:
        return 0#might let it reduce heat loss over time or something
    
func play_burning_animation():
    pass
    
func restore():
    self.visible=true
    hitbox.set_collision_layer_value(6,true)
    
func disable():
    self.visible=false
    hitbox.set_collision_layer_value(6,false)
