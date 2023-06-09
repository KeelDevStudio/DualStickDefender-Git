extends CanvasLayer
class_name HUDBtn

var tower_range = 64

func _ready():
	$BuildBar/Arrow2.disabled = true
	$BuildBar/Arrow3.disabled = true
	$BuildBar/Arrow4.disabled = true

func set_tower_preview(tower_type, mouse_position):
	var drag_tower = load("res://Actors/Characters/Player/Defenses/" + tower_type + ".tscn").instance()
	drag_tower.set_name("DragTower")
	drag_tower.modulate = Color("ad54ff3c")
	
	
	var control = Control.new()
	control.add_child(drag_tower, true)
#	control.add_child(range_texture, true)
	control.rect_position = mouse_position
	control.set_name("TowerPreview")
	add_child(control, true)
	move_child(get_node("TowerPreview"), 0)
	
func update_tower_preview(new_position, color):
	get_node("TowerPreview").rect_position = new_position
	if get_node("TowerPreview/DragTower").modulate != Color(color):
		get_node("TowerPreview/DragTower").modulate = Color(color)

