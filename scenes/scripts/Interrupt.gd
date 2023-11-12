extends Object


class_name Interrupt


enum Type {EXIT, CONFIRM}


var type: Type
var info


func _init(param_type: Type, param_info):
	self.type = param_type
	self.info = param_info
