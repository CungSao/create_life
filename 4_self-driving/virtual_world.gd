extends Node2D

var width = 600
var height = 600

var window_size = Vector2(width, height)
var color = Color.BLACK
var pos

var p1 = Vector2(200,200)
var p2 = Vector2(500,200)
var p3 = Vector2(400,400)
var p4 = Vector2(100,300)

var s1 = [p1, p2]
var s2 = [p1, p3]
var s3 = [p1, p4]
var s4 = [p2, p3]
var graph = [[p1, p2, p3, p4], [s1,s2,s3,s4]]
var button:bool

func _ready():
	WindowUtil.set_pos_screen(window_size)

func _process(_delta):
	queue_redraw()
	
func _input(event):
	if event is InputEventMouseButton && event.pressed:
		pos = get_global_mouse_position()

func event_draw(event):
	if event is InputEventMouseButton:
		button = !button
	if event is InputEventMouseMotion && button:
		pos = get_global_mouse_position()

func _draw():
	draw_graph(graph)
	
	if pos:
		add_point(pos)
		graph[0].push_back(pos)

func draw_graph(_graph):
	for point in _graph[0]:
		set_draw_cir(point)
	for segment in _graph[1]:
		set_draw_line(segment[0],segment[1])
	
func add_point(_pos):
	set_draw_cir(_pos)
	
func set_draw_cir(_pos, size=18, c=Color.BLACK ):
	draw_circle(_pos, size, c)

func set_draw_line(from:Vector2, to:Vector2, c=Color.BLACK, size=4):
	draw_line(from, to, c, size)
