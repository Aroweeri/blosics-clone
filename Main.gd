extends Node2D

var pressed = false;
var clickPos = null;
var ball = preload("res://Ball.tscn")
var newBall;
var clickTime = 0;
var releaseTime = 0;


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
	
func _unhandled_input(event):
	if(event is InputEventMouseButton):
		if(event.button_index == BUTTON_LEFT and not event.pressed):
			if(clickPos):
				releaseTime = OS.get_ticks_msec();
				print(releaseTime);
				newBall.growing = false;
				newBall.apply_central_impulse(Vector2(-1000*newBall.mass,0));
				clickPos = null;


func _on_Area2D_input_event(viewport, event, shape_idx):
	if(not event is InputEventMouseButton):
		return;
		
	if(event.button_index == BUTTON_LEFT and event.pressed):
		clickPos = event.position;
		clickTime = OS.get_ticks_msec();
		print(clickTime);
		newBall = ball.instance();
		newBall.position = event.position;
		add_child(newBall);


func _on_DespawnArea_body_exited(body):
	body.queue_free();
