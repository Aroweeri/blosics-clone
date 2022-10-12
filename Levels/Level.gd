extends Node2D

export var winPoints = 0;
export var pointsMultiplier : float = 1;
export var blockScale = 1;

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
	$CanvasLayer/HBoxContainer2/PointsLabel.text = "Points: 0/" + str(winPoints);
	
func _unhandled_input(event):
	if(event is InputEventMouseButton):
		if(event.button_index == BUTTON_LEFT and not event.pressed):
			releasePos = event.position;
			if(clickPos):
				newBall.growing = false;
				var shootVector : Vector2 = clickPos - releasePos;
				shootVector = shootVector.clamped(300);
				shootVector *= newBall.mass * 20;
				
				newBall.apply_central_impulse(shootVector);
				clickPos = null;
				
				points -= round(newBall.mass);
				$CanvasLayer/HBoxContainer2/PointsLabel.text = "Points: " + str(points) + "/" + str(winPoints);


func _on_DespawnArea_body_exited(body):
	if(body.is_in_group("blocks")):
		var tempPoints = body.scaleX * body.scaleY * pointsMultiplier;
		if(body.type == Cube.CubeType.GREEN):
			points += tempPoints;
		elif(body.type == Cube.CubeType.RED):
			points -= tempPoints;
		else: #white block
			pass;
	body.queue_free();
	$CanvasLayer/HBoxContainer2/PointsLabel.text = "Points: " + str(points) + "/" + str(winPoints);
	if(points >= winPoints):
		$CanvasLayer/HBoxContainer/NextButton.disabled = false;
	else:
		$CanvasLayer/HBoxContainer/NextButton.disabled = true;
	


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
	get_tree().reload_current_scene();
