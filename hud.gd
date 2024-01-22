extends CanvasLayer

var points = 0;
var show_points_timer = 0
var point_shower_speed = 1
var original_point_shower_y

# Called when the node enters the scene tree for the first time.
func _ready():
	$MarginContainer/PointsShower/Label.hide()
	original_point_shower_y = $MarginContainer/PointsShower/Label.position.y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if show_points_timer > 0:
		var points_label = $MarginContainer/PointsShower/Label
		points_label.position.y -= point_shower_speed
		points_label.show()
		points_label.text = str(points)
		if points > 1:
			points_label.text += "!"
		
		show_points_timer -= delta
		if show_points_timer <= 0:
			points_label.position.y = original_point_shower_y
			points_label.hide()
			
	
func set_score(score, points_last_scored):
	$MarginContainer/Label.text = "Score: " + str(score) + " Laps: " + str(floor(score / 4))
	
	if points_last_scored > 0:
		await get_tree().create_timer(2.2).timeout
		points = points_last_scored
		show_points_timer = .8
	
