########################
### PLAYER CONTROLER ###
########################


### EXPENSION ###

extends Controler
class_name PlayerControler


export(NodePath) var AbilitysComponentPath
onready var Abilitys = get_node(AbilitysComponentPath)

### BUILT IN ###

func _input(_event):
	right = Input.get_action_strength("Right")
	left = Input.get_action_strength("Left")
	up = Input.get_action_strength("Up")
	down = Input.get_action_strength("Down")
	attack1 = Input.get_action_strength("Attack1")
	defense1 = Input.get_action_strength("Defense 1")
	defense2 = Input.get_action_strength("Defense 2")
