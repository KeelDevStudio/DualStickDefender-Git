extends Control
class_name HealthBarComponent

export(NodePath) var statsPath
onready var stats = get_node(statsPath)

var current_health_value : float

func _ready():
	$TextureProgress.set_max(stats.max_health)
	$TextureProgress.set_value(stats.current_health)

func _process(_delta):
	if $TextureProgress.value != stats.current_health:
		$TextureProgress.set_value(stats.current_health)
