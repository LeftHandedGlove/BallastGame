class_name RoomTile extends RigidBody3D

@onready var mesh_instance_3d: MeshInstance3D = $MeshInstance3D
@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D


func set_tile_size( size:Vector3 ) -> void:
	# Update the mesh instance
	var box_mesh = BoxMesh.new()
	box_mesh.size = size
	mesh_instance_3d.mesh = box_mesh
	# Update the collision shape
	var box_shape = BoxShape3D.new()
	box_shape.size = size
	collision_shape_3d.shape = box_shape
