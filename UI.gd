extends Control


var steps = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func update_label():
	$CanvasLayer/Control/StepValue.text = str(steps)

	
func add_step():
	steps += 1
	update_label()
	
func reset_steps():
	steps = 0
	update_label()
