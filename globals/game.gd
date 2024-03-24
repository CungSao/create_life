extends Node2D

signal gamestart
signal gameover
signal score_changed(new_score:int)

const GRID_SIZE = Vector2(800,480)
const CELL_SIZE = Vector2(32,32)

const CELLS_AMOUNT = Vector2(GRID_SIZE.x / CELL_SIZE.x, GRID_SIZE.y / CELL_SIZE.y)

var score = 0 : set = _set_score

func _ready():
	await get_tree().process_frame
	gamestart.emit()
	
func restart():
	score = 0
	get_tree().reload_current_scene()
	
func _set_score(new_score:int):
	score = new_score
	score_changed.emit(score)
	
