extends YSort

onready var spawner := $Mobs/SpawnerMob

onready var spawner_teleport := $Mobs/SpawnerTeleporter



func _ready() -> void:
	spawner.spawn()
	#spawner_teleport.spawn()










