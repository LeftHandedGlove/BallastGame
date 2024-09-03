extends CSGTorus3D

var rotateSpeed = 0.0001
var moveSpeed = 0.01
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("Space"):
		rotateSpeed += 0.1
		print( "Hello" )

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.rotate_y( rotateSpeed )
	#if self.transform.origin.x > 50 or self.transform.origin.x < 0:
		#moveSpeed = -moveSpeed
	#self.translate(Vector3(0, moveSpeed, 0))	
	
	
