extends Timer


func pause():
	set_process(false)


func resume():
	set_process(true)
	