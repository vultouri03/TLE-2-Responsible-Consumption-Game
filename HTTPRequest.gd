extends Node

@export var responseBody: Resource
var file_path = 'res://Images/bonnetje.png'
var url = Globalvars.webserver
enum STATUS {SUCCESS, CLIENT_ERR, SERVER_ERR, NONE, FUNC_ERR}

var requestStatus = STATUS.NONE

var responseData = {}

signal Response_Done

# Called when the node enters the scene tree for the first time.
func _ready():
	
	print('Ready')


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Globalvars.can_update_now:
		print("Processing")

func _convert_to_base64():
	
	var image = Image.new()
	var image_data
	if Globalvars._get_image_texture() == null :
		image = load(file_path)
		Globalvars.image_texture = image

	image_data = Globalvars._get_image_texture().save_jpg_to_buffer()

	

	#print(image_data)

	var headers = PackedStringArray(["Content-Type: application/json"])
	
	var _base_64_data = Marshalls.raw_to_base64(image_data)

	var object = {
		"id" : Globalvars.user_hardware_id,
		"image" : _base_64_data,
	}

	var json = JSON.stringify(object)

	#print(json)

	_sendToServer(headers, json)

func _sendToServer(headers, json):

	var endPointUrl = url + 'classify'

	$HTTPRequest.request_completed.connect(_handleResponse)

	var error = $HTTPRequest.request(endPointUrl, headers, HTTPClient.METHOD_POST, json)
	
	if error != OK:
			print(_get_request_status(STATUS.FUNC_ERR))
	else:
		pass
	print("Requesting : "+ endPointUrl)

func _get_request_status(status):
	match status:
		STATUS.NONE:
			return "Request not yet executed";
		STATUS.SUCCESS:
			return "Request successful";
		STATUS.CLIENT_ERR:
			return "Request failed, check your connection."
		STATUS.SERVER_ERR: 
			return "Request failed, service is encountering problems. Please be patient."
		STATUS.FUNC_ERR: 
			return "There's a software issue."

func _handleResponse(result, response_code, headers, body):
	print(response_code)
	match response_code:
		200:
			requestStatus = STATUS.SUCCESS
		404:
			requestStatus = STATUS.CLIENT_ERR
		500:
			print('Internal Server Error')
	
	#Turn these prints off eventually when done debugging because they output a massive base64 log that overflows the console. 
	print(headers)
	print(result)
	print(response_code)

	print(_get_request_status(requestStatus))

	print(body.get_string_from_utf8())
	print(responseBody)
	
	if response_code != 200:
		Globalvars.receipt_status = JSON.stringify("ERROR")

#There's an error with the server's sending of data that causes this to return a 502
	if responseBody:
		
		Globalvars.categories = JSON.parse_string(body.get_string_from_utf8())
		#for key in Globalvars.categories:
			#if (key.name == responseBody[key][0]):
				#key.name == responseBody[key][1]
		#print(Globalvars.categories)
		Response_Done.emit()
	$HTTPRequest.request_completed.disconnect(_handleResponse)	

func _on_button_button_down():
	SelectSFX.play()
	_convert_to_base64()





func _on_button_2_button_down():
	SelectSFX.play()
	get_tree().change_scene_to_file("res://Levels/lvl_main_menu.tscn")
