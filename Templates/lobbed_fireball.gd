class_name LobbedFireball extends RigidBody3D
var directdamage=10
var splashdamage=5
func fire( facing:Vector3, speed:float ) -> void:
    facing=facing.normalized();
    self.linear_velocity+=(speed/sqrt(2))*(facing+Vector3(0,1,0));


func _on_body_entered(body):
    if body.has_method("takeDamage"):
        body.takeDamage(directdamage);
    $"SplashDamageArea/AoE Image".visible=true
    $"Direct Image".visible=false
    self.freeze=true
    for splashedbody in $SplashDamageArea.get_overlapping_bodies():
        if splashedbody!=body and splashedbody.has_method("takeDamage"):
            splashedbody.takeDamage(splashdamage)
    await get_tree().create_timer(0.5).timeout
    self.queue_free()
