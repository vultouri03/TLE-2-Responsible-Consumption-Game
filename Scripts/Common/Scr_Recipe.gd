extends Node2D
@export var RecipeInfoPanel:Panel
@export var requiredIngredients:Array =["wheats","wheats","meat","meat"]
@export var ingredientAtlas:Array = [
		{
			"name": "wheats",
			"x": 0,
			"y": 0
		},
		{
			"name": "meat",
					"x": 0,
			"y": 0
		},
		{
			"name": "drinks",
					"x": 0,
			"y": 0
		},
		{
			"name": "spices",
					"x": 0,
			"y": 0
		},
		{
			"name": "dairy",
					"x": 0,
			"y": 0
		},
		{
			"name": "vegetables",
					"x": 0,
			"y": 0
		},
		{
			"name": "sauces",
					"x": 0,
			"y": 0
		}
	]
var ingredients: Array = []

# Ingredient data structure
class Ingredient:
	var name: String
	var sprite_atlas_offset: Vector2

	func _init(name: String, offset: Vector2):
		self.name = name
		self.sprite_atlas_offset = offset


func check_recipe_complete(provided_ingredients: Array) -> bool:
		# Define the required ingredients for the recipe

	
	# Create dictionaries to count occurrences of each ingredient
	var provided_counter = {}
	var required_counter = {}
	
	# Count occurrences in provided ingredients
	for ingredient in provided_ingredients:
		if provided_counter.has(ingredient):
			provided_counter[ingredient] += 1
		else:
			provided_counter[ingredient] = 1
	
	# Count occurrences in required ingredients
	for ingredient in requiredIngredients:
		if required_counter.has(ingredient):
			required_counter[ingredient] += 1
		else:
			required_counter[ingredient] = 1
	
	# Compare both dictionaries
	return provided_counter == required_counter  


func add_ingredient(name: String, offset: Vector2) -> void:
	var ingredient = Ingredient.new(name, offset)
	ingredients.append(ingredient)


func get_sprite_atlas_offset(ingredient_name: String) -> Vector2:
	for ingredient in ingredientAtlas:
		if ingredient.name == ingredient_name:
			return Vector2(ingredient.x,ingredient.y)
	return Vector2.ZERO  #

func set_up_gui():
	
# Example usage
func _ready():
	print( check_recipe_complete(["wheat","meat","meat","wheat"]))
	print(	get_sprite_atlas_offset("wheats"))
	pass
