extends CanvasLayer

signal display_message_signal(message_type)

var message_turn : String = "Turn " + str(GameEvents.current_turn)
var message_win : String = "You've conquisted a territory!"
var message_escape : String = "Escape Succesful!"
var message_lose : String = "Space Megasex is death!"
var message_fail_conquest : String = "Conquest failed!"
var message_fail_defend : String = "Territory lost!"
var message_cutsom : String

@onready var timer = $Timer
@onready var melody = $AudioStreamPlayer
@onready var anim = $AnimationPlayer
@onready var message_label = $Area/Panel/Message

func _ready():
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
