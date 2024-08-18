class_name Requirement

var type: ReqType
var complete: bool

enum ReqType { AREA, RELATIVE_SIZE, DIMENSIONS }

# Area requirement
class AreaRequirement extends Requirement:
	var area: int

	func _init(_area) -> void:
		area = _area
		complete = false
