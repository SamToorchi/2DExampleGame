extends Button

func _ready():
	$HTTPRequest.connect("request_completed", self, "_on_HTTPRequest_request_completed")
	
func _on_Button2_pressed():
	print("geht")
	$HTTPRequest.request("https://jsonplaceholder.typicode.com/todos/1", PoolStringArray([]),false)

func _on_HTTPRequest_request_completed (result, response_code, headers, body):
	if(response_code == 200):
		get_parent().get_node("Label").text = body.get_string_from_utf8()

