#############
### STATS ###
#############


### EXPENSION ####

extends Node
class_name Stats


signal current_health_0


### GLOBAL VARIABLE ###

export var max_health : int 
onready var current_health setget set_current_health
export var damage : int
export var speed : int

func _ready():
	current_health = max_health
#	healthBarTexture.set_max(max_health)
#	healthBarTexture.set_value(current_health)


func set_current_health(_value):
	current_health = _value
	if current_health == 0 :
		emit_signal("current_health_0")
	pass
