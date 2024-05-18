extends Button
@export var button_name:String = "generic_food"
@export var button_name_localized:String = "Generic Food"
@export var button_icon: CompressedTexture2D
# Called when the node enters the scene tree for the first time.
func _ready():
	if button_icon != null:
		set_button_icon(button_icon)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	print(button_name_localized)
	pass # Replace with function body.


func _spawn_food_draggable():
	
