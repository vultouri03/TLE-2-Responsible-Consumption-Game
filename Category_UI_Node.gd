extends Sprite2D

@onready var amount = $Amount


@export var baseExpiration : int
var expiration : int
#Decrease the amount of items in the inventory
var _amount : int
var _amountText : String

#chaneged ready to _ready to make it work on initialization
func _ready():
	_amountText = amount.text
	_amount = int(_amountText)
	expiration = baseExpiration
	print("expiration is")
	print(expiration)

func _on_button_pressed():
	print("button pressed")
	
	if _amount > 0:
		if expiration == 1:
			expiration = baseExpiration
		_instantiateDraggable()
		updateAmount()
	


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


func updateExpiration():
	
	if expiration <= 0:
		print("product expired")
		#removed _amount -= 1 which set the amount to zero which prevented it from updating
		expiration = baseExpiration
		updateAmount()
		

func updateAmount():
	if _amount > 0:
		#added this to better update the actual amount
		_amount -= 1
		var _amountString = str(_amount)

		self.get_node("Amount").text = _amountString
