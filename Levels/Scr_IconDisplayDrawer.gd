extends Panel
@export var icon_display_prefab:PackedScene
@export var container:VBoxContainer
@export var titleLabel:Label
var ingredientDict = {}
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _clear_contents():
	for chi in container.get_children():
		container.remove_child(chi)
		chi.queue_free()
	

func _update_recipe_name(recipe_name):
	titleLabel.text = recipe_name
func _draw_new_icon(ingredient_name,coordinates):
	var new_icon = icon_display_prefab.instantiate()
	container.add_child(new_icon)
	new_icon._change_atlas_texture_coordinates(coordinates)
	new_icon.name = ingredient_name

func _update_amount_count(ingredient_name,current,desired):
	if container.get_node_or_null(ingredient_name) != null:
		container.get_node(ingredient_name)._update_count(current,desired)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
