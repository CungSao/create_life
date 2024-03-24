class_name Snake extends Node2D

signal hit(minisnake_hit:Minisnake)

var head = Minisnake.new()
var minisnakes:Array[Minisnake]

var curr_direction = Vector2.RIGHT
var next_direction = Vector2.RIGHT
var tween_move:Tween

func _ready():
	head.size = Game.CELL_SIZE
	head.color = Colors.BLUE_DARK
	minisnakes.push_front(head)
	
	hit.connect(_on_hit)
	
	tween_move = create_tween().set_loops()
	tween_move.tween_callback(move).set_delay(.075)

func _process(_delta):
	queue_redraw()
	
func _draw():
	for minisnake in minisnakes:
		draw_rect(minisnake.get_rect(), minisnake.color)

func _input(_event):
	if Input.is_action_pressed("ui_left"):
		if curr_direction == Vector2.RIGHT: return
		next_direction = Vector2.LEFT
	if Input.is_action_pressed("ui_right"):
		if curr_direction == Vector2.LEFT: return
		next_direction = Vector2.RIGHT
	if Input.is_action_pressed("ui_up"):
		if curr_direction == Vector2.DOWN: return
		next_direction = Vector2.UP
	if Input.is_action_pressed("ui_down"):
		if curr_direction == Vector2.UP: return
		next_direction = Vector2.DOWN
	if Input.is_action_pressed("ui_accept"):
		grow()

func move():
	curr_direction = next_direction
	var next_pos = head.curr_pos + (curr_direction * Game.CELL_SIZE)
	next_pos = wraps(next_pos, Game.GRID_SIZE)
	head.curr_pos = next_pos
	
	# move other minisnakes
	for i in range(1, minisnakes.size()):
		minisnakes[i].curr_pos = minisnakes[i-1].prev_pos
	
	# check coll between head and minisnakes
	for i in range(1, minisnakes.size()):
		if head.get_rect().intersects(minisnakes[i].get_rect()):
			hit.emit(minisnakes[i])
			Game.gameover.emit()
			break

func wraps(value:Vector2, length:Vector2) -> Vector2:
	value.x = fposmod(value.x, length.x)
	value.y = fposmod(value.y, length.y)
	return value

func grow():
	var minisnake = Minisnake.new()
	var last_minisnake:Minisnake = minisnakes.back()
	
	minisnake.curr_pos = last_minisnake.curr_pos
	minisnake.color = Colors.BLUE
	minisnake.size = Game.CELL_SIZE
	minisnakes.push_back(minisnake)
	
	Game.score += 1

func _on_hit(_mini:Minisnake):
	tween_move.kill()
	await get_tree().process_frame
	
	for minisnake in minisnakes:
		minisnake.go_to_prev_pos()
