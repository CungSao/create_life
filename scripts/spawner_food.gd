extends Node2D

var food = Food.new()
@onready var snake = %snake

func _ready():
	spawn_food()
	
func _process(_delta):
	queue_redraw()
	
	if food.get_rect().intersects(snake.head.get_rect()):
		snake.grow()
		spawn_food()
	
func _draw():
	draw_rect(food.get_rect(), food.color)

func spawn_food():
	var is_on_occupied_pos = true
	if is_on_occupied_pos:
		var rand_pos = Vector2.ZERO
		rand_pos.x = randf_range(0, Game.GRID_SIZE.x - Game.CELL_SIZE.x)
		rand_pos.y = randf_range(0, Game.GRID_SIZE.y - Game.CELL_SIZE.y)
		food.pos = rand_pos.snapped(Game.CELL_SIZE)
	
	# check if pos is occupied
	for minisnake in snake.minisnakes:
		if food.get_rect().intersects(minisnake.get_rect()):
			is_on_occupied_pos = true
			break
		else:
			is_on_occupied_pos = false
