extends "res://mobs/Cannon.gd"

onready var default_shot_position = $Position2D

var shots = [
	0, deg2rad(45), deg2rad(90), deg2rad(135),
	 deg2rad(180), deg2rad(225), deg2rad(270),deg2rad(315)
]


func shoot_at_target(target: Node2D) -> void:
	for shot in shots:
		look_at(default_shot_position.global_position)
		var bullet: Bullet = BulletScene.instance()
		bullet.global_transform = self.global_transform
		bullet.max_range = max_range
		bullet.speed = bullet_speed
		bullet.collision_mask = collision_mask
		# We exported the angle in degrees because it's easier to edit in the
		# inspector, but the randomize_rotation() function needs the angle in
		# radians, so we convert the angles with deg2rad().
		#		bullet.randomize_rotation(deg2rad(random_angle_degrees))
		bullet.rotate(shot)
		get_tree().root.add_child(bullet)
