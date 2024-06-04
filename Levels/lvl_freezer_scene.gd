extends Node2D

var leftovers: int = 0

@onready var container = $Container
@onready var label = $RichTextLabel


@export var leftover_prefab: PackedScene
var instance
var clear_freezer = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
	
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	label.text = "[center]You have " + str(leftovers) + " items left over
Want to store them"


func _on_visibility_changed():
	if clear_freezer:
		Globalvars.stored_foods = 0
		clear_freezer = false
	else:
		clear_freezer = true
	
	if Globalvars._gameManager() != null:
		leftovers = Globalvars._gameManager().food_amount
		print(leftovers)
		for n in leftovers:
			instance = leftover_prefab.instantiate()
			print("child added")
			container.add_child(instance)
			container.get_child(n).position.x = randi_range(0, get_viewport().get_visible_rect().size.x)
			container.get_child(n).position.y = randi_range(100, 130)


func _on_game_manager_turn_switched():
	Globalvars._gameManager().food_amount = 0
		


func _on_area_2d_function_to_trigger():
	Globalvars.stored_foods += randi_range(5,10)
