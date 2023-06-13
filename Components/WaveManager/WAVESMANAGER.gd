extends StateMachine
class_name WavesManager

var waveManager_machine = self
var waveStateID = 0

var nbs_mobs_wave : int = 0
var nbs_mobs_wave_kill : int = 0 

enum DIFFICULT_WAVE{
	EASY,
	NORMAL,
	HARD,
	}
	
export (DIFFICULT_WAVE) var difficult_wave
var difficult_wave_name : String
var wave_name = "WAVE 1"
var wave : Object

export(NodePath) var HUDPath
onready var HUD = get_node(HUDPath)

export(NodePath) var playerPath
onready var player = get_node(playerPath)

export(NodePath) var buildingCamPath
onready var buildingCam = get_node(buildingCamPath)

export(NodePath) var HUDBtn_BuildBar_Path
onready var HUDBtn_BuildBar = get_node(HUDBtn_BuildBar_Path)

signal startWave
signal howManyMobs
signal difficulty_choice

func _ready():

	_update_WAVE()
	_updated_HUD()
	
	match(difficult_wave):
		DIFFICULT_WAVE.EASY : difficult_wave_name = "EASY"
		DIFFICULT_WAVE.NORMAL : difficult_wave_name = "NORMAL"
		DIFFICULT_WAVE.HARD : difficult_wave_name = "HARD"
	
	emit_signal("difficulty_choice", difficult_wave_name)


func _next_wave_state():
	waveStateID = waveStateID +1
	_update_WAVE()
	_emit_signal_how_many_mobs()
#	pass



func _emit_signal_start_wave(_wave_name : String):
	emit_signal("startWave", _wave_name, difficult_wave_name)

	
	pass

func _emit_signal_how_many_mobs():
	nbs_mobs_wave = 0
	emit_signal("howManyMobs", wave_name)
	_updated_HUD()


func _add_mob_kill():
	nbs_mobs_wave_kill +=1
	_updated_HUD()
	if nbs_mobs_wave_kill == nbs_mobs_wave:
		_next_wave_state()

func _updated_HUD():
	HUD.max_nbs_mobs = nbs_mobs_wave
	HUD.kill_nbs_mobs = nbs_mobs_wave_kill
	HUD.current_wave = wave

func _update_WAVE():
	waveManager_machine.set_state(get_child(waveStateID))
	wave_name = waveManager_machine.get_state_name()
	wave = waveManager_machine.get_state()
	nbs_mobs_wave_kill = 0
	_switch_player_or_build_mode()
	get_tree().call_group("Defense", "_switch_build_mode", wave )

func _switch_player_or_build_mode():
	if wave is StateWaveWait:
		buildingCam.current = true
		player.state_machine.set_state("BUILD")
		for i in HUDBtn_BuildBar.get_children():
			i.disabled = false
			i.visible = true
	
	if wave is StateWaveWave:

		player.get_node("Camera2D").current = true
		player.state_machine.set_state("IDLE")
		for i in HUDBtn_BuildBar.get_children():
			i.disabled = true
			i.visible = false
