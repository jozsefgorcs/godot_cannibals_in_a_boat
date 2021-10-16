extends Area2D


var seat_1_taken = false
var seat_2_taken = false

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

func sit(who):
	print("call sit")
	if(seat_1_taken && seat_2_taken):
		print ("error")
	if(!seat_1_taken):
		seat_1_taken = true
		who.position = get_seat1_pos()
	if(!seat_2_taken):
		seat_2_taken = true
		who.position = get_seat2_pos()
