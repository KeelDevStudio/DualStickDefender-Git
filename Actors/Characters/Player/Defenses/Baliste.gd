##############
### TURRET ###
##############


### EXPANSION ###

extends Node2D
class_name Turret


### GLOBAL VARIABLE ###

onready var projectile = preload("res://Actors/Characters/Player/Weapons/Arrow.tscn")
onready var state_machine = $STATEMACHINE
onready var chase_area = $ChaseArea
var target : Node2D
var cooldown :float = 5.0
var projectile_speed:= 200.0
var fire_rate:= false


### BUILT IN ###
func _initialize():
	var __ = chase_area.connect("body_entered", self, "_on_Area2D_body_entered")
	__ = chase_area.connect("area_shape_exited", self, "_on_Area2D_body_exited")
func _ready():
	state_machine.set_to_default_state()
	_initialize()
func _physics_process(_delta):
	if target != null : $Turet.look_at(target.global_position)


### LOGIC ###

func _updated_animation():
	var state_name = state_machine.get_state_name()
	$Turet.play(state_name)

func _attack_effect():
	
	var projectile_instance = projectile.instance()
	projectile_instance.position = global_position
	projectile_instance.target = target
	get_tree().get_root().add_child(projectile_instance)
	fire_rate = false


### LOGIC STATE ###

func RELOAD_enter_state():
	call_deferred("_updated_animation")
	$Cooldown.start(cooldown)
func RELOAD_update_state(_delta):
	yield($Cooldown,"timeout")
	state_machine.set_state("READY")

func READY_enter_state():
	_updated_animation()
	$FireRate.start(2)
func READY_update_state(_delta):
	yield($FireRate,"timeout")
	if target != null:
		state_machine.set_state("FIRE")
	
func FIRE_update_state(_delta):
	_attack_effect()
	state_machine.set_state("RELOAD") 


### SIGNALS RESPONSES ###

func _on_Area2D_body_entered(_body):
	target = _body
func _on_Area2D_body_exited(_body): 
	$Turet.rotation = 0
	target = null

