extends Mob

onready var RayCastLOS := $RayCast2D
onready var sword_sprite := $Sprite
onready var cooldowntimer := $CoolDownTimer
onready var before_attack_timer := $BeforeAttackTimer
onready var attack_timer := $AttackTimer
onready var lunge_timer := $LungeTimer
onready var hurt_area := $Sprite/HurtArea

var idle_rotation_speed := 0.037
var is_attacking := false
var is_lungeing := false
var angle_to_target := 0.0
var direction_to_target := Vector2.ZERO
var attack_on_cooldown := true


func _ready() -> void:
	attack_timer.connect("timeout", self, "_on_AttackTimer_timeout")
	lunge_timer.connect("timeout", self, "_on_LungeTimer_timeout")
	hurt_area.connect("body_entered", self, "_on_HurtArea_body_entered")

func _physics_process(delta: float) -> void:
	if not is_lungeing and not is_attacking:
		spin_sword()
	if is_attacking:
		pass
	elif not _target or not in_line_of_sight():
		return

	if is_lungeing:
		_velocity = direction_to_target * 5
		_velocity = move_and_slide(_velocity, Vector2.ZERO)
	elif is_attacking:
		return
	elif _target_within_range:
		orbit_target()
	else:
		follow(_target.global_position)


func in_line_of_sight():
	RayCastLOS.look_at(_target.global_position)
	RayCastLOS.force_raycast_update()
	
	if RayCastLOS.get_collider() is KinematicBody2D:
		return true
	else:
		#_target = null
		_sprite_alert.visible = false
		return false


func spin_sword():
	_sprite_alert.visible = true
	sword_sprite.rotate(idle_rotation_speed)


# Called when the player is within attack range.
func _on_AttackArea_body_entered(body: Robot) -> void:
	_target_within_range = true
	before_attack_timer.start()


func _on_AttackArea_body_exited(_body: Robot) -> void:
	_target_within_range = false
	before_attack_timer.stop()


#halts the sword and orients it toward the player
#starts next timer
func _on_BeforeAttackTimer_timeout() -> void:
	#sword_sprite.look_at(_target.position)
	direction_to_target = _target.global_position - global_position
	angle_to_target = transform.x.angle_to(direction_to_target)
	sword_sprite.rotation = angle_to_target
	is_attacking = true
	attack_timer.start()


#The the halted sword then lunges at the already set location
#starts lungetimer which will stop the attack
func _on_AttackTimer_timeout():
	is_lungeing = true
	lunge_timer.start()


func _on_LungeTimer_timeout():
	is_lungeing = false
	is_attacking = false
	cooldowntimer.start()
	attack_on_cooldown = false


func _on_CoolDownTimer_timeout() -> void:
	attack_on_cooldown = true
	pass


func _on_DetectionArea_body_exited(_body: Robot) -> void:
	#_target = null
	#_sprite_alert.visible = false
	pass

func _on_HurtArea_body_entered(body: Node):
	if body is Robot:
		body.take_damage(damage)





