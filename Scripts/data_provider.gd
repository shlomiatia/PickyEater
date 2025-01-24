extends Node

var _data: Dictionary

func get_data() -> Dictionary:
    if _data.is_empty():
        load_data()
    return _data

func load_data() -> void:
    var file = FileAccess.open("res://Data/data.json", FileAccess.READ)
    var json = JSON.parse_string(file.get_as_text())
    
    # Convert the array of string data into a dictionary
    _data = {}
    for string_data in json.Strings:
        _data[string_data.Id] = string_data.Text
