##############
### HITBOX ###
##############

### EXPENSION ###

extends Area2D
class_name HitBox


### GLOBAL VARIABLE ###

export var damage : int


func _ready():
	var __= connect("area_entered", self, "_on_area_entered")


func _on_area_entered(_area):
	_area.hurtbox_hurt(damage)
