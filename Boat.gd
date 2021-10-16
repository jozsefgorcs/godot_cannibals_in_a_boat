extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func get_seat1_pos():
	return $Seat1.global_position

func get_seat2_pos():
	return $Seat1.global_position

func has_empty_seat():
	return false
	
func get_empty_seat_pos():
	print(get_seat1_pos())
	return get_seat1_pos()
