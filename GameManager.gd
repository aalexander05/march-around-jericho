extends Node

signal change_question_text(new_text)
signal change_question(question)
signal correct_answer()
signal incorrect_answer()
signal clear_messages()

var show_question = false
var score = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	Signals.next_question.connect(get_question.bind())
	Signals.answer_submitted.connect(check_question.bind())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_N:
			if show_question:
				show_question = false
				get_node("../CanvasLayer").hide()
			else:
				show_question = true
				get_question()
				get_node("../CanvasLayer").show()
			
			
func get_question():
	clear_messages.emit()
	var question = StaticData.getNextQuestion()
	var new_text = question["Question"]
	new_text += "\n"
	new_text += question["Correct Answer"]
	new_text += "\n"
	for a in question["Other Multiple Choice Answers"]:
		new_text += a
		new_text += "\n"
	change_question_text.emit(new_text)
	change_question.emit(question)

func check_question(text):
	if text == StaticData.currentQuestion["Correct Answer"]:
		score += 1
		correct_answer.emit()
		# get_question();
		$"../HUD".set_score(score)
	else:
		incorrect_answer.emit()
		
	
