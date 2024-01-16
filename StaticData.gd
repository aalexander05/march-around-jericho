extends Node

var big_question_object = {}
var questions = []
var question_index = 0

var filePath = "res://data.json"

var current_question = {}

func _ready():
	big_question_object = load_json_file(filePath)
	
	for q in range(len(big_question_object)):
		questions.push_back(big_question_object[str(q+1)])
	
	questions.shuffle()
		
	
	
func load_json_file(filePath : String):
	if FileAccess.file_exists(filePath):
		var dataFile = FileAccess.open(filePath, FileAccess.READ)
		var parsedResult = JSON.parse_string(dataFile.get_as_text())
		
		if parsedResult is Dictionary:
			return parsedResult
		else:
			print("Error reading file")
	else:
		print("File doesn't exist!")

func get_next_question():
	current_question = questions[question_index]
	question_index += 1;
	if question_index >= len(questions):
		question_index = 0

	return current_question
