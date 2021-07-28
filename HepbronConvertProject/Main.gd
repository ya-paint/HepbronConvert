extends Node2D




func _on_LineEdit_text_changed(new_text):
	
	var hepbron_convert = HepbronConvert.new()
	var hepbrons = hepbron_convert.JpnToHebprns( new_text )
	
	get_node("HepbronOutput").text = ""
	for hepbron in hepbrons :
		get_node("HepbronOutput").text += hepbron + "\n"
	
	pass # Replace with function body.
