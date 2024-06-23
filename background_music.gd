extends AudioStreamPlayer2D


func _ready():
    # Play only if not already playing
	if not playing:
		play()
		print("BackgroundMusic started playing")
	else:
		set_stream_paused(false)  # Ensure it is not paused if already playing
		print("BackgroundMusic is already playing")