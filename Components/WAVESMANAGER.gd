extends StateMachine
class_name WavesManager

var waveManager_machine = self
var waveStateID = 0

var nbs_mobs_wave : int = 0

enum DIFFICULT_WAVE{
	EASY,
	NORMAL,
	HARD,
	}
	
export (DIFFICULT_WAVE) var difficult_wave
var difficult_wave_name : String

var wave_name = "WAVE 1"

signal startWave
signal howManyMobs
signal difficulty_choice

func _ready():
	waveManager_machine.set_state(get_child(waveStateID))
	
	match(difficult_wave):
		DIFFICULT_WAVE.EASY : difficult_wave_name = "EASY"
		DIFFICULT_WAVE.NORMAL : difficult_wave_name = "NORMAL"
		DIFFICULT_WAVE.HARD : difficult_wave_name = "HARD"
	
	emit_signal("difficulty_choice", difficult_wave_name)


func _next_wave_state():
	waveStateID = waveStateID +1
	waveManager_machine.set_state(get_child(waveStateID))
#	pass

func _emit_signal_start_wave(value : String):
	emit_signal("startWave", value, difficult_wave_name)
	pass

func _emit_signal_how_many_mobs():
	emit_signal("howManyMobs", wave_name)
