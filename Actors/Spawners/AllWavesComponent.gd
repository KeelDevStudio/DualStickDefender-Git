extends Node2D
class_name AllWavesComponent

export(NodePath) var position2DPath
onready var position2D = get_node(position2DPath)

onready var wave_childs : Array = get_children()
onready var wave_childs_count = get_child_count() -1

var wave_spawned : bool = false setget set_wave_spawned
var ready_to_spawn : bool = false setget set_ready_to_spawn

var wave_index : int = 0


func _ready():
	_prepare_wave()


func set_ready_to_spawn(value):
	if ready_to_spawn != value:
		ready_to_spawn = value
		
	if ready_to_spawn == true :
		_spawn_wave()

func set_wave_spawned(value) : 
	if wave_spawned != value:
		wave_spawned = value
		
	if wave_spawned == true and wave_index < wave_childs_count:
		wave_index = wave_index +1
		_prepare_wave()
	else :
		pass

func _prepare_wave():
	wave_spawned = false
	ready_to_spawn = false
	wave_childs[wave_index]._start_add_pool_spawn()

func _spawn_wave():
	wave_childs[wave_index]._start_wave_spawn()
