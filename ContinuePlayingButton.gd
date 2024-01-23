extends Button

signal hide_end_message

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	Signals.emit_signal("next_question")
	Signals.emit_signal("reset_score")
	hide_end_message.emit()

