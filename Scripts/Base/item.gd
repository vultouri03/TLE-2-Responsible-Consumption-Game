class_name Item

@export var itemID : int
@export var itemName : String
@export var expirationDate : int 
@export var amount : float
@export var unit : Globalvars.unitOfMesurement;
@export var description: String
func getID():
	return self.itemID
func getName():
	if itemName =="" or itemName == null:
		return "Item name not defined."
	return self.itemName
func getExpiryDate():
	return self.expirationDate
func getAmount(metrics:Globalvars.unitOfMesurement):
	#todo : Add conversion code
	match metrics: 
		Globalvars.unitOfMesurement.litres: 
			return self.amount
		Globalvars.unitOfMesurement.millilitres:
			return self.amount
		Globalvars.unitOfMesurement.grams:
			return self.amount
		Globalvars.unitOfMesurement.kilograms: 
			return self.amount
	return 

func _setVars(id,name,expry,amount_of_stuff,uom):
	if id != null:
		self.itemID = id
	if name != null:
		self.itemName = name
	if name != null:
		self.expirationDate = expry
	if uom != null:
		self.unit = uom
	if amount_of_stuff != null:
		self.amount = amount_of_stuff

func _init(id,name,expry,amount_of_stuff,uom):
	_setVars(id,name,expry,amount_of_stuff,uom)
