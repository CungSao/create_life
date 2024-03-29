extends Label

@onready var line_edit = $LineEdit

func _ready():
	match name:
		"speed":
			line_edit.text = str(Save.speed)
		"distance":
			line_edit.text = str(Save.distance_limits[1])
		"size":
			line_edit.text = str(Save.size.x)
		"number_yellow":
			line_edit.text = str(Save.number_yellow)
		"number_red":
			line_edit.text = str(Save.number_red)
		"number_green":
			line_edit.text = str(Save.number_green)
		"yellow_x_yellow":
			line_edit.text = str(Save.yellow_yellow_rule)
		"yellow_x_red":
			line_edit.text = str(Save.yellow_red_rule)
		"yellow_x_green":
			line_edit.text = str(Save.yellow_green_rule)
		"red_x_red":
			line_edit.text = str(Save.red_red_rule)
		"red_x_yellow":
			line_edit.text = str(Save.red_yellow_rule)
		"red_x_green":
			line_edit.text = str(Save.red_green_rule)
		"green_x_green":
			line_edit.text = str(Save.green_green_rule)
		"green_x_yellow":
			line_edit.text = str(Save.green_yellow_rule)
		"green_x_red":
			line_edit.text = str(Save.green_red_rule)

func _on_line_edit_text_submitted(new_text):
	line_edit.release_focus()
	if new_text == "":
		line_edit.text = "0"
	elif int(new_text) >= 100:
		line_edit.text = "77"
	
	match name:
		"speed":
			#Save.propagate_call(str(name))
			Save.speed = float(new_text)
		"distance":
			Save.distance_limits[1] = int(new_text)
		"size":
			Save.size = Vector2(int(new_text), int(new_text))
		"number_yellow":
			Save.number_yellow = float(new_text)
		"number_red":
			Save.number_red = float(new_text)
		"number_green":
			Save.number_green = float(new_text)
		"yellow_x_yellow":
			Save.yellow_yellow_rule = float(new_text)
		"yellow_x_red":
			Save.yellow_red_rule = float(new_text)
		"yellow_x_green":
			Save.yellow_green_rule = float(new_text)
		"red_x_red":
			Save.red_red_rule = float(new_text)
		"red_x_yellow":
			Save.red_yellow_rule = float(new_text)
		"red_x_green":
			Save.red_green_rule = float(new_text)
		"green_x_green":
			Save.green_green_rule = float(new_text)
		"green_x_yellow":
			Save.green_yellow_rule = float(new_text)
		"green_x_red":
			Save.green_red_rule = float(new_text)
			
func _input(event):
	if event is InputEventMouseButton:
		if event.pressed != true: return
		line_edit.release_focus()
