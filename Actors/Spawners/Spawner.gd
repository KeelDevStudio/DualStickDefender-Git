tool
extends Node2D
class_name SpawnerComponent

enum MOB_JOB{
	MELEE,
	RANGE,
	MAGIC,
	}
	
enum MOB_TYPE{
	EASY,
	NORMAL,
	HARD,
	EXPERT,
	NIGHTMARE,
	}

export (MOB_JOB) var mob_job
export (MOB_TYPE) var mob_type
export var nbs_mobs : int = 0
export var wait_to_start : int = 0
export var rate_to_spawn : float = 0.0

var preloadMob :PackedScene

func _ready():
	match(mob_job):
		MOB_JOB.MELEE : preloadMob = preload("res://Actors/Characters/Enemies/Mobs/Enemie2.tscn")
	
#	match(type):
#		"easy" : preloadMob.type = "easy"
#		"normal" : preloadMob.type = "normal"
#		"hard" : preloadMob.type = "hard"
#		"nightmare" : preloadMob.type = "nightmare"
	pass

#func _input(event):
#	var just_pressed = event.is_pressed() and not event.is_echo()
#	if Input.is_key_pressed(KEY_A) and just_pressed:
#		_spawn_mobs()

func _spawn_mobs():
	
	$Timer.start(wait_to_start) ; yield($Timer,"timeout")
	
	for i in nbs_mobs :
		var mob = preloadMob.instance()
		mob.position = self.global_position
		$Timer.start(rate_to_spawn) ; yield($Timer, "timeout")
		get_tree().current_scene.add_child(mob)

