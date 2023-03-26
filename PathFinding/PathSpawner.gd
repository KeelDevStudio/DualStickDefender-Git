extends Path2D

var timer = 0
export var spawnTime = 10

export var follower : Resource
export (Array, Resource) var follower_Array

func _process(delta):
	timer = timer + delta
	
	if (timer > spawnTime):
		randomize()
		follower_Array.shuffle()
		var follower_instance = follower_Array[0].instance()
		add_child(follower_instance)
		timer = 0
