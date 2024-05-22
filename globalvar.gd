extends Node
var webserver = "https://tle-2-receipt-scan-webservice.onrender.com/"
var image_texture: Image
var update_delay_tick = 2; #tick of 2 seconds
var current_delay_tick = 0;
var can_update_now = false;
var user_hardware_id = OS.get_unique_id()
var active_receipt = {"id":0,"image":""}
enum unitOfMesurement {litres,millilitres,grams,kilograms}
var categories = {}

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
	

func setImageTexture(texture):
	image_texture = Image.new()
	image_texture.load_jpg_from_buffer(texture)

func _get_image_texture():
	return image_texture
