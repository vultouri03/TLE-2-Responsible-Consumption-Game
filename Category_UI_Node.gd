extends Sprite2D


func _on_button_pressed():
    var _amountText = self.get_node("Amount").text
    var _amount = int(_amountText) -1
    var _amountString = str(_amount)
    self.get_node("Amount").text = _amountString