extends CardStack

export var vertical_separation:float = 10.0

func _get_card_coords(index:int) -> Vector2:
	var row_cards=int(index/2)
		
	var x_offset=(row_cards*(Constants.CARD_WIDTH+separation))
	if centered:
		x_offset=x_offset-(_get_max_width()/2)+(Constants.CARD_WIDTH/2)
	
	var row=index%2
	var y_offset=row*(Constants.CARD_HEIGHT+vertical_separation)
	
	
	return Vector2(x_offset, y_offset)


func _get_max_width():
	assert(max_cards>0, "Cannot get max width if with no max cards")
	var separation_width=max(separation*(max_cards-1),0)
	var max_width=separation_width+max_cards*Constants.CARD_WIDTH
	return max_width/2
