# Changes

### Code
- instance_destroy(obj_achievementGetMgr) - Achivement crashes the game for levels outside the achivement list, so achievement notificans have been disabled until further notice. Also, obj_achievementGetMgr_Draw_64 has been added custom text to pervent the game from crashing.
- obj_goalMgr_Create - removed global.a.X if statements and ini.open(global.savedata). So no more saving records as well.
- Added debugMgr to splash room and title room. Made it so it can be edited to wrap to a room.
- rm_boot declares additional global variables after gamepad is set deadzone.
- obj_pauseMenuMgr - Change text for other characters to "BACK TO ENTRANCE" from "BACK TO MENU" and scr_pauseMenu() been changed to send everyone back to entrance
- obj_gameMgr_Step - Change the goal management, so that every character can go back to entrance after completing the stage.
- obj_goalMgr_Step - Set Rumia's and Seija's BackMenuMgr to obj_entranceBackMgr
- obj_player - Added a 10 frame jumpBuffer window for QoL purposes.

### Fairies
- obj_fairy1 - No physics. Turns on fairy_wall
- obj_fairy2 - Same as obj_fairy1, except has a smaller search range for player, and has the addition of "move_contact_solid"
- obj_fairy3 - Physics. Charges. Kills on touch.
- obj_fairy4 - Stays still, but jumps when the player goes over the fairy.

# Custom Additions

### Custom Dialogue
- Newline: #
- Call src_text for cutscene dialogue.
- Changes to how text is render, like draw_set_halign(fa_center), applies to all text rending. Need to change the text rendering back to normal.
- The HUD's font is actually made out of sprites.
- Default font_message size is 32 pixels.

### Custom Menu
- obj_mapMenuMgr contains index on worlds. scr_mapMenu() is how the player warps.

### Custom Stages
- Add a custom world door to rm_entrance (Dream Hub World)
- Add creation code to rooms that sets resources and obj_playStartMgr.
- entrancePoint determines... the position the player will need in rm_entrance after exiting obj_doorEn since there can only be one spawn point for the player. Thankfully, "none" does nothing special.
- To set the player's position after beating a level, obj_entranceBackMgr's step script looks at global.stagePoint and global.entrancePoint to determine which room to send the player back to.
- To apply player's position in a world, it is in the world's room Creation Code for stagePoint.
- Same case must apply obj_doorEn. Then any additional wrap points must be added to rm_entrance player.
- obj.bgm needs an if case for stages. Also for the hub world as well.
- obj_doorNumber is setup by Creation Code for image_index.
- Rooms should be setup 2000 x 2000 to give flexibility to level design, as moving elements in UMT takes forever.
- Base backgrounds have an object to help them scroll and loop on screen.
- Figured out how to get doors to have names and make an object flexible. Set global.stageTitle under Step. And add another global variable to control for the fact mutiple door detect the same instance and delete the same instance in a single frame.
- Add rooms to obj_bgm to set music.

# IDEAS
- obj_player has all the physics in the step event
- Shaders? (Ultrmarine Rain uses obj_rain_control for rain effects)
- Foreground elements (backgrounds can be foreground elements)
- More inside tiles for tilesets

### Iku's Weather Station
- With each key collected, the rain becomes more pouring.
- Fairies move faster.
- Design of level should allow any key to be collected in order.
- Perhaps ranking can be based on least used resources?

# TODO
- Achievements Unlocked, destroy that instance as well.
- Get doors to save clear status and best time to save files.
- Add achievements? ac is the case switch used for obj_achievementCheckMgr and ini_open(global.savedata)
- Check gamepad support
- Change the clear condition so that it is called by a function, and not make it based on obj_gameMgr knowing there are no obj_goal left in a stage.

# BUGS
- Seems like sometimes the startplayerinput obj doesn't work sometimes.
- Okay, if the game is paused as the room loads, Fairy_count can just break. How is the object skipping its create function? (Just put vars in the draw script itself)

# UTMCE
- To delete object events, click on subtype ID or the box around the event itself and press delete. Subtype IDs can't be removed?

# DISCOVERIES
- According to obj_stageTimeLoadX_Create_0 (X refer to world number), extra stages were originally supposed to unlock when getting every puzzle piece in a world. clearFlag is what detemines if a door appears. Through, trying to get clearFlag to work doesn't seem to function correctly, so clearFlag stays at 0. Also, game crashes as it tries to grab nonexistent time for extra stages.
if (peaceCountT01 != 0 && peaceCountT02 != 0 && peaceCountT03 != 0 && peaceCountT04 != 0 && peaceCountT05 != 0)
{
    if (instance_exists(obj_doorTEX) == 1)
        obj_doorTEX.clearFlag = 1
}

- In gml_Script_scr_mapMenu, there are extra cases for Cirno's and Rumia's Worlds. Could these be the extra two world on the side of the map?
case 11:
        global.mapMenuMpos = 11
        if (global.lang == "ja")
            obj_mapSelectQuestion.mapName = "ひみつ部屋"
        else if (global.lang == "en")
            obj_mapSelectQuestion.mapName = " Secret Rooms"
        else if (global.lang == "ch")
            obj_mapSelectQuestion.mapName = "秘密房间"
        break
    case 12:
        global.mapMenuMpos = 12
        if (global.lang == "ja")
            obj_mapSelectQuestion.mapName = "Frost Ornament"
        else if (global.lang == "en")
            obj_mapSelectQuestion.mapName = " Frost Ornament"
        else if (global.lang == "ch")
            obj_mapSelectQuestion.mapName = "Frost Ornament"
        break
    case 13:
        global.mapMenuMpos = 13
        if (global.lang == "ja")
            obj_mapSelectQuestion.mapName = "invisible the dark"
        else if (global.lang == "en")
            obj_mapSelectQuestion.mapName = " invisible the dark"
        else if (global.lang == "ch")
            obj_mapSelectQuestion.mapName = "invisible the dark"
        break
- obj_fairy4, it seems like there is evidence that it was supposed to be a playable character. What is odd about obj_fairy4 is that it doesn't have a obj_fairyXD associated to the object. Truly fairies are the most complex object in this game.

if (instance_exists(obj_darkBomb) == 1)

                    instance_destroy(obj_darkBomb)

                if (instance_exists(obj_darkBlock) == 1)

                    instance_destroy(obj_darkBlock)

                audio_play_sound(se_darkBreak, 10, false)

                darkPower++

                if (darkPower == 0)

                    obj_gameMgr.energy = 3

                else if (darkPower == 1)

                    obj_gameMgr.energy = 2

                else if (darkPower == 2)

                    obj_gameMgr.energy = 1

                else if (darkPower == 1)

                    obj_gameMgr.energy = 0

            }

Okey, the way it works is that, Rumia has limited uses on her darkPower that make it not matter if she has a bunch of Energy in the first place, since every use of "C" sets her energy depending on darkPower, which is seperate from energy.
On the First use of "C", energy is 2. (The first if case can't happen normally.)
2nd use, energy is 1.
3rd use, energy is 0.
So Rumia has limited uses of her explosives, but it does mean she can use all of her DARK during her first use, get 2 DARK back.