extends Node2D

var pressed = false;
var clickPos = null;
var releasePos = null;
var ball = preload("res://Ball.tscn")
var newBall;


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
	
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


func _on_DespawnArea_body_exited(body):
	body.queue_free();


func _on_BallSpawnArea_input_event(viewport, event, shape_idx):
	if(not event is InputEventMouseButton):
		return;
		
	if(event.button_index == BUTTON_LEFT and event.pressed):
		clickPos = event.position;
		newBall = ball.instance();
		newBall.position = event.position;
		add_child(newBall);
