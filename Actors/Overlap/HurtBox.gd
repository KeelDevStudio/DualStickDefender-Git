###############
### HURTBOX ###
###############


### EXPENSION ###

extends Area2D
class_name HurtBox


### SIGNAL ###

signal Hurtbox_hurt


### LOGIC ###

func hurtbox_hurt(damage):
	print("hurt")
	emit_signal("Hurtbox_hurt", damage)
	
