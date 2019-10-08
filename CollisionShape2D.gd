extends CollisionShape2D





func _ready():
	position = Vector2 (get_viewport().size.x/2, get_viewport().size.y/1.5)

func _process(delta):
	var t = Timer.new()
	t.set_wait_time(0.4)
	t.set_one_shot(true)
	self.add_child(t)
	
	if Input.is_key_pressed(KEY_LEFT):
		self.position.x -= 2
	if Input.is_key_pressed(KEY_RIGHT):
		self.position.x += 2
	if Input.is_key_pressed(KEY_SPACE):
		self.position.y -= 20
		t.start() 
		yield(t, "timeout")

	
