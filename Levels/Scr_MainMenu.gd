extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var imagePlugin

# Get the permissions for the camera.
func _getImagePermissions():
	if Engine.has_singleton("GodotGetImage"):
		imagePlugin = Engine.get_singleton("GodotGetImage")
		imagePlugin.connect("image_request_completed",_updateCameraButtonState)
		
	if imagePlugin:
		imagePlugin.resendPermission()
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
	pass # Replace with function body.


func _on_camera_pressed():
	print("Camera button pressed")
	_getImagePermissions()
	
	pass # Replace with function body.
