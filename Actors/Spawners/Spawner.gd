extends Node2D
class_name SpawnerComponent

#export(NodePath) var position2DPath
#onready var position2D = get_node(position2DPath)



export var pack_mob : PackedScene
export var nbs_mobs : int

onready var parent = get_parent()

var min_wait : float = 1
var max_wait : float = 2 

func _ready():
	pass
#	_add_mobs_in_parent_array()

func _add_mobs_in_parent_array():
	for i in nbs_mobs:
		var pack_mob_instance = pack_mob.instance()
		parent.pool_spawn.append(pack_mob_instance)

#func _add_mob_array():
#	for mob in pack_mobs:
#		for nb_mob in nbs_mobs[iteration]:
#			var mob_instance = mob.instance()
#			mob_instance.position = position2D.global_position
#			mobs.append(mob_instance)
#		iteration = iteration +1
#	mobs_value = mobs.size()



#func _input(event):
#	var just_pressed = event.is_pressed() and not event.is_echo()
#	if Input.is_key_pressed(KEY_A) and just_pressed:
#		_spawn_mobs()

#func _spawn_mobs():
#	for i in mobs :
#		$Timer.start(rand_range(min_wait, max_wait)) ; yield($Timer, "timeout")
#		get_tree().get_root().add_child(i)
#		mobs_value = mobs_value -1
