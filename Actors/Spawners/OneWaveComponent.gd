extends Node2D
class_name OneWaveComponent

export var wait_time : Vector2
onready var parent = get_parent()
var spawner_childs : Array 
var pool_spawn : Array



func _start_wave_spawn():
	for mob in pool_spawn:
		$Timer.start(rand_range(wait_time.x, wait_time.y)); yield($Timer, "timeout")
		mob.position = parent.position2D.global_position
		get_tree().get_root().add_child(mob)
	parent.wave_spawned = true
	

func _start_add_pool_spawn():
	for i in get_children():
		if i is SpawnerComponent:
			spawner_childs.append(i)
	
	for i in spawner_childs:
		i._add_mobs_in_parent_array()
	parent.ready_to_spawn = true
