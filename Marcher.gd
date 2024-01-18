extends Node

enum positions {
	North,
	South,
	East,
	West
}

var current_position = positions.North
var target_postition

var tween

var move_timer = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	target_postition = $"Position North"


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
			target_postition = $"Position East"
			current_position = positions.East
		positions.East:
			new_animation = "Idle"
			target_postition = $"Position South"
			current_position = positions.South
		positions.South:
			new_animation = "WalkLeft"
			target_postition = $"Position West"
			current_position = positions.West
		positions.West:
			new_animation = "WalkUp"
			target_postition = $"Position North"
			current_position = positions.North
	
	tween = create_tween()
	tween.tween_property($CharacterBody2D, "position", target_postition.position, 2)
	
	$CharacterBody2D/Sprite2D2/AnimationPlayer.play(new_animation)
	


func _on_game_manager_correct_answer():
	move_timer = 2
	
