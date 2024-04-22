extends Node

@export var responseBody: Resource
var file_path = './Images/Banana.jpg'
var url = Globalvars.webserver
enum STATUS {SUCCESS, CLIENT_ERR, SERVER_ERR, NONE, FUNC_ERR}

var requestStatus = STATUS.NONE

# Called when the node enters the scene tree for the first time.
func _ready():
	
	print('Ready')


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Globalvars.can_update_now:
		print("Processing")

func _convert_to_base64():
	
	var image = Image.new()

	if Globalvars.imagetexture == null:
		image.load(file_path)
	else:
		image.load(Globalvars.imageTexture)

	var image_data = image.save_jpg_to_buffer()

	#print(image_data)

	var headers = PackedStringArray(["Content-Type: application/json"])
	
	var _base_64_data = Marshalls.raw_to_base64(image_data)

	var object = {
		"id" : 0000,
		"image" : _base_64_data,
	}

	var json = JSON.stringify(object)

	print(json)

	_sendToServer(headers, json)

func _sendToServer(headers, json):

	var endPointUrl = url + 'classify'

	$HTTPRequest.request_completed.connect(_handleResponse)

	$HTTPRequest.request(endPointUrl, headers, HTTPClient.METHOD_POST, json)
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
	match response_code:
		200:
			requestStatus = STATUS.SUCCESS
		404:
			requestStatus = STATUS.CLIENT_ERR
		500:
			print('Internal Server Error')
	
	print(headers)
	print(result)
	print(response_code)

	print(_get_request_status(requestStatus))

	print(body.get_string_from_utf8())
	print(responseBody)

	if responseBody:
		responseBody.categories = JSON.parse_string(body.get_string_from_utf8())
		
	

	


func _on_button_button_down():
	_convert_to_base64()
