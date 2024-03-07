extends Node2D


@export var caption: String = ""
@export var caption_pos: Vector2

@export var actions: int = 1
@export var activation_mode: int = 0
@export var pull_mode: int = 0
@export var color: int = 0
@export var thickness: int = 2


var radius = 20

func _ready():
	set_caption(caption)


func to_select(pos):
	if abs(pos.x - position.x) <= radius and abs(pos.y - position.y) <= radius:
		return true
	return false
	
func set_caption(value = ""):
	#if not value: return
	$Caption.text = value
	caption = value
	
func get_base_dict():
	var dict = {}
	dict.name = name
	dict.caption = caption
	dict.caption_pos = caption_pos
	dict.actions = actions
	dict.activation_mode = activation_mode
	dict.pull_mode = pull_mode
	dict.color = color
	dict.thickness = thickness
	dict.x = position.x
	dict.y = position.y
	return dict