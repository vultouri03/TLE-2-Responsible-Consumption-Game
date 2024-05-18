extends Sprite2D

@export var item = Area2D

func _on_button_pressed():
	var _amountText = self.get_node("Amount").text
	var _amount = int(_amountText) -1
	var _amountString = str(_amount)
	self.get_node("Amount").text = _amountString

	#Instantiate draggable item with the right image
	var scene = preload("res://Scripts/GUI/Draggable.tscn")
	var instance = scene.instantiate()
	add_child(instance)
    instance.get_child(0).texture = self.texture
    instance.get_child(0).frame = self.frame
    #This currently spawns the full image, but the image is animated and should spawn the right frame based on the one assigned on the parent


