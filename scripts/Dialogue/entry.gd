extends Node2D

@onready var character = %Character
@onready var dialog_ui = %DialogUI
@onready var quest_background = %"DialogUI/QuestText/ScrollSprite"
@onready var quest_text: Label = %"DialogUI/QuestText"

var dialog_index:int = 0
var current_quest_item: String = ""

const dialog_lines: Array[String] = [
	"Glimpo: Welcome, all. My shop of cursed and quirky magical items is open—who's in need tonight?",
	
	"Sir Roland: I've been gravely wounded on the battlefield; my very life hangs by a thread.",
	"Sir Roland: I request the Healing Potion!",
	
	"Mage Alaric: Sir Roland, your sorrow echoes, yet I seek a relic to shatter the mundane.",
	"Mage Alaric: I request the Enregistered Magic Wand!",
	
	"Bald Goblin: (muttering) I’m sick of this barren curse—my head’s as empty as my hope.",
	"Bald Goblin: I request the Potion of Capillarity!",
	
	"Octavius: In my many lonely limbs, I ache for a tender touch to break this isolation.",
	"Octavius: I request the Love Potion!",
	
	"Claude: Yo, man, I'm stinkin’ and high; nothing ever changes this endless mess.",
	"Claude: I request the Methamorphosis Crystals!",
	
	"Macaron: The bitter chill of the north gnaws at my soul; I yearn for even a spark of warmth.",
	"Macaron: I request the Perlimpimpin Powder!",
	
	"Kadjit: Every day drags me deeper into despair—I'm drowning in this void.",
	"Kadjit: I request the Poison Potion!",
	
	"Glimpo: Y’all have some heavy wishes tonight. My wares are as unpredictable as fate itself—one minute they heal, the next they hurt.",
	
	"Sir Roland: I pray the Healing Potion will mend my shattered body.",
	"Mage Alaric: And may the Enregistered Magic Wand unleash the hidden powers of my craft.",
	"Bald Goblin: Perhaps a little capillarity will restore what I've long lost.",
	"Octavius: The Love Potion must bring the embrace I so desperately need.",
	"Claude: If the Methamorphosis Crystals can flip my world around, I’m all in.",
	"Macaron: With the Perlimpimpin Powder, I hope to thaw the frost that grips my heart.",
	"Kadjit: And if the Poison Potion offers release, may it finally end this unending torment.",
	
	"Glimpo: Listen up, friends—take your items and tread carefully. In this shop, magic’s a fickle mistress; it might light your way or plunge you into chaos.",
	"Glimpo: Remember, sometimes sharing your burdens can help ease the darkness, even if none of these potions can promise salvation.",
	
	"Sir Roland: May our paths, though steeped in peril, lead us to a glimmer of hope.",
	"Mage Alaric: Let the unpredictable magic guide us toward brighter horizons.",
	"Bald Goblin: I just want to feel something—anything—on this barren head.",
	"Octavius: And I long for a love that heals, not harms.",
	"Claude: Cheers to change, even if it's just a flicker in this endless night.",
	"Macaron: To the uncertain magic that binds us—may it kindle warmth within our hearts.",
	"Kadjit: Even in despair, a spark of life is worth seeking.",
	
	"Glimpo: Then go, my troubled friends. May these enchanted wares be the key to the change you seek—or at the very least, a lesson in the wild unpredictability of magic."

]

func _ready() :
	dialog_index = 0
	quest_background.visible = false
	quest_text.text = "No quest available"
	quest_text.visible = false
	process_current_line()
	
func _process(delta: float) :
	pass
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("next_line"):
		if dialog_index<len(dialog_lines)-1:
			dialog_index+=1
			process_current_line()

func process_current_line():
	var line = dialog_lines[dialog_index]
	var line_info = parse_line(line)
	dialog_ui.change_line(line_info["speaker_name"], line_info["dialog_line"])
	character.change_character(line_info["speaker_name"])
	check_for_quest_item(line_info["dialog_line"])

func parse_line(line:String):
	var line_info = line.split(":")
	assert(len(line_info)>=2)
	return {
		"speaker_name": line_info[0],
		"dialog_line": line_info[1]
	}

func check_for_quest_item(line: String):
	var start_keyword = "request the "
	var end_keyword = "!"
	var start_index = line.find(start_keyword)
	if start_index != -1:
		start_index += start_keyword.length()
		var end_index = line.find(end_keyword, start_index)
		if end_index != -1:
			current_quest_item = line.substr(start_index, end_index - start_index)
			quest_text.text = "Current Quest: " + current_quest_item
			quest_background.visible = true
			quest_text.visible = true
