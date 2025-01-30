extends RigidBody3D
var damage=100
var splashdamage=50


func _on_body_entered(body):
    if body.has_method("takeDamage"):
        body.takeDamage(damage)
    $"SplashDamageArea/AoE Image".visible=true
    $"Direct Image".visible=false
    self.freeze=true
    for splashedbody in $SplashDamageArea.get_overlapping_bodies():
        if splashedbody!=body and splashedbody.has_method("takeDamage"):
            splashedbody.takeDamage(splashdamage)
    await get_tree().create_timer(0.5).timeout
    self.queue_free()
