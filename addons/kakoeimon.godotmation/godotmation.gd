@tool
extends Node

@export var version: float = 0.1
@export var author: String = ""
@export var time_mode: int = 0
@export var interval: float = 1.0
@export var actions: int = 0
@export var distribution_mode: int = 0
@export var color_coding: int = 0
@export var dice: String = "D6"
@export var skill: String = ""
@export var multiplayer_skill: String = ""
@export var strategy: String = ""


@export var height: int = 800
@export var width: int = 600
@export var number_of_runs: int = 100
@export var visible_runs: int = 100
@export var speed: int = 1
@export var autostart: bool = true

var nodes = [] #All the nodes, no connections. This is for state change
var interactive_nodes = []
var automatic_nodes = []
var on_start_nodes = []

var resources = []
var states = []

var ticks = 0 #This is to count the ticks for the interval resources and more...

var reverse_order = false


func _ready():
	if not Engine.is_editor_hint():
		setup()
		if autostart:
			_start()

func setup():
	var parent = get_parent()
	for node in get_children():
		if node.type >=2:
			nodes.append(node)
			if node.activation_mode == 1:
				interactive_nodes.append(node)
			elif node.activation_mode == 2:
				automatic_nodes.append(node)
			elif node.activation_mode == 3:
				on_start_nodes.append(node)
		elif node.type == 0:
			resources.append(node)
		elif node.type == 1:
			states.append(node)
			

	for r in resources:
		r.convert_label()
		var start = get_child(r.start)
		start.output_resources.append(r)
		r.start_node = start
		var end = get_child(r.end)
		end.input_resources.append(r)
		r.end_node = end
		
	for s in states:
		s.convert_label()
		var start = get_child(s.start)
		var end = get_child(s.end)
		s.start_node = start
		s.end_node = end
		
		if s.state_type >=9:
			if s.state_type == 9:
				start.trigger_states.append(s)
			if s.state_type == 10:
				start.reverse_trigger_states.append(s)
		elif s.state_type >=4:
			end.input_conditional_states.append(s)
		else:
			start.output_states.append(s)
			end.input_states.append(s)
	#setup delay and queue
	for n in get_children():
		if n.type == 7:
			if n.output_resources and n.output_resources.size():
				for i in range(n.output_resources[0].get_number()):
					n.resources_line.append(0)
					n.number = 0
	
	if automatic_nodes.size(): #This is here cause I cannot set it in the edittor
		var t = Timer.new()
		t.name = "Timer"
		add_child(t)
		t.wait_time = interval
		t.connect("timeout", Callable(self, "_interval_timeout"))
	print("godotmation setup end")
	
	
func _start():
	if has_node("Timer"):
		get_node("Timer").start()
	for n in nodes:
		n.apply_state()
	for r in resources:
		r.apply_state()
	for s in states:
		s.apply_state()
	for node in on_start_nodes:
		node.trigger()
	_interval_timeout()


func _interval_timeout():
	ticks +=1
	if reverse_order:
		for i in range(automatic_nodes.size() - 1, -1, -1):
			automatic_nodes[i].trigger()
		reverse_order = false
	else:
		for n in automatic_nodes:
			n.trigger()
		reverse_order = true
	
	for n in nodes:
		if n.pushed:
			n.apply_satisfaction()
		
	for n in nodes:
		n.apply_state()
		
	for r in resources:
		r.apply_state()
		
	for s in states:
		s.apply_state()
		

func _clear():
	for c in get_children():
		c.free()

func get_dict():
	var dict = {}
	dict.name = name
	dict.version = version
	dict.author = author
	dict.time_mode = time_mode
	dict.interval = interval
	dict.actions = actions
	dict.distribution_mode = distribution_mode
	dict.color_coding = color_coding
	dict.dice = dice
	dict.skill = skill
	dict.multiplayer = multiplayer_skill
	dict.strategy = strategy
	dict.height = height
	dict.width = width
	dict.number_of_runs = number_of_runs
	dict.visible_runs = visible_runs
	dict.speed = speed
	dict.autostart = autostart
	
	dict.nodes = []
	
	for c in get_children():
		if not c is Timer:
			dict.nodes.append(c.get_dict())
	
	return dict
