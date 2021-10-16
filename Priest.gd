extends KinematicBody2D

export(Area2D) var boat_node

var is_in_boat = false
var moving_to_boat = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	if(moving_to_boat):
		#move_and_slide(self.position, boat_node.)
	pass



func _on_Priest_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.is_pressed():
		self.on_click()


func on_click():
	print("Click on priest" )
	print(boat_node)
	move_and_slide( Vector2(5,5),Vector2(10,10))

