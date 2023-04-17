extends Node
class_name AnimationPlayerStates

export(NodePath) var stateMachinePath
onready var state_machine = get_node(stateMachinePath)

export(NodePath) var navigationPath
onready var navigation = get_node(navigationPath)

export(NodePath) var animationTreePath
onready var animationTree = get_node(animationTreePath)
onready var animationState = animationTree.get("parameters/playback")


func _process(_delta):
	animationState.travel(state_machine.get_state_name())
	if navigation.velocity != Vector2.ZERO:
		animationTree.set("parameters/"+state_machine.get_state_name()+"/blend_position", navigation.velocity)



