@tool
extends "editor_node.gd"

var type = 7

@export var resource_color: int = 0
@export var starting_resources: int = 0
@export var number: int = 0
@export var capacity: int = -1
@export var queue: bool = false


var selected = false

@onready var colors = get_parent().get_parent().get_parent().colors
@onready var font = ThemeDB.fallback_font

	
func _draw():
	
	if selected:
		draw_circle(Vector2(), radius + thickness * 2, get_parent().get_parent().selected_color)
	draw_circle(Vector2(),radius + thickness/2, colors[0]) 
	draw_circle(Vector2(),radius - thickness/2, colors[1])
	draw_queue()
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
	
func draw_queue():
	var _x = 7 * 0.8
	var _y = 13 * 0.8
	var pos = Vector2(0, 0)
	if queue: pos.x -= _x + 1
		
	draw_line(pos, pos - Vector2(_x, _y), colors[0], 2)
	draw_line(pos, pos + Vector2(_x, -_y), colors[0], 2)
	draw_line(pos - Vector2(_x, _y), pos + Vector2(_x, -_y), colors[0], 2)
	draw_line(pos, pos + Vector2(_x, _y), colors[0], 2)
	draw_line(pos, pos - Vector2(_x, -_y), colors[0], 2)
	draw_line(pos + Vector2(_x, _y), pos - Vector2(_x, -_y), colors[0], 2)
		
	if queue:
		pos.x = _x + 2
		draw_line(pos, pos - Vector2(_x, _y), colors[0], 2)
		draw_line(pos, pos + Vector2(_x, -_y), colors[0], 2)
		draw_line(pos - Vector2(_x, _y), pos + Vector2(_x, -_y), colors[0], 2)
		draw_line(pos, pos + Vector2(_x, _y), colors[0], 2)
		draw_line(pos, pos - Vector2(_x, -_y), colors[0], 2)
		draw_line(pos + Vector2(_x, _y), pos - Vector2(_x, -_y), colors[0], 2)
	
func get_dict():
	var dict = get_base_dict()
	dict.type = type
	dict.resource_color = resource_color
	dict.starting_resources = starting_resources
	dict.capacity = capacity
	dict.queue = queue
	return dict
	
func change_number(value):
	$Number.text = str(value)
