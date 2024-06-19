extends Button
@export var recipeSystem:Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Globalvars.GameManager.currentState == 0 || Globalvars.GameManager.currentState == 1:
		if recipeSystem.recipe_object.check_if_draggables_meet_recipe_count():
			text = "Continue"
			disabled = false;
		else:
			text ="Check your ingredients!"
			disabled = true;
	else:
			text = "Continue"
			disabled = false;
	pass
