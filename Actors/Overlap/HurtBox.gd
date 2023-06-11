###############
### HURTBOX ###
###############


### EXPENSION ###

extends Area2D
class_name HurtBox


export(NodePath) var statsPath
onready var stats = get_node(statsPath)




### LOGIC ###

func hurtbox_hurt(damage):
	if stats.current_health != 0 :
		stats.current_health = max(0, stats.current_health - damage)


	
