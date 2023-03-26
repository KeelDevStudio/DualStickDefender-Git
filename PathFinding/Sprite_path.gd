extends PathFollow2D

onready var path_follow = get_parent()

export var speed = 150
var move_direction =0


func _physics_process(delta):
	Movement_loop(delta)

func Movement_loop(_delta):
	set_offset(get_offset() + speed *_delta)
#	var prepos = path_follow.get_global_position()
#	path_follow.set_offset(path_follow.get_offset() + speed * _delta)
#	var pos = path_follow.get_global_position()
#	move_direction = (pos.angle_to_point(prepos) /3.14)

