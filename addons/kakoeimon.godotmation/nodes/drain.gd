@tool
extends Node


var type = 5
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

var trigger_states = []
var reverse_trigger_states = []

var input_conditional_states = []

var active = true

var satisfied = true

var pushed = false

func trigger():
	if not active: return
	
	for r in input_resources:
		if not r.trigger():
			satisfied = false

	if satisfied:
		for r in input_resources:
			r.update_flow()
		for s in trigger_states:
			s.end_node.trigger()
	for r in input_resources:
		if not r.satisfied:
			for s in reverse_trigger_states:
				s.end_node.trigger()
			break
	return

func pull_resources(resource):
	if not active: return
	pushed = true
	if not resource.trigger():
		satisfied = false

	
func apply_satisfaction():
	for r in input_resources:
		if not r.used: satisfied = false
		if not r.satisfied or not r.used:
			for s in reverse_trigger_states:
				s.end_node.trigger()
			break
	if satisfied:
		for r in input_resources:
			r.update_flow()
		for s in trigger_states:
			s.end_node.trigger()
	pushed = false

func can_push(value):
	return 0


func change_input_state(value): 
	return value

func change_output_state(value):
	return value

func apply_state():
	satisfied = true
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