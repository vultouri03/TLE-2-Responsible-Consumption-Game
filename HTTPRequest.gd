extends Node

var file_path = './Images/Banana.jpg'

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

	_convert_to_base64()

	var url = 'https://tle-2-receipt-scan-webservice.onrender.com/'

	$HTTPRequest.request_completed.connect(_handleResponse)

	$HTTPRequest.request(url, headers, HTTPClient.METHOD_POST, json)

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
			requestStatus
		404:
			print('Not Found')
		500:
			print('Internal Server Error')
		
	var json = JSON.parse_string(json.get_string_from_utf8())
	

	
