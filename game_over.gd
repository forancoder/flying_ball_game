extends CanvasLayer

signal restart 
func _process(delta: float) -> void:
	if Input.is_anything_pressed():
		print("segnale emesso")
		emit_signal("restart")
