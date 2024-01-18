extends Node

enum positions {
	North,
	South,
	East,
	West
}

var current_position = positions.North
var target_position
var target_position2


var new_animation2 = ""

var tween

var move_timer = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	target_position = $"Position North East"
	target_position2 = $"Position East"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if move_timer > 0:
		move_timer -= delta
		if move_timer <= 0:
			move_one_space()


func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_G:
			move_one_space()
			
			

# stolen from https://stackoverflow.com/questions/13462001/ease-in-and-ease-out-animation-formula
func parametric_blend(t):
	var sqr = t * t
	return sqr / (2 * (sqr - t) + 1)
	
func move_one_space():
	if tween:
		tween.kill()
				
	var new_animation = ""
			
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
	
	tween = create_tween()
	tween.tween_property($CharacterBody2D, "position", target_position.position, 2)
	tween.tween_callback(setSecondAnimation)
	tween.chain().tween_property($CharacterBody2D, "position", target_position2.position, 2)
	
	$CharacterBody2D/Sprite2D2/AnimationPlayer.play(new_animation)
	
func setSecondAnimation():
	$CharacterBody2D/Sprite2D2/AnimationPlayer.play(new_animation2)
	


func _on_game_manager_correct_answer():
	move_timer = 2
	
	
