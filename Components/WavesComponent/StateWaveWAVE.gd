#############
### STATEWAVE ###
#############


### EXPENSION ###

extends State
class_name StateWaveWave


### GLOBAL VARIABLE ###

onready var wavesManager = get_parent()



### VIRTUAL GENERIC ###

func enter_state() -> void:
	wavesManager._emit_signal_start_wave(self.name)


func update_state(_delta : float) -> void:
	pass


func exit_state() -> void:
	pass


func is_current_state():
	return wavesManager.get_state() == self
	
