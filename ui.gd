extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_game_manager_change_question_text(new_text):
	var label = $MarginContainer/NinePatchRect/QuestionDisplay
	label.text = new_text


func _on_game_manager_change_question(question):
	var label = $MarginContainer/NinePatchRect/QuestionDisplay
	label.text = question["Question"]
	
	var button1 = $MarginContainer/NinePatchRect/HFlowContainer/Button
	var button2 = $MarginContainer/NinePatchRect/HFlowContainer/Button2
	var button3 = $MarginContainer/NinePatchRect/HFlowContainer/Button3
	var button4 = $MarginContainer/NinePatchRect/HFlowContainer/Button4
	
	var buttons = [
		button1,
		button2,
		button3,
		button4
	]
	
	for b in buttons:
		b.text = ""
		b.show()
	
	var answers = [
		question["Correct Answer"]
	]
	
	for wrong_answer in question["Other Multiple Choice Answers"]:
		answers.push_back(wrong_answer)
		
	answers.shuffle()
	
	for i in len(answers):
		buttons[i].text = answers[i]
	
	for b in buttons:
		if b.text == "":
			b.hide()
	
