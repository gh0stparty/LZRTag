
include_files = { "*.lua" }

stds.nodemcu = {
	read_globals = {
		"tmr",
		"mqtt",
		"uart",
		"wifi",
		"adc",
		"node",
		"sjson",
		"file",
		"encoder",
		"sntp",
		"rtctime",
	}
}

stds.playerdata = {
	globals = {
		"serverURL",
		"playerTopic",
		"lasertagTopic",
		"playerID",
		"invertButton",
	}
}

stds.lasertag = {
	globals = {
		"setVestBrightness",
		"setVestColor",
		"overrideVest",
		"ping",
		"vibrate",
		"fireWeapon",

		"gameRunning",

		"subscribeTo",
		"registerUARTCommand",
		"homeQTT",
		"homeQTT_connected",
		"onMQTTConnect",
	}
}

std="min+nodemcu+lasertag+playerdata"

allow_defined 			= true

ignore = {
	"131", -- Unused global variables
	"212", -- Unused function argument
	"213", -- Unused loop variables
}