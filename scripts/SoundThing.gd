class_name AudioThing extends Node


@onready var bump = $Bump
@onready var crash = $Crash
@onready var item_gathered = $ItemGathered
@onready var break_sound = $Break


func _enter_tree():
	Singleton.audio_thing = self
