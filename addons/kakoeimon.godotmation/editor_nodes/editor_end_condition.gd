@tool
extends "editor_node.gd"

var type = 8

@export var resource_color: int = 0
@export var starting_resources: int = 0
@export var number: int = 0
@export var capacity: int = -1

var selected = false

@export var signaller: bool = true

@onready var colors = get_parent().get_parent().get_parent().colors
@onready var font = ThemeDB.fallback_font



func draw(in_color, in_radius):
	var size = Vector2(in_radius, in_radius)
	draw_rect(Rect2(-size, size*2), in_color )
	size -= Vector2(thickness, thickness)
	draw_rect(Rect2(-size, size*2), Color(1,1,1) )
	size /= 1.5
	draw_rect(Rect2(-size, size*2), in_color )
	
	
func _draw():
	if selected:
		draw(get_parent().get_parent().selected_color, radius)
		
	draw(colors[color], radius - thickness)
	if signaller:
		draw_circle(Vector2(), 8, colors[1])
	
	
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
	dict.signaller = signaller
	return dict
	
