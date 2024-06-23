extends Node

enum States {Prep, Cooking, Feeding, Storage}


#the states in the editor place the gameobject related to each state under there
#if you want to reset you gameobject send the signal visibility changed to itself and put the _ready() code in there
@onready var feeding = $"../Feeding"
@onready var prep = $"../Prep"
@onready var cooking = $"../Cooking"
@onready var storage = $"../Storage"

@export var currentState : States 

var turn : int = 1
#makes sure that the turn switch is not called on game start
var gameStarted = false
@export var gameOver : bool
#The food to serve 
@export var food_to_serve_for_the_day = 4;
#difficulty 
@export var cooking_threshold_overflow_forgiveness = 12;
#the amount of food
var food_amount = 0; 
signal turn_switched

# Called when the node enters the scene tree for the first time.
func _ready():
	Globalvars._add_game_manager_to_global(self)
	if (currentState > 0):
		currentState -= 1
	else:
		currentState = 3
	_on_next_state_button_down()
	add_to_group("GameManager",true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_next_state_button_down():
	SelectSFX.play()
	print(currentState)
	match currentState:
		States.Prep:
			currentState = 1
			load_state(cooking, prep)
		States.Cooking:
			currentState = 2
			load_state(feeding, cooking)
		States.Feeding:
			currentState = 3
			load_state(storage, feeding)
		States.Storage:
			if(gameOver):
				#code to go to endScene
				pass
			else:
				turn += 1
				currentState = 0
				load_state(prep, storage)
			#connect this signal if you want values to change after a turn is over
			if gameStarted:
				#actually emited the signal this time
				turn_switched.emit()
			else:
				gameStarted = true

func load_state(newState : Node2D, oldState : Node2D):
	oldState.visible = false
	oldState.process_mode = Node.PROCESS_MODE_DISABLED
	
	newState.visible = true
	newState.process_mode = Node.PROCESS_MODE_INHERIT
