extends Area2D

var checking_is_active= true

signal game_over()

func _on_Timer_timeout():
	if(!checking_is_active):
		return
	var array_of_bodies = get_overlapping_bodies()
	var priestCount = 0
	var cannibalCount = 0
	for body in array_of_bodies:
		if(body.get_collision_layer()==1):
			priestCount +=1
		elif(body.get_collision_layer()==2):
			cannibalCount+=1
	if(cannibalCount>priestCount && priestCount>0 ):
		print("attack!!!")
		emit_signal("game_over")

func start_checking():
	checking_is_active = true

func stop_checking():
	checking_is_active = false
