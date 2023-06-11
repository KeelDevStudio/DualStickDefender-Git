#############
### LEVEL ###
#############


### EXPENSION ####

extends YSort
class_name Level


export(NodePath) var tilemapLimitPath
onready var tileMapLimit = get_node(tilemapLimitPath)
onready var rectangle: Rect2 = tileMapLimit.get_used_rect()

### BUILT IN ###

func _set_cam_limit(cam):
	if cam != null :
		cam.limit_left = rectangle.position.x * $TileMap.cell_size.x
		cam.limit_top = rectangle.position.y * $TileMap.cell_size.y
		cam.limit_right = (rectangle.position.x + rectangle.size.x) * $TileMap.cell_size.x
		cam.limit_bottom = (rectangle.position.y + rectangle.size.y) * $TileMap.cell_size.y
