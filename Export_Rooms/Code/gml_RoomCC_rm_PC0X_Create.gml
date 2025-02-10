obj_gameMgr.bankiHead = 2
obj_gameMgr.energy = 3
obj_gameMgr.ice = 9
obj_gameMgr.cost = 9
if (global.nineHeadMode == 1)
{
    obj_gameMgr.bankiHead = 9
    obj_gameMgr.energy = 99
    obj_gameMgr.ice = 99
    obj_gameMgr.cost = 99
}
global.playerCamera = 1
instance_create(x, y, obj_playStartMgr)
