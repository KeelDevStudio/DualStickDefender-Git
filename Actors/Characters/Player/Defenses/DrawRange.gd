extends Node2D

var cen = Vector2(0,0)
var rad = 0.0
var col = "64b5afaf"

func _ready()-> void:
	update()



func _draw():
	draw_circle(cen,rad,col)

