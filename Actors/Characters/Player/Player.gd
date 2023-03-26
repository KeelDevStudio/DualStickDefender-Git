##############
### PLAYER ###
##############


### EXPENSION  ###

extends KinematicBody2D
class_name Player


### GLOBAL VARIABLE ###

const MAX_SPEED = 50
const FRICTION = 500
const ACCELERATION = 250

onready var animation_player = $AnimationPlayer
onready var animation_tree = $AnimationTree
onready var animation_state = animation_tree.get("parameters/playback")
onready var state_machine = $STATEMACHINE
onready var controler = $Controler

var velocity = Vector2.ZERO
var dir_move = Vector2.ZERO


### BUIL IN ###

func _ready():
	state_machine.set_to_default_state()

func _physics_process(_delta):
	_updated_animation()
	dir_move = Vector2.ZERO
	dir_move.x = int(controler.right) - int(controler.left)
	dir_move.y = int(controler.down) - int(controler.up)
	dir_move = dir_move.normalized()


### LOGIC ###

func hurt(_damage):
	pass
	
func _updated_animation():
	animation_state.travel(state_machine.get_state_name())
	if velocity != Vector2.ZERO:
		animation_tree.set("parameters/" + state_machine.get_state_name() + "/blend_position", velocity)


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


### SIGNAL RESPONSISES ###

func _attack_animation_finished():
	state_machine.set_state("MOVE")
