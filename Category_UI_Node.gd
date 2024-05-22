extends Sprite2D

@export var baseExpiration : int
var expiration = baseExpiration
#Decrease the amount of items in the inventory
var _amountText = self.get_node("Amount").text
var _amount = int(_amountText)


func _on_button_pressed():
	 
	if _amount > 0:

		var _amountString = str(_amount - 1)

		self.get_node("Amount").text = _amountString

		_instantiateDraggable()
	


func _instantiateDraggable():
	var root = get_tree().current_scene
	print(root)
	#Instantiate draggable item with the right image
	var scene = preload("res://Game_objects/Prefabs/DraggableItem.tscn")
	var instance = scene.instantiate()
	var textureToChange = instance.get_child(1)
	#sets the frame to the correct image
	textureToChange.frame = self.frame
	instance.global_position = self.position
	root.add_child(instance)


func _on_visibility_changed():
	if expiration <= 0:
		_amount -= 1
		expiration = baseExpiration