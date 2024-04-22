extends Node
var webserver = "https://tle-2-receipt-scan-webservice.onrender.com/"
var imagetexture = Image.new()
var update_delay_tick = 2; #tick of 2 seconds
var current_delay_tick = 0;
var can_update_now = false;
func _process(delta):
	if update_delay_tick > current_delay_tick:
		current_delay_tick+=delta
		can_update_now = false
	else:
		can_update_now = true
		print("update tick triggered")
		current_delay_tick = 0
	

func setImageTexture(texture):
	imagetexture = ImageTexture.create_from_image(texture)
