extends CanvasLayer
class_name HUDWave

var max_nbs_mobs : int
var kill_nbs_mobs : int
var current_wave : Object

onready var label = $Label
onready var progress = $ProgressBar
onready var progressLabel = $ProgressBar/LabeProgress


func _process(_delta):
	if current_wave != null:
		if current_wave is StateWaveWait:
			label.set_text("WAIT")
			
		
		if current_wave is StateWaveWave:
			label.set_text(current_wave.name)
			progress.visible = true
			progress.max_value = max_nbs_mobs
			progress.value = kill_nbs_mobs
			progressLabel.set_text(str(kill_nbs_mobs) + " / " + str(max_nbs_mobs)) 
			
		else :
			progress.visible = false

