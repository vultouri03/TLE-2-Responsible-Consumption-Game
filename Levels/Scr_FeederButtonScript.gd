extends Button
@export var progress_bar:ProgressBar;
@export var draggable_prefab:PackedScene;
@export var food_state_label:Label;

var spawned_items: Array
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var food_amount;
var food_to_serve_for_the_day;
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	food_amount = Globalvars._gameManager().food_amount;
	food_to_serve_for_the_day = Globalvars._gameManager().food_to_serve_for_the_day;
	progress_bar.value = food_amount/food_to_serve_for_the_day
	if food_amount>0:
		var food_state_string = "Dishes Left: %s / %s"
		food_state_label.text =  food_state_string % [food_amount, food_to_serve_for_the_day]
	else:
		food_state_label.text = "There's no more food, wrap it up."
	pass


func _on_pressed():
	pass # Replace with function body.


func _on_button_button_up():
	if food_amount>0: 
		print("Spawning Food!")
		Globalvars._gameManager().food_amount+= -1;
		var instance = draggable_prefab.instantiate();
		instance.position = Vector2(360, position.y+200); 
		add_child(instance);
		
	else:
		print("Theres no Food!!!")
		pass # Replace with function body.


func _on_visibility_changed():
	for i in get_child_count():
			if i > 1:
				spawned_items.push_back(get_child(i))
	for i in spawned_items.size():
		Globalvars.score.points.feeding_waste += 1
		print(Globalvars.score.points)
