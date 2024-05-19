extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# restart the game button
func _on_retry_button_pressed():
	print('Retry');
	pass


# quit the game
func _on_quit_button_pressed():
	print('Quit');
	pass


# show tips page
func _on_tips_button_pressed():
	get_tree().change_scene_to_file("res://tips_ui.tscn")
	print('Tips');
	pass
