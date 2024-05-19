extends Node2D


@onready var droppable = $Droppable
@onready var sprite = $AnimatedSprite2D

@export var stomache_size : int

var times_fed: int = 0
var sweet_spot: float
var hungry_level: float
var full: bool = false
var animating = false
var selected: bool = true

signal on_stomach_full()

# Called when the node enters the scene tree for the first time.
func _ready():
	#used as the fullness level where players get the most points
	sweet_spot = round(stomache_size/2)
	hungry_level = round(sweet_spot/2)
	print(hungry_level)
	sprite.play("idle")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func stomache_full():
	if(times_fed == stomache_size):
		if(droppable):
			droppable.queue_free()
		full = true
		on_stomach_full.emit()
		
func on_drop_down():
	times_fed += 1
	animating = true
	sprite.play("eating")
	stomache_full()
	print(times_fed)


func _on_animated_sprite_2d_animation_finished():
	animating = false
	if(full == true):
		sprite.play("full")
		animating = true
	else:
		sprite.play("idle")


func _on_droppable_entered(area):
	if area.class_object_name != null: 
		if area.class_object_name == "Draggable":
			if(animating == false):
				sprite.play("selected")


func _on_droppable_exited(area):
	if area.class_object_name != null: 
		if area.class_object_name == "Draggable":
			if (animating == false):
				sprite.play("sad")
