extends Node2D

var PriestNode = preload("Priest.tscn")
var CannibalNode = preload("Cannibal.tscn")

onready var spawnpoint1 = $SpawnPlaces/Spawnplace
onready var spawnpoint2 = $SpawnPlaces/Spawnplace2
onready var spawnpoint3 = $SpawnPlaces/Spawnplace3
onready var spawnpoint4 = $SpawnPlaces/Spawnplace4
onready var spawnpoint5 = $SpawnPlaces/Spawnplace5
onready var spawnpoint6 = $SpawnPlaces/Spawnplace6

onready var finishpoint1 = $SpawnPlaces/Spawnplace7
onready var finishpoint2 = $SpawnPlaces/Spawnplace8
onready var finishpoint3 = $SpawnPlaces/Spawnplace9
onready var finishpoint4 = $SpawnPlaces/Spawnplace10
onready var finishpoint5 = $SpawnPlaces/Spawnplace11
onready var finishpoint6 = $SpawnPlaces/Spawnplace12

onready var starterSpawnPoints = [spawnpoint1,spawnpoint2,spawnpoint3,spawnpoint4,spawnpoint5,spawnpoint6]
onready var finisherSpawnPoints = [finishpoint1,finishpoint2,finishpoint3,finishpoint4,finishpoint5,finishpoint6]

onready var boat = $Boat

onready var priest1 = $Characters/Priest
onready var priest2 = $Characters/Priest2
onready var priest3  = $Characters/Priest3
onready var cannibal1 = $Characters/Cannibal
onready var cannibal2 = $Characters/Cannibal2
onready var cannibal3 = $Characters/Cannibal3

var is_boat_left_side=true

func _ready():
	place_character(priest1, spawnpoint1)
	place_character(priest2, spawnpoint2)
	place_character(priest3, spawnpoint3)
	place_character(cannibal1, spawnpoint4)
	place_character(cannibal2, spawnpoint5)
	place_character(cannibal3, spawnpoint6)
	
	
func _process(delta):
	if(Input.is_action_just_pressed("boat_go") && !boat. all_seat_are_empty() && !$AnimationPlayer.is_playing()):
		if(is_boat_left_side):
			$AnimationPlayer.play("boat_go")
			is_boat_left_side=false
		else:
			$AnimationPlayer.play("boat_back")
			is_boat_left_side=true


func place_character(what, where):
	what.position = where.position
	what.boat = boat

func get_a_free_spawn_point():
	if (is_boat_left_side):
		return get_a_free_spawn_point_from_array(starterSpawnPoints)
	else:
		return get_a_free_spawn_point_from_array(finisherSpawnPoints)
		
func is_game_finished():
	return get_a_free_spawn_point_from_array(finisherSpawnPoints) == null
	
func get_a_free_spawn_point_from_array(arr):
	for sp in arr:
		if(!sp.is_place_taken()):
			return sp
	return null
	

func _on_Character_wants_get_out(who):
	if($AnimationPlayer.is_playing()):
		 return
	boat.get_out(who,get_a_free_spawn_point())



func _on_Character_wants_to_sit(who):
	if($AnimationPlayer.is_playing()):
		return
	boat.sit(who)


func _on_AnimationPlayer_animation_finished(anim_name):
	$CollisionOverlapChecker.start_checking()	
	pass


func _on_AnimationPlayer_animation_started(anim_name):
	$CollisionOverlapChecker.stop_checking()	
	pass # Replace with function body.


func _on_Boat_boat_operation_finished():
	print ("boat operation finished")
	pass # Replace with function body.




func _on_Timer_timeout():
	if(is_game_finished()):
		print("game finished")
		$Timer.stop()
	else:
		print("game not yet finished")
