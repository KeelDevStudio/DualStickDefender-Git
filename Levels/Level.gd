#############
### LEVEL ###
#############


### EXPENSION ####

extends YSort


### BUILT IN ###

func _ready() -> void :
	var rectangle: Rect2 = $TileMap.get_used_rect()
	var cam = $Player/Camera2D
	
	cam.limit_left = rectangle.position.x * $TileMap.cell_size.x
	cam.limit_top = rectangle.position.y * $TileMap.cell_size.y
	cam.limit_right = (rectangle.position.x + rectangle.size.x) * $TileMap.cell_size.x
	cam.limit_bottom = (rectangle.position.y + rectangle.size.y) * $TileMap.cell_size.y
