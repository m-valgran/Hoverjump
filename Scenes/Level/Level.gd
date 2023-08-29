extends Node2D

const obstacle_scene = preload("res://Scenes/Obstacle/Obstacle.tscn")
const gui_game_over_scene = preload("res://Scenes/GUIGameOver/GUIGameOver.tscn")
var can_spawn_obstacle = true
var obstacle
var player
var gui_game_over

func _ready():
	player = get_node("Player")
	player.score_changed.connect(draw_score)
	player.dead.connect(draw_game_over)

func _process(_delta):
	spawn_obstacle()
	destroy_obstacle()

func draw_game_over():
	var gui_game_over_instance = gui_game_over_scene.instantiate()
	self.add_child(gui_game_over_instance)
	get_node("GUIGameOver").press_return.connect(return_to_menu)

func draw_score(score):
	$GUI/Label.text = str(10000000 + score).substr(1)

func spawn_obstacle():
	var x_pos = randi_range(500,1000)
	if can_spawn_obstacle:
		var obstacle_instance = obstacle_scene.instantiate()
		obstacle_instance.position = Vector2(player.position.x + x_pos, player.initial_y_pos+3)
		self.add_child(obstacle_instance)
		obstacle = get_node("Obstacle")
		can_spawn_obstacle = false
		
func destroy_obstacle():
	if obstacle and obstacle.position.x < player.position.x-400:
		obstacle.queue_free()
		can_spawn_obstacle = true

func return_to_menu():
	get_tree().change_scene_to_file("res://Scenes/Menu/Menu.tscn")
