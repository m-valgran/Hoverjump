extends Node2D

const obstacle_scene = preload("res://Scenes/Obstacle/Obstacle.tscn")
const gui_game_over_scene = preload("res://Scenes/GUIGameOver/GUIGameOver.tscn")
var can_spawn_obstacle = true
var gui_game_over

func _ready():
	$Player.dead.connect(draw_game_over)

func _process(_delta):
	spawn_obstacle()
	destroy_obstacle()
	draw_score()

func draw_game_over():
	var gui_game_over_instance = gui_game_over_scene.instantiate()
	$GUI.add_child(gui_game_over_instance)

func draw_score():
	$GUI/Label.text = str(10000000 + $Player.score).substr(1)

func spawn_obstacle():
	var x_pos = randi_range(500,1000)
	if can_spawn_obstacle:
		var obstacle_instance = obstacle_scene.instantiate()
		obstacle_instance.position = Vector2($Player.position.x + x_pos, 
		$Player.initial_y_pos + 4)
		self.add_child(obstacle_instance)
		can_spawn_obstacle = false
		
func destroy_obstacle():
	if $Obstacle and $Obstacle.position.x < $Player.position.x-400:
		$Obstacle.queue_free()
		can_spawn_obstacle = true
