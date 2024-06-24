extends Node
class_name scoremanager

# the current score
var currentScore = 100
 
var highscores = [0, 0, 0, 0, 0]

# where to save
const save_path = "user://savefile.save"

# load on start
func _ready():
	var penalty  = 0
	penalty += Globalvars.score.points.expired
	penalty += Globalvars.score.points.cooking_waste
	penalty += Globalvars.score.points.feeding_waste
	penalty += Globalvars.score.points.starving
	penalty += Globalvars.score.points.storing_waste
	currentScore -= penalty * 3
	if currentScore < 0 :
		currentScore = 0
	_load_score()

# rcall this functie at begin of game to make sure it is 0
func _reset_score():
	currentScore = 0
	pass

# add score (score) amount to add on current score
func _add_score(score):
	currentScore += score
	pass

# remove score (score) amount to remove on current score
func _remove_score(score):
	currentScore -= score
	pass

# call this functie at end of game so he check highscore
func _endgame():
	# Insert the current score into the highscores array if it qualifies
	highscores.append(currentScore)
	highscores.sort()  # Sort in ascending order
	highscores.reverse()  # Reverse to get descending order
	highscores = highscores.slice(0, 5)  # Keep only the top 5 scores
	_save_score()  # Save the updated high scores
	pass

# save the highscore 
func _save_score():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	for score in highscores:
		file.store_var(score)
	pass
	
 
# load the current highscore
func _load_score():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		for i in range(highscores.size()):
			highscores[i] = file.get_var(highscores[i])
	else:
		print("no data saved...")
		highscores = [0, 0, 0, 0, 0]
	print(highscores)
	pass

# delete the current highscore
func _delete_score():
	if FileAccess.file_exists(save_path):	
		DirAccess.remove_absolute(save_path)
		_load_score()
	else:
		print("no data saved...")
	pass
