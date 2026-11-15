HORIZONTAL_VEL = 3;
BASE_JUMP_VEL = 5;
TRAMPOLINE_JUMP_VEL = 30;
vy += 0.3;
vx = 0;


if (place_meeting(x, y, oSpikes))
{
		
	if(!audio_is_playing(collideSound))
	{
		audio_play_sound(collideSound, 10, false)
	}
	global.deathCounter++;
	room_restart();
	
}
if keyboard_check(vk_escape) {
	global.lastRoom = room;
	room_goto(MainMenu);
}

if (keyboard_check(ord("R")))
{
    room_restart();
}
if (place_meeting(x, y, oOpenDoor))
{
	room_goto_next();
	global.lastRoom = room;
}


//set x-velocity
if (keyboard_check(vk_left) && !place_meeting(x-1, y, oBlock)) {
	vx -= HORIZONTAL_VEL;	
}


if (keyboard_check(vk_right) && !place_meeting(x+1, y, oBlock)) {
	vx += HORIZONTAL_VEL;	
}



//if on fnormal block, can jump and no grav.
if place_meeting(x, y+1, oBlock) {
        vy = 0
        if keyboard_check(vk_up)
        {
                vy -= BASE_JUMP_VEL;        
        }
}

else if place_meeting(x, y+1, oTrampoline) {vy -= TRAMPOLINE_JUMP_VEL;}

if (place_meeting(x, y-1, oSolid) && vy < 0) {vy = 0.3;}

if (place_meeting(x, y-1, oSolid) && vy < 0) {vy = 0.3;}

if place_meeting(x, y, oKey) {
	key = instance_place(x, y, oKey);
	if (key != noone) {
		instance_destroy(key); 
	}
	
	with (oClosedDoor) {
        instance_create_layer(x, y, layer, oOpenDoor);
        instance_destroy();
    }
}

move_and_collide(vx, vy, oSolid)
