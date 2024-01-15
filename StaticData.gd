extends Node

var itemData = {}

var filePath = "res://data.json"

var currentQuestion = {}

func _ready():
	itemData = load_json_file(filePath)
	getNextQuestion()
	
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

func getNextQuestion():
	var rng = RandomNumberGenerator.new()
	var my_random_number = rng.randi_range(1, len(itemData))
	print(my_random_number)
	currentQuestion = itemData[str(my_random_number)]

	return currentQuestion
