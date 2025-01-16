extends CanvasLayer

signal display_message_signal(message_type)

@onready var timer = $Timer
@onready var melody = $AudioStreamPlayer
@onready var anim = $AnimationPlayer
@onready var message_label = $Area/Panel/Message

func _ready():
	self.visible = false
	pass#emit_display_message_signal(message_turn)

func emit_display_message_signal(message: String):
	emit_signal("display_message_signal", message)

func _on_display_message_signal(message_type):
	get_tree().paused = true
	self.visible = true
	anim.play("sweep")
	timer.start()
	melody.play()
	message_label.text = message_type

func _on_timer_timeout():
	get_tree().paused = false
	self.visible = false
