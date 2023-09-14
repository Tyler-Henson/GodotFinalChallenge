extends Mob
onready var animation_player := $AnimationPlayer
onready var shock_area := $ShockArea
onready var cannon := $BombCannon

var triggered := false


func _ready() -> void:
	shock_area.connect("body_entered", self, "_on_shock_area_body_entered")



func _on_AttackArea_body_entered(body: Robot) -> void:
	if not triggered:
		triggered = true
		_sprite_alert.visible = true
		animation_player.play("will_explode")
		


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "will_explode":
		_disable()
		_die_sound.play()
		animation_player.play("explode")
		cannon.shoot_at_target(self) #using self as dummy variable
	elif anim_name == "explode":
		queue_free()


func _on_shock_area_body_entered(body: Robot):
	body.take_damage(damage)



