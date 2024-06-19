extends Node





# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_fetch_calls_response_done():
	get_tree().change_scene_to_file("res://Levels/lvl_main_game.tscn")
	#var scene = preload("res://Game_objects/UI/inventory.tscn")
	#var instance = scene.instantiate()
	#self.add_child(instance)
	
