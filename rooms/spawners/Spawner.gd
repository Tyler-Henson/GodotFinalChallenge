class_name Spawner
extends Sprite


export(Array, PackedScene) var list := []

export (int, 0, 100, 1) var spawning_chance := 50


func _ready() -> void:
	texture = null


func spawn():
	if not list:
		return
	
	randomize()
	#check if anything needs to be spawned
	if randi() % 101 > spawning_chance:
		return
		
	var random_scene_index := randi() % list.size()
	var scene: PackedScene = list[random_scene_index]
	
	if not scene:
		return
	var node: Node2D = scene.instance()

	get_parent().add_child(node)
	node.global_position = global_position


















