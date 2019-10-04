extends AnimatedSprite



func _ready():
	position = Vector2 (get_viewport().size.x/2, get_viewport().size.y/1.5)
	connect ("animation_finished", self, "on_AnimatedSprite_animation_finished")
	set_process_input(true)
	get_viewport().audio_listener_enable_2d = true

func _process(delta):

	
	var t = Timer.new()
	t.set_wait_time(0.3)
	t.set_one_shot(true)
	self.add_child(t)
	
	
	if Input.is_key_pressed(KEY_LEFT):
		if Input.is_key_pressed(KEY_Q):
			self.animation = "jumpattack"
			self.position.x -= 2
			self.flip_h = true
		else:
			animation = "run"
			self.position.x -= 2
			self.flip_h = true
	if Input.is_key_pressed(KEY_RIGHT):
		if Input.is_key_pressed(KEY_Q):
			self.animation = "jumpattack"
			self.position.x += 2
			self.flip_h = false
		else:
			animation = "run" 
			self.position.x += 2
			self.flip_h = false
	if Input.is_key_pressed(KEY_SPACE):
		self.animation = "jump"
		self.position.y -= 20
		t.start() 
		yield(t, "timeout")
	
func on_AnimatedSprite_animation_finished():
	animation = "stay"
	
func _input(event):
	if event.is_action_released("ui_right") || event.is_action_released("ui_left") :
		self.animation = "stay"

## Projekt > Projekteinstellungen > Eingabe-Zuordnung
	if event.is_action_pressed("fire"):
		print("Q")
		$AudioStreamPlayer2D.play()
		self.animation = "jumpattack"
		
	
