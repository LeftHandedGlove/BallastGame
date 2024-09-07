class_name SubBuilder extends Node3D


func _ready() -> void:
	for x in range(1):
		for z in range(1):
			var scene : PackedScene = load("res://sub_builder/storage_room.tscn")
			var instance : Node3D = scene.instantiate()
			instance.transform.origin.x = x * 2.5
			instance.transform.origin.z = z * 2.5
			add_child(instance)


func place_first_door() -> void:
	pass
