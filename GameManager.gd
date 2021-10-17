extends Node2D

var PriestNode = preload("Priest.tscn")
var CannibalNode = preload("Cannibal.tscn")

onready var spawnpoint1 = $SpawnPlaces/Spawnplace
onready var spawnpoint2 = $SpawnPlaces/Spawnplace2
onready var spawnpoint3 = $SpawnPlaces/Spawnplace3
onready var spawnpoint4 = $SpawnPlaces/Spawnplace4
onready var spawnpoint5 = $SpawnPlaces/Spawnplace5
onready var spawnpoint6 = $SpawnPlaces/Spawnplace6

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
	if(Input.is_action_just_pressed("boat_go")):
		if(is_boat_left_side):
			$AnimationPlayer.play("boat_go")
			is_boat_left_side=false
		else:
			$AnimationPlayer.play("boat_back")
			is_boat_left_side=true

func place_character(what, where):
	what.position = where.position
	what.boat = boat
