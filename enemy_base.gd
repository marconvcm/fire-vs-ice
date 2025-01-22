class_name EnemyBase extends Actor
var health:int = 10

func takeDamage(damage:int)->void:
    health-=damage
    if health<=0:
        die()

func die()->void:
    self.queue_free()
