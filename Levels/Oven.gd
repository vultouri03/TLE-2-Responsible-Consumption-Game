extends Node2D

@export var drop:Node2D
@export var progressBar:ProgressBar
@export var desiredValue:float = 50
var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
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
	# Set the progress bar color based on the value
	if current_value > desiredValue + forgiveness:
		progressBar.get("theme_override_styles/fill").bg_color = Color(1, 0, 0)  # Red color
		Globalvars._gameManager().food_amount += 1
	elif current_value > desiredValue - (1 + forgiveness) and current_value < desiredValue + (1 + forgiveness):
		progressBar.get("theme_override_styles/fill").bg_color = Color(0, 1, 0)  # Green color
		Globalvars._gameManager().food_amount += 1
	elif current_value < desiredValue:
			progressBar.get("theme_override_styles/fill").bg_color = Color(0.4, 0, 0.4)  # Purple color

		
func _function_to_execute():
	print("EXECUTED!!!")
	progressBar.value += rng.randf_range(1,10);
	_update_progress_bar()
