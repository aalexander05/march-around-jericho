extends Node

signal done_destroying_city


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
			
		


func _on_game_manager_goal_reached():
	var tween = create_tween()
	var camera_shake_movement = 2
	var position_left = Vector2($"../Camera2D".position.x - camera_shake_movement, $"../Camera2D".position.y)
	var position_right = Vector2($"../Camera2D".position.x + camera_shake_movement, $"../Camera2D".position.y)
	
	var camera_movement_duration = .08
	for i in range(9):
		tween.chain().tween_property($"../Camera2D", "position", position_left, camera_movement_duration)
		tween.chain().tween_property($"../Camera2D", "position", position_right, camera_movement_duration)
		
	await tween.finished
	show_destroyed_city()
	done_destroying_city.emit()
	
func show_destroyed_city():
	$"../CityWalls".hide()
	$"../CityDoors".hide()
	$"../CityCrumbled1".show()
	
func fix_city():
	$"../CityWalls".show()
	$"../CityDoors".show()
	$"../CityCrumbled1".hide()
