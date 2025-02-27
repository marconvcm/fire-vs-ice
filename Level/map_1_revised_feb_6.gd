extends Node3D
var playerspawnposition: Vector3
var torchstatus=[0,0,0,0,0,0,0,0,0,0,0]

func _ready():
    playerspawnposition=$Player.global_position;
    

func ResetLevel():
    get_tree().call_group("Burnables", "restore")
    $Player.global_position=playerspawnposition;

func on_torch_lit(torchindex:int):
    if torchstatus[torchindex]==0:
        torchstatus[torchindex]=1
        checkifalllit()
    pass
    
func checkifalllit():
    if torchstatus.has(0):
        print("Torch lit, but not done yet!")
        return
    else:
        print("You did it!")
        pass#trigger victory
