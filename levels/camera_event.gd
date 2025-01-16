extends Camera2D
class_name CameraEvent

const LEFT_SCREEN = 640

signal camera_shake(intensity : float)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("down"):
		pass

#TODO: OCULTAR TODO LO QUE NO ESTE EN CAMARA
