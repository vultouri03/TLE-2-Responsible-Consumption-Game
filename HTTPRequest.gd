extends HTTPRequest

var file = ''

# Called when the node enters the scene tree for the first time.
func _ready():
	_sendToServer()
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _sendToServer():

	var headers = {
		"Content-Type": "application/json",
	}
	
	var _base_64_data = Marshalls.raw_to_base64(file.get_buffer(file.get_len()))
	var json = JSON.stringify(_base_64_data)

	var url = ''

	$HTTPRequest.request(url, headers, HTTPClient.METHOD_POST, json)

	var response = json.parse($HTTPRequest.get_response_data())

	if $HTTPRequest.get_response_code() == 200:
		_handleResponse('SUCCESS ' + response)
	else:
		_handleResponse('FAILED ' + response)


func _handleResponse(response):
	print(response)
	
	