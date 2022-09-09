extends RigidBody2D

export var scaleX = 1.0;
export var scaleY = 1.0;

func _ready():
	mass = scaleX * scaleY;
	$CollisionShape2D.scale.x = scaleX;
	$CollisionShape2D.scale.y = scaleY;
