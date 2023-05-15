extends Node2D
class_name OneWaveComponent

var mobsNextWave : Array
var spawners : Array

func _ready():
	spawners = get_children()

func _start_spawn_mobs():
	for spawner in spawners:
		spawner._spawn_mobs()
		
func _how_many_mobs_next_waves():
#### returns type, job and nbs to wave ####
	mobsNextWave.clear()
	
	for spawner in spawners:
		mobsNextWave.append(spawner.nbs_mobs)
	return mobsNextWave
	
