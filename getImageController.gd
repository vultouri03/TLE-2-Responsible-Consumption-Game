extends Node2D
var imagePlugin

# Called when the node enters the scene tree for the first time.
func _ready():
	if Engine.has_singleton("GodotGetImage"):
		imagePlugin = Engine.get_singleton("GodotGetImage")
		imagePlugin.connect("image_request_completed",_set_image)

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _get_camera_image():
	if imagePlugin:
		imagePlugin.getCameraImage()
	else: 
		print("Button Worked but plugin inst loaded...")
	pass # Replace with function body.

func _get_gallery_selection():
	if imagePlugin:
		imagePlugin.getGalleryImage()
	else: 
		print("Button Worked but plugin inst loaded...")
	pass # Replace with function body.

func _set_image(dict):
	print(dict)
	for image in dict.values():
		print(image);
		var currentImage = Image.new()
		currentImage.load_jpg_from_buffer(image)
		print("Loading Image")
		await get_tree().process_frame
		Globalvars.setImageTexture(image)
		var texture = ImageTexture.create_from_image(currentImage)
		$TextureRect.texture = texture
	pass
