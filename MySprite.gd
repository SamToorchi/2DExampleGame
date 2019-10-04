extends Sprite

func _ready():
	# Center Position
	position = Vector2(get_viewport().size.x/2, get_viewport().size.y/2)
	#scale = Vector2 (0.9, 0.9)
	#rotate(deg2rad(90))
	set_process(true)
	
# laufende Funktion	
#delta 60FPS
func _process(delta):
	rotation = self.rotation + deg2rad(90 * delta)
	translate(Vector2(-100 * delta, 0))
	if(position.x < 0):
		position = Vector2(get_viewport().size.x, get_viewport().size.y/2)