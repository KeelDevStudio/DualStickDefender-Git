#############
### STATEWAVE ###
#############


### EXPENSION ###

extends State
class_name StateWaveWait


### GLOBAL VARIABLE ###

onready var WavesManager = get_parent()


### VIRTUAL GENERIC ###

func enter_state() -> void:
	pass


func update_state(_delta : float) -> void:
	if Input.is_action_just_pressed("Test1"):
		WavesManager._next_wave_state()
		pass
	
func exit_state() -> void:
	pass


func is_current_state():
	return WavesManager.get_state() == self
	
