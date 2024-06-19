extends Control
@export var PanelNode:Panel
@export var LabelNode:Label
@export var SpriteNode:TextureRect

# Called when the node enters the scene tree for the first time.
func _ready():
	_check_nodes()	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _check_nodes():
	if PanelNode == null: 
		PanelNode = get_node("Panel")
	if LabelNode == null:
		LabelNode = get_node("List")
	if SpriteNode == null:
		SpriteNode = get_node("TextureRect")		
