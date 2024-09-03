extends Node

@export var scenes : Dictionary = {}
var current_scene_name : String = ""


func _ready() -> void:
	# Figure out what is the main scene and update the current_scene_name to match
	var main_scene : String = ProjectSettings.get_setting("application/run/main_scene")
	current_scene_name = scenes.find_key(main_scene)


func add_scene(scene_name : String, scene_path : String) -> void:
	scenes[scene_name] = scene_path
	

func remove_scene(scene_name : String) -> void:
	scenes.erase(scene_name)


func switch_to_scene(scene_name : String) -> void:
	var current_scene = get_tree().current_scene
	var next_scene = load(scenes[scene_name]).instantiate()
	current_scene.queue_free()
	get_tree().root.call_deferred("add_child", next_scene)
	get_tree().set_deferred("current_scene", next_scene)


func restart_scene() -> void :
	get_tree().reload_current_scene()
	

func quit_game() -> void:
	get_tree().quit()
