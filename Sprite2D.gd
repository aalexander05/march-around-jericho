extends Sprite2D

var speed = 10


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("Idle")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	pass
	

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_W:
			pass
