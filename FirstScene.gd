extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.show_modal(true)
	pass
	#$ConfirmationDialog.get_cancel().connect("pressed", self, "_on_Cancel")
	#$ConfirmationDialog.show_modal(true)




func _on_Button_pressed():
	get_tree().quit()
