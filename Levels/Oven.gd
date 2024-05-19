extends Node2D

@export var drop:Node2D
@export var progressBar:ProgressBar
@export var desiredValue:float = 50
# Called when the node enters the scene tree for the first time.
func _ready():
	print(drop)
	_update_progress_bar()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if drop.function_should_trigger_now == true:
		_function_to_execute()
	pass
func _update_progress_bar(): 
	if progressBar.value > desiredValue:
		progressBar.get("theme_override_styles/fill").bg_color = Color(255, 0, 0)
	if progressBar.value < desiredValue:
		progressBar.get("theme_override_styles/fill").bg_color = Color(100, 0, 100)
	if progressBar.value+10 < desiredValue:
		progressBar.get("theme_override_styles/fill").bg_color = Color(50, 100, 50)
	if progressBar.value > desiredValue-1 && progressBar.value < desiredValue+1 :
		progressBar.get("theme_override_styles/fill").bg_color = Color(0, 100, 0)
		
func _function_to_execute():
	print("EXECUTED!!!")
	progressBar.value += 10
	_update_progress_bar()
