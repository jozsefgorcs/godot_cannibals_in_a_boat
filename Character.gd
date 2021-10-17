extends KinematicBody2D


var boat = null
var is_in_boat = false
var moving_to_boat = false
var current_seat = null

signal wants_to_sit(who)
signal wants_get_out(who)


func _ready():
	pass

func _physics_process(delta):
	if(is_in_boat && current_seat!=null):
		position = current_seat.global_position

func _on_Character_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.is_pressed():
		self.on_click()

func on_click():
	if is_in_boat:
		emit_signal("wants_get_out", self)
	else:
		emit_signal("wants_to_sit", self)




