#########################
### ENEMIE NAVIGATION ###
#########################


### EXPENSION ###

extends Navigation2D


### GLOBAL VARIABLE ###

onready var line2D = $Line2D

var velocity: Vector2 = Vector2.ZERO
var path : Array = []


### BUILT IN ###

func _process(_delta):
	line2D.global_position = Vector2.ZERO


### LOGIC ###

func _navigate():
	if path.size() > 0 :
		velocity = global_position.direction_to(path[1])
	
	if global_position == path[0]:
		path.pop_front()
	
	else : return Vector2.ZERO

func _generate_path(target, levelNavigation):
	if levelNavigation != null and target != null:
		path = levelNavigation.get_simple_path(global_position, target.global_position, false)
		line2D.points = path
