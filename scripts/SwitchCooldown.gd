extends Timer


@onready var ship_off = $ShipOff
@onready var ship_on = $ShipOn


func _enter_tree():
	Singleton.switch_cooldown = self
