extends Control

@export var categories : Resource
var category_names = ["Bread", "Meat", "Drinks", "Spices", "Dairy", "Vegetables", "Sauces"]
# Called when the node enters the scene tree for the first time.
func _ready():

	categories = load("res://Resources/categories.tres")
	print(categories.categories)

	for c in self.get_children():
		for n in category_names:			
			if c.get_name().find(n):
				#c.get_child("Amount").text = categories[n]
				print(c.get_name())
			else:
				print("Not a category")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	print("Button Pressed")
	

#TODO Create dummy data

#TODO also a quick suggestion for after this all works. could it perhaps be a good idea to add a button to the side of the Food_items that when pressed lowers the amount and spawns a draggable version of the food item? 
