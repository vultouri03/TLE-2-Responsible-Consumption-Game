extends Node2D

@onready var status_timer = $"Status Timer"
@onready var progress_bar = $ProgressBar
@onready var ui = $UI
@onready var text = $TEXT



func _on_request_send():
	status_timer.start()
	ui.visible = false


func _process(delta):
	var status = JSON.parse_string(Globalvars.receipt_status)
	match status:
		"CONNECTING":
			progress_bar.value = 0
			text.text = "hello world"
		"NONE":
			progress_bar.value = 12.5
		"PROCESSING":
			progress_bar.value = 25
		"CLASSIFYING":
			progress_bar.value = 50
		"CATEGORIZING":
			progress_bar.value = 75
		"SUCCESS":
			progress_bar.value = 100
			status_timer.stop()
		
