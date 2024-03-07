@tool
extends "BaseButton.gd"



func draw():
	var radius = get_size().x / 2
	draw_set_transform(Vector2(10, 30), 0, Vector2(2,2))
	draw_string(ThemeDB.fallback_font, Vector2(), "Text")
	draw_set_transform(Vector2(4, 60), 0, Vector2(2,2))
	draw_string(ThemeDB.fallback_font, Vector2(), "Label")
	pass
