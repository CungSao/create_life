extends Node

var speed = .1
var distance_limits = [0, 80]
var size = Vector2(7,7):
	set(new_value):
		size = new_value

var number_yellow = 55
var number_red = 55
var number_green = 55
	
var yellow_yellow_rule:float = .02
var yellow_red_rule:float = .0001
var yellow_green_rule:float = -.2

var red_red_rule:float = -.1
var red_yellow_rule:float = -.01
var red_green_rule:float = -.34

var green_green_rule:float = -.32
var green_yellow_rule:float = -.17
var green_red_rule:float = .34
