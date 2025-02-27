extends burnable
@export var torch_ID:int
@onready var firesprite=$StaticBody3D/FireSprite
signal torch_lit(torch_ID:int)

func ready():
    firesprite.visible=false
    

func burn(touching:bool) -> float:
    if firesprite.visible==false:
        firesprite.visible=true
        torch_lit.emit(torch_ID)
    return 0

func restore():
    pass #do nothing, overriding default, since resets shouldn't effect torch state
