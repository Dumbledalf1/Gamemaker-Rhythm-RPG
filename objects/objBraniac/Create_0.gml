/// #description Start Dialogue
previous_room = roomOverworld;
var chartName = "Tutorial.json"
with (instance_create_depth(x, y, -1, objBattleHandler)) {
	var buffer = buffer_load(chartName);
	var jsonString = buffer_read(buffer, buffer_text);
	chart = json_parse(jsonString);
	buffer_delete(buffer);
}

image_speed = 0;
with (instance_create_depth(x + 50, y, 1, objDialogue)) {
	lines = ["Welcome to the tutorial!",
		"Press A, S, and D when notes reach the bridges.",
		"Great players keep the beat steady. Ready to practice?"]
	active = true;
	onFinish = function() { 
		objBattleHandler.started = true;
		instance_destroy(objDialogue);
		objBraniac.image_speed = 1;
	};
	target = other.id;
}
songFinish = function() {
	with (instance_create_depth(x + 50, y, 1, objDialogue)) {
		lines = ["Nice work! You finished the tutorial level."]
		active = true;
		onFinish = function() { room_goto(objBraniac.previous_room) };
		target = objBraniac;
	}
}
objBattleHandler.enemyID = id;
