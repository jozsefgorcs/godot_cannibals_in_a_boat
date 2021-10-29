extends Control


var time = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func start_timer():
	$Timer.start()
	time = 0
	updateLabel()
	
func stop_timer():
	$Timer.stop()

func _on_Timer_tick():
	time += 1
	updateLabel()
	
func updateLabel():
	$CanvasLayer/Label.text = str(time)
	
