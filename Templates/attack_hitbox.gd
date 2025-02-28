extends StaticBody3D
func takeDamage(damage:float):
    self.get_parent().takeDamage(damage)
