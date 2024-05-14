extends Area2D
class_name Draggable
var class_object_name:String
var previous_mouse_position = Vector2()
var is_dragging = false

func _on_Draggable_input_event(viewport,event,shape_id):
	if event.is_action_pressed("ui_touch"):
		print(event)
		get_viewport().set_input_as_handled()
		previous_mouse_position = event.position
		is_dragging = true
#func _drop_check():
	
func _input(event):
	if not is_dragging:
		return
	if event.is_action_released("ui_touch"):
		previous_mouse_position = Vector2()
		is_dragging = false
	if is_dragging and event is InputEventMouseMotion:
		position += event.position - previous_mouse_position
		previous_mouse_position = event.position

# Called when the node enters the scene tree for the first time.
func _ready():
	class_object_name= "Draggable"
	set_process_input(true)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	
	pass # Replace with function body.
