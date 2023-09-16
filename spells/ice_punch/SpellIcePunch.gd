class_name SpellIcePunch
extends Spell


var shots = [deg2rad(-20), 0, deg2rad(20)]


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("shoot") and _cooldown_timer.is_stopped():
		shoot()


func shoot() -> void:
	_cooldown_timer.start()
	for shot in shots:
		var bullet: Bullet = bullet_scene.instance()
		get_tree().root.add_child(bullet)
		bullet.global_transform = global_transform
		bullet.max_range = max_range
		bullet.speed = max_bullet_speed
		bullet.rotation += shot
	_audio.play()
