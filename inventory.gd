extends Control

@export var categories : Resource

signal on_turn_changed

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
			print(Globalvars.categories.categories[n]["amount"])
			self.get_children()[n]._amount = Globalvars.categories.categories[n]["amount"]
			self.get_children()[n].get_node("Amount").text = str(Globalvars.categories.categories[n]["amount"])
			#print(c.get_node("Amount").text)


func _on_game_manager_turn_switched():
	print("turn has switched")
	for n in range(7):	
		self.get_children()[n].expiration -= 1
		print(self.get_children()[n].expiration)
		self.get_children()[n].updateExpiration()
