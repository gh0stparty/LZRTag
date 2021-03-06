
game = {
	brightness 	= 0,
	team			= 7,
}

player = {
	dead = false,
	ammo = 0,
	shotCooldown = false,
}

hitConfDefaults = {
	hitFlashBrightness 	= 4,
	hitFlashDuration   	= 100,
	hitVibration			= 100,

	deathFlashBrightness = 10,
	deathFlashDuration	= 1500,
	deathBrightness		= 1,
	deathVibration			= 1500,
}
hitConf = hitConfDefaults;

fireConfDefaults = {
	ammoCap 			= 5,
	perReloadAmmo 	= 5,

	reloadDelay = 3000,

	perShotDelay	= 333,

	flashBrightness = 10,

	shotLocked = true,
	reportButton = false,
}
fireConf = fireConfDefaults;

-- luacheck: globals updateAmmo attemptShot
subscribeTo(playerTopic .. "/AmmoSet", 1,
	function(data)
		data = tonumber(data);
		if(data) then
			updateAmmo(data);
			attemptShot();
		end
	end);

subscribeTo(playerTopic .. "/ID", 1,
	function(data)
		player.id = tonumber(data);
		if(player.id) then
			uart.write(0, 100, player.id);
		end
	end);

subscribeTo(playerTopic .. "/Team", 1,
	function(data)
		game.team = tonumber(data) or 7;
		setVestColor(game.team);
	end);
subscribeTo(playerTopic .. "/Brightness", 1,
	function(data)
		game.brightness = tonumber(data) or 0;
		if(not(player.dead)) then
			setVestBrightness(game.brightness);
		end
	end);

subscribeTo(playerTopic .. "/Heartbeat", 1,
	function(data)
		setVibratePattern(tonumber(data) or 0);
	end
);

hitConfOptions = {
	metatable = {
		__index = hitConfDefaults}};
subscribeTo(playerTopic .. "/HitConf", 1,
	function(data)
		if(data == nil or data:len() < 2) then
			hitConf = hitConfDefaults
		else
			hitConf = sjson.decode(data, hitConfOptions);
		end
	end);

fireConfOptions = {
	metatable = {
		__index = fireConfDefaults}}
subscribeTo(playerTopic .. "/FireConf", 1,
	function(data)
		if(data == nil or data:len() < 2) then
			fireConf = fireConfDefaults
		else
			fireConf = sjson.decode(data, fireConfOptions);
		end
	end);
