extends KinematicBody2D

export(NodePath) var boat_node_path

onready var boat = get_node(boat_node_path)
var is_in_boat = false
var moving_to_boat = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _physics_process(delta):
	if(moving_to_boat):
		moving_to_boat = false #TODO
		pass
		#move_and_slide(boat.get("position"))
		#print(position)
	pass



func _on_Priest_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.is_pressed():
		self.on_click()


func on_click():
	print("Click on priest" )
	position = boat.get_empty_seat_pos()
	moving_to_boat = true
	#move_and_slide( Vector2(5,5),Vector2(10,10))

