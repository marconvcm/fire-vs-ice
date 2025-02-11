class_name LobbedFireball extends RigidBody3D
var strength:float
var directdamage=10
var splashdamage=5
var maxdirectradius=2.5
var maxsplashradius=10
func fire( facing:Vector3, speed:float ) -> void:
    facing=facing.normalized();
    self.linear_velocity+=(speed/sqrt(2))*(facing+Vector3(0,1,0));
    $"Direct Image".play()


func _on_body_entered(body):
    if body.has_method("takeDamage"):
        body.takeDamage(directdamage);
    else:
        var bodyobject=body.get_parent()
        if bodyobject is burnable:
            bodyobject.burn(false)
    $"SplashDamageArea/AoE Image".visible=true
    $"Direct Image".visible=false
    self.freeze=true
    for splashedbody in $SplashDamageArea.get_overlapping_bodies():
        if splashedbody!=body and splashedbody.has_method("takeDamage"):
            splashedbody.takeDamage(splashdamage)
        else:
            var bodyobject=splashedbody.get_parent()
            if bodyobject is burnable:
                bodyobject.burn(false)
    await get_tree().create_timer(0.5).timeout
    self.queue_free()

func set_strength(thisstrength:float):
    strength=thisstrength
    print($DirectHitHitbox.shape.radius)
    $DirectHitHitbox.shape.radius=maxdirectradius*strength
    print($DirectHitHitbox.shape.radius)
    $"Direct Image".pixel_size=0.015*maxdirectradius*strength
    $SplashDamageArea/CollisionShape3D.shape.radius=maxsplashradius*strength
    $"SplashDamageArea/AoE Image".mesh.radius=maxsplashradius*strength
    $"SplashDamageArea/AoE Image".mesh.height=2*maxsplashradius*strength
