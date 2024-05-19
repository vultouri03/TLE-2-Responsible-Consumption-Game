extends Node
class_name scoremanager

# the current score
var currentScore = 0
 
# load on start
func _ready():
	load_score()

# reset current score begin game
func reset_score():
	currentScore = 0
	pass

# add score (score) amount to add on current score
func add_score(score):
	currentScore += score
	pass

# remove score (score) amount to remove on current score
func remove_score(score):
	currentScore -= score
	pass

# save the highscore 
func save_score():
	pass
	
 
# load the current highscore
func load_score():
	
	pass
