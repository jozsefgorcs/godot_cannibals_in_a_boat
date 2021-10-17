extends Area2D



func _ready():
	pass # Replace with function body.


func is_place_taken():
	var a = get_overlapping_bodies()
	return (a.size()>0)
