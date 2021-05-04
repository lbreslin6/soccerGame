extends Area2D


const MOVE_SPEED = 100

var _ball_dir_X
var _up
var _down
var _left
var _right

onready var _screen_size_y = get_viewport_rect().size.y
onready var _screen_size_x = get_viewport_rect().size.x

func _ready():
	var n = name.to_lower()
	_up = n + "_move_up"
	_down = n + "_move_down"
	_left = n + "_move_left"
	_right = n + "_move_right"
	if n == "left":
		_ball_dir_X = 1
	else:
		_ball_dir_X = -1


func _process(delta):
	# Move up and down based on input.
	
	var inputY = Input.get_action_strength(_down) - Input.get_action_strength(_up)
	var inputX = Input.get_action_strength(_right) - Input.get_action_strength(_left)
	if inputY != 0:
		position.y = clamp(position.y + inputY * MOVE_SPEED * delta, 16, _screen_size_y - 16)
	if inputX != 0:
		position.x = position.x + inputX * MOVE_SPEED * delta

	

func getPos(player):
	var format_string = "../%s"
	var actual_string = format_string % player
	return get_node(actual_string).position

func getDist(player):
	var ab = getPos(player) - getPos('Ball')
	return sqrt(pow(ab.x,2)+ pow(ab.y,2))

func _on_area_entered(area):
	if area.name == "Ball":
		# Assign new direction.
		#area.direction = Vector2(_ball_dir_X, randf() * 2 - 1).normalized()
		
		var Bottom = get_node("../Bottom").position
		var distances = {Left: getDist('Left'), Right: getDist('Right'), Top:
		area.direction = getPos('Left') - area.position
		print_debug (area.direction)
		print_debug(getDist('Left'))
		area.direction = area.direction.normalized()
