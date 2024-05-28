extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var imagePlugin
var currentMenu = "start"
@export var getImageController:Node2D
# Get the permissions for the camera.
func _getImagePermissions():
	if Engine.has_singleton("GodotGetImage"):
		imagePlugin = Engine.get_singleton("GodotGetImage")
	if imagePlugin:
		imagePlugin.resendPermission()
		imagePlugin.getCameraImage()
	else: 
		print("Button Worked but plugin inst loaded...")
	pass # Replace with function body.

func _updateCameraButtonState():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_pressed():
	print("Start button pressed")
	_switch_menu_state()
	
	pass # Replace with function body.


func _on_camera_pressed():
	print("Camera button pressed")
	#_getImagePermissions()
	
	
	pass # Replace with function body.


func _on_back_pressed():
	_switch_menu_state()
	pass # Replace with function body.


func _on_continue_pressed():
	get_tree().change_scene_to_file("res://Levels/lvl_main_game.tscn")
	pass # Replace with function body.


func _on_scan_pressed():
	#getImageController._get_camera_image()
	get_tree().change_scene_to_file("res://Game_objects/test.tscn")
	pass # Replace with function body.


func _switch_menu_state():
	if currentMenu == "start":
		currentMenu = "sub_menu_1"
	else:
		currentMenu = "start"
	
	if currentMenu == "start":
		$VboxStart.visible = true
		$VBoxSubMenu.visible = false
	else:
		$VboxStart.visible = false
		$VBoxSubMenu.visible = true
