extends MarginContainer

var x = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_H:
			visible = !visible
			if visible:
				show()
			else:
				hide()
			
			

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
