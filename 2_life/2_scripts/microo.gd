extends Node2D

var min_xy = 0
var max_x = Game.GRID_SIZE.x - Save.size.x
var max_y = Game.GRID_SIZE.y - Save.size.y

var particles = []

var yellow
var red
var green

func _input(_event):
	if Input.is_action_pressed("reset"):
		get_tree().reload_current_scene()
		
func _draw():
	for i in particles.size():
		draw_rect(
			Rect2(Vector2(particles[i].x, particles[i].y), Vector2(Save.size)),
			particles[i].color
			)

func particle(x:int,y:int,c = Color.BLACK):
	return {"x":x, "y":y, "vx":0, "vy":0, "color":c}

func create(number, color:Color, group = []):
	for i in number:
		var random_vector = Vector2(
			randi_range(min_xy, max_x),
			randi_range(min_xy, max_y)
		)
		group.push_back(particle(random_vector.x, random_vector.y, color))
		particles.push_back(group[i])
	return group

func rule(particles1, particles2, g):
	for i in particles1.size():
		var fx = 0
		var fy = 0
		
		for j in particles2.size():
			var a = particles1[i]
			var b = particles2[j]
			
			var dx = a.x - b.x
			var dy = a.y - b.y
			var d = sqrt(dx*dx + dy+dy)
			
			if d > Save.distance_limits[0] && d < Save.distance_limits[1]:
				var F = g * 1/d
				fx += F * dx
				fy += F * dy

			a.vx = (a.vx + fx) * Save.speed
			a.vy = (a.vy + fy) * Save.speed
			a.x += a.vx
			a.y += a.vy
			
			if a.x < 0 || a.x > Game.GRID_SIZE.x-7: a.vx *= -200
			if a.y < 0 || a.y > Game.GRID_SIZE.y-7: a.vy *= -200
			
func _ready():
	yellow = create(Save.number_yellow, Colors.BLUE)
	red = create(Save.number_red, Colors.RED)
	green = create(Save.number_green, Color.SEA_GREEN)

func _process(_delta):
	queue_redraw()
	rule(yellow, yellow, Save.yellow_yellow_rule)
	rule(yellow, red, Save.yellow_red_rule)
	rule(yellow, green, Save.yellow_green_rule)
	
	rule(red, red, Save.red_red_rule)
	rule(red, yellow, Save.red_yellow_rule)
	rule(red, green, Save.red_green_rule)
	
	rule(green, green, Save.green_green_rule)
	rule(green, red, Save.green_yellow_rule)
	rule(green, yellow, Save.green_red_rule)
