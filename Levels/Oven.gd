extends Node2D

@export var drop:Node2D
@export var progressBar:ProgressBar
@export var desiredValue:float = 50
var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	progressBar.value =0;
	print(drop)
	_update_progress_bar()
	pass # Replace with function body.

func get_current_progress():
	return progressBar.value/desiredValue

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if drop.function_should_trigger_now == true:
		_function_to_execute()
	
	pass
func _update_progress_bar(): 
	var forgiveness = Globalvars._gameManager().cooking_threshold_overflow_forgiveness
	var current_value = progressBar.value
	var food_amount = Globalvars._gameManager().food_amount; 
	var food_to_serve_amount =  Globalvars._gameManager().food_to_serve_for_the_day;
	var overflow = (food_amount>food_to_serve_amount)
	# Set the progress bar color based on the value
	if current_value > desiredValue + forgiveness or overflow:
		progressBar.get("theme_override_styles/fill").bg_color = Color(1, 0, 0)  # Red color
		Globalvars._gameManager().food_amount += 1
	elif current_value > desiredValue - (1 + forgiveness) and current_value < desiredValue + (1 + forgiveness):
		progressBar.get("theme_override_styles/fill").bg_color = Color(0, 1, 0)  # Green color
		Globalvars._gameManager().food_amount += 1
	elif current_value < desiredValue:
			progressBar.get("theme_override_styles/fill").bg_color = Color(0.4, 0, 0.4)  # Purple color

		
func _function_to_execute():
	print("EXECUTED!!!")
	progressBar.value += rng.randf_range(5,10);
	_update_progress_bar()
	
func _on_lvl_cooking_testing_visibility_changed():
	progressBar.value = Globalvars.stored_foods
	if(Globalvars.stored_foods > 0):
		progressBar.get("theme_override_styles/fill").bg_color = Color(0, 0, 1)  # Red color
	pass # Replace with function body.
