extends Node
var webserver = "https://tle-2-receipt-scan-webservice.onrender.com/"
var update_delay_tick = 1; #tick of 10 seconds
var current_delay_tick = 0;
var can_update_now = false;
func _process(delta):
    if update_delay_tick > current_delay_tick:
        current_delay_tick+=delta
        can_update_now = false
    else:
        can_update_now = true
        current_delay_tick = 0
    