extends Area2D
class_name Draggable
var class_object_name:String
@export var draggable_type_id:String = "Generic" #define the draggable_type_id so that Drop scripts dont interface if they are different.
var previous_mouse_position = Vector2()
var is_dragging = false
var current_scale = Vector2(1,1)
@export var category_id = "wheats"
@export var parent:Node2D
func _on_Draggable_input_event(viewport,event,shape_id):
	if event.is_action_pressed("ui_touch"):
		print(event)
		parent.z_index +=100;
		get_viewport().set_input_as_handled()
		previous_mouse_position = event.position
		is_dragging = true
#func _drop_check():
func _remove_from_group_on_delete():
	remove_from_group("Draggables")
func _input(event):
	if not is_dragging:
		parent.scale = current_scale;
		return
	if event.is_action_released("ui_touch"):
		previous_mouse_position = Vector2()
		is_dragging = false
	if is_dragging and event is InputEventMouseMotion:
		
		parent.scale = current_scale*1.25;
		parent.position += event.position - previous_mouse_position
		previous_mouse_position = event.position

# Called when the node enters the scene tree for the first time.
func _ready():
	class_object_name= "Draggable"
	add_to_group("Draggables")
	set_process_input(true)
	if parent == null:
		parent = self
	
	current_scale = parent.scale
	pass # Replace with function body.
func _setDragged():
	var auto_drag  = InputEventAction.new()
	auto_drag.action = "ui_touch"
	auto_drag.pressed = true
	Input.parse_input_event(auto_drag)
	
	#sets the draggable's stats but overrides the parent to be self to avoid duplication errors
func _setStats(label_name,sprite_img): 
	parent = self
	if get_node("Label"):
		get_node("Label").text = label_name
	if get_node("Sprite2D"):
		get_node("Sprite2D").texture = sprite_img
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _exit_tree():
	_remove_from_group_on_delete()
	
func _on_body_entered(body):

	pass # Replace with function body.


func _on_area_entered(area):
	var other =area
	if other.class_object_name != null:
		if other.class_object_name == class_object_name:
			if other.is_dragging == false && is_dragging == true:
				other.parent.z_index = parent.z_index-1;
	pass # Replace with function body.
