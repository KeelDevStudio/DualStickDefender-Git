##################
### PROJECTILE ###
##################


### EXPENSION ###

extends Area2D
class_name Projectile


### GLOBAL VARIABLE ###

export var damage : int
var move = Vector2.ZERO
var speed = 20.0
var look_vec = Vector2.ZERO
var target


### BUILT IN ###

func _ready():
	var __ = $VisibilityNotifier2D.connect("screen_exited", self, "_on_screen_exited")
	__ = $VisibilityNotifier2D.connect("screen_entered", self, "_on_screen_entered")
	__ = connect("area_entered", self, "_on_area_entered")
#	__ = connect("body_entered", self,"_on_body_entered")
	if target != null:
		$Sprite.look_at(target.global_position)
		look_vec = target.global_position - global_position

func _physics_process(delta):
	move = Vector2.ZERO
	
	move = move.move_toward(look_vec, delta)
	move = move.normalized() * speed
	global_position += move


### SIGNAL RESPONSISES ###

func _on_area_entered(_area):
	_area.hurtbox_hurt(damage)
	queue_free()

func _on_screen_exited():
	self.visible = false

func _on_screen_entered():
	self.visible = true
