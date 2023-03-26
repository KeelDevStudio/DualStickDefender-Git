#####################
### STATE MACHINE ###
#####################


### EXPENSION ###

extends Node
class_name StateMachine


### GLOBAL VARIABLE ###


var current_state : Node = null setget set_state, get_state
var previous_state : Node = null 


### ACCESSORS ###

func set_state(state) -> void :
	if state is String:
		state = get_node_or_null(state)
	
	elif state == current_state:
		return
	
	if current_state != null:
		current_state.exit_state()
	
	previous_state = current_state
	current_state = state
	
	if current_state != null:
		current_state.enter_state() 
func get_state () -> Node: return current_state
func get_state_name() -> String : 
	if current_state == null:
		return ""
	return current_state.name


### BUILT-IN ###

func _physics_process(delta : float) -> void:
	if current_state != null:

		current_state.update_state(delta)


### VIRTUAL ###

func enter_state():
	pass

func exit_state():
	set_state(null)
	
func set_to_default_state():
	set_state(get_child(0))

