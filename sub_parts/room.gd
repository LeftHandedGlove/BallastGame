@tool
class_name Room extends Node3D

@export var update : bool = false
@export var dimensions : Vector3i = Vector3i(1, 1, 1)
@export var door_locations : Array

@onready var floor_mesh_instance_3d: MeshInstance3D = $FloorMeshInstance3D


func _ready() -> void:
	# Verify there is at least one door
	if len(door_locations) == 0:
		printerr("A room must have at least one door")
	

func gen_mesh() -> void:
	var a_mesh := ArrayMesh.new()
	var vertices := PackedVector3Array([
		Vector3(0, 0, 0),
		Vector3(1, 0, 0),
		Vector3(1, 0, 1)
	])
	var indices := PackedInt32Array([
		0,1,2
	])
	var array = []
	array.resize(Mesh.ARRAY_MAX)
	array[Mesh.ARRAY_VERTEX] = vertices
	array[Mesh.ARRAY_INDEX] = indices
	a_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, array)
	floor_mesh_instance_3d.mesh = a_mesh
	
func _process(delta: float) -> void:
	if update:
		gen_mesh()
		update = false

func add_ceiling() -> void:
	pass
