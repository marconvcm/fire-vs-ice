extends Node3D

func _ready():
    MusicPlayer.explore()


func _on_kill_plane_body_entered(body):
    if body.has_method("die"):
        body.die()
