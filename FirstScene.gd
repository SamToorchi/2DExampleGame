extends Node

var currentLevel
var score = 0
var lives = 0


func _ready():
	
	var dir = Directory.new()
	if !dir.dir_exists("user://"):
		dir.open("user://")
		dir.make_dir("user://")
	if OS.is_userfs_persistent():
		print("IndexedDB works")
		
func get_score():
	return score
	
func set_score(var amount):
	score += amount

func get_lives():
	return lives

func set_lives(var amount):
	lives = 0
	lives += amount
	
func get_level():
	return get_tree().get_current_scene().get_filename()
	
func set_level(var levelName):
	currentLevel = levelName
	print("set_level")
	

var GameData = {
		level = "",
		score = 0,
		lives = 0
	}

func save_game_state(var saveName):
	var saveGame = File.new()
	saveGame.open("user://" + saveName + ".json", File.WRITE)
	
	var data = GameData
	
	data.level = get_level()
	data.score = get_score()
	data.lives = get_lives()
	
	saveGame.store_line(JSON.print(data))
	saveGame.close()
	
	print(get_level())
	print(get_lives())
	print(get_score())
	
# this loads a previously saved game state
func load_game_state(var saveName):
	
	#create a file object
	var loadGame = File.new()
	
	# see if the file actually exists before opening it
	if !loadGame.file_exists("user://" + saveName + ".json"):
		print("File not found! Aborting...")
		return
		
	# use an empty dictionary to assign temporary data to
	var currentLine = {}
	# read the data in
	loadGame.open("user://" + saveName + ".json", File.READ)
	currentLine = parse_json(loadGame.get_line())

	currentLevel = currentLine["level"]
	lives = currentLine["lives"]
	score = currentLine["score"]
	
	set_level(currentLevel)
	set_lives(lives)
	set_score(score)

	loadGame.close()
	print(currentLevel)
	print(lives)
	print(score)
	
	print(get_level())
	print(get_lives())
	print(get_score())
	
func new_game(saveName):
	
	var loadGame = Directory.new()
	if loadGame.file_exists("user://" + saveName + ".json"):
		loadGame.remove("user://" + saveName + ".json")
		
	#initialize default variables
	currentLevel = "user://FirstScene.tscn"
	set_score(0)
	set_lives(4)
	set_level(currentLevel)
	
	print(get_level())
	print(get_lives())
	print(get_score())
	
func delete_game(saveName):
	set_score(0)
	set_lives(0)
	set_level(currentLevel)
	var loadGame = Directory.new()
	if loadGame.file_exists("user://" + saveName + ".json"):
		loadGame.remove("user://" + saveName + ".json")
	print ('removed')
	print(get_level())
	print(get_lives())
	print(get_score())

func _on_Button_pressed():
	get_tree().quit()
	
func _on_Save_pressed():
	save_game_state("MyGame")
	print("Save Complete")

func _on_load_pressed():
	load_game_state("MyGame")

func _on_newGame_pressed():
	new_game("MyGame")
	print("new Game loaded")

func _on_removeSaveFile_pressed():
	delete_game("MyGame")
