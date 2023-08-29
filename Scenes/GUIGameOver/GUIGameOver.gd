extends CanvasLayer

signal press_return

func _on_button_pressed():
	press_return.emit()
