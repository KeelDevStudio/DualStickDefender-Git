extends Control
class_name TowerBuildComponent

export(NodePath) var map_node_path
onready var map_node = get_node(map_node_path)

export(NodePath) var HUD_btn_path
onready var HUD_btn = get_node(HUD_btn_path)

export(NodePath) var TowerExclusionTilemapPath
onready var Tower_Exclusion_Tilemap = get_node(TowerExclusionTilemapPath)

var build_mode = false
var build_valid = false
var build_tile
var build_location
var build_type



func _ready():
	for i in get_tree().get_nodes_in_group("build_buttons"):
		i.connect("pressed", self, "initiate_build_mode", [i.get_name()])
	



func _process(_delta):
	if build_mode == true :
		update_tower_preview()
	pass



func _unhandled_input(event):
	if event.is_action_released("ui_cancel") and build_mode == true:
		cancel_build_mode()
	if event.is_action_released("ui_accept") and build_mode == true:
		verify_and_build()
#		cancel_build_mode()



func initiate_build_mode(tower_type):
	if build_mode:
		cancel_build_mode()
	build_type = tower_type + "T1"
	build_mode = true
	HUD_btn.set_tower_preview(build_type, get_global_mouse_position())
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	
	
	
	
func update_tower_preview():
	var mouse_postion = get_global_mouse_position()
	var current_tile = Tower_Exclusion_Tilemap.world_to_map(mouse_postion)
	var tile_position = Tower_Exclusion_Tilemap.map_to_world(current_tile)
	
	if Tower_Exclusion_Tilemap.get_cellv(current_tile) == -1:
		HUD_btn.update_tower_preview(tile_position, "ad54ff3c")
		build_valid = true
		build_location = tile_position
		build_tile = current_tile
	else:
		HUD_btn.update_tower_preview(tile_position, "adff4545")
		build_valid = false
	
	
	
	
func cancel_build_mode():
	build_mode = false
	build_valid = false
	HUD_btn.get_node("TowerPreview").free()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
	
	
func verify_and_build():
	if build_valid:
		## verify cash + units defenses
		var new_tower = load("res://Actors/Characters/Player/Defenses/" + build_type + ".tscn").instance()
		new_tower.position = build_location
		new_tower.first_build_mode = false
		get_tree().current_scene.add_child(new_tower, true)
		Tower_Exclusion_Tilemap.set_cellv(build_tile, 5)
		cancel_build_mode()
	


