extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	assert($Label is Label, "Invalid version label")
	var name=ProjectSettings.get_setting("application/config/name")
	var version=ProjectSettings.get_setting("application/config/version")
	assert(name!=null and version!=null, "Invalid application/config/version or name")
	$Label.text=name+" "+version
	print(name+" "+version)
