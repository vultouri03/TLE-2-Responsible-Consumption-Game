extends Area2D
class_name Drop
var class_object_name:String
var draggable_to_monitor:Area2D
@export var desired_draggable_type_ids:Array = ["Generic"]
var function_should_trigger_now = false
var last_category_id
signal function_to_trigger

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var can_process = false
	if draggable_to_monitor != null: 
		for id in desired_draggable_type_ids:
			if draggable_to_monitor.draggable_type_id == id:
				can_process = true;
				break;
		if can_process:
			if(!draggable_to_monitor.is_dragging):
				last_category_id = draggable_to_monitor.category_id.to_lower()
				if draggable_to_monitor.parent:
					draggable_to_monitor.parent.queue_free()
				else:
					draggable_to_monitor.queue_free()
				function_to_trigger.emit()
				function_should_trigger_now = true
	else:
		function_should_trigger_now = false
	pass



	



func _on_area_entered(area):
	if area.class_object_name != null: 
		if area.class_object_name == "Draggable":
			draggable_to_monitor = area
	



func _on_area_exited(area):
	if area.class_object_name != null: 
		if area.class_object_name == "Draggable":
			if(draggable_to_monitor!= null):
				if (area == draggable_to_monitor):
					draggable_to_monitor = null
				

