extends Control

var categories = null;
@export var category_rows = []

# Called when the node enters the scene tree for the first time.
func _ready():

	categories = load("res://Resources/categories.tres")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _grab_children():
	for category in category_rows:
		#category.get_node("Amount").text = #categories[category.get_node("amount").text]