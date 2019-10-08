extends Node

# declare our variables
var currentLevel
var score = 0
var lives = 0



func _ready():
	#$Label.show_modal(true)
	
	# first determine if a Saves directory exists.
	# if it doesn't, create it.
	var dir = Directory.new()
	if !dir.dir_exists("user://Saves"):
		dir.open("user://")
		dir.make_dir("user://Saves")
		
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
	#get_tree().change_scene(levelName)
	print("set_level")
	
# the following functions save and load a game, depending on what the player does at the main/pause menus.
# at the end of each level, the save function is automatically called.

# first create a dictionary to store the save info in. Similar to a serializable class in Unity in which 
# the player data would be stored.

var GameData = {
		level = "",
		score = 0,
		lives = 0
	}

func save_game_state(var saveName):
	var saveGame = File.new()
	saveGame.open("user://Saves/" + saveName + ".sve", File.WRITE)
	
	var data = GameData
	
	data.level = get_level()
	data.score = get_score()
	data.lives = get_lives()
	
	saveGame.store_line(JSON.print(data))
	#saveGame.store_line(data)
	saveGame.close()
	
# this loads a previously saved game state
func load_game_state(var saveName):
	
	#create a file object
	var loadGame = File.new()
	
	# see if the file actually exists before opening it
	if !loadGame.file_exists("user://Saves/" + saveName + ".sve"):
		print("File not found! Aborting...")
		return
		
	# use an empty dictionary to assign temporary data to
	var currentLine = {}
	# read the data in
	loadGame.open("user://Saves/" + saveName + ".sve", File.READ)
	currentLine = parse_json(loadGame.get_line())

	currentLevel = currentLine["level"]
	lives = currentLine["lives"]
	score = currentLine["score"]

	loadGame.close()
	print(currentLevel)
	print(lives)
	print(score)
	
func new_game():
	#initialize default variables
	currentLevel = "user://FirstScene.tscn"
	set_score(0)
	set_lives(3)
	set_level(currentLevel)
	


func _on_Button_pressed():
	get_tree().quit()
	
func _on_Save_pressed():

	save_game_state("MyGame")
	print("Save Complete")

	


func _on_load_pressed():
	load_game_state("MyGame")
	print("load Complete")


func _on_newGame_pressed():
	new_game()
	print("new Game loaded")
