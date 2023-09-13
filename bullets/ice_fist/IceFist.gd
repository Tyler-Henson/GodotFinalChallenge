extends Bullet

onready var _animation_player := $AnimationPlayer

var max_acceleration = speed * 2

export (float, 0.0, 1.0, 0.01) var acceleration_rate := 0.5

func _ready() -> void:
	_animation_player.connect("animation_finished", self, "_on_AnimationPlayer_animation_finished")
	_animation_player.play("spawn")


func _destroy():
	_disable()
	_audio.play()
	_animation_player.play("destroy")


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "destroy":
		queue_free()

func _move(delta: float) -> void:
	speed = lerp(speed, max_acceleration, acceleration_rate)
	var distance := speed * delta
	var motion := transform.x * speed * delta

	position += motion

	_travelled_distance += distance
	if _travelled_distance > max_range:
		_destroy()




