extends HTTPRequest

var file_path = './Images/Banana.jpg'

# Called when the node enters the scene tree for the first time.
func _ready():
	_sendToServer()
	print('Ready')


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print('Processing')

func _sendToServer():

	var image = Image.new()
	image.load(file_path)
	var image_data = image.save_jpg_to_buffer()

	print(image_data)

	var headers = {
		"Content-Type": "application/json",
	}
	
	var _base_64_data = Marshalls.raw_to_base64(image_data)
	var json = JSON.stringify(_base_64_data)

	print(json)

	var url = 'http://localhost:8000/classify'

	self.request(url, headers, HTTPClient.METHOD_POST, json)

	var response = json.parse($HTTPRequest.get_response_data())

	if $HTTPRequest.get_response_code() == 200:
		_handleResponse('SUCCESS ' + response)
	else:
		_handleResponse('FAILED ' + response)


func _handleResponse(response):
	print(response)
	
	
