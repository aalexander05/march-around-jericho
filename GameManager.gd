extends Node

signal change_question_text(new_text)
signal change_question(question)
signal correct_answer()
signal incorrect_answer()
signal clear_messages()
signal set_possible_points(possible_points, original_max_possible_points)

var current_question = {}
var show_question = false
var score = 0
var steps_can_go_if_correct = 0 # set by each question's answer count
var already_answered = false
var submitted_answers = []


# Called when the node enters the scene tree for the first time.
func _ready():
	Signals.next_question.connect(get_question.bind())
	Signals.answer_submitted.connect(check_question.bind())
	
	
	show_question = true
	get_question()
	get_node("../CanvasLayer").show()

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
	already_answered = false
	submitted_answers = []
	clear_messages.emit()
	current_question = StaticData.get_next_question()
	
	# set text
	var new_text = current_question["Question"]
	new_text += "\n"
	new_text += current_question["Correct Answer"]
	new_text += "\n"
	for a in current_question["Other Multiple Choice Answers"]:
		new_text += a
		new_text += "\n"
	
	# set potential points scoring
	steps_can_go_if_correct	= len(current_question["Other Multiple Choice Answers"])
	set_possible_points.emit(steps_can_go_if_correct, len(current_question["Other Multiple Choice Answers"]))
	
	# emit signals
	change_question_text.emit(new_text)
	change_question.emit(current_question)

func check_question(text):
	
	if already_answered:
		# don't award points or anything. just leave.
		# (they already answered the question)
		return
	
	if text == StaticData.current_question["Correct Answer"]:
		already_answered = true;
		score += steps_can_go_if_correct
		correct_answer.emit()
		# get_question();
		$"../HUD".set_score(score)
	else:
		for a in submitted_answers:
			if a == text:
				return
		
		submitted_answers.push_back(text)
		
		
		
		if steps_can_go_if_correct > 0:
			steps_can_go_if_correct -= 1
			set_possible_points.emit(steps_can_go_if_correct, len(current_question["Other Multiple Choice Answers"]))
			
		incorrect_answer.emit()
		
	


func _on_canvas_layer_ready_to_show_again():
	get_question();
