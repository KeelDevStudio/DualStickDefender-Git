#############################
### EASY ENEMIE CONTROLER ###
#############################


### EXPENSION ###

extends KinematicBody2D
class_name EasyEnemieControler


### GLOBAL VARIABLE ###


onready var timer = $Timer

export(NodePath) var navigationComponentPath
onready var navigation = get_node(navigationComponentPath)



onready var state_machine = $STATEMACHINE
onready var stats = $Stats



var levelNavigation: Navigation2D = null
var main_target = null
var target = null
var target_in_range = false


### BUILT_IN ###

func _initialize():
	var __ = stats.connect("current_health_0", self, "_on_current_health_0")


	
func _ready():
	_initialize()
	state_machine.set_to_default_state()
	var tree = get_tree()
	if tree.has_group("cristal"):
		main_target = tree.get_nodes_in_group("cristal")[0]

	
func _physics_process(_delta):
	if target == null:
		target = main_target

### LOGIC ###


### LOGIC STATE ###

func IDLE_update_state(_delta):
	if !target_in_range : state_machine.set_state("MOVE")	
	elif target_in_range and timer.is_stopped(): state_machine.set_state("ATTACK")

func MOVE_update_state(_delta):
	if !target_in_range : var __ = move_and_slide(navigation.velocity * stats.speed)
	else : state_machine.set_state("IDLE")
		
func ATTACK_exit_state():
	timer.start(2)




### SIGNALS RESPONSISES ###

func _attack_animation_finished():
	state_machine.set_state("IDLE")

func DIE_animation_finished():
	queue_free()
	


func _on_current_health_0():
	$HurtBox/CollisionShape2D.queue_free()
	state_machine.set_state("DIE")
	

