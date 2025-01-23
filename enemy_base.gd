class_name EnemyBase extends Actor
var health:int = 10

func takeDamage(damage:int)->void:
    $AudioStreamPlayer3D.play()
    health-=damage
    if health<=0:
        prepareToDie()

func prepareToDie()->void:
    #allow enemy to say their last words before deletion
    $AudioStreamPlayer3D.finished.connect(die)
    
func die():
    self.queue_free()
