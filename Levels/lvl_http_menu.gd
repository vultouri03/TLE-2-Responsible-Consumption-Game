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
	if ui.visible == false:
		match status:
			"STATUS_ERROR":
				progress_bar.valye = 0
				text.text ="[center]Something went wrong with the status server, request might still go through"
			"ERROR":
				progress_bar.value = 0
				text.text ="[center]There is an issue with the receipt server or the server is down for maintanance"
			"CONNECTING":
				progress_bar.value = 0
				text.text = "[center]Connecting to the server"
			"NONE":
				progress_bar.value = 12.5
				text.text = "[center]Received receipt on the server"
			"PROCESSING":
				progress_bar.value = 25
				text.text = "[center]Processing receipt"
			"CLASSIFYING":
				progress_bar.value = 50
				text.text = "[center]Classifying receipt text"
			"CATEGORIZING":
				progress_bar.value = 75
				"[center]Categorizing items"
			"SUCCESS":
				progress_bar.value = 100
				text.text = "[center]Request completed"
				status_timer.stop()
			


func _on_progress_bar_value_changed(value):
	if value == 100:
		get_tree().change_scene_to_file("res://Levels/lvl_main_game.tscn")
