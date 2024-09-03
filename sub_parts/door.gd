extends Node3D

@onready var front_collider: Area3D = $FrontCollider
@onready var rear_collider: Area3D = $RearCollider
@onready var animation_player: AnimationPlayer = $AnimationPlayer


var is_door_open : bool = true

func _ready() -> void:
	close_door()


func open_door():
	var should_open_door : bool = ( not is_door_open ) 
	if should_open_door:
		is_door_open = true
		animation_player.play("DoorAnimations/OpenDoor")
	
func close_door():
	var should_close_door : bool = (
		( is_door_open ) and 
		( not front_collider.has_overlapping_bodies() ) and 
		( not rear_collider.has_overlapping_bodies() ))
	if should_close_door:
		is_door_open = false
		animation_player.play("DoorAnimations/CloseDoor")


func _on_front_collider_body_entered(_body: Node3D) -> void:
	open_door()


func _on_rear_collider_body_entered(_body: Node3D) -> void:
	open_door()


func _on_front_collider_body_exited(_body: Node3D) -> void:
	close_door()
	
	
func _on_rear_collider_body_exited(_body: Node3D) -> void:
	close_door()
