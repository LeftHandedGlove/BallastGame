class_name Room extends Node3D

@export var update : bool = false
@export var dimensions : Vector3i = Vector3i(1, 1, 1)
@export var wall_thickness : float = 0.1
@export var room_tile : PackedScene


@onready var floor: Node3D = $Floor
@onready var ceiling: Node3D = $Ceiling


func _ready() -> void:
	generate_room()
	

func _process(delta: float) -> void:
	pass


func generate_room() -> void:
	# Iterate over every cube in the room, adding outer tiles when needed
	for x in dimensions.x:
		for y in dimensions.y:
			for z in dimensions.z:
				# If the dimensions are at their extremes then there are walls
				if ( x == 0 ) or ( x == ( dimensions.x - 1 ) ):
					create_tile(x, y, z)
				if ( y == 0 ) or ( y == ( dimensions.y - 1 ) ):
					create_tile(x, y, z)
				if ( z == 0 ) or ( z == ( dimensions.z - 1 ) ):
					create_tile(x, y, z)


func create_tile(x:int, y:int, z:int) -> void:
	var current_tile:RoomTile = room_tile.instantiate()
	add_child(current_tile)
	# Floor Tiles
	if y == 0:
		current_tile.set_tile_size( Vector3( 
			1, 
			wall_thickness, 
			1 
		))
		current_tile.position = Vector3( 
			x + 0.5, 
			wall_thickness / 2, 
			z + 0.5 
		)
	# Ceiling Tiles
	if y == ( dimensions.y - 1 ):
		current_tile.set_tile_size( Vector3( 
			1, 
			wall_thickness, 
			1 
		))
		current_tile.position = Vector3( 
			x + 0.5, 
			dimensions.y + ( wall_thickness / 2 ), 
			z + 0.5 
		)
	# South Wall Tiles
	# North Wall Tiles
	# West Wall Tiles
	# East Wall Tiles
		

func generate_floor() -> void:
	# Remove any old tiles
	for child in floor.get_children(): 
		floor.remove_child(child)
		child.queue_free()
	# Add the new tiles
	for x in range(dimensions.x):
		for z in range(dimensions.z):
			var current_tile:RoomTile = room_tile.instantiate()
			floor.add_child(current_tile)
			current_tile.set_tile_size(Vector3(1, wall_thickness, 1))
			current_tile.position = Vector3(
				x + 0.5, 
				wall_thickness / 2, 
				z + 0.5,
			)


func generate_ceiling() -> void:
	# Remove any old tiles
	for child in ceiling.get_children(): 
		ceiling.remove_child(child)
		child.queue_free()
	# Add the new tiles
	for x in range(dimensions.x):
		for z in range(dimensions.z):
			var current_tile:RoomTile = room_tile.instantiate()
			ceiling.add_child(current_tile)
			current_tile.set_tile_size(Vector3(1, wall_thickness, 1))
			current_tile.position = Vector3(
				x + 0.5, 
				dimensions.y + (wall_thickness / 2), 
				z + 0.5,
			)
