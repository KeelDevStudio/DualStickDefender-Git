extends Label

export(NodePath) var spawnerComponentPath
onready var spawnerComponent = get_node(spawnerComponentPath)

#func _process(_delta):
#	set_text(str(spawnerComponent.mobs_value))
