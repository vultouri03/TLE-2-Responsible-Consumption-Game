extends Control

#toggle visibilty and toggle icon to icon name
func _on_button_pressed():
	self.visible = !self.visible
	
	var connectedButton = get_node("../TutorialButton")
	if self.visible:
		connectedButton.icon = load("res://images/XIcon.png")
		get_child(0).mouse_filter = MOUSE_FILTER_STOP
		#self.process.mode = Node.PROCESS_MODE_ALWAYS
	else:
		connectedButton.icon = load("res://images/Questionmark.png")
		get_child(0).mouse_filter = MOUSE_FILTER_IGNORE
		#self.process_mode = Node.PROCESS_MODE_DISABLED 
	

	
