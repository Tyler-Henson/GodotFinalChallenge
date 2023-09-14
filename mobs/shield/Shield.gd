extends Mob


onready var _cannon := $Cannon
onready var RayCastLOS := $RayCast2D


func _physics_process(delta: float) -> void:
	
	if not _target:
		return
	if not in_line_of_sight():
		return
	
	_cannon.look_at(_target.position)
	if _target_within_range:
		orbit_target()
		_prepare_to_attack()
	else:
		follow(_target.global_position)
		


func _prepare_to_attack() -> void:
	if not is_ready_to_attack():
		return
	_before_attack_timer.start()

func _on_BeforeAttackTimer_timeout() -> void:
	if not _target:
		return
	
	_cannon.shoot_at_target(_target)
	_cooldown_timer.start()


# causes the shield to follow the player forever
func _on_DetectionArea_body_exited(_body: Robot) -> void:
	return	


func in_line_of_sight():
	RayCastLOS.look_at(_target.global_position)
	RayCastLOS.force_raycast_update()
	
	if RayCastLOS.get_collider() is KinematicBody2D:
		return true
	else:
		_target = null
		_sprite_alert.visible = false
		return false



