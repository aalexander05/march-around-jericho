extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	
	await get_tree().create_timer(3.5).timeout
	$Title/AnimationPlayer.play("FadeOut")
	await get_tree().create_timer(1.75).timeout
	$AnimationPlayer.play("FadeIn")
	await get_tree().create_timer(1).timeout
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
