extends Sprite2D

func _on_button_pressed():
	 
	#Decrease the amount of items in the inventory
	var _amountText = self.get_node("Amount").text
	var _amount = int(_amountText)

	if _amount > 0:

		var _amountString = str(_amount - 1)

		self.get_node("Amount").text = _amountString

		_instantiateDraggable()
	


func _instantiateDraggable():

	#Instantiate draggable item with the right image
	var scene = preload("res://Scripts/GUI/Draggable.tscn")
	var instance = scene.instantiate()
	var textureToChange = instance.get_child(0).texture

	add_child(instance)

	textureToChange = self.texture
	textureToChange.texture.frame = self.texture.frame
	#This currently spawns the full image, but the image is animated and should spawn the right frame based on the one assigned on the parent