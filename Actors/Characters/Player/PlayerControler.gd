########################
### PLAYER CONTROLER ###
########################


### EXPENSION ###

extends Controler
class_name PlayerControler


### BUILT IN ###

func _input(_event):
	right = Input.get_action_strength("Right")
	left = Input.get_action_strength("Left")
	up = Input.get_action_strength("Up")
	down = Input.get_action_strength("Down")
	attack1 = Input.get_action_strength("Attack1")
