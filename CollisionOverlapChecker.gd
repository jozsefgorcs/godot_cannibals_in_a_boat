extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var a = get_overlapping_bodies()
	print(a.size())
	pass # Replace with function body.


func _physics_process(delta):
	var a = get_overlapping_bodies()
	if(a.size()>0):
		pass

