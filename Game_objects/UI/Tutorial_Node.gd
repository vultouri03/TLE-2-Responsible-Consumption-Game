extends Control

#toggle visibilty and toggle icon to icon name
func _on_button_pressed():
	self.visible = !self.visible

	#change icon of connected button to reflect visibility swapping between the questionmark and the x in the images folder
	var connectedButton = get_node("../TutorialButton")
	if self.visible:
		connectedButton.icon = load("res://images/XIcon.png")
	else:
		connectedButton.icon = load("res://images/Questionmark.png")
	

	
