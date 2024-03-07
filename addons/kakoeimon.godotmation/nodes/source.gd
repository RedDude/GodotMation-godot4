@tool
extends Node


var type = 4
@export var caption: String
@export var color: int
@export var actions: int
@export var activation_mode: int

@export var pull_mode: int

@export var resource_color: String

@export var caption_pos: float
@export var thickness: int
@export var position: Vector2


var input_resources = []
var output_resources = []
var input_states = []
var output_states = []

var input_conditional_states = []

var active = true

var trigger_states = []

var pushed = false


#Source only triggers the output connection's end nodes to pull resources.
func trigger():
	if not active: return
	
	for r in output_resources:
		r.end_node.pull_resources(r)

	for s in trigger_states:
		s.end_node.trigger()
	return

func pull_resources(resource):
	pass
	
func apply_satisfaction():
	pass


func can_push(value):
	return value


func change_input_state(value): 
	return value

func change_output_state(value):
	return value

func apply_state():
	active = true
	for s in input_conditional_states:
		s.trigger()
	return true
	
func get_dict():
	var dict = {}
	dict.type = type
	dict.caption = caption
	dict.color = color
	dict.actions = actions
	dict.activation_mode = activation_mode
	dict.pull_mode = pull_mode
	dict.resource_color = resource_color
	dict.caption_pos = caption_pos
	dict.thickness = thickness
	dict.x = position.x
	dict.y = position.y
	
	return dict
