extends Node2D
#This is hella sloppy but I'm short on time.
var recipesList = [
	{"recipe_name": "Bread", "ingredients": ["wheats"]},
	{"recipe_name": "Meat Sandwich", "ingredients": ["wheats", "wheats", "meat"]},
	{"recipe_name": "Water", "ingredients": ["drinks"]},
	{"recipe_name": "Plate o Carrot", "ingredients": ["vegetables"]},
	{"recipe_name": "Spicy Chicken", "ingredients": ["meat", "spices"]},
]
var recipeCurrentIndex = 0;
@export var currentRecipeName:String = "Bread"
@export var RecipeInfoPanel:Panel
@export var RecipeInfoContainer:VBoxContainer
@export var requiredIngredients:Array =["wheats","wheats","meat","meat", "dairy"]
@export var ingredientAtlas:Array = [
		{
			"name": "wheats",
					"x": 60,
			"y": 30
		},
		{
			"name": "meat",
				"x": 455,
			"y": 30
		},
		{
			"name": "drinks",
					"x": 955,
			"y": 30
		},
		{
			"name": "spices",
					"x": 1400,
			"y": 30
		},
		{
			"name": "dairy",
					"x": 1860,
			"y": 30
		},
		{
			"name": "vegetables",
					"x": 2310,
			"y": 30
		},
		{
			"name": "sauces",
					"x": 2800,
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

func check_if_own_recipes_complete():
	return check_recipe_complete(ingredients)
func check_recipe_complete(provided_ingredients: Array) -> bool:
		# Define the required ingredients for the recipe
	#print(provided_ingredients)
	
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
	
	var gui_counts = get_current_ingredient_counts()
	for ingredient in requiredIngredients:
		for gui_ing in gui_counts:
			if gui_ing.ingredient_name == ingredient:
				RecipeInfoPanel._update_amount_count(gui_ing.ingredient_name,gui_ing.current_count,gui_ing.desired_count)

	#Compare both dictionaries
	#return provided_counter == required_counter  
	for ingredient in required_counter.keys():
		var required_amount = required_counter[ingredient]
		var provided_amount = provided_counter.get(ingredient, 0)
		if provided_amount < required_amount:
			return false
	return true

func get_current_ingredient_counts() -> Array:
	var ingredient_counts = {}
	var desired_counts = {}

	# Count occurrences in required ingredients
	for ingredient in requiredIngredients:
		if ingredient_counts.has(ingredient):
			ingredient_counts[ingredient] += 1
		else:
			ingredient_counts[ingredient] = 1
	
	# Initialize desired counts
	for ingredient in requiredIngredients:
		if desired_counts.has(ingredient):
			desired_counts[ingredient] += 1
		else:
			desired_counts[ingredient] = 1
	
	var formatted_counts = []
	for ingredient in ingredient_counts.keys():
		formatted_counts.append({
			"ingredient_name": ingredient,
			"current_count": ingredient_counts[ingredient],
			"desired_count": desired_counts[ingredient]
		})
	
	return formatted_counts

	
func add_ingredient(name: String) -> void:
	ingredients.append(name)


func get_sprite_atlas_offset(ingredient_name: String) -> Vector2:
	for ingredient in ingredientAtlas:
		if ingredient.name == ingredient_name:
			return Vector2(ingredient.x,ingredient.y)
	return Vector2.ZERO

func set_up_gui():
	RecipeInfoPanel._clear_contents()
	RecipeInfoPanel._update_recipe_name(currentRecipeName)
	var repeats = []
	for ingredient in requiredIngredients:
		for ingredient_atlas_coord in ingredientAtlas:
			if ingredient_atlas_coord.name == ingredient:
				if !repeats.has(ingredient):
					repeats.append(ingredient)
					RecipeInfoPanel._draw_new_icon(ingredient,Vector2(ingredient_atlas_coord.x,ingredient_atlas_coord.y))
	pass
func _iterate_count():
	if check_recipe_complete(ingredients):
		print("Recipe Complete")
	else:
		print("Recipe incomplete")
	pass
func _process(delta):
	if Globalvars.can_update_now:
		_iterate_count()


func _set_current_recipe(desired_recipe):
	requiredIngredients= desired_recipe.ingredients
	currentRecipeName = desired_recipe.recipe_name
	set_up_gui()
	_iterate_count()
	
func next_recipe():
	if recipeCurrentIndex<(recipesList.size()-1):
		recipeCurrentIndex+=1;
		_set_current_recipe(recipesList[recipeCurrentIndex])
func previous_recipe():
	if (recipeCurrentIndex-1)>=0:
		recipeCurrentIndex+=-1;
		_set_current_recipe(recipesList[recipeCurrentIndex])
func check_if_draggables_meet_recipe_count():
	var draggables = get_tree().get_nodes_in_group("Draggables")
	var send_check =[]
	for draggable in draggables:
		if draggable.visible:
			send_check.append(draggable.category_id.to_lower())
			#print(draggable.category_id.to_lower())
	ingredients = send_check
	return check_recipe_complete(send_check)
	pass
func is_item_desired(item):
	for ingredient in requiredIngredients:
		if item == ingredient:
			return true
func _ready():
	Globalvars.RecipeSystem = self
	set_up_gui()
	_set_current_recipe(recipesList[recipeCurrentIndex])
	pass
