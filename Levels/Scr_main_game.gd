extends Node2D

@onready var inventory = $Inventory
@onready var creatures = $creatures


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_button_down():
	if inventory.visible == true:
		creatures.process_mode = Node.PROCESS_MODE_ALWAYS
		inventory.visible = false
	else:
		creatures.process_mode = Node.PROCESS_MODE_DISABLED
		print(creatures.process_mode)
		inventory.visible = true
		



