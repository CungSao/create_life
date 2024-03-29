class_name Minisnake

var curr_pos:Vector2 : set = _set_curr_pos
var prev_pos:Vector2
var size:Vector2
var color:Color

func get_rect() -> Rect2:
	return Rect2(curr_pos, size)

func go_to_prev_pos():
	curr_pos = prev_pos
	
func _set_curr_pos(new_pos:Vector2):
	prev_pos = curr_pos
	curr_pos = new_pos
