extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready():
	_settext()
	pass

# Load the text into the game
func _settext():
	# TEST show current score
	$"TESTSCORE/Current Score".text = str($score_Manager.currentScore)
	
	$"Highscores/Current Score".text = "CURRENT SCORE : " + str($score_Manager.currentScore)
	$"Highscores/Highscore 1".text = str($score_Manager.highscores[0])
	$"Highscores/Highscore 2".text = str($score_Manager.highscores[1])
	$"Highscores/Highscore 3".text = str($score_Manager.highscores[2])
	$"Highscores/Highscore 4".text = str($score_Manager.highscores[3])
	$"Highscores/Highscore 5".text = str($score_Manager.highscores[4])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# restart the game button
func _on_retry_button_pressed():
	print('Restart game');
	pass

# quit the game
func _on_quit_button_pressed():
	print('Quit game');
	pass


# show tips page
func _on_tips_button_pressed():
	get_tree().change_scene_to_file("res://tips_ui.tscn")
	print('Tips pagina');
	pass

#THIS IS TO TEST SCORE
func _on_add_button_pressed():
	$score_Manager._add_score(1)
	$"TESTSCORE/Current Score".text = str($score_Manager.currentScore)
	pass # Replace with function body.

func _on_remove_button_pressed():
	$score_Manager._remove_score(1)
	$"TESTSCORE/Current Score".text = str($score_Manager.currentScore)
	pass # Replace with function body.

func _on_save_button_pressed():
	$score_Manager._endgame()
	$"TESTSCORE/Current Score".text = str($score_Manager.currentScore)
	pass # Replace with function body.

func _on_load_button_pressed():
	$score_Manager._load_score()
	_settext()
	$"TESTSCORE/Current Score".text = str($score_Manager.currentScore)
	pass # Replace with function body.

func _on_delete_button_pressed():
	$score_Manager._delete_score()
	pass # Replace with function body.
