class_name EnemyBase extends Actor
var health:float = 10.0
var dying:bool = false

func takeDamage(damage:float)->void:
    $AudioStreamPlayer3D.play()
    health-=damage
    print(damage)
    if health<=0 and !dying:
        prepareToDie()

func prepareToDie()->void:
    #allow enemy to say their last words before deletion
    dying=true
    $AudioStreamPlayer3D.finished.connect(die)
    
func die():
    self.queue_free()
