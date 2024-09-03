extends Node3D

var door_speed : float = 0.01
var door_closing : bool = false
var door_max_open_position : float = 0.73
var door_closed_position : float = 0.25
@onready var right_door: CSGBox3D = $Door/RightDoor
@onready var left_door: CSGBox3D = $Door/LeftDoor


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var new_door_location : float = 0.0
	var current_door_location : float = left_door.transform.origin.x
	if ( current_door_location >= door_max_open_position and not door_closing ):
		new_door_location = door_max_open_position
		door_closing = true
	elif ( current_door_location <= door_closed_position and door_closing ):
		new_door_location = door_closed_position
		door_closing = false
	elif door_closing:
		new_door_location = current_door_location - door_speed
	else:
		new_door_location = current_door_location + door_speed
	left_door.transform.origin.x = new_door_location
	right_door.transform.origin.x = -new_door_location
		
	
