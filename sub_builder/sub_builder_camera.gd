class_name SubBuilderCamera extends Area3D

@export var radius : float = 20.0
@export var zoom_speed : float = 0.05
@export var zoom_speed_distance_factor : float = 2
@export var mouse_angle_speed : float = 0.005
@export var button_angle_speed : float = 0.05
@export var vertical_angle_clamp : float = 1.5
@export var focus : Vector3 = Vector3(0, 0, 0)
@export var xy_angle : float = deg_to_rad(-30.0)
@export var xz_angle : float = deg_to_rad(30.0)

var mouse_position_pre_rotation : Vector2


@onready var neck: Node3D = $Neck
@onready var head: Node3D = $Neck/Head
@onready var camera_3d: Camera3D = $Neck/Head/Camera3D


func _ready() -> void:
	self.transform.origin = Vector3(radius, 0, 0)
	camera_3d.look_at(Vector3(0, 0, 0))


func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_pressed("RotateBuilderCamera"):
		Input.set_default_cursor_shape(Input.CURSOR_MOVE)
		if event is InputEventMouseMotion:
			# Handle mouse side to side motion
			xz_angle -= event.relative.x * mouse_angle_speed
			# Handle mouse up and down motion		
			xy_angle -= event.relative.y * mouse_angle_speed
			
	else:
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)


func _input(event: InputEvent) -> void:
	# Handle zoom
	if event.is_action("Zoom In") or event.is_action("Zoom Out"):
		if Input.is_action_just_released("Zoom In"):
			radius -= ( zoom_speed * ( radius * zoom_speed_distance_factor ) )
		if Input.is_action_just_released("Zoom Out"):
			radius += ( zoom_speed * ( radius * zoom_speed_distance_factor ) )


func _physics_process(_delta: float) -> void:
	# Handle button side to side motion
	if Input.is_action_pressed("Strafe Left"):
		xz_angle -= button_angle_speed
	if Input.is_action_pressed("Strafe Right"):
		xz_angle += button_angle_speed
	# Handle button up and down motion
	if Input.is_action_pressed("Forward"):
		xy_angle -= button_angle_speed
	if Input.is_action_pressed("Backward"):
		xy_angle += button_angle_speed
	update_camera_position()


func update_camera_position() -> void:
	# Clamp things
	if xz_angle > (2 * PI):
		xz_angle -= (2 * PI)
	elif xz_angle < 0:
		xz_angle += (2 * PI)
	xy_angle = clampf(xy_angle, -vertical_angle_clamp, vertical_angle_clamp)
	# Calculate new position
	var x : float = (radius * sin(xz_angle) * cos(xy_angle)) + focus.x
	var z : float = (radius * cos(xz_angle) * cos(xy_angle)) + focus.z
	var y : float = (radius * -sin(xy_angle)) + focus.y
	self.transform.origin = Vector3(x, y, z)
	camera_3d.look_at(Vector3(0, 0, 0))
