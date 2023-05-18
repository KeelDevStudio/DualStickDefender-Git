#############
### STATS ###
#############


### EXPENSION ####

extends Node
class_name Stats

enum ACTOR_TYPE{
	ENEMY,
	PLAYER
	}
	
export (ACTOR_TYPE) var actor_type
var actor_type_name : String

onready var waveManagerArray = get_tree().get_nodes_in_group("WavesManager")
onready var waveManager = waveManagerArray[0]



signal current_health_0
signal im_dead


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
		match(actor_type):
			ACTOR_TYPE.ENEMY : waveManager._add_mob_kill()
			
		emit_signal("current_health_0")
	pass
