extends Node2D

var util = load("res://Util.gd").new();

export var winPoints = 0;
export var pointsMultiplier : float = 1;
export var blockScale = 1;

#Set this in the editor to the level number. i.e. Level1 = 1
#This is used to unlock the next level after winning.
export var levelID = 0;

var levelPaths = ["Level1.tscn", "Level2.tscn", "Level3.tscn", "Level4.tscn", "Level5.tscn", 
				  "Level6.tscn", "Level7.tscn", "Level8.tscn", "Level9.tscn", "Level10.tscn"];
var pressed = false;
var clickPos = null;
var releasePos = null;
var ball = preload("res://Ball.tscn")
var newBall;
var points = 0;

const Cube = preload("res://Cube.gd");
onready var cube = Cube.new();

# Called when the node enters the scene tree for the first time.
func _ready():
	$UI/HBoxContainer2/PointsLabel.text = "POINTS: 0/" + str(winPoints);
	$UI/HBoxContainer2/LevelLabel.text = "LEVEL: " + str(levelID) + "/10";
	$UI/HBoxContainer/MenuButton.connect("pressed", self, "_on_MenuButton_pressed");
	$UI/HBoxContainer/RestartButton.connect("pressed", self, "_on_RestartButton_pressed");
	$UI/HBoxContainer/NextButton.connect("pressed", self, "_on_NextButton_pressed");
	
func _unhandled_input(event):
	if(event is InputEventMouseButton):
		if(event.button_index == BUTTON_LEFT and not event.pressed):
			releasePos = event.position;
			if(clickPos):
				
				#ball's size is locked when the player releases it.
				newBall.growing = false;
				
				#Ball becomes physics enabled upon being released.
				newBall.set_collision_mask(1);
				newBall.set_collision_layer(1);
				
				var shootVector : Vector2 = clickPos - releasePos;
				shootVector = shootVector.clamped(300);
				shootVector *= newBall.mass * 20;
				
				newBall.apply_central_impulse(shootVector);
				clickPos = null;
				
				points -= round(newBall.mass*2);
				$UI/HBoxContainer2/PointsLabel.text = "POINTS: " + str(points) + "/" + str(winPoints);


func _on_DespawnArea_body_exited(body):
	if(body.is_in_group("blocks")):
		var tempPoints = body.scaleX * body.scaleY * pointsMultiplier;
		if(body.type == Cube.CubeType.GREEN):
			points += tempPoints;
		elif(body.type == Cube.CubeType.RED):
			points -= tempPoints;
	body.queue_free();
	$UI/HBoxContainer2/PointsLabel.text = "POINTS: " + str(points) + "/" + str(winPoints);
	if(points >= winPoints):
		$UI/HBoxContainer/NextButton.disabled = false;
		$UI/HBoxContainer/NextButton.text = "NEXT >>";
	else:
		$UI/HBoxContainer/NextButton.disabled = true;
		$UI/HBoxContainer/NextButton.text = "";
	


func _on_BallSpawnArea_input_event(viewport, event, shape_idx):
	if(not event is InputEventMouseButton):
		return;
		
	if(event.button_index == BUTTON_LEFT and event.pressed):
		clickPos = event.position;
		newBall = ball.instance();
		newBall.position = event.position;
		add_child(newBall);


func _on_RestartButton_pressed():
	get_tree().reload_current_scene();

func _on_NextButton_pressed():
	
	#update unlocked levels
	if(levelID < 10):
		var data = util.load_data("res://data.json");
		data["levels"][str(levelID+1)]["unlocked"] = true;
		util.save_data(data, "res://data.json");
	
	if(levelID < 10):
		get_tree().change_scene("res://Levels/" + levelPaths[levelID]);
	else:
		get_tree().change_scene("res://Levels/" + levelPaths[0]);
	
func _on_MenuButton_pressed():
	get_tree().reload_current_scene();
