extends Node

func save_data(data, path):
	var json_str = JSON.print(data, "\t");
	var file = File.new();
	file.open(path, File.WRITE);
	file.store_line(json_str);
	file.close();

func load_data(path) -> Dictionary:
	var file = File.new();
	file.open(path, File.READ);
	var json_str = file.get_as_text();
	var data = {};
	data = parse_json(json_str);
	file.close();
	return data;
