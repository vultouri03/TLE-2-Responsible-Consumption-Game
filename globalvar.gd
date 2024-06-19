extends Node
var webserver = "https://tle-2-receipt-scan-webservice.onrender.com/"
var image_texture: Image
var update_delay_tick = 2; #tick of 2 seconds
var current_delay_tick = 0;
var can_update_now = false;
var receipt_status = JSON.stringify("CONNECTING")
var user_hardware_id = OS.get_unique_id()
var active_receipt = {"id":0,"image":""}
enum unitOfMesurement {litres,millilitres,grams,kilograms}
enum States {Prep, Cooking, Feeding, Storage}
var served_foods:Array = [];
var score : Dictionary = {
	"points" : {
		"expired" = 0,
		"cooking_waste" = 0, 
		"feeding_waste"= 0,  
		"starving" = 0, 
		"storing_waste" = 0
	}
}
var stored_foods: int = 0
var GameManager:Node
#added dummy data into here so you don't need to call the api to test
var categories = {"categories": [
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
	
	]}
#Set the gamemanger as a globalvar value without fucking with autoload
func _add_game_manager_to_global(manager):
	GameManager = manager;
#Acess the gamemanger as a globalvar value without fucking with autoload
func _gameManager():
	return GameManager;

func _ready():
	active_receipt.id = user_hardware_id;
	active_receipt.image = image_texture;
	print("User HWID" + user_hardware_id)

func _process(delta):
	if update_delay_tick > current_delay_tick:
		current_delay_tick+=delta
		can_update_now = false
	else:
		can_update_now = true
		print("update tick triggered")
		current_delay_tick = 0
	if can_update_now:
		if get_tree().get_nodes_in_group("GameManager"):
			var gm = get_tree().get_nodes_in_group("GameManager")[0];
			if gm!= null: 
				if gm.currentState == States.Feeding:
					_spawn_served_food()
				else:
					print("Cant Serve Food Yet!!!")

func setImageTexture(texture):
	image_texture = Image.new()
	image_texture.load_jpg_from_buffer(texture)

func _get_image_texture():
	return image_texture

func _spawn_served_food():
	if served_foods.size()>0:
		#for food in served_foods: 
		print("Served Food")
	
	served_foods.clear()		
		

func _add_food_to_serve(food_draggable):
	if food_draggable!= null:
		served_foods.append(food_draggable)
		get_tree().root.add_child(food_draggable)
