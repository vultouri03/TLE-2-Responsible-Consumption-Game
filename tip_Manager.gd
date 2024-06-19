extends Node

var file = "res://tips.json"
var json_as_text = FileAccess.get_file_as_string(file)
var json_data
var tips_list
var tip_eind

var scoreList = {
	"expired": 0,
	"cooking_waste": 0,
	"feeding_waste": 0,
	"starving": 0,
	"storing_waste": 0
}

# Called when the node enters the scene tree for the first time.
func _ready():
	_get_all_tips()
	_set_all_tips()
	_get_tip()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _get_all_tips():
	var json_parser = JSON.new()
	var parse_result = json_parser.parse(json_as_text)
	
	if parse_result != OK:
		print("ERROR: Failed to parse JSON")
		return
	
	json_data = json_parser.get_data()
	
	if typeof(json_data) == TYPE_DICTIONARY:
		for category in json_data.keys():
			if typeof(json_data[category]) == TYPE_ARRAY and json_data[category].size() > 0:
				print("Tips found in the category:", category)
			else:
				print("ERROR: No tips found in the category:", category)
	else:
		print("ERROR: Invalid JSON format. Expected a dictionary.")
	pass

# set all tips op the tips page
func _set_all_tips():
	tips_list = $"../TipList"
	if(tips_list):
		tips_list.clear()
		for category in json_data.keys():
			if typeof(json_data[category]) == TYPE_ARRAY and json_data[category].size() > 0:
				for tip in json_data[category]:
					tips_list.add_item(tip, null, false)
	else:
		print("ERROR: tips_list not found")
	pass

func _add_tip_score(key: String, valueToAdd: int):
	scoreList[key] += valueToAdd
	pass

func _remove_tip_score(key: String, valueToAdd: int):
	scoreList[key] -= valueToAdd
	pass

func _reset_tip_score():
	scoreList["expired"] = 0
	scoreList["cooking_waste"] = 0
	scoreList["feeding_waste"] = 0
	scoreList["starving"] = 0
	scoreList["storing_waste"] = 0
	pass

# get the eind tip
func _get_tip():
	var highestKey = ""
	var highestValue = -1
	var my_random_number = 0
	
	for key in scoreList.keys():
		if scoreList[key] > highestValue:
			highestValue = scoreList[key]
			highestKey = key
	
	if typeof(json_data) == TYPE_DICTIONARY:
		my_random_number = randf_range(0, json_data[highestKey].size())
		print('eind tip ' + json_data[highestKey][my_random_number])
	else:
		print('ERROR: get eind tip')
	
	tip_eind = $"../Tips/TipText"
	if(tip_eind):
		tip_eind.text = 'TIP: ' + json_data[highestKey][my_random_number]
	else:
		print("ERROR: tip_eind not found")
	pass
