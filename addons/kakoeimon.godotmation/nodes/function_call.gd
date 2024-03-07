@tool
extends Node


var type = 9

@export var caption: String
@export var color: int
@export var actions: int
@export var activation_mode: int
@export var pull_mode: int
@export var resource_color: String
@export var number: int = 0
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

var pushed = false


func trigger():
	if not active or not caption: return
	number = get_parent().get_parent().call(caption)
	pass


func pull_resources(resource):
	pass

	
func apply_satisfaction():
	pushed = false
	pass

func can_push(value):
	if value <= number:
		return value
	return max(0, number)


func change_input_state(value): 
	return 0


func change_output_state(value):
	if value > number:
		print(value)
	number += value
	return value


func get_changed_number():
	return number

func get_output_number():
	return number
	
func get_input_number():
	return number


func apply_state():
	active = true
	for s in input_conditional_states:
		s.trigger()
	if active:
		trigger()
	else:
		number = 0

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
