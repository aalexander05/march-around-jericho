extends MarginContainer

@onready var label = $MarginContainer/Label

func _ready():
	label.text = StaticData.itemData["question"]
