#############################
### EASY ENEMIE CONTROLER ###
#############################


### EXPENSION ###

extends KinematicBody2D
class_name EasyEnemieControler


### GLOBAL VARIABLE ###

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var chaseArea = $ChaseArea
onready var line2D = $Navigation2D/Line2D
onready var timer = $Timer
onready var navigation = $Navigation2D
onready var state_machine = $STATEMACHINE

var velocity: Vector2 = Vector2.ZERO
var speed := 30
var path : Array = []
var levelNavigation: Navigation2D = null
var main_target = null
var target = null
var target_in_range = false


### BUILT_IN ###

func _initialize():
	var __ = $ChaseArea.connect("body_entered", self, "_on_chaseArea_body_entered")
	__ = $ChaseArea.connect("body_exited", self, "_on_chaseArea_body_exited")
	__ = $AttackArea.connect("body_entered", self, "_on_attackArea_body_entered")
	__ = $AttackArea.connect("body_exited", self, "_on_attackArea_body_exited")
	
func _ready():
	_initialize()
	state_machine.set_to_default_state()
	var tree = get_tree()
	if tree.has_group("levelNavigation"):
		levelNavigation = tree.get_nodes_in_group("levelNavigation")[0]
	if tree.has_group("cristal"):
		main_target = tree.get_nodes_in_group("cristal")[0]
	target = main_target
	
func _physics_process(_delta):
	_updated_animation()

### LOGIC ###


### LOGIC STATE ###

func IDLE_update_state(_delta):
	if target and levelNavigation:
		navigation._generate_path(target, levelNavigation)
	if !target_in_range : state_machine.set_state("MOVE")	
	elif target_in_range and timer.is_stopped(): state_machine.set_state("ATTACK")

func MOVE_update_state(_delta):
	if target and levelNavigation:
		navigation._generate_path(target, levelNavigation)
		navigation._navigate()
	
	if !target_in_range : var __ = move_and_slide(navigation.velocity * speed)
	else : state_machine.set_state("IDLE")
		
func ATTACK_exit_state():
	timer.start(2)

	
#### LOGICS ###

func _updated_animation():
	animationState.travel(state_machine.get_state_name())
	if navigation.velocity != Vector2.ZERO:

		animationTree.set("parameters/"+state_machine.get_state_name()+"/blend_position", navigation.velocity)


### SIGNALS RESPONSISES ###

func _attack_animation_finished():
	state_machine.set_state("IDLE")

func _on_chaseArea_body_entered(_body):
	if _body != null:
		target = _body
		
func _on_chaseArea_body_exited(_body):
	if _body == target :
		target = main_target

func _on_attackArea_body_entered(_body):
	target_in_range = true

func _on_attackArea_body_exited(_body):
	target_in_range = false
