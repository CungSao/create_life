class_name Food

var pos:Vector2
var size = Game.CELL_SIZE
var color = Colors.BLUE_SKY

func get_rect() -> Rect2:
	return Rect2(pos, size)
