extends CanvasLayer

var hide_incorrect_message_timer = 0
var hide_correct_message_timer = 0

signal ready_to_show_again()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if hide_incorrect_message_timer > 0:
		hide_incorrect_message_timer -= delta
		if hide_incorrect_message_timer <= 0:
			# incorrect message is shown and needs to be hidden
			$MarginContainer/NinePatchRect/IncorrectMessage.hide()
			
			
	if hide_correct_message_timer > 0:
		hide_correct_message_timer -= delta
		if hide_correct_message_timer <= 0:
			hide()
	


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
	

func _on_game_manager_incorrect_answer():
	$MarginContainer/NinePatchRect/IncorrectMessage.show()
	hide_incorrect_message_timer = 3


func _on_game_manager_correct_answer(score):
	hide_correct_message_timer = 2
	
	
	# in case the player quickly clicks the right answer
	# right after the clicked the wrong answer
	# so we won't have both messages displaying  >_<
	$MarginContainer/NinePatchRect/IncorrectMessage.hide()
	
	$MarginContainer/NinePatchRect/CorrectMessage.show()


func _on_game_manager_clear_messages():
	$MarginContainer/NinePatchRect/IncorrectMessage.hide()
	$MarginContainer/NinePatchRect/CorrectMessage.hide()


func _on_game_manager_set_possible_points(possible_points, original_max_possible_points):
	var new_possible_points_text = "Possible Points: " + str(possible_points)
	
	#for p in range(possible_points):
		#new_possible_points_text += "🦶"
	#
	#for p in range(original_max_possible_points - possible_points):
		#new_possible_points_text += "❌"
	$MarginContainer/NinePatchRect/PossiblePoints.text = new_possible_points_text


func _on_marcher_done_moving():
	ready_to_show_again.emit()
	show()
