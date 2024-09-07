@tool
class_name PipeGenerator extends Node3D

const pi2 : float = (2 * PI)
@export var update : bool = false
@export var radius : float = 1.0
@export var quality : int = 3
@onready var mesh_instance_3d: MeshInstance3D = $MeshInstance3D
var endcap_index_offset = quality + 1


func _process(_delta: float) -> void:
	if update:
		endcap_index_offset = quality + 1
		generate_pipe()
		update = false


func generate_pipe() -> void:
	generate_pipe_section(Vector3(0,1,0), Vector3(0,1,0), Vector3(0,1,0))
	
		
func generate_pipe_section(end_point:Vector3, start_normal:Vector3, end_normal:Vector3) -> void:
	# Various variables required to generate the mesh
	var array_mesh : ArrayMesh = ArrayMesh.new()
	var vertices : PackedVector3Array = []
	var indices : PackedInt32Array = []
	var mesh_arrays = []
	mesh_arrays.resize(Mesh.ARRAY_MAX)
	mesh_arrays[Mesh.ARRAY_VERTEX] = vertices
	mesh_arrays[Mesh.ARRAY_INDEX] = indices
	# Figure out the vertices and indices
	generate_pipe_section_start_cap(start_normal, vertices, indices)
	generate_pipe_section_end_cap(end_point, end_normal, vertices, indices)
	connect_pipe_section_caps(indices)
	# Generate the Mesh
	array_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, mesh_arrays)
	mesh_instance_3d.mesh = array_mesh
	
func generate_pipe_section_start_cap(cap_normal:Vector3, vertices:PackedVector3Array, indices:PackedInt32Array) -> void:
	# TODO: Add support for the normal
	# Create the vertices
	for i in range(quality + 1):
		if i == 0:
			vertices.append(Vector3(0, 0, 0))
		else:
			var angle : float = pi2 - ((pi2 / quality) * i)
			var x : float = cos(angle) * radius
			var z : float = sin(angle) * radius
			var y : float = 0
			var vertex := Vector3(x, y, z)
			vertices.append(vertex)
	# Create the indices
	for i in range(1, quality+1 ):
		indices.append(0)
		indices.append(i)
		if i < quality:
			indices.append(i+1)
		else:
			indices.append(1)
		
func generate_pipe_section_end_cap(end_point:Vector3, cap_normal:Vector3, vertices:PackedVector3Array, indices:PackedInt32Array) -> void:
	# TODO: Add support for the normal
	# Create the vertices
	for i in range(quality + 1):
		if i == 0:
			vertices.append(end_point)
		else:
			var angle : float = pi2 - ((pi2 / quality) * i)
			var x : float = cos(angle) * radius
			var z : float = sin(angle) * radius
			var y : float = 0
			var vertex := Vector3(x, y, z) + end_point
			vertices.append(vertex)
	# Create the indices
	for i in range(1, quality + 1 ):
		indices.append(0 + endcap_index_offset)
		if i < quality:
			indices.append(i + 1 + endcap_index_offset)
		else:
			indices.append(1 + endcap_index_offset)
		indices.append(i + endcap_index_offset)
		
func connect_pipe_section_caps(indices:PackedInt32Array) -> void:
	for i in range(1, quality + 1):
		if i < quality:
			# Lower triangle
			indices.append(i)
			indices.append(i + endcap_index_offset)
			indices.append(i + 1)
			# Upper triangle
			indices.append(i + endcap_index_offset)
			indices.append(i + 1 + endcap_index_offset)
			indices.append(i + 1)
		else:
			# Lower triangle
			indices.append(i)
			indices.append(i + endcap_index_offset)
			indices.append(1)
			# Upper triangle
			indices.append(i + endcap_index_offset)
			indices.append(1 + endcap_index_offset)
			indices.append(1)
