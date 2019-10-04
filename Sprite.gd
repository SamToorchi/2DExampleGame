extends Sprite

var timer

func _ready():
	position = Vector2(get_viewport().size.x/2, get_viewport().size.y/2)
	timer = Timer.new()
	timer.connect("timeout", self, "tick")
	add_child(timer)
	timer.wait_time = 0.1
	timer.start()
	
func tick():
	if self.frame < 9:
		self.frame = self.frame + 1
	else:
		self.frame = 0
