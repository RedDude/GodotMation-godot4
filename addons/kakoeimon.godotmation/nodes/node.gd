@tool
extends Node


var type = 2

@export var caption: String
@export var color: int
@export var actions: int
@export var activation_mode: int
@export var pull_mode: int
@export var resource_color: String
@export var starting_resources: int
@export var number: int
@export var capacity: int
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

var input_number = 0

var output_number = 0

var pushed = false


func trigger():
	if not active: return
	var satisfied = true
	##################PULL ANY
	if pull_mode == 0: #pull any
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
		##################PUSH ANY
	elif pull_mode == 2: #push any
		for r in output_resources:
			if not r.trigger():
				satisfied = false
			
		##################PUSH ALL
	elif pull_mode == 3: #push all
		for r in output_resources:
			if not r.can_push_all():
				satisfied = false
				break
		if satisfied:
			for r in output_resources:
				r.trigger()
	
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
	pass



func can_push(value):
	if value <= number + output_number:
		return value
	return max(0, number + output_number)


func change_input_state(value): 
	input_number += value
	#value is and the state change in fact so we trigger the output states with this value
	for s in output_states:
		s.trigger(value)
	return input_number


func change_output_state(value):
	if value > number + output_number:
		print(value)
	output_number += value
	#value is and the state change in fact so we trigger the output states with this value
	for s in output_states:
		s.trigger(value)
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
	#active is setted here as true and this may change by the input_conditional_states
	active = true
	for s in input_conditional_states:
		s.trigger()

