##############
### TURRET ###
##############


### EXPANSION ###

extends Node2D
class_name Turret


### GLOBAL VARIABLE ###

onready var projectile = $Turet/Muzzle.projectile
onready var state_machine = $STATEMACHINE
onready var chase_area = $ChaseArea
onready var muzzle = $Turet/Muzzle
onready var stats = $Stats


var build_mode = true
var current_enemie : Node2D
var enemies := []
var target : Node2D
export var chase_range := 30
var cooldown :float = 1.0
var projectile_speed:= 200.0
var fire_rate:= false
var rad = chase_range


### BUILT IN ###
func _initialize():
	$ChaseArea/CollisionShape2D.shape = CircleShape2D.new()
	$ChaseArea/CollisionShape2D.shape.set_radius(chase_range)
	$ChaseArea/Node2D.rad = chase_range
	
func _ready():
	_initialize()
	if build_mode == false:
		var __ = chase_area.connect("body_entered", self, "_on_body_area_entered")
		__ = chase_area.connect("body_exited", self, "_on_body_area_exited")
		state_machine.set_to_default_state()
		$ChaseArea/Node2D.visible = false
		self.position.y = self.position.y -2







	

func _physics_process(_delta):
	if enemies != []:
		current_enemie = enemies[0]
		$Turet.look_at(current_enemie.global_position)
	else : 
		current_enemie = null
		$Turet.rotation = 0
		

func _input(_event):
	if build_mode == false:
		if Input.is_action_pressed("Defense 2"): 
			$ChaseArea/Node2D.visible = true
		elif Input.is_action_just_released("Defense 2") : $ChaseArea/Node2D.visible = false

	


	

#
#	else : 
#		global_position = get_global_mouse_position()
#		if Input.is_action_just_pressed("Defense 2"): 
#			state_machine.set_to_default_state()
#			building = false
#			$ChaseArea/CollisionShape2D.disabled = false


### LOGIC ###

func _updated_animation():
	var state_name = state_machine.get_state_name()
	$Turet.play(state_name)

func _attack_effect():
	
	var projectile_instance = projectile.instance()
	projectile_instance.position = global_position
	projectile_instance.target = enemies[0]
	projectile_instance.set_collision_mask_bit(muzzle.collision_mask, true)
	get_tree().current_scene.add_child(projectile_instance)
	projectile_instance.damage = stats.damage
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
	$FireRate.start(3)
func READY_update_state(_delta):
	if current_enemie != null and $FireRate.is_stopped():
		state_machine.set_state("FIRE")
	
func FIRE_update_state(_delta):
	_attack_effect()
	state_machine.set_state("RELOAD") 


### SIGNALS RESPONSES ###

func _on_body_area_entered(_body):
		if _body.is_in_group("Enemy"):
			enemies.append(_body)
func _on_body_area_exited(_area):
		if _area.is_in_group("Enemy"):
			enemies.erase(_area)


