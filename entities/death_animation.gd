extends AnimatedSprite2D

func _on_audio_stream_player_finished():
	queue_free()
