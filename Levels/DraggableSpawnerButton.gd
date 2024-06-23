extends Button

@export var button_name:String = "generic_food"
@export var button_name_localized:String = "Generic Food"
@export var button_icon: CompressedTexture2D
@export var food_item:Script
@export var draggable_reference:Node
var draggable_spawn
# Called when the node enters the scene tree for the first time.
func _ready():
	if button_icon != null:
		set_button_icon(button_icon)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	SelectSFX.play()
	print(button_name_localized)
	_spawn_food_draggable()
	pass # Replace with function body.


func _spawn_food_draggable():
	if draggable_spawn!= null:
		draggable_spawn.queue_free()
	draggable_reference.input_pickable = false
	draggable_spawn = draggable_reference.duplicate()
	add_child(draggable_spawn)
	draggable_spawn._setStats("x1",button_icon)
	draggable_spawn.position =Vector2(size.x/2,0) + Vector2(0,-128)
	draggable_spawn.input_pickable = true
	draggable_spawn._setDragged()
	print(draggable_spawn)
	pass
