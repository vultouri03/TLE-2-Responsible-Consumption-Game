extends Area2D
class_name Drop

var draggable_to_monitor:Area2D
var function_to_trigger:Signal
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if draggable_to_monitor != null: 
		if(!draggable_to_monitor.is_dragging):
			draggable_to_monitor.queue_free()
			function_to_trigger.emit()
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
				

