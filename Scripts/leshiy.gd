extends Mob 

var wind = preload("res://Scenes/wind.tscn")
var shish = preload("res://Scenes/shishimora.tscn")
var mohov = preload("res://Scenes/mohovik.tscn")

var enemys = []

func ready_func():
	dirRightAnim = false
	SPEED = 50
	$Panel/Label.text = "Леший: Лес в тебе разочарован."
	super.ready_func()
	spawnEnemies(self.position.x)

func spawnEnemies(coords):
	var enemy
	randomize()
	var enemiNum = randi()%2 
	match enemiNum:
		0: 
			enemy = shish.instantiate()
			get_tree().root.add_child.call_deferred(enemy)
		1: 
			enemy = mohov.instantiate()
			get_tree().root.add_child.call_deferred(enemy)
	enemys.append(enemy)
	var enemyCoord = 300 + randi()&5 * 50
	if randi()%2 == 1:
		enemyCoord = -enemyCoord
	if coords + enemyCoord > 3000 or coords + enemyCoord < 0:
		enemyCoord = -enemyCoord
	enemy.position.x = coords + enemyCoord
	enemy.position.y = 500
	$SpawnMobs.start()

func spawn_wind():
	var w = wind.instantiate()
	get_tree().root.add_child(w)
	w.position = $DamageBox/HitBox/CollisionShape2D.global_position
	w.scale.x = -1.4*$DamageBox.scale.x
	w.scale.y = 1.4

func attack1_state():
	velocity.x = 0
	animPlayer.play("Attack1")
	await animPlayer.animation_finished
	$Collision/AreaAttack/CollisionAttack.disabled = true
	$Collision/Detector/DetectorCollision.disabled = true
	state = IDLE

func death_state():
	velocity.x = 0
	alive = false
	$Collision/AreaAttack/CollisionAttack.set_deferred("disabled", true)
	$Collision/Detector/DetectorCollision.set_deferred("disabled", true)
	animPlayer.play("Death")
	await animPlayer.animation_finished
	GlobalScene.level_1_complete = true
	queue_free()


func _on_mob_health_no_health():
	if alive:
		state = DEATH

func _on_mob_health_received_damage(direction):
	direction_received_damage = direction
	state = HIT

func _on_spawn_mobs_timeout() -> void:
	spawnEnemies(self.position.x)
