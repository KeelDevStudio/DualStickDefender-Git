extends Node2D
class_name AllWaveComponent

var difficultyChoise : String
var difficultySpawners : Array
var spawnerSelect : Object
var nbs_mobs_math : int = 0
onready var waveManagerArray = get_tree().get_nodes_in_group("WavesManager")
onready var waveManager = waveManagerArray[0]

func _ready():
	difficultySpawners = get_children()
	
	var __ = waveManager.connect("startWave", self, "_on_startWave")
	__ = waveManager.connect("howManyMobs", self, "_on_return_WAVEMANAGER_howManyMobs")
	__ = waveManager.connect("difficulty_choice", self, "_on_difficulty_choice")	

	
#####  wait a signal #####
# check the dificulte choice


#### when signal received ####
# start waves with dificulte choice


		

func _start_wave():
	for difficultySpawner in difficultySpawners:
		if difficultySpawner.name == difficultyChoise:
			difficultySpawner._start_spawn_mobs()
	

func _return_all_mobs_in_wave():
	for difficultySpawner in difficultySpawners:
		if difficultySpawner.name == difficultyChoise:
			return difficultySpawner._how_many_mobs_next_waves()
		


func _on_startWave(name,type):
	if name == self.name:
		difficultyChoise = type
		_start_wave()
	

func _on_return_WAVEMANAGER_howManyMobs(name) :
	if name == self.name:
		nbs_mobs_math = 0
		for i in _return_all_mobs_in_wave():
			waveManager.nbs_mobs_wave += i 
#			nbs_mobs_math = nbs_mobs_math + i
#		
	
func _on_difficulty_choice(value : String):
	difficultyChoise = value
