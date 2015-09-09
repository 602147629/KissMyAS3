package lovefox.game
{
    import flash.events.*;
    import lovefox.unit.*;

    public class Hang extends EventDispatcher
    {
        public static var limitedHang:Boolean = false;
        public static var limitedHangTime:uint = 0;
        public static var _hangStartTime:uint;
        public static var _hangLoopTimer:Number;
        private static var _selectedMap:Object;
        private static var _selectedTargetArray:Array = [];
        private static var _selectedTargetType:uint = 0;
        private static var _selectedPos:Array;
        private static var _selectedPosIndex:uint = 0;
        private static var _selectedTargetMap:Object = {};
        private static var _currTarget:Object;
        public static var _preSkillTargetId:Object;
        private static var _thinkTimer:Object;
        private static var _doMapCompleteTimer:Object;
        private static var _itemLockMap:Object = {};
        private static var _escapeCount:int = 0;
        private static var _switch:Object = false;
        private static var _lockPosition:Boolean = false;
        private static var _lockPoint:Object;
        public static var _expCopyDoorID:int = 0;
        public static var _expCopyGateLock:Boolean = false;
        public static var _preExpCopyHanging:Boolean = false;

        public function Hang()
        {
            return;
        }// end function

        public static function hangMonster(param1)
        {
            Config.doingCookie = {act:"hangMonster", monsterID:param1};
            Config.player.stop(false, true);
            stop();
            DistrictMap.stop();
            return launchMonster(param1);
        }// end function

        public static function hangItem(param1)
        {
            return;
        }// end function

        public static function hangPosition(param1, param2)
        {
            Config.doingCookie = {act:"hangPosition", taskID:param1, eventId:param2};
            Config.player.stop(false, true);
            stop();
            DistrictMap.stop();
            var _loc_3:* = DistrictMap._tflagMap[param1][param2][0];
            DistrictMap.goMap(_loc_3.mapId, _loc_3._x, _loc_3._y);
            return true;
        }// end function

        public static function hangMap(param1)
        {
            stop();
            DistrictMap.goMap(param1);
            return;
        }// end function

        public static function hangGather(param1)
        {
            if (Config._gatherMap[param1] == null)
            {
                return;
            }
            Config.doingCookie = {act:"hangGather", gatherID:param1};
            Config.player.stop(false, true);
            stop();
            DistrictMap.stop();
            return launchGather(param1);
        }// end function

        public static function hangNpc(param1)
        {
            Config.doingCookie = {act:"hangNpc", npcID:param1};
            Config.player.stop(false, true);
            stop();
            DistrictMap.stop();
            return launchNpc(param1);
        }// end function

        public static function get hanging() : Boolean
        {
            if (_selectedMap == DistrictMap.realMapId && _selectedTargetArray != null)
            {
                return true;
            }
            return false;
        }// end function

        public static function init()
        {
            Config.map.removeEventListener("complete", handleMapComplete);
            Config.map.addEventListener("complete", handleMapComplete);
            return;
        }// end function

        public static function launchNpc(param1)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = DistrictMap.sortNearMap(DistrictMap.findMapFromNPC(param1))[0];
            if (_loc_3 != null)
            {
                _selectedMap = _loc_3;
                _selectedTargetType = UNIT_TYPE_ENUM.TYPEID_NPC;
                _selectedTargetArray = [param1];
                _selectedPos = DistrictMap.getNpcRefreshType(param1, _selectedMap);
                _selectedPosIndex = 0;
                start();
                return true;
            }
            return;
        }// end function

        public static function launchGather(param1)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = DistrictMap.sortNearMap(DistrictMap.findMapFromGather(param1));
            if (_loc_3.length == 0)
            {
                return false;
            }
            var _loc_4:* = _loc_3[0];
            if (_loc_3[0] != null)
            {
                _selectedMap = _loc_4;
                _selectedTargetType = UNIT_TYPE_ENUM.TYPEID_GATHER;
                _selectedTargetArray = [param1];
                _selectedPos = DistrictMap.getGatherRefreshType(param1, _selectedMap);
                _selectedPosIndex = 0;
                start();
                return true;
            }
            return;
        }// end function

        public static function launchMonster(param1, param2 = false)
        {
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_7:* = undefined;
            var _loc_5:* = Config._monsterMap[param1].type;
            if (Config._monsterMap[param1].type == 2)
            {
                _loc_7 = {16:true, 17:true};
                _loc_4 = DistrictMap.sortNearMap(DistrictMap.findMapFromMonster(param1, _loc_7));
            }
            else
            {
                _loc_4 = DistrictMap.sortNearMap(DistrictMap.findMapFromMonster(param1));
            }
            if (_loc_4.length == 0)
            {
                return false;
            }
            var _loc_6:* = _loc_4[0];
            if (_loc_4[0] != null)
            {
                _selectedTargetType = UNIT_TYPE_ENUM.TYPEID_UNIT;
                _selectedMap = _loc_6;
                if (param2)
                {
                    selectedTarget = DistrictMap.findMonsterFromMap(_loc_6);
                }
                else
                {
                    selectedTarget = [param1];
                    _selectedPos = DistrictMap.getMonsterRefreshType(param1, _selectedMap);
                }
                _selectedPosIndex = 0;
                start();
                return true;
            }
            return;
        }// end function

        private static function hangTimeLoop()
        {
            var _loc_1:* = limitedHangTime * 60 - int((getTimer() - _hangStartTime) / 1000);
            if (_loc_1 < 0)
            {
                Config.message(Config.language("Hang", 1));
                stop();
            }
            else
            {
                Config.ui._monsterIndexUI._hangTimeTf.text = Config.language("Hang", 2) + Config.timeShow(_loc_1);
            }
            return;
        }// end function

        public static function lockPoint()
        {
            _lockPoint = {_x:Config.player._x, _y:Config.player._y};
            return;
        }// end function

        public static function start(param1:Boolean = false)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = null;
            if (limitedHang)
            {
                _hangStartTime = getTimer();
                clearInterval(_hangLoopTimer);
                _hangLoopTimer = setInterval(hangTimeLoop, 1000);
                Config.ui._monsterIndexUI._hangTimeTf.text = Config.language("Hang", 2) + Config.timeShow(limitedHangTime * 60);
            }
            _lockPosition = param1;
            _selectedTargetMap = {};
            for (_loc_2 in _selectedTargetArray)
            {
                
                _selectedTargetMap[_selectedTargetArray[_loc_2]] = _selectedTargetArray[_loc_2];
                if (Config.ui._monsterIndexUI.hanging && Config.ui._monsterIndexUI._eliteCB.selected)
                {
                    _loc_4 = Config._toEliteMap[_selectedTargetArray[_loc_2]];
                    if (_loc_4 != null)
                    {
                        _loc_3 = 0;
                        while (_loc_3 < _loc_4.length)
                        {
                            
                            _selectedTargetMap[_loc_4[_loc_3]] = _loc_4[_loc_3];
                            _loc_3 = _loc_3 + 1;
                        }
                    }
                }
            }
            stopThink();
            if (_selectedMap != null)
            {
                if (_selectedMap != DistrictMap.realMapId)
                {
                    DistrictMap.goRealMap(_selectedMap);
                }
                else
                {
                    startThink();
                }
            }
            return;
        }// end function

        public static function stop(param1 = false)
        {
            if (limitedHang)
            {
                clearInterval(_hangLoopTimer);
                Config.ui._monsterIndexUI._hangTimeTf.text = "";
            }
            Config.doingCookie = null;
            stopThink();
            _selectedMap = null;
            _selectedTargetArray = [];
            _selectedPos = null;
            if (!param1)
            {
                if (Config.ui != null)
                {
                    Config.ui._monsterIndexUI.hanging = false;
                }
            }
            return;
        }// end function

        private static function handleCurrentTargetDestroy(param1)
        {
            Config.player.attacked = false;
            currTarget = null;
            think();
            return;
        }// end function

        private static function lockItem(param1)
        {
            releaseItemLock(param1);
            _itemLockMap[param1] = setTimeout(releaseItemLock, 5000, param1);
            return;
        }// end function

        private static function releaseItemLock(param1)
        {
            clearTimeout(_itemLockMap[param1]);
            delete _itemLockMap[param1];
            return;
        }// end function

        public static function think()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = null;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            var _loc_8:* = undefined;
            clearTimeout(_thinkTimer);
            if (_expCopyGateLock && Config.map._type == 25)
            {
                if (Config.player.target == null)
                {
                    _loc_2 = Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_NPC, _expCopyDoorID);
                    if (_loc_2 != null)
                    {
                        Config.player.target = _loc_2;
                    }
                }
                _thinkTimer = setTimeout(think, 500);
                return;
            }
            if (Config.player != null && Config.map != null && Config.map._state == "ready")
            {
                if (!Config.player.testPositionLegal())
                {
                    if (_escapeCount > 10)
                    {
                        _escapeCount = -10;
                        Config.ui._gamesystem.handleEscape();
                    }
                    else
                    {
                        var _loc_10:* = _escapeCount + 1;
                        _escapeCount = _loc_10;
                    }
                    _thinkTimer = setTimeout(think, 500);
                    return;
                }
                else
                {
                    _escapeCount = 0;
                }
            }
            if (Skill.chanting)
            {
                if (Skill.chantTarget == null)
                {
                    Skill.castChant();
                }
            }
            else if (Config.map._state == "ready" && Config.player != null)
            {
                if (Config.player.die)
                {
                    Config.player.hangLife();
                }
                else
                {
                    if (_selectedTargetType == UNIT_TYPE_ENUM.TYPEID_UNIT)
                    {
                        _loc_3 = Config.ui._monsterIndexUI._setupPanel.findBufferItem();
                        _loc_1 = 0;
                        while (_loc_1 < _loc_3.length)
                        {
                            
                            if (_itemLockMap[_loc_3[_loc_1].id] == null)
                            {
                                Config.ui._charUI.useItem(_loc_3[_loc_1].item);
                                if (_loc_3[_loc_1].buffBaseId != null)
                                {
                                    lockItem(_loc_3[_loc_1].buffBaseId);
                                }
                            }
                            _loc_1 = _loc_1 + 1;
                        }
                        _loc_3 = Config.ui._monsterIndexUI._setupPanel.findRecoverItem();
                        _loc_1 = 0;
                        while (_loc_1 < _loc_3.length)
                        {
                            
                            if (_itemLockMap[_loc_3[_loc_1].id] == null)
                            {
                                Config.ui._charUI.useItem(_loc_3[_loc_1].item);
                                lockItem(_loc_3[_loc_1].id);
                            }
                            _loc_1 = _loc_1 + 1;
                        }
                        if (currTarget != null && !currTarget.visible)
                        {
                            currTarget = null;
                        }
                    }
                    if (currTarget == null)
                    {
                        if (Config.player.resting)
                        {
                        }
                        else
                        {
                            _loc_4 = false;
                            if (Config.ui._playerHead.fcmstatus <= 0)
                            {
                                currTarget = findNearTarget(12, 0, 2);
                            }
                            if (currTarget != null)
                            {
                                thinkTarget(currTarget);
                            }
                            else
                            {
                                if (_selectedTargetType == UNIT_TYPE_ENUM.TYPEID_UNIT && Config.ui._monsterIndexUI._setupPanel.findRest())
                                {
                                    if (!Config.player.attacked)
                                    {
                                        Config.player.startRest();
                                        _loc_4 = true;
                                    }
                                }
                                if (!_loc_4)
                                {
                                    if (_selectedTargetType == UNIT_TYPE_ENUM.TYPEID_UNIT)
                                    {
                                        _loc_5 = Config.ui._monsterIndexUI._setupPanel.findBufferSkill();
                                        if (_loc_5 != null)
                                        {
                                            _loc_5.select();
                                        }
                                    }
                                    if (_selectedTargetType == UNIT_TYPE_ENUM.TYPEID_NPC)
                                    {
                                        _loc_6 = Unit.getNpclist();
                                        for (_loc_1 in _loc_6)
                                        {
                                            
                                            if (_selectedTargetMap[String(_loc_6[_loc_1]._data.id)] != null)
                                            {
                                                currTarget = _loc_6[_loc_1];
                                                break;
                                            }
                                        }
                                    }
                                    else if (_lockPosition && _lockPoint != null && Config.ui._monsterIndexUI._hangMode1.selected)
                                    {
                                        if (Config.map._type == 25)
                                        {
                                            currTarget = findNearMonsterUnlimited();
                                        }
                                        else
                                        {
                                            currTarget = findNearTarget(12, 0, 1, _lockPoint, 15 * Map._ptPerTile);
                                        }
                                    }
                                    else if (Config.map._type == 25)
                                    {
                                        currTarget = findNearMonsterUnlimited();
                                    }
                                    else
                                    {
                                        currTarget = findNearTarget(12, 0, 1);
                                    }
                                    if (currTarget != null)
                                    {
                                        thinkTarget(currTarget);
                                        if (_selectedTargetType == UNIT_TYPE_ENUM.TYPEID_NPC)
                                        {
                                            return;
                                        }
                                    }
                                    else if (_selectedPos != null)
                                    {
                                        _loc_7 = Config.map.tileToMap(_selectedPos[_selectedPosIndex]);
                                        if (!Config.player._moveFlag && (Config.player._desPt == null || (Math.floor(Config.player._desPt._x - _loc_7._x) > 1 || Math.floor(Config.player._desPt._y - _loc_7._y) > 1)))
                                        {
                                            Config.player.go(_loc_7);
                                            var _loc_10:* = _selectedPosIndex + 1;
                                            _selectedPosIndex = _loc_10;
                                            if (_selectedPosIndex >= _selectedPos.length)
                                            {
                                                _selectedPosIndex = 0;
                                            }
                                        }
                                    }
                                    else if (!Config.player._moveFlag)
                                    {
                                        if (Config.map._type != 25 && _lockPosition && _lockPoint != null && Config.ui._monsterIndexUI._hangMode1.selected)
                                        {
                                            Config.player.go(_lockPoint);
                                        }
                                        else
                                        {
                                            if (Config.map._type == 25)
                                            {
                                                _loc_8 = Config.map._logicalTile[int(Config.map._logicalWidth / 2)][int(Config.map._logicalHeight / 2)];
                                            }
                                            else
                                            {
                                                _loc_8 = Config.map.getRandomWalkableTile(Config.player._currTile);
                                            }
                                            if (_loc_8 != null)
                                            {
                                                Config.player.go(Config.map.tileToMap(_loc_8));
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    else
                    {
                        thinkTarget(currTarget);
                        if (_selectedTargetType == UNIT_TYPE_ENUM.TYPEID_NPC)
                        {
                            return;
                        }
                    }
                }
            }
            _thinkTimer = setTimeout(think, 500);
            return;
        }// end function

        private static function thinkTarget(param1)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = null;
            if (param1.type == UNIT_TYPE_ENUM.TYPEID_UNIT)
            {
                _loc_6 = Config.ui._monsterIndexUI._setupPanel.findPrimarySkill();
                if (_loc_6 != null)
                {
                    _loc_6.select();
                    Config.player.target = param1;
                    return;
                }
                Skill.selectedSkill = null;
                Config.player.target = param1;
            }
            else
            {
                Skill.selectedSkill = null;
                Config.player.target = param1;
                Config.player.autoPick();
            }
            return;
        }// end function

        public static function startThink()
        {
            stopThink();
            think();
            return;
        }// end function

        public static function stopThink()
        {
            currTarget = null;
            clearTimeout(_thinkTimer);
            return;
        }// end function

        private static function handleMapComplete(param1)
        {
            clearTimeout(_doMapCompleteTimer);
            _doMapCompleteTimer = setTimeout(doMapComplete, 500);
            return;
        }// end function

        private static function doMapComplete()
        {
            clearTimeout(_doMapCompleteTimer);
            if (_selectedMap != null)
            {
                if (_selectedMap == DistrictMap.realMapId)
                {
                    startThink();
                }
                else
                {
                    stopThink();
                }
            }
            return;
        }// end function

        public static function findNearItem(param1 = 8, param2 = 0)
        {
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_9:* = undefined;
            var _loc_5:* = Config.player;
            var _loc_6:* = param2;
            var _loc_7:* = [];
            var _loc_8:* = _loc_5._currTile;
            if (_loc_5._currTile == null)
            {
                return null;
            }
            while (_loc_7.length == 0 && _loc_6 < param1)
            {
                
                _loc_7 = [];
                _loc_4 = _loc_8._y - _loc_6;
                if (_loc_4 >= 0 && _loc_4 < Config.map._logicalHeight)
                {
                    _loc_3 = -_loc_6 + _loc_8._x;
                    while (_loc_3 < (_loc_6 + 1) + _loc_8._x)
                    {
                        
                        if (_loc_3 >= 0 && _loc_3 < Config.map._logicalWidth)
                        {
                            if (Config.map._logicalTile[_loc_3][_loc_4]._currItem.length > 0)
                            {
                                if (Config.map._logicalTile[_loc_3][_loc_4].walkable)
                                {
                                    return Config.map._logicalTile[_loc_3][_loc_4]._currItem[0];
                                }
                            }
                        }
                        _loc_3 = _loc_3 + 1;
                    }
                }
                _loc_4 = _loc_8._y + _loc_6;
                if (_loc_4 >= 0 && _loc_4 < Config.map._logicalHeight)
                {
                    _loc_3 = -_loc_6 + _loc_8._x;
                    while (_loc_3 < (_loc_6 + 1) + _loc_8._x)
                    {
                        
                        if (_loc_3 >= 0 && _loc_3 < Config.map._logicalWidth)
                        {
                            if (Config.map._logicalTile[_loc_3][_loc_4]._currItem.length > 0)
                            {
                                if (Config.map._logicalTile[_loc_3][_loc_4].walkable)
                                {
                                    return Config.map._logicalTile[_loc_3][_loc_4]._currItem[0];
                                }
                            }
                        }
                        _loc_3 = _loc_3 + 1;
                    }
                }
                _loc_3 = _loc_8._x - _loc_6;
                if (_loc_3 >= 0 && _loc_3 < Config.map._logicalWidth)
                {
                    _loc_4 = -_loc_6 + _loc_8._y;
                    while (_loc_4 < (_loc_6 + 1) + _loc_8._y)
                    {
                        
                        if (_loc_4 >= 0 && _loc_4 < Config.map._logicalHeight)
                        {
                            if (Config.map._logicalTile[_loc_3][_loc_4]._currItem.length > 0)
                            {
                                if (Config.map._logicalTile[_loc_3][_loc_4].walkable)
                                {
                                    return Config.map._logicalTile[_loc_3][_loc_4]._currItem[0];
                                }
                            }
                        }
                        _loc_4 = _loc_4 + 1;
                    }
                }
                _loc_3 = _loc_8._x + _loc_6;
                if (_loc_3 >= 0 && _loc_3 < Config.map._logicalWidth)
                {
                    _loc_4 = -_loc_6 + _loc_8._y;
                    while (_loc_4 < (_loc_6 + 1) + _loc_8._y)
                    {
                        
                        if (_loc_4 >= 0 && _loc_4 < Config.map._logicalHeight)
                        {
                            if (Config.map._logicalTile[_loc_3][_loc_4]._currItem.length > 0)
                            {
                                if (Config.map._logicalTile[_loc_3][_loc_4].walkable)
                                {
                                    return Config.map._logicalTile[_loc_3][_loc_4]._currItem[0];
                                }
                            }
                        }
                        _loc_4 = _loc_4 + 1;
                    }
                }
                _loc_6 = _loc_6 + 1;
            }
            return null;
        }// end function

        private static function findNearMonsterUnlimited() : Unit
        {
            var _loc_2:* = NaN;
            var _loc_3:* = null;
            var _loc_4:* = undefined;
            var _loc_5:* = NaN;
            var _loc_1:* = Unit.getUnitList(UNIT_TYPE_ENUM.TYPEID_UNIT);
            if (_loc_1 != null)
            {
                _loc_2 = int.MAX_VALUE;
                _loc_3 = null;
                for (_loc_4 in _loc_1)
                {
                    
                    _loc_5 = testDistance(Config.player, _loc_1[_loc_4]);
                    if (_loc_5 < _loc_2)
                    {
                        _loc_3 = _loc_1[_loc_4];
                        _loc_2 = _loc_5;
                    }
                }
                return _loc_3;
            }
            return null;
        }// end function

        private static function findNearTargetExpCopy(param1 = 12, param2 = 0, param3 = 0, param4 = null)
        {
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            var _loc_8:* = undefined;
            var _loc_9:* = undefined;
            var _loc_10:* = undefined;
            var _loc_11:* = undefined;
            var _loc_12:* = undefined;
            var _loc_14:* = null;
            var _loc_13:* = Config.player._currTile;
            _loc_5 = Config.map.tileToMap(_loc_13);
            _loc_11 = param2;
            _loc_10 = [];
            while (_loc_10.length == 0 && _loc_11 < param1)
            {
                
                _loc_10 = [];
                _loc_7 = _loc_13._y - _loc_11;
                if (_loc_7 > 0 && _loc_7 < (Config.map._logicalHeight - 1))
                {
                    _loc_6 = -_loc_11 + _loc_13._x;
                    while (_loc_6 < (_loc_11 + 1) + _loc_13._x)
                    {
                        
                        if (_loc_6 > 0 && _loc_6 < (Config.map._logicalWidth - 1) && Config.map._logicalTile[_loc_6][_loc_7].terrainwalkable)
                        {
                            if (param3 == 0)
                            {
                                _loc_14 = Config.map._logicalTile[_loc_6][_loc_7]._currUnit.concat(Config.map._logicalTile[_loc_6][_loc_7]._currItem);
                            }
                            else if (param3 == 1)
                            {
                                _loc_14 = Config.map._logicalTile[_loc_6][_loc_7]._currUnit;
                            }
                            else if (param3 == 2)
                            {
                                _loc_14 = Config.map._logicalTile[_loc_6][_loc_7]._currItem;
                            }
                            _loc_8 = 0;
                            while (_loc_8 < _loc_14.length)
                            {
                                
                                _loc_12 = _loc_14[_loc_8];
                                if (testTarget(_loc_12))
                                {
                                    if (param4 != null)
                                    {
                                        _loc_10.push({unit:_loc_12, r:Math.abs(_loc_12._y - param4._y) + Math.abs(_loc_12._x - param4._x)});
                                    }
                                }
                                _loc_8 = _loc_8 + 1;
                            }
                        }
                        _loc_6 = _loc_6 + 1;
                    }
                }
                _loc_7 = _loc_13._y + _loc_11;
                if (_loc_7 > 0 && _loc_7 < (Config.map._logicalHeight - 1))
                {
                    _loc_6 = -_loc_11 + _loc_13._x;
                    while (_loc_6 < (_loc_11 + 1) + _loc_13._x)
                    {
                        
                        if (_loc_6 > 0 && _loc_6 < (Config.map._logicalWidth - 1) && Config.map._logicalTile[_loc_6][_loc_7].terrainwalkable)
                        {
                            if (param3 == 0)
                            {
                                _loc_14 = Config.map._logicalTile[_loc_6][_loc_7]._currUnit.concat(Config.map._logicalTile[_loc_6][_loc_7]._currItem);
                            }
                            else if (param3 == 1)
                            {
                                _loc_14 = Config.map._logicalTile[_loc_6][_loc_7]._currUnit;
                            }
                            else if (param3 == 2)
                            {
                                _loc_14 = Config.map._logicalTile[_loc_6][_loc_7]._currItem;
                            }
                            _loc_8 = 0;
                            while (_loc_8 < _loc_14.length)
                            {
                                
                                _loc_12 = _loc_14[_loc_8];
                                if (testTarget(_loc_12))
                                {
                                    if (param4 != null)
                                    {
                                        _loc_10.push({unit:_loc_12, r:Math.abs(_loc_12._y - param4._y) + Math.abs(_loc_12._x - param4._x)});
                                    }
                                }
                                _loc_8 = _loc_8 + 1;
                            }
                        }
                        _loc_6 = _loc_6 + 1;
                    }
                }
                _loc_6 = _loc_13._x - _loc_11;
                if (_loc_6 > 0 && _loc_6 < (Config.map._logicalWidth - 1))
                {
                    _loc_7 = -_loc_11 + _loc_13._y;
                    while (_loc_7 < (_loc_11 + 1) + _loc_13._y)
                    {
                        
                        if (_loc_7 > 0 && _loc_7 < (Config.map._logicalHeight - 1) && Config.map._logicalTile[_loc_6][_loc_7].terrainwalkable)
                        {
                            if (param3 == 0)
                            {
                                _loc_14 = Config.map._logicalTile[_loc_6][_loc_7]._currUnit.concat(Config.map._logicalTile[_loc_6][_loc_7]._currItem);
                            }
                            else if (param3 == 1)
                            {
                                _loc_14 = Config.map._logicalTile[_loc_6][_loc_7]._currUnit;
                            }
                            else if (param3 == 2)
                            {
                                _loc_14 = Config.map._logicalTile[_loc_6][_loc_7]._currItem;
                            }
                            _loc_8 = 0;
                            while (_loc_8 < _loc_14.length)
                            {
                                
                                _loc_12 = _loc_14[_loc_8];
                                if (testTarget(_loc_12))
                                {
                                    if (param4 != null)
                                    {
                                        _loc_10.push({unit:_loc_12, r:Math.abs(_loc_12._y - param4._y) + Math.abs(_loc_12._x - param4._x)});
                                    }
                                }
                                _loc_8 = _loc_8 + 1;
                            }
                        }
                        _loc_7 = _loc_7 + 1;
                    }
                }
                _loc_6 = _loc_13._x + _loc_11;
                if (_loc_6 > 0 && _loc_6 < (Config.map._logicalWidth - 1))
                {
                    _loc_7 = -_loc_11 + _loc_13._y;
                    while (_loc_7 < (_loc_11 + 1) + _loc_13._y)
                    {
                        
                        if (_loc_7 > 0 && _loc_7 < (Config.map._logicalHeight - 1) && Config.map._logicalTile[_loc_6][_loc_7].terrainwalkable)
                        {
                            if (param3 == 0)
                            {
                                _loc_14 = Config.map._logicalTile[_loc_6][_loc_7]._currUnit.concat(Config.map._logicalTile[_loc_6][_loc_7]._currItem);
                            }
                            else if (param3 == 1)
                            {
                                _loc_14 = Config.map._logicalTile[_loc_6][_loc_7]._currUnit;
                            }
                            else if (param3 == 2)
                            {
                                _loc_14 = Config.map._logicalTile[_loc_6][_loc_7]._currItem;
                            }
                            _loc_8 = 0;
                            while (_loc_8 < _loc_14.length)
                            {
                                
                                _loc_12 = _loc_14[_loc_8];
                                if (testTarget(_loc_12))
                                {
                                    if (param4 != null)
                                    {
                                        _loc_10.push({unit:_loc_12, r:Math.abs(_loc_12._y - param4._y) + Math.abs(_loc_12._x - param4._x)});
                                    }
                                }
                                _loc_8 = _loc_8 + 1;
                            }
                        }
                        _loc_7 = _loc_7 + 1;
                    }
                }
                _loc_11 = _loc_11 + 1;
            }
            _loc_10.sortOn("r", Array.NUMERIC);
            if (_loc_10.length == 0)
            {
                return null;
            }
            return _loc_10[0].unit;
        }// end function

        private static function findNearTarget(param1 = 12, param2 = 0, param3 = 0, param4 = null, param5 = 0)
        {
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            var _loc_8:* = undefined;
            var _loc_9:* = undefined;
            var _loc_10:* = undefined;
            var _loc_11:* = undefined;
            var _loc_12:* = undefined;
            var _loc_13:* = undefined;
            var _loc_15:* = null;
            var _loc_14:* = Config.player._currTile;
            _loc_6 = Config.map.tileToMap(_loc_14);
            _loc_12 = param2;
            _loc_11 = [];
            while (_loc_11.length == 0 && _loc_12 < param1)
            {
                
                _loc_11 = [];
                _loc_8 = _loc_14._y - _loc_12;
                if (_loc_8 > 0 && _loc_8 < (Config.map._logicalHeight - 1))
                {
                    _loc_7 = -_loc_12 + _loc_14._x;
                    while (_loc_7 < (_loc_12 + 1) + _loc_14._x)
                    {
                        
                        if (_loc_7 > 0 && _loc_7 < (Config.map._logicalWidth - 1) && Config.map._logicalTile[_loc_7][_loc_8].terrainwalkable)
                        {
                            if (param3 == 0)
                            {
                                _loc_15 = Config.map._logicalTile[_loc_7][_loc_8]._currUnit.concat(Config.map._logicalTile[_loc_7][_loc_8]._currItem);
                            }
                            else if (param3 == 1)
                            {
                                _loc_15 = Config.map._logicalTile[_loc_7][_loc_8]._currUnit;
                            }
                            else if (param3 == 2)
                            {
                                _loc_15 = Config.map._logicalTile[_loc_7][_loc_8]._currItem;
                            }
                            _loc_9 = 0;
                            while (_loc_9 < _loc_15.length)
                            {
                                
                                _loc_13 = _loc_15[_loc_9];
                                if (testTarget(_loc_13))
                                {
                                    if (param4 == null || testDistance(_loc_13, param4) < param5)
                                    {
                                        _loc_11.push({unit:_loc_13, r:Math.abs(_loc_13._y - Config.player._y) + Math.abs(_loc_13._x - Config.player._x)});
                                    }
                                }
                                _loc_9 = _loc_9 + 1;
                            }
                        }
                        _loc_7 = _loc_7 + 1;
                    }
                }
                _loc_8 = _loc_14._y + _loc_12;
                if (_loc_8 > 0 && _loc_8 < (Config.map._logicalHeight - 1))
                {
                    _loc_7 = -_loc_12 + _loc_14._x;
                    while (_loc_7 < (_loc_12 + 1) + _loc_14._x)
                    {
                        
                        if (_loc_7 > 0 && _loc_7 < (Config.map._logicalWidth - 1) && Config.map._logicalTile[_loc_7][_loc_8].terrainwalkable)
                        {
                            if (param3 == 0)
                            {
                                _loc_15 = Config.map._logicalTile[_loc_7][_loc_8]._currUnit.concat(Config.map._logicalTile[_loc_7][_loc_8]._currItem);
                            }
                            else if (param3 == 1)
                            {
                                _loc_15 = Config.map._logicalTile[_loc_7][_loc_8]._currUnit;
                            }
                            else if (param3 == 2)
                            {
                                _loc_15 = Config.map._logicalTile[_loc_7][_loc_8]._currItem;
                            }
                            _loc_9 = 0;
                            while (_loc_9 < _loc_15.length)
                            {
                                
                                _loc_13 = _loc_15[_loc_9];
                                if (testTarget(_loc_13))
                                {
                                    if (param4 == null || testDistance(_loc_13, param4) < param5)
                                    {
                                        _loc_11.push({unit:_loc_13, r:Math.abs(_loc_13._y - Config.player._y) + Math.abs(_loc_13._x - Config.player._x)});
                                    }
                                }
                                _loc_9 = _loc_9 + 1;
                            }
                        }
                        _loc_7 = _loc_7 + 1;
                    }
                }
                _loc_7 = _loc_14._x - _loc_12;
                if (_loc_7 > 0 && _loc_7 < (Config.map._logicalWidth - 1))
                {
                    _loc_8 = -_loc_12 + _loc_14._y;
                    while (_loc_8 < (_loc_12 + 1) + _loc_14._y)
                    {
                        
                        if (_loc_8 > 0 && _loc_8 < (Config.map._logicalHeight - 1) && Config.map._logicalTile[_loc_7][_loc_8].terrainwalkable)
                        {
                            if (param3 == 0)
                            {
                                _loc_15 = Config.map._logicalTile[_loc_7][_loc_8]._currUnit.concat(Config.map._logicalTile[_loc_7][_loc_8]._currItem);
                            }
                            else if (param3 == 1)
                            {
                                _loc_15 = Config.map._logicalTile[_loc_7][_loc_8]._currUnit;
                            }
                            else if (param3 == 2)
                            {
                                _loc_15 = Config.map._logicalTile[_loc_7][_loc_8]._currItem;
                            }
                            _loc_9 = 0;
                            while (_loc_9 < _loc_15.length)
                            {
                                
                                _loc_13 = _loc_15[_loc_9];
                                if (testTarget(_loc_13))
                                {
                                    if (param4 == null || testDistance(_loc_13, param4) < param5)
                                    {
                                        _loc_11.push({unit:_loc_13, r:Math.abs(_loc_13._y - Config.player._y) + Math.abs(_loc_13._x - Config.player._x)});
                                    }
                                }
                                _loc_9 = _loc_9 + 1;
                            }
                        }
                        _loc_8 = _loc_8 + 1;
                    }
                }
                _loc_7 = _loc_14._x + _loc_12;
                if (_loc_7 > 0 && _loc_7 < (Config.map._logicalWidth - 1))
                {
                    _loc_8 = -_loc_12 + _loc_14._y;
                    while (_loc_8 < (_loc_12 + 1) + _loc_14._y)
                    {
                        
                        if (_loc_8 > 0 && _loc_8 < (Config.map._logicalHeight - 1) && Config.map._logicalTile[_loc_7][_loc_8].terrainwalkable)
                        {
                            if (param3 == 0)
                            {
                                _loc_15 = Config.map._logicalTile[_loc_7][_loc_8]._currUnit.concat(Config.map._logicalTile[_loc_7][_loc_8]._currItem);
                            }
                            else if (param3 == 1)
                            {
                                _loc_15 = Config.map._logicalTile[_loc_7][_loc_8]._currUnit;
                            }
                            else if (param3 == 2)
                            {
                                _loc_15 = Config.map._logicalTile[_loc_7][_loc_8]._currItem;
                            }
                            _loc_9 = 0;
                            while (_loc_9 < _loc_15.length)
                            {
                                
                                _loc_13 = _loc_15[_loc_9];
                                if (testTarget(_loc_13))
                                {
                                    if (param4 == null || testDistance(_loc_13, param4) < param5)
                                    {
                                        _loc_11.push({unit:_loc_13, r:Math.abs(_loc_13._y - Config.player._y) + Math.abs(_loc_13._x - Config.player._x)});
                                    }
                                }
                                _loc_9 = _loc_9 + 1;
                            }
                        }
                        _loc_8 = _loc_8 + 1;
                    }
                }
                _loc_12 = _loc_12 + 1;
            }
            _loc_11.sortOn("r", Array.NUMERIC);
            if (_loc_11.length == 0)
            {
                return null;
            }
            return _loc_11[0].unit;
        }// end function

        private static function testDistance(param1, param2)
        {
            return Math.sqrt(Math.pow(param1._x - param2._x, 2) + Math.pow(param1._y - param2._y, 2));
        }// end function

        private static function testTarget(param1)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            if (param1 is Effect)
            {
                return false;
            }
            if (_selectedTargetType == UNIT_TYPE_ENUM.TYPEID_UNIT && param1.type == UNIT_TYPE_ENUM.TYPEID_UNIT)
            {
                if (!param1.die && param1.visible && _selectedTargetMap[String(param1._data.id)] != null && !param1.hangError)
                {
                    _loc_6 = Number(Config.player.attackMode.range);
                    if (_loc_6 > 48)
                    {
                        return Config.map.testFlyStraight(Config.player, param1);
                    }
                    return Config.map.testWalkable(Config.player, param1);
                }
                else
                {
                    return false;
                }
            }
            else if (_selectedTargetType == UNIT_TYPE_ENUM.TYPEID_UNIT && param1.type == UNIT_TYPE_ENUM.TYPEID_ITEM_MAP)
            {
                if (param1.pickDisable)
                {
                    return false;
                }
                if (Config.ui._monsterIndexUI._setupPanel.getItemPick(param1._itemData.id))
                {
                    return Config.map.testWalkable(Config.player, param1, 0);
                }
                return false;
            }
            else if (_selectedTargetType == UNIT_TYPE_ENUM.TYPEID_GATHER && param1.type == UNIT_TYPE_ENUM.TYPEID_GATHER)
            {
                if (param1.visible && _selectedTargetMap[String(param1._data.id)] != null)
                {
                    return Config.map.testWalkable(Config.player, param1);
                }
                return false;
            }
            else if (_selectedTargetType == UNIT_TYPE_ENUM.TYPEID_NPC && param1.type == UNIT_TYPE_ENUM.TYPEID_NPC)
            {
                if (param1.visible && _selectedTargetMap[String(param1._data.id)] != null)
                {
                    return Config.map.testWalkable(Config.player, param1);
                }
                return false;
            }
            return;
        }// end function

        public static function set selectedMap(param1)
        {
            _selectedMap = param1;
            return;
        }// end function

        public static function get selectedMap()
        {
            return _selectedMap;
        }// end function

        public static function set selectedTarget(param1:Array)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            _selectedTargetArray = param1;
            _loc_2 = 0;
            while (_loc_2 < _selectedTargetArray.length)
            {
                
                _loc_7 = Config._monsterMap[_selectedTargetArray[_loc_2]];
                _loc_3 = 1;
                while (_loc_3 < 4)
                {
                    
                    _loc_5 = Number(_loc_7["drop" + _loc_3]);
                    if (_loc_5 != 0 && Config._sonMap[_loc_5] != null)
                    {
                        for (_loc_4 in Config._sonMap[_loc_5])
                        {
                            
                            _loc_6 = Config._sonMap[_loc_5][_loc_4];
                            _selectedTargetArray.push(Number(_loc_6.item));
                        }
                    }
                    _loc_3 = _loc_3 + 1;
                }
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public static function set selectedTargetType(param1:int)
        {
            _selectedTargetType = param1;
            return;
        }// end function

        public static function get selectedTarget()
        {
            return _selectedTargetArray;
        }// end function

        public static function get selectedTargetMap()
        {
            return _selectedTargetMap;
        }// end function

        public static function set currTarget(param1)
        {
            if (_currTarget != null)
            {
                _currTarget.removeEventListener("destroy", handleCurrentTargetDestroy);
            }
            _currTarget = param1;
            if (_currTarget != null)
            {
                _currTarget.addEventListener("destroy", handleCurrentTargetDestroy);
            }
            return;
        }// end function

        public static function get currTarget()
        {
            return _currTarget;
        }// end function

    }
}
