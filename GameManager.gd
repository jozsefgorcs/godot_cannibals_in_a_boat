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

onready var boat_seat1 = $Boat/Seat1
onready var boat_seat2 = $Boat/Seat2

onready var starterSpawnPoints = [spawnpoint1,spawnpoint2,spawnpoint3,spawnpoint4,spawnpoint5,spawnpoint6]
onready var finisherSpawnPoints = [finishpoint1,finishpoint2,finishpoint3,finishpoint4,finishpoint5,finishpoint6]
onready var boat_seats = [boat_seat1, boat_seat2]

onready var boat = $Boat

onready var priest1 = $Characters/Priest
onready var priest2 = $Characters/Priest2
onready var priest3  = $Characters/Priest3
onready var cannibal1 = $Characters/Cannibal
onready var cannibal2 = $Characters/Cannibal2
onready var cannibal3 = $Characters/Cannibal3

var is_boat_left_side=true

func _ready():
	init_game()
	
	
func init_game():
	place_character(priest1, spawnpoint1)
	place_character(priest2, spawnpoint2)
	place_character(priest3, spawnpoint3)
	place_character(cannibal1, spawnpoint4)
	place_character(cannibal2, spawnpoint5)
	place_character(cannibal3, spawnpoint6)
	
	if(!is_boat_left_side):
		$AnimationPlayer.play("boat_back")
		
	$Timer.start()
	
func _process(delta):
	if(Input.is_action_just_pressed("boat_go") && !boat. all_seat_are_empty() && !$AnimationPlayer.is_playing()):
		if(is_boat_left_side):
			$AnimationPlayer.play("boat_go")
			is_boat_left_side=false
			$Boat/Sprite.flip_h=false
		else:
			$AnimationPlayer.play("boat_back")
			is_boat_left_side=true
			$Boat/Sprite.flip_h=true


func place_character(what, where):
	what.position = where.position
	what.boat = boat
	what.current_seat = null
	what.current_place = where
	what.is_in_boat=false

func get_a_free_spawn_point():
	if (is_boat_left_side):
		return get_a_free_spawn_point_from_array(starterSpawnPoints)
	else:
		return get_a_free_spawn_point_from_array(finisherSpawnPoints)

func collect_characters_in_arrays(array1, array2):
	var characters = []
	var concat_array = array1+array2
	for sp in concat_array:
		if(sp.is_place_taken()):
			characters.push_back(sp.get_taken_character().get_collision_layer())
	return characters
			
		
func is_game_finished():
	return get_a_free_spawn_point_from_array(finisherSpawnPoints) == null
	
func get_a_free_spawn_point_from_array(arr):
	for sp in arr:
		if(!sp.is_place_taken()):
			return sp
	return null
	
func is_character_standing_on_left_side(who):
	if(who.current_place==null):
		return false
	return starterSpawnPoints.has(who.current_place)

func _on_Character_wants_get_out(who):
	if($AnimationPlayer.is_playing()):
		 return
	boat.get_out(who,get_a_free_spawn_point())


func _on_Character_wants_to_sit(who):
	if($AnimationPlayer.is_playing()):
		return
	if(is_boat_left_side && is_character_standing_on_left_side(who)):
		boat.sit(who)
	elif(!is_boat_left_side && !is_character_standing_on_left_side(who)):
		boat.sit(who)


func _on_AnimationPlayer_animation_finished(anim_name):
	$Timer.start()
	pass


func _on_AnimationPlayer_animation_started(anim_name):
	$Timer.stop()
	pass # Replace with function body.


func _on_Boat_boat_operation_finished():
	print ("boat operation finished")
	pass # Replace with function body.

func is_game_over():
	var left_side=[]
	var right_side=[]
	if(is_boat_left_side):
		left_side = collect_characters_in_arrays(starterSpawnPoints, boat_seats)
		right_side = collect_characters_in_arrays(finisherSpawnPoints, [])
	else:
		right_side = collect_characters_in_arrays(finisherSpawnPoints, boat_seats)
		left_side = collect_characters_in_arrays(starterSpawnPoints, [])
			
	return array_has_more_cannibal(left_side) || array_has_more_cannibal(right_side)
	
	
func array_has_more_cannibal(array):
	var priest_count = 0
	var cannibal_count = 0
	for collision_layer_id in array:
		if(collision_layer_id==1):
			priest_count +=1
		else:
			cannibal_count +=1
	
	return priest_count>0 && cannibal_count>priest_count
		


func _on_Timer_timeout():
	if(is_game_finished()):
		get_tree().change_scene("res://GameFinished.tscn")
		$Timer.stop()
	if(is_game_over()):
		get_tree().change_scene("res://GameOver.tscn")
		$Timer.stop()
	else:
		print("game not yet finished")


func _on_game_over():
	
	$Timer.stop()
	get_tree().change_scene("res://GameOver.tscn")


func _on_Go_pressed():
	if(!boat. all_seat_are_empty() && !$AnimationPlayer.is_playing()):
		if(is_boat_left_side):
			$AnimationPlayer.play("boat_go")
			is_boat_left_side=false
			$Boat/Sprite.flip_h=false
		else:
			$AnimationPlayer.play("boat_back")
			is_boat_left_side=true
			$Boat/Sprite.flip_h=true
