extends "res://mobs/Cannon.gd"

var shots = [deg2rad(-15), 0, deg2rad(15)]


func shoot_at_target(target: Node2D) -> void:
	for shot in shots:
		look_at(target.global_position)
		var bullet: Bullet = BulletScene.instance()
		bullet.global_transform = _position_2d.global_transform
		bullet.max_range = max_range
		bullet.speed = bullet_speed
		bullet.collision_mask = collision_mask
		# We exported the angle in degrees because it's easier to edit in the
		# inspector, but the randomize_rotation() function needs the angle in
		# radians, so we convert the angles with deg2rad().
		#		bullet.randomize_rotation(deg2rad(random_angle_degrees))
		bullet.rotate(shot)
		get_tree().root.add_child(bullet)
