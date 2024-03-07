@tool
extends "editor_node.gd"

var type = 6

@export var resource_color: int = 0
@export var starting_resources: int = 0
@export var number: int = 0
@export var capacity: int = -1

var selected = false

@onready var colors = get_parent().get_parent().get_parent().colors
@onready var font = ThemeDB.fallback_font



func draw(in_color, in_thickness):
	var line = []
	line.append(Vector2(-radius - in_thickness, -radius -in_thickness*2) )
	line.append(Vector2(radius + in_thickness*2, 0) )
	line.append(Vector2(-radius - in_thickness, radius +in_thickness*2) )
	
	draw_colored_polygon(PackedVector2Array(line), in_color)
	
	
func _draw():
	if selected:
		draw(get_parent().get_parent().selected_color, thickness)
		draw_line(Vector2(0, -radius), Vector2(0, radius), get_parent().get_parent().selected_color, thickness*2)
	
	draw(colors[color], 0)
	draw(colors[1], -thickness)
	draw_line(Vector2(0, -radius), Vector2(0, radius), colors[color], thickness)
	
	var pos = Vector2(radius + thickness, radius + thickness)
	if pull_mode >=2:
		draw_char(font, pos, "p", 16, colors[color])

		#var next = draw_char(font, pos, "p", "&", colors[color])
		#pos.x += next
	if pull_mode == 1 or pull_mode == 3:
		draw_string(font, pos,  "&", HORIZONTAL_ALIGNMENT_CENTER, -1, 16, colors[color])
	
	pos.y = -pos.y
	if activation_mode == 1:
		pass
	elif activation_mode == 2:
		draw_string(font, Vector2(),  "*", HORIZONTAL_ALIGNMENT_CENTER, -1, 16, colors[color])
	
func set_starting_resources(value):
	starting_resources = value
	$Number.text = str(starting_resources)
	
func get_dict():
	var dict = get_base_dict()
	dict.type = type
	dict.resource_color = resource_color
	
	return dict
	
