extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# go back to the end screen
func _on_button_pressed():
	get_tree().change_scene_to_file("res://end_UI.tscn")
	print('Back')
	pass
