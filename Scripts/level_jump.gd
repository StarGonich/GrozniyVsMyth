extends Node2D

var static_platform = preload("res://Scenes/Static_platform.tscn")
var destroy_platform = preload("res://Scenes/destroy_platform.tscn")
var move_platform = preload("res://Scenes/move_platform_node.tscn")
var rockTSCN = preload("res://Scenes/rock.tscn")
var palka = preload("res://Scenes/plaka.tscn")

var spawn = false

var first_point = -500
var second_point = -8500
var end_point = -10000

var point

var max_height = 1000:
	set(value):
		max_height = value
		if point != end_point:
			if max_height < 0 and max_height < point and not spawn:
				var p = palka.instantiate()
				get_tree().root.add_child(p)
				platforms.append(p)
				p.position.y = max_height - 200
				p.position.x = 572
				spawn = true
		else:
			if max_height < 0 and max_height < point: 
				await get_tree().create_timer(1.0).timeout
				get_tree().change_scene_to_file("res://Scenes/End_scene.tscn")

var last_spawn = 10
var last_coordx = 400

var mda = false
var speedArea = 150
var platforms = []
var clear = false

func _ready() -> void:
	$AudioStreamPlayer2D.play()
	match GlobalScene.cur_point:
		1: 
			point = first_point
			GlobalScene.cur_level = 1
		2:
			point = second_point
			GlobalScene.cur_level = 3
		3:
			point = end_point
			GlobalScene.cur_level = 5
	await get_tree().create_timer(5.0).timeout
	mda = true
	spawn_rock()

func _process(delta: float) -> void:
	max_height = min($Groznyi.position.y - 400, max_height)
	var new_last_spawn = int(max_height / 100)
	if new_last_spawn < last_spawn:
		spawn_platform(new_last_spawn)
		spawn_platform(new_last_spawn)
		last_spawn = new_last_spawn
	$Granizi/CollisionShape2D.position.y = $Groznyi.position.y
	$Granizi/CollisionShape2D2.position.y = $Groznyi.position.y

func _on_spawn_rock_timeout() -> void:
	spawn_rock()

func spawn_rock():
	var rock = rockTSCN.instantiate()
	get_tree().root.add_child(rock)
	platforms.append(rock)
	rock.position.x = $Groznyi.position.x
	rock.position.y = max_height - 300
	$SpawnRock.start()
	
			
func _physics_process(delta: float) -> void:
	if $Groznyi.death_rock_or_fire:
		get_tree().paused = true 
		$CanvasLayer/LoseMenu.visible = true
	if mda:
		$DeathArea.position.y -= speedArea*delta

func spawn_platform(height):
	var platform
	randomize()
	var randPlatform = randi()%8
	match randPlatform:
		0, 3, 5, 7: 
			platform = static_platform.instantiate()
			get_tree().root.add_child(platform)
		2, 4:
			platform = move_platform.instantiate()
			get_tree().root.add_child(platform)
		1, 6:
			platform = destroy_platform.instantiate()
			get_tree().root.add_child(platform)
	platforms.append(platform)
	var randxScale: float = randi()%3+1
	platform.scale.x = randxScale/3
	randomize()
	var xcoord = randi()%5 
	if last_coordx + xcoord*100 > 1152 or last_coordx + xcoord*100 < 0:
		xcoord = -xcoord
	platform.position.x = last_coordx + xcoord*100
	last_coordx = platform.position.x
	platform.position.y = height*150 - randi()%5*50
	
func _on_groznyi_clear_platform() -> void:
	for platform in platforms:
		get_tree().root.call_deferred("remove_child", platform)
