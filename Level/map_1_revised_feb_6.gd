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
        get_tree().paused=true
        $"Victory Screen".visible=true
        print("You did it!")
        pass#trigger victory

func makebothnavimaps():
    var navigation_mesh_mimic: NavigationMesh = NavigationMesh.new()
    var navigation_mesh_golem: NavigationMesh = NavigationMesh.new()
    navigation_mesh_golem.agent_radius=100
    navigation_mesh_golem.agent_height=100
    navigation_mesh_mimic.agent_radius=10
    navigation_mesh_mimic.agent_height=10
    var root_node: Node3D = get_node("NavigationRegion3D")
    var source_geometry_data: NavigationMeshSourceGeometryData3D = NavigationMeshSourceGeometryData3D.new() 
    NavigationServer3D.parse_source_geometry_data(navigation_mesh_mimic, source_geometry_data, root_node)
    var navigation_map_mimic: RID = NavigationServer3D.map_create()
    var navigation_map_golem: RID = NavigationServer3D.map_create()
    NavigationServer3D.map_set_active(navigation_map_mimic, true)
    NavigationServer3D.map_set_active(navigation_map_golem, true)
    var navigation_region_mimic: RID = NavigationServer3D.region_create()
    var navigation_region_golem: RID = NavigationServer3D.region_create()
    NavigationServer3D.region_set_map(navigation_region_mimic, navigation_map_mimic)
    NavigationServer3D.region_set_map(navigation_region_golem, navigation_map_golem)
    NavigationServer3D.region_set_navigation_mesh(navigation_region_mimic, navigation_mesh_mimic)
    NavigationServer3D.region_set_navigation_mesh(navigation_region_golem, navigation_mesh_golem)
