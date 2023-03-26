#############
### STATE ###
#############


### EXPENSION ###

extends Node
class_name State


### GLOBAL VARIABLE ###

onready var state_machine = get_parent()


### VIRTUAL GENERIC ###

func enter_state() -> void:
	if owner.has_method(self.name+"_enter_state"):
		owner.call(self.name+"_enter_state")

func update_state(delta : float) -> void:
	if owner.has_method(self.name+"_update_state"):
		owner.call(self.name+"_update_state", delta)
	
func exit_state() -> void:
	if owner.has_method(self.name+"_exit_state"):
		owner.call(self.name+"_exit_state")
	pass

func is_current_state():
	return state_machine.get_state() == self
	
