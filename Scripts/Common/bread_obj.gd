extends Node

var itemDefinition = load("res://Scripts/Common/milk.gd")
var item = itemDefinition.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	item._setVars(0001,"Chicken Powder Milk", 8, 1.5,Globalvars.unitOfMesurement.litres)
	print(item.getName())
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
