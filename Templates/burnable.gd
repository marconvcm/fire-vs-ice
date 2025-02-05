class_name burnable extends MeshInstance3D
@export var heatvalue:float = 100

func burn(touching:bool)->float:
    play_burning_animation()
    disable()
    return heatvalue
    
func play_burning_animation():
    pass
    
func restore():
    pass
    
func disable():
    pass
