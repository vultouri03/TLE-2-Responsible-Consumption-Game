extends Node
enum STATUS{SUCCESS,CLIENT_ERR, SERVER_ERR,NONE,FUNC_ERR}
var requestStatus = STATUS.NONE
# Called when the node enters the scene tree for the first time.
func _ready():
	_get_reciept_status()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _get_reciept_status(): 
	
	$HTTPRequest.request_completed.connect(_on_request_completed)
	var error = $HTTPRequest.request("http://127.0.0.1:8000/classify")
	if error != OK:
			print(_get_request_status(STATUS.FUNC_ERR))
	else:
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

func _on_request_completed(result, response_code, headers, body):
	match response_code:
		200:
			requestStatus = STATUS.SUCCESS
		400:
			requestStatus = STATUS.CLIENT_ERR
		500:
			requestStatus = STATUS.SERVER_ERR
	print(_get_request_status(requestStatus))
	var json = JSON.parse_string(body.get_string_from_utf8())
	print(json)


