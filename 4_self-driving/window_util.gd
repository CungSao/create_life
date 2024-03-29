extends Node

func set_pos_screen(window_size, screen_size = Vector2(1600, 900)):
	#window
	DisplayServer.window_set_size(window_size)
	DisplayServer.window_set_position(Vector2(screen_size.x/2-window_size.x/2, screen_size.y/2-window_size.y/2))
	#content
	get_tree().root.content_scale_size = window_size
	get_tree().root.content_scale_mode = Window.CONTENT_SCALE_MODE_CANVAS_ITEMS
