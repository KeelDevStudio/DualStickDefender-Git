#########################
### ENEMIE NAVIGATION ###
#########################


### EXPENSION ###

extends Node2D


### GLOBAL VARIABLE ###

export(NodePath) var ownerTargetPath
onready var ownerTarget = get_node(ownerTargetPath)

onready var line2D = $Line2D

var levelNavigation: Navigation2D = null
var velocity: Vector2 = Vector2.ZERO
var path : Array = []


### BUILT IN ###

func _ready():
	var tree = get_tree()
	if tree.has_group("levelNavigation"):
		levelNavigation = tree.get_nodes_in_group("levelNavigation")[0]

func _process(_delta):
	line2D.global_position = Vector2.ZERO
	_generate_path()
	_navigate()

### LOGIC ###

func _navigate():
	if path.size() > 0 :
		velocity = global_position.direction_to(path[1])

	
	if global_position == path[0]:
		path.pop_front()
	
	else : return Vector2.ZERO

func _generate_path():
	if levelNavigation != null and ownerTarget.target != null:
		path = levelNavigation.get_simple_path(global_position, ownerTarget.target.global_position, false)
		line2D.points = path
