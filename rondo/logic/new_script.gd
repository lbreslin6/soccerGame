extends Area2D


var _ball_dir_X
var _up
var _down
var _left
var _right

onready var _screen_size_y = get_viewport_rect().size.y
onready var _screen_size_x = get_viewport_rect().size.x



const MOVE_SPEED = 100

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

func sort(array):
		for i in range(array.size()-1, -1, -1):
			for j in range(1,i+1,1):
				if array[j-1] > array[j]:
					var temp = array[j-1]
					array[j-1] = array[j]
					array[j] = temp
		return array
func selectPass(Pass):
	var players = {"Left": getDist('Left'), "Right": getDist('Right'), "Top": getDist('Top'), "Bottom": getDist('Bottom')}
	var playerPlace = ["Left", "Right", "Top", "Bottom"]
	var distances = [players["Left"], players["Right"], players["Top"], players["Bottom"]]
	var distancesPre = [players["Left"], players["Right"], players["Top"], players["Bottom"]]
	var sorted = sort(distances)
	var selection = sorted[Pass]
	print(selection, 'selection')
	print(sorted, 'sorted')
	print(distancesPre, 'distances')
	
	for i in 4:
		print('hello')
		if round(distancesPre[i]) == round(selection):
			print(playerPlace[i], 'PlayerPlaceI')
			return playerPlace[i]

func _on_area_entered(area):
	if area.name == "Ball":
		# Assign new direction.
		#area.direction = Vector2(_ball_dir_X, randf() * 2 - 1).normalized()
		
		
		var random_generator = RandomNumberGenerator.new()
		random_generator.randomize()
		var random_value = random_generator.randi_range(1,3)
		area.direction = getPos(selectPass(random_value)) - area.position
		area.direction = area.direction.normalized()
