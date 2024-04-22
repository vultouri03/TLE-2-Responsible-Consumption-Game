extends Node
enum STATUS{SUCCESS,CLIENT_ERR, SERVER_ERR,NONE,FUNC_ERR}
var requestStatus = STATUS.NONE
var webserver = Globalvars.webserver
var active_receipt = {"id":1000,"image":""} #the reciept object that aligns with the server
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
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
	print(headers)
	print(result)
	print(response_code)
	print(_get_request_status(requestStatus))
	var json = JSON.parse_string(body.get_string_from_utf8())
	print(json)

	
func _send_to_server(webserver_url,body_to_json_encode,function_to_do_after_request_completion):
	$HTTPRequest.request_completed.connect(function_to_do_after_request_completion)
	print("Requesting : "+ webserver_url)

	var headers = ["Content-Type: application/json"]

	var error = $HTTPRequest.request(webserver_url, headers, HTTPClient.METHOD_POST, JSON.stringify(body_to_json_encode))
	
	if error != OK:
			print(_get_request_status(STATUS.FUNC_ERR))
	else:
		pass
	pass


func _on_bt_send_button_up():

	_send_to_server(webserver+"classify",active_receipt,_on_request_completed)
	pass 


func _on_bt_status_button_up():

	_send_to_server(webserver+"status",active_receipt,_on_request_completed)
	pass

func _on_bt_fakeload_button_up():
	pass
