extends Node

var itemDefinition = load("res://Scripts/Base/item.gd")

var item = itemDefinition.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	print(item.getName());
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
