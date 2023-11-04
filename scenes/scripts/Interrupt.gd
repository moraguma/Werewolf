extends Object


class_name Interrupt


enum Type {EXIT, CONFIRM}


var type: Type
var info


func _init(type: Type, info):
	self.type = type
	self.info = info
