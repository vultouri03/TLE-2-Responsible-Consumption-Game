extends Node

enum States {Prep, Cooking, Feeding, Storage}


#the states in the editor place the gameobject related to each state under there
#if you want to reset you gameobject send the signal visibility changed to itself and put the _ready() code in there
@onready var feeding = $"../Feeding"
@onready var prep = $"../Prep"
@onready var cooking = $"../Cooking"
@onready var storage = $"../Storage"

@export var currentState : States 

var turn : int = 0
@export var gameOver : bool

signal turn_switched

# Called when the node enters the scene tree for the first time.
func _ready():
	if (currentState > 0):
		currentState -= 1
	else:
		currentState = 3
	_on_next_state_button_down()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_next_state_button_down():
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
			turn_switched.emit()
			if(gameOver):
				#code to go to endScene
				pass
			else:
				currentState = 0
				load_state(prep, storage)
			#connect this signal if you want values to change after a turn is over
			

func load_state(newState : Node2D, oldState : Node2D):
	oldState.visible = false
	oldState.process_mode = Node.PROCESS_MODE_DISABLED
	
	newState.visible = true
	newState.process_mode = Node.PROCESS_MODE_INHERIT
