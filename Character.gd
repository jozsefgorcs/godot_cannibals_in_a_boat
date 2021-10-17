extends KinematicBody2D


var boat = null
var is_in_boat = false
var moving_to_boat = false
var current_seat = null



func _ready():
	pass

func _physics_process(delta):
	if(current_seat!=null):
		position = current_seat.global_position

func _on_Character_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.is_pressed():
		self.on_click()

func on_click():
	print("Click on character" )
	boat.sit(self)
	moving_to_boat = true
	#move_and_slide( Vector2(5,5),Vector2(10,10))




