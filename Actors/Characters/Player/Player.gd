##############
### PLAYER ###
##############


### EXPENSION  ###

extends KinematicBody2D
class_name Player


### GLOBAL VARIABLE ###

const FRICTION = 500
const ACCELERATION = 250

onready var damage = $Stats.damage
onready var MAX_SPEED = $Stats.speed
onready var animation_player = $AnimationPlayer
onready var animation_tree = $AnimationTree
onready var animation_state = animation_tree.get("parameters/playback")
onready var state_machine = $STATEMACHINE
onready var controler = $Controler
#onready var HP_bar = $HUD/HealthBar/TextureProgress
onready var stats = $Stats

var velocity = Vector2.ZERO
var dir_move = Vector2.ZERO


### BUIL IN ###

func _ready():
	var __ = stats.connect("current_health_0", self, "_on_current_health_0")
	state_machine.set_to_default_state()
	$Pivot/PivotWeapon/AttacktHitBox.damage = stats.damage
#	HP_bar.set_max(stats.max_health)
#	HP_bar.set_value(stats.current_health)

func _physics_process(_delta):
	var mouse_position = get_global_mouse_position()
	_updated_animation()
	dir_move = Vector2.ZERO
	dir_move.x = int(controler.right) - int(controler.left)
	dir_move.y = int(controler.down) - int(controler.up)
	dir_move = dir_move.normalized()
	$Pivot/PivotWeapon.look_at(mouse_position)
#	if dir_move.x != 0:
	if (mouse_position.x - self.position.x) > 1:
		$Pivot.scale.x = +1
	elif (mouse_position.x - self.position.x) < 1: 
		$Pivot.scale.x = -1


### LOGIC ###

func hurt(_damage):
	pass
	
func _updated_animation():
	animation_state.travel(state_machine.get_state_name())
#	if velocity != Vector2.ZERO and not state_machine.get_state_name() == "ATTACK":
#		animation_tree.set("parameters/" + state_machine.get_state_name() + "/blend_position", velocity)
#		animation_tree.set("parameters/ATTACK/blend_position", velocity)
#
		


### LOGIC STATE ###

func MOVE_update_state(_delta):
	if dir_move != Vector2.ZERO:
		velocity = velocity.move_toward(dir_move * MAX_SPEED, ACCELERATION * _delta)
	else : state_machine.set_state("IDLE")

	if controler.attack1 : state_machine.set_state("ATTACK")

	velocity = move_and_slide(velocity)

func IDLE_update_state(_delta):
	velocity = velocity.move_toward(Vector2.ZERO, FRICTION * _delta)
	
	if dir_move != Vector2.ZERO:
		state_machine.set_state("MOVE")
	
	if controler.attack1 : state_machine.set_state("ATTACK")


### SIGNAL RESPONSISES ###

func _attack_animation_finished():
	state_machine.set_state("MOVE")

func DIE_animation_finished():
	queue_free()

func _on_current_health_0():
	state_machine.set_state("DIE")
