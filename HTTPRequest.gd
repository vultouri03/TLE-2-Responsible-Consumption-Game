extends Node

var file_path = './Images/Banana.jpg'
var url = Globalvars.webserver
enum STATUS {SUCCESS, CLIENT_ERR, SERVER_ERR, NONE, FUNC_ERR}

var requestStatus = STATUS.NONE

# Called when the node enters the scene tree for the first time.
func _ready():
	_convert_to_base64()
	print('Ready')


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print('Processing')

func _convert_to_base64():
	var image = Image.new()
	image.load(file_path)
	var image_data = image.save_jpg_to_buffer()

	print(image_data)

	var headers = PackedStringArray(["Content-Type", "application/json"])
	
	var _base_64_data = Marshalls.raw_to_base64(image_data)
	var json = JSON.stringify(_base_64_data)

	print(json)

	_sendToServer(headers, json)

func _sendToServer(headers, json):

	var endPointUrl = url + '/classify'

	$HTTPRequest.request_completed.connect(_handleResponse)

	$HTTPRequest.request(endPointUrl, headers, HTTPClient.METHOD_POST, json)
	print("Requesting : "+ endPointUrl)

	var error = $HTTPRequest.request(endPointUrl, headers, HTTPClient.METHOD_POST, JSON.stringify(json))
	
	if error != OK:
			print(_get_request_status(STATUS.FUNC_ERR))
	else:
		pass
	pass



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

	var responseBody = JSON.parse_string(body.get_string_from_utf8())
	print(responseBody)
		
	

	
