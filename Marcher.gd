extends Node

signal done_moving()

enum positions {
	North,
	South,
	East,
	West
}

var current_position = positions.North

var target_position
var target_position2

var walk_duration = 1.25

# Called when the node enters the scene tree for the first time.
func _ready():
	target_position = $"Position North East"
	target_position2 = $"Position East"

func _process(delta):
	pass
	
func setAnimation(animation):
	$CharacterBody2D/Sprite2D2/AnimationPlayer.play(animation)
	

func _on_game_manager_correct_answer(score):
	await get_tree().create_timer(2.5).timeout
	var spaces_to_move = score
	
	var march_tween = create_tween()
	
	for i in range(spaces_to_move):
		
		var new_animation = ""
		var new_animation2 = ""
				
		match current_position:
			positions.North:
				new_animation = "WalkRight"
				new_animation2 = "Idle"
				target_position = $"Position North East"
				target_position2 = $"Position East"
				current_position = positions.East
			positions.East:
				new_animation = "Idle"
				new_animation2 = "WalkLeft"
				target_position = $"Position South East"
				target_position2 = $"Position South"
				current_position = positions.South
			positions.South:
				new_animation = "WalkLeft"
				new_animation2 = "WalkUp"
				target_position = $"Position South West"
				target_position2 = $"Position West"
				current_position = positions.West
			positions.West:
				new_animation = "WalkUp"
				new_animation2 = "WalkRight"
				target_position = $"Position North West"
				target_position2 = $"Position North"
				current_position = positions.North
		
		if i == 0 && $CharacterBody2D/Sprite2D2/AnimationPlayer.current_animation != new_animation:
			setAnimation(new_animation)
	
		march_tween.chain().tween_property($CharacterBody2D, "position", target_position.position, walk_duration)
		march_tween.tween_callback(setAnimation.bind(new_animation2))
		march_tween.chain().tween_property($CharacterBody2D, "position", target_position2.position, walk_duration)
		
	await march_tween.finished
	await get_tree().create_timer(.6).timeout
	done_moving.emit()
	
