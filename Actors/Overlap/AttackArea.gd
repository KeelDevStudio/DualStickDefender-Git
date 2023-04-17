extends Area2D
class_name AttackArea

export(NodePath) var ownerNodePath
onready var ownerNode = get_node(ownerNodePath)

func _ready() -> void:
	var __ = connect("body_entered", self, "_on_body_entered")
	__ = connect("body_exited", self, "_on_body_exited")
	pass
	
func _on_body_entered(_body):
	ownerNode.target_in_range = true
	
func _on_body_exited(_body):
	ownerNode.target_in_range = false
