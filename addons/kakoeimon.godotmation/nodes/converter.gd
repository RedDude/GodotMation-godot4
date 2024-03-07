@tool
extends Node


var type = 6
@export var caption: String
@export var color: int
@export var actions: int
@export var activation_mode: int

@export var pull_mode: int

@export var resource_color: String

@export var caption_pos: float
@export var thickness: int
@export var position: Vector2


####### Extra vars for the functionality of the pool

var input_resources = []
var output_resources = []
var input_states = []
var output_states = []

var trigger_states = []
var reverse_trigger_states = []
var input_conditional_states = []


@export var active: bool = true

var number = 0

var input_number = 0

var output_number = 0

var satisfied = true

var pushed = false

func trigger():
	if not active: return
	##################PULL ANY
	if pull_mode !=1: #pull any
		for r in input_resources:
			if not r.trigger():
				satisfied = false
		##################PULL ALL
	elif pull_mode == 1: #pull all
		for r in input_resources:
			if not r.can_push_all():
				satisfied = false
				break
		if satisfied:
			for r in input_resources:
				r.trigger()

	
	if satisfied:
		for r in input_resources:
			r.update_flow()
		for r in output_resources:
			r.trigger()
		for s in trigger_states:
			s.end_node.trigger()
	for r in input_resources:
		if not r.satisfied:
			for s in reverse_trigger_states:
				s.end_node.trigger()
			break
	pass

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
		for r in output_resources:
			r.trigger()
		for s in trigger_states:
			s.end_node.trigger()
	pushed = false

func can_push(value):
	return value


func change_input_state(value):
	number += value
	return input_number


func change_output_state(value):
	number += value
	return value


func get_changed_number():
	return number + output_number + input_number

func get_output_number():
	return number + output_number
	
func get_input_number():
	return number + input_number


func apply_state():
	if output_number or input_number:
		number += output_number + input_number

		output_number = 0
		input_number = 0
	satisfied = true
	#active is setted here as true and this may change by the input_conditional_states
	active = true
	for s in input_conditional_states:
		s.trigger()

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
