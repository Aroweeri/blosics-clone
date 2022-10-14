extends RigidBody2D

var growing = true;
export var growthSpeed = 1;
export var maxSize = 5;
export var massConstant = 0.5;


func _process(delta):
	if(growing):
		$CollisionShape2D.scale.x += growthSpeed * delta;
		$CollisionShape2D.scale.y += growthSpeed * delta;
		mass = massConstant * $CollisionShape2D.scale.x * $CollisionShape2D.scale.x;
		if($CollisionShape2D.scale.x >= maxSize):
			growing = false;
