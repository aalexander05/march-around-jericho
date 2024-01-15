extends CharacterBody2D

const SPEED = 100.0
#const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var x_direction = Input.get_axis("ui_left", "ui_right")
	var y_direction = Input.get_axis("ui_up", "ui_down")
	
	if x_direction:
		velocity.x = x_direction * SPEED
		
		if x_direction < 0:
			$Sprite2D2/AnimationPlayer.play("WalkLeft")
		if x_direction > 0:
			$Sprite2D2/AnimationPlayer.play("WalkRight")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if y_direction:
		velocity.y = y_direction * SPEED
		if y_direction > 0:
			$Sprite2D2/AnimationPlayer.play("Idle")
		if y_direction < 0:
			$Sprite2D2/AnimationPlayer.play("WalkUp")
			
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
