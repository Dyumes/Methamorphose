extends Node2D
@onready var character = %Character
@onready var dialog_ui = %DialogUI

const dialog_lines: Array[String] = [
	"Mage Alaric: I've delved into ancient scrolls and dusty grimoires, yet today fate leads me to a relic of rebellion.",
	"Glimpo: Uh, welcome to my dump of dodgy magical junk. I ain't got much that works like it should.",
	"Mage Alaric: In my pursuit of raw, untamed power, I request the Enregistered Magic Wand!",
	"Glimpo: The Enregistered Magic Wand, huh? That one's rare as it is unpredictable—might spark wonders or wreak havoc.",
	"Mage Alaric: I risk it all, even if its magic comes with a curse. My experiments demand something beyond the ordinary.",
	"Glimpo: Alright... take it. But don't come cryin' when it blows up more than just your pride."
]

func _ready() :
	process_line(parse_line(dialog_lines[0]))
	
func _process(delta: float) :
	pass


func process_line(line_info:Dictionary):
	dialog_ui.speaker_name.text = line_info["speaker_name"]
	dialog_ui.dialog_line.text= line_info["dialog_line"]
	
func parse_line(line:String):
	var line_info = line.split(":")
	assert(len(line_info)>=2)
	print("I m here")
	return {
		"speaker_name": line_info[0],
		"dialog_lines": line_info[1]
	}
