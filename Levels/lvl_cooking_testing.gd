extends Node2D
@export var parent:Node2D;
@export var itemYStartingPosition = 600;
@export var itemXoffset = 60;
@export var itemScale:float = 0.08;
@export var itemStartingPositionNode:Node2D;
@export var cooking_oven:Node2D;
@export var generic_food_item_recipe_prefab:PackedScene;
@export var serve_button:Button;
@export var completed_dishes_label:Label;

@onready var cooking = $Cooking


var positionsUpdated = false;
# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_check_for_all_draggables()
	var str = "Prepared Dishes : %d / %d"
	var amount = Globalvars._gameManager().food_amount;
	var to_serve = Globalvars._gameManager().food_to_serve_for_the_day;
	completed_dishes_label.text = str%[amount,to_serve]
	#
	#if cooking_oven.get_current_progress() < 1:
		#serve_button.visible = false;
	#else:
		#serve_button.visible = true;
	#
	pass



func _check_for_all_draggables():
	if positionsUpdated == false: 
		var draggables = get_tree().get_nodes_in_group("Draggables")
		var iterate = 0
		var offset = 96
		var yOffset = 0
		var yIterateOffset = 4
		for drag in draggables: 
			drag.parent.scale = Vector2(itemScale,itemScale)
			drag.parent.position = Vector2(0,0)
			if iterate > yIterateOffset:
				iterate = 0;
				yOffset += 1;
			drag.parent.position = itemStartingPositionNode.position+ Vector2((itemXoffset*iterate),itemYStartingPosition+(yOffset*(offset*2)))
			drag.draggable_type_id = cooking_oven.drop.desired_draggable_type_ids[0];
			drag.parent.reparent(self)
			#add_child(drag.parent);
			drag.parent.process_mode = Node.PROCESS_MODE_INHERIT
			iterate+=1
		positionsUpdated = true;
		cooking_oven.process_mode = Node.PROCESS_MODE_INHERIT
	


func _on_visibility_changed():
	cooking_oven.process_mode = Node.PROCESS_MODE_DISABLED
	if positionsUpdated:
		positionsUpdated = false;
		var draggables = get_tree().get_nodes_in_group("Draggables")
		for drag in draggables:
			drag.parent.queue_free()
			#drag.parent.process_mode = Node.PROCESS_MODE_DISABLED;
		

	pass # Replace with function body.


func _on_serve_button_button_up():
	var food_instance_draggble = generic_food_item_recipe_prefab.instantiate();
	food_instance_draggble.get_child(0).draggable_type_id = "Generic";
	food_instance_draggble.position = cooking_oven.drop.position;
	add_child(food_instance_draggble)
	food_instance_draggble.process_mode = Node.PROCESS_MODE_ALWAYS;
	Globalvars._add_food_to_serve(food_instance_draggble);
	pass # Replace with function body.
