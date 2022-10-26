extends Control

var util = load("res://Util.gd").new();

func _ready():
	var data = util.load_data("res://data.json");
	
	if(data["levels"]["1"]["unlocked"]):
		$VBoxContainer/GridContainer/Button.disabled = false;
	if(data["levels"]["2"]["unlocked"]):
		$VBoxContainer/GridContainer/Button2.disabled = false;
	if(data["levels"]["3"]["unlocked"]):
		$VBoxContainer/GridContainer/Button3.disabled = false;
	if(data["levels"]["4"]["unlocked"]):
		$VBoxContainer/GridContainer/Button4.disabled = false;
	if(data["levels"]["5"]["unlocked"]):
		$VBoxContainer/GridContainer/Button5.disabled = false;
	if(data["levels"]["6"]["unlocked"]):
		$VBoxContainer/GridContainer/Button6.disabled = false;
	if(data["levels"]["7"]["unlocked"]):
		$VBoxContainer/GridContainer/Button7.disabled = false;
	if(data["levels"]["8"]["unlocked"]):
		$VBoxContainer/GridContainer/Button8.disabled = false;
	if(data["levels"]["9"]["unlocked"]):
		$VBoxContainer/GridContainer/Button9.disabled = false;
	if(data["levels"]["10"]["unlocked"]):
		$VBoxContainer/GridContainer/Button10.disabled = false;
