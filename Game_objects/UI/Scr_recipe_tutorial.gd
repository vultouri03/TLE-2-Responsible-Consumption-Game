extends Node2D
@export var recipe_info_panel:Node
@export var recipe_modal:Node
@export var recipe_object:Node2D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_texture_button_pressed():
	recipe_info_panel.visible = !recipe_info_panel.visible
	pass # Replace with function body.


func _on_button_pressed():
	recipe_info_panel.visible = !recipe_info_panel.visible
	recipe_modal.visible = recipe_info_panel.visible
	pass # Replace with function body.


func _on_next_pressed():
	recipe_object.next_recipe()
	pass # Replace with function body.


func _on_previous_pressed():
	recipe_object.previous_recipe()
	pass # Replace with function body.
