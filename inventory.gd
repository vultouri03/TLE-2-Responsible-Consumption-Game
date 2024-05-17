extends Control

var categories = null;
var category_names = ["Bread", "Meat", "Drinks", "Spices", "Dairy", "Vegetables", "Sauces"]
# Called when the node enters the scene tree for the first time.
func _ready():

	categories = load("res://Resources/categories.tres")

	for c in self.get_children():
		for n in category_names:			
			if c.get_name().find(n):
				c.get_node("Amount").text = categories[n]
				print(c.get_name())
			else:
				print("Not a category")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	print("Button Pressed")
	
