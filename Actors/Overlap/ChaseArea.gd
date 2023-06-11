extends Area2D
class_name ChaseArea

export(NodePath) var ownerNodePath
onready var ownerNode = get_node(ownerNodePath)

func _ready() -> void:
	var __ = connect("body_entered", self, "_on_body_entered")
	__ = connect("body_exited", self, "_on_body_exited")
	pass
	
func _on_body_entered(_body):
	if ownerNode != null:
		ownerNode.target = _body
	
func _on_body_exited(_body):
	if ownerNode != null :
		ownerNode.target = null

