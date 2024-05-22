extends Control

@export var categories : Resource

var dummyData = {
	"categories": [
		{
			"name": "wheats",
			"amount": 1
		},
		{
			"name": "meat",
			"amount": 1
		},
		{
			"name": "drinks",
			"amount": 3
		},
		{
			"name": "spices",
			"amount": 1
		},
		{
			"name": "dairy",
			"amount": 2
		},
		{
			"name": "vegetables",
			"amount": 5
		},
		{
			"name": "sauces",
			"amount": 2
		}
	
	]
}
# Called when the node enters the scene tree for the first time.
func _ready():

	categories = load("res://Resources/categories.tres")
	
	var responseBody = {"dairy":2,"meat":2,"drinks":3,"vegetables":5,"wheats":3,"spices":0,"sauces":0}
	
	
		
		#if (Globalvars.categories.categories[key] == responseBody[key][0]):
			#Globalvars.categories.categories[key] == responseBody[key]
	#print(dummyData.categories[0]["amount"])
	print(self.get_children())
	for n in range(7):	
		if(Globalvars.categories != {}):	
			self.get_children()[n].get_node("Amount").text = str(Globalvars.categories.categories[n]["amount"])
			#print(c.get_node("Amount").text)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


#TODO also a quick suggestion for after this all works. could it perhaps be a good idea to add a button to the side of the Food_items that when pressed lowers the amount and spawns a draggable version of the food item? 


func _on_game_manager_turn_switched():
	for n in range(7):	
		self.get_children()[n].expiration -= 1