package lovefox.game
{
    import lovefox.astar.*;

    public class DistrictMap extends Object
    {
        private static var _astar:DistrictAstar;
        public static var _map:Array = [];
        public static var _jumpMap:Object = {};
        private static var _npcMap:Object = {};
        public static var _monsterMap:Object = {};
        private static var _gatherMap:Object = {};
        private static var _npcBuff:Object;
        private static var _positionBuff:Object;
        private static var _path:Array;
        private static var _doMapCompleteTimer:Object;
        public static var _npcMapMatrix:Array = [];
        public static var _mapNpcMatrix:Array = [];
        public static var _monsterMapMatrix:Array = [];
        public static var _mapMonsterMatrix:Array = [];
        public static var _mapNameMap:Object = {};
        public static var _gatherMapMatrix:Array = [];
        public static var _mapGatherMatrix:Array = [];
        public static var _tflagMap:Array = [];
        public static var _splitMap:Array;
        private static var mapSplitMap:Array = [];

        public function DistrictMap()
        {
            return;
        }// end function

        public static function testSame(param1, param2 = null, param3 = null)
        {
            var _loc_7:* = undefined;
            var _loc_8:* = undefined;
            var _loc_9:* = undefined;
            var _loc_10:* = undefined;
            var _loc_11:* = undefined;
            var _loc_4:* = false;
            var _loc_5:* = Math.floor(param2 / Map._ptPerTile * 2);
            var _loc_6:* = Math.floor(param3 / Map._ptPerTile * 2);
            if (Config.map.id == param1)
            {
                if (mapSplitMap[param1] == null || (param2 == null || param3 == null))
                {
                    _loc_4 = true;
                }
                else
                {
                    _loc_8 = Math.floor(Config.player._currTile._x / 2);
                    _loc_9 = Math.floor(Config.player._currTile._y / 2);
                    _loc_10 = Math.floor(_loc_5 / 2);
                    _loc_11 = Math.floor(_loc_6 / 2);
                    _loc_7 = 0;
                    while (_loc_7 < mapSplitMap[param1].length)
                    {
                        
                        if (mapSplitMap[param1][_loc_7][_loc_8 + "_" + _loc_9] && mapSplitMap[param1][_loc_7][_loc_10 + "_" + _loc_11])
                        {
                            _loc_4 = true;
                        }
                        _loc_7 = _loc_7 + 1;
                    }
                }
            }
            return _loc_4;
        }// end function

        public static function get realMapId()
        {
            var i:*;
            var j:*;
            var x1:*;
            var y1:*;
            var id1:*;
            try
            {
                x1 = Math.floor(Config.player._currTile._x / 2);
                y1 = Math.floor(Config.player._currTile._y / 2);
                id1 = Config.map.id;
                if (mapSplitMap[id1] != null)
                {
                    i;
                    while (i < mapSplitMap[id1].length)
                    {
                        
                        if (mapSplitMap[id1][i][x1 + "_" + y1])
                        {
                            return id1 * 1000 + i;
                        }
                        i = (i + 1);
                    }
                }
                else
                {
                    return id1;
                }
            }
            catch (e)
            {
                return Config.map.id;
            }
            return;
        }// end function

        public static function realToMap(param1)
        {
            if (param1 > 100000)
            {
                return Math.floor(param1 / 1000);
            }
            return param1;
        }// end function

        public static function getRealMapId(param1, param2, param3)
        {
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = Math.floor(param2);
            var _loc_7:* = Math.floor(param3);
            var _loc_8:* = param1;
            if (mapSplitMap[_loc_8] != null)
            {
                _loc_4 = 0;
                while (_loc_4 < mapSplitMap[_loc_8].length)
                {
                    
                    if (mapSplitMap[_loc_8][_loc_4][_loc_6 + "_" + _loc_7])
                    {
                        return _loc_8 * 1000 + _loc_4;
                    }
                    _loc_4 = _loc_4 + 1;
                }
            }
            else
            {
                return _loc_8;
            }
            return;
        }// end function

        public static function goRealMap(param1, param2 = null, param3 = null)
        {
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            stop();
            var _loc_8:* = Math.floor(param2 / Map._ptPerTile * 2);
            var _loc_9:* = Math.floor(param3 / Map._ptPerTile * 2);
            if (realMapId == param1)
            {
                Config.player.go(Config.map.tileToMap({_x:_loc_8, _y:_loc_9}), true);
            }
            else
            {
                _path = realFindPath(param1);
                if (_path.length > 1)
                {
                    if (param2 != null)
                    {
                        _positionBuff = {_x:param2, _y:param3};
                    }
                    _loc_6 = fingNearJump(_path[0].id, _path[1].id);
                    _loc_7 = Config.map.tileToMap(_loc_6);
                    _loc_6._x = _loc_7._x;
                    _loc_6._y = _loc_7._y;
                    Config.player.stop(false, true);
                    Config.player.target = _loc_6;
                    _path.shift();
                    Config.map.removeEventListener("complete", handleMapComplete);
                    Config.map.addEventListener("complete", handleMapComplete);
                }
            }
            return;
        }// end function

        public static function goMap(param1, param2 = null, param3 = null)
        {
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            if (param2 == null)
            {
                if (!testSame(param1, param2, param3))
                {
                    goMapSub(param1);
                }
                return;
            }
            stop();
            Hang.stop();
            var _loc_8:* = Math.floor(param2 / Map._ptPerTile * 2);
            var _loc_9:* = Math.floor(param3 / Map._ptPerTile * 2);
            if (testSame(param1, param2, param3))
            {
                Config.player.go(Config.map.tileToMap({_x:_loc_8, _y:_loc_9}), true);
            }
            else
            {
                _path = findPath(Config.map.id, param1, _loc_8, _loc_9);
                if (_path.length > 1)
                {
                    _positionBuff = {_x:param2, _y:param3};
                    _loc_6 = fingNearJump(_path[0].id, _path[1].id);
                    _loc_7 = Config.map.tileToMap(_loc_6);
                    _loc_6._x = _loc_7._x;
                    _loc_6._y = _loc_7._y;
                    Config.player.stop(false, true);
                    Config.player.target = _loc_6;
                    _path.shift();
                    Config.map.removeEventListener("complete", handleMapComplete);
                    Config.map.addEventListener("complete", handleMapComplete);
                }
            }
            return;
        }// end function

        private static function goMapSub(param1)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            stop();
            Hang.stopThink();
            if (mapSplitMap[param1] == null)
            {
                _path = realFindPath(param1);
            }
            else
            {
                _loc_3 = [];
                _loc_2 = 0;
                while (_loc_2 < mapSplitMap[param1].length)
                {
                    
                    _loc_4 = realFindPath(param1 * 1000 + _loc_2);
                    _loc_3.push({r:getPathCost(_loc_4), path:_loc_4});
                    _loc_2 = _loc_2 + 1;
                }
                _loc_3.sortOn("r", Array.NUMERIC);
                _path = _loc_3[0].path;
            }
            if (_path.length > 1)
            {
                _loc_5 = fingNearJump(_path[0].id, _path[1].id);
                _loc_6 = Config.map.tileToMap(_loc_5);
                _loc_5._x = _loc_6._x;
                _loc_5._y = _loc_6._y;
                Config.player.stop(false, true);
                Config.player.target = _loc_5;
                _path.shift();
                Config.map.removeEventListener("complete", handleMapComplete);
                Config.map.addEventListener("complete", handleMapComplete);
            }
            return;
        }// end function

        public static function goNpc(param1)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            stop();
            Hang.stop();
            var _loc_6:* = _npcMap[param1];
            if (_npcMap[param1] != null)
            {
                if (realMapId == _loc_6.map)
                {
                    Config.player.target = Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_NPC, Npc._idIndexMap[param1]);
                    return true;
                }
                _path = findPath(Config.map.id, _loc_6.map, _loc_6.x, _loc_6.y);
                if (_path.length > 1)
                {
                    _npcBuff = _loc_6;
                    _loc_4 = fingNearJump(_path[0].id, _path[1].id);
                    _loc_5 = Config.map.tileToMap(_loc_4);
                    _loc_4._x = _loc_5._x;
                    _loc_4._y = _loc_5._y;
                    Config.player.stop(false, true);
                    Config.player.target = _loc_4;
                    _path.shift();
                    Config.map.removeEventListener("complete", handleMapComplete);
                    Config.map.addEventListener("complete", handleMapComplete);
                    return true;
                }
                Config.message(Config.language("DistrictMap", 1));
                return false;
            }
            else
            {
                Config.message(Config.language("DistrictMap", 2));
                return false;
            }
        }// end function

        public static function testNpcNear(param1)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = _npcMap[param1];
            if (_npcMap[param1] != null)
            {
                if (realMapId == _loc_4.map)
                {
                    if (Config.player.target != null && Config.player.target.testTileDistance(Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_NPC, param1)) <= 1)
                    {
                        return true;
                    }
                    return false;
                }
                else
                {
                    return false;
                }
            }
            else
            {
                return false;
            }
        }// end function

        public static function getNearNpc(param1)
        {
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_2:* = [];
            _loc_3 = 0;
            while (_loc_3 < param1.length)
            {
                
                if (_npcMap[param1[_loc_3]] != null)
                {
                    if (Config.map.id == _npcMap[param1[_loc_3]].map)
                    {
                        _loc_2.push({id:param1[_loc_3], r:0});
                    }
                    else
                    {
                        _loc_4 = findPath(Config.map.id, _npcMap[param1[_loc_3]].map, _npcMap[param1[_loc_3]].x, _npcMap[param1[_loc_3]].y);
                        if (_loc_4.length > 1)
                        {
                            _loc_2.push({id:param1[_loc_3], r:(_loc_4.length - 1)});
                        }
                    }
                }
                _loc_3 = _loc_3 + 1;
            }
            _loc_2.sortOn("r", Array.NUMERIC);
            if (_loc_2.length == 0)
            {
                return null;
            }
            return _loc_2[0].id;
        }// end function

        public static function stop()
        {
            _npcBuff = null;
            _positionBuff = null;
            clearTimeout(_doMapCompleteTimer);
            Config.map.removeEventListener("complete", handleMapComplete);
            return;
        }// end function

        private static function handleMapComplete(param1)
        {
            clearTimeout(_doMapCompleteTimer);
            _doMapCompleteTimer = setTimeout(doMapComplete, 200);
            return;
        }// end function

        private static function doMapComplete()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = undefined;
            clearTimeout(_doMapCompleteTimer);
            if (_path.length > 1)
            {
                _loc_1 = fingNearJump(_path[0].id, _path[1].id);
                _loc_2 = Config.map.tileToMap(_loc_1);
                _loc_1._x = _loc_2._x;
                _loc_1._y = _loc_2._y;
                Config.player.target = _loc_1;
                _path.shift();
            }
            else
            {
                if (_npcBuff != null)
                {
                    Config.player.target = Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_NPC, Npc._idIndexMap[_npcBuff.id]);
                }
                else if (_positionBuff != null)
                {
                    Config.player.go(_positionBuff, true);
                }
                stop();
            }
            return;
        }// end function

        private static function fingNearJump(param1, param2)
        {
            var _loc_3:* = undefined;
            var _loc_4:* = {};
            for (_loc_3 in _jumpMap[param1][param2][0])
            {
                
                _loc_4[_loc_3] = _jumpMap[param1][param2][0][_loc_3];
            }
            return _loc_4;
        }// end function

        public static function realFindPath(param1)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = Math.floor(Config.player._currTile._x / 2);
            var _loc_5:* = Math.floor(Config.player._currTile._y / 2);
            var _loc_6:* = Config.map.id;
            if (mapSplitMap[_loc_6] != null)
            {
                _loc_2 = 0;
                while (_loc_2 < mapSplitMap[_loc_6].length)
                {
                    
                    if (mapSplitMap[_loc_6][_loc_2][_loc_4 + "_" + _loc_5])
                    {
                        _astar.setStartPoint(_map[_loc_6 * 1000 + _loc_2]);
                        break;
                    }
                    _loc_2 = _loc_2 + 1;
                }
            }
            else
            {
                _astar.setStartPoint(_map[_loc_6]);
            }
            _astar.setEndPoint(_map[param1]);
            if (_loc_6 == param1)
            {
                return [_map[param1]];
            }
            return _astar.findPath();
        }// end function

        public static function findPath(param1, param2, param3 = null, param4 = null, param5 = null)
        {
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            param1 = Config.map.id;
            var _loc_8:* = Math.floor(Config.player._currTile._x / 2);
            var _loc_9:* = Math.floor(Config.player._currTile._y / 2);
            var _loc_10:* = Math.floor(param3 / 2);
            var _loc_11:* = Math.floor(param4 / 2);
            var _loc_12:* = false;
            var _loc_13:* = false;
            if (mapSplitMap[param1] != null)
            {
                _loc_6 = 0;
                while (_loc_6 < mapSplitMap[param1].length)
                {
                    
                    if (mapSplitMap[param1][_loc_6][_loc_8 + "_" + _loc_9])
                    {
                        _astar.setStartPoint(_map[param1 * 1000 + _loc_6]);
                        _loc_12 = true;
                        break;
                    }
                    _loc_6 = _loc_6 + 1;
                }
            }
            else
            {
                _loc_12 = true;
                _astar.setStartPoint(_map[param1]);
            }
            if (mapSplitMap[param2] != null)
            {
                if (_loc_10 == null)
                {
                    _loc_13 = true;
                    _astar.setEndPoint(_map[param2 * 1000 + param5]);
                }
                else
                {
                    _loc_6 = 0;
                    while (_loc_6 < mapSplitMap[param2].length)
                    {
                        
                        if (mapSplitMap[param2][_loc_6][_loc_10 + "_" + _loc_11])
                        {
                            _loc_13 = true;
                            _astar.setEndPoint(_map[param2 * 1000 + _loc_6]);
                            break;
                        }
                        _loc_6 = _loc_6 + 1;
                    }
                }
            }
            else
            {
                _loc_13 = true;
                _astar.setEndPoint(_map[param2]);
            }
            if (_loc_12 && _loc_13)
            {
                return _astar.findPath();
            }
            return [];
        }// end function

        private static function getPathCost(param1:Array)
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            while (_loc_3 < param1.length)
            {
                
                _loc_2 = _loc_2 + param1[_loc_3].cost;
                _loc_3 = _loc_3 + 1;
            }
            trace("getPathCost", _loc_2);
            return _loc_2;
        }// end function

        public static function sortNearMap(param1:Object, param2:int = -1)
        {
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = null;
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            var _loc_8:* = undefined;
            _loc_5 = [];
            for (_loc_3 in param1)
            {
                
                _loc_7 = param1[_loc_3];
                _loc_6 = realFindPath(_loc_7);
                if (realMapId == _loc_7)
                {
                    _loc_5.push({r:0, map:_loc_7});
                    continue;
                }
                if (_loc_6.length != 0)
                {
                    _loc_5.push({r:getPathCost(_loc_6), map:_loc_7});
                }
            }
            _loc_5.sortOn("r", Array.NUMERIC);
            _loc_8 = [];
            _loc_3 = 0;
            while (_loc_3 < _loc_5.length)
            {
                
                _loc_8.push(_loc_5[_loc_3].map);
                _loc_3 = _loc_3 + 1;
            }
            return _loc_8;
        }// end function

        public static function findMonsterNear()
        {
            var _loc_2:* = undefined;
            var _loc_1:* = [];
            for (_loc_2 in _mapMonsterMatrix[realMapId])
            {
                
                _loc_1.push(_loc_2);
            }
            return _loc_1;
        }// end function

        public static function findMonsterFromMap(param1:uint)
        {
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_2:* = [];
            if (mapSplitMap[param1] != null)
            {
                _loc_3 = 0;
                while (_loc_3 < mapSplitMap[param1].length)
                {
                    
                    if (mapSplitMap[param1][_loc_3])
                    {
                        for (_loc_4 in _mapMonsterMatrix[param1 * 1000 + _loc_3])
                        {
                            
                            _loc_2.push(_loc_4);
                        }
                    }
                    _loc_3 = _loc_3 + 1;
                }
            }
            else
            {
                for (_loc_3 in _mapMonsterMatrix[param1])
                {
                    
                    _loc_2.push(_loc_3);
                }
            }
            return _loc_2;
        }// end function

        public static function findGatherFromMap(param1:uint) : Array
        {
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_2:* = [];
            if (mapSplitMap[param1] != null)
            {
                _loc_3 = 0;
                while (_loc_3 < mapSplitMap[param1].length)
                {
                    
                    if (mapSplitMap[param1][_loc_3])
                    {
                        for (_loc_4 in _mapGatherMatrix[param1 * 1000 + _loc_3])
                        {
                            
                            _loc_2.push(_loc_4);
                        }
                    }
                    _loc_3 = _loc_3 + 1;
                }
            }
            else
            {
                for (_loc_3 in _mapGatherMatrix[param1])
                {
                    
                    _loc_2.push(_loc_3);
                }
            }
            return _loc_2;
        }// end function

        public static function findMapFromNPC(param1:uint) : Array
        {
            var _loc_3:* = undefined;
            var _loc_2:* = [];
            for (_loc_3 in _npcMapMatrix[param1])
            {
                
                _loc_2.push(_loc_3);
            }
            return _loc_2;
        }// end function

        public static function findMapFromMonster(param1:uint, param2:Object = null)
        {
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_3:* = [];
            for (_loc_4 in _monsterMapMatrix[param1])
            {
                
                _loc_5 = int(Config._mapMap[realToMap(_loc_4)].mapData.type);
                if (param2 == null || param2[_loc_5])
                {
                    _loc_3.push(_loc_4);
                }
            }
            return _loc_3;
        }// end function

        public static function findMapFromGather(param1:uint)
        {
            var _loc_3:* = undefined;
            var _loc_2:* = [];
            for (_loc_3 in _gatherMapMatrix[param1])
            {
                
                _loc_2.push(_loc_3);
            }
            return _loc_2;
        }// end function

        public static function findMap(param1, param2) : int
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            if (param1 == UNIT_TYPE_ENUM.TYPEID_NPC)
            {
                _loc_3 = findMapFromNPC(param2);
                if (_loc_3 != null)
                {
                    _loc_4 = sortNearMap(_loc_3);
                    if (_loc_4.length > 0)
                    {
                        return realToMap(_loc_4[0]);
                    }
                    return null;
                }
                else
                {
                    return null;
                }
            }
            else if (param1 == UNIT_TYPE_ENUM.TYPEID_UNIT)
            {
                _loc_5 = Config._monsterMap[param2].type;
                if (_loc_5 == 2)
                {
                    _loc_6 = {16:true, 17:true};
                    _loc_3 = findMapFromMonster(param2, _loc_6);
                }
                else
                {
                    _loc_3 = findMapFromMonster(param2);
                }
                if (_loc_3 != null)
                {
                    _loc_4 = sortNearMap(_loc_3);
                    if (_loc_4.length > 0)
                    {
                        return realToMap(_loc_4[0]);
                    }
                    return null;
                }
                else
                {
                    return null;
                }
            }
            else if (param1 == UNIT_TYPE_ENUM.TYPEID_GATHER)
            {
                _loc_3 = findMapFromGather(param2);
                if (_loc_3 != null)
                {
                    _loc_4 = sortNearMap(_loc_3);
                    if (_loc_4.length > 0)
                    {
                        return realToMap(_loc_4[0]);
                    }
                    return null;
                }
                else
                {
                    return null;
                }
            }
            return null;
        }// end function

        public static function getNpcRefreshType(param1, param2)
        {
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_7:* = _npcMapMatrix[param1][param2];
            var _loc_8:* = [];
            for (_loc_3 in _loc_7)
            {
                
                _loc_8.push(_loc_7[_loc_3]);
            }
            return _loc_8;
        }// end function

        public static function getGatherRefreshType(param1, param2)
        {
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_7:* = _gatherMapMatrix[param1][param2];
            var _loc_8:* = [];
            for (_loc_3 in _loc_7)
            {
                
                _loc_6 = _loc_7[_loc_3]._type;
                if (_loc_6 == 1)
                {
                    return null;
                }
                _loc_8.push(_loc_7[_loc_3]);
            }
            return _loc_8;
        }// end function

        public static function getMonsterRefreshType(param1, param2)
        {
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_7:* = _monsterMapMatrix[param1][param2];
            var _loc_8:* = [];
            for (_loc_3 in _loc_7)
            {
                
                _loc_6 = _loc_7[_loc_3]._type;
                if (_loc_6 == 1)
                {
                    return null;
                }
                _loc_8.push(_loc_7[_loc_3]);
            }
            return _loc_8;
        }// end function

        public static function init()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            var _loc_8:* = undefined;
            var _loc_9:* = undefined;
            var _loc_10:* = undefined;
            var _loc_11:* = undefined;
            var _loc_12:* = undefined;
            var _loc_13:* = undefined;
            var _loc_14:* = undefined;
            var _loc_15:* = undefined;
            var _loc_18:* = undefined;
            var _loc_19:* = undefined;
            var _loc_20:* = undefined;
            var _loc_21:* = undefined;
            var _loc_22:* = undefined;
            var _loc_23:* = undefined;
            var _loc_24:* = undefined;
            _astar = new DistrictAstar();
            var _loc_16:* = [];
            var _loc_17:* = [];
            _splitMap = [];
            for (_loc_1 in Config._mapMap)
            {
                
                _mapNameMap[String(Config._mapMap[_loc_1].mapData.name)] = _loc_1;
                var _loc_27:* = Config._mapMap[_loc_1].flagData != null && Config._mapMap[_loc_1].flagData.data != null;
                _loc_7 = Config._mapMap[_loc_1].flagData != null && Config._mapMap[_loc_1].flagData.data != null;
                if (_loc_27)
                {
                    _loc_7 = Config._mapMap[_loc_1].flagData.data;
                    if (!(_loc_7 is Array))
                    {
                        _loc_7 = [_loc_7];
                    }
                }
                else
                {
                    _loc_7 = [];
                }
                _loc_10 = false;
                _loc_2 = 0;
                while (_loc_2 < _loc_7.length)
                {
                    
                    _loc_15 = _loc_7[_loc_2];
                    if (_loc_15.type == "split_map")
                    {
                        _loc_10 = true;
                        break;
                    }
                    _loc_2 = _loc_2 + 1;
                }
                if (!_loc_10)
                {
                    _map[_loc_1] = new District(_loc_1, 1);
                    if (Config._mapCost[_loc_1] != null)
                    {
                        _map[_loc_1].setCost(Number(Config._mapCost[_loc_1].cost));
                    }
                    _loc_16.push(_map[_loc_1]);
                    _loc_17[_loc_1] = Config._mapMap[_loc_1];
                    continue;
                }
                mapSplitMap[_loc_1] = [];
                _loc_11 = [];
                _loc_13 = 0;
                _loc_12 = Map.getBlockMap(Config._mapMap[_loc_1].mapData, Config._mapMap[_loc_1].flagData);
                _loc_2 = 0;
                while (_loc_2 < _loc_7.length)
                {
                    
                    _loc_15 = _loc_7[_loc_2];
                    if (_loc_15.type == "split_map")
                    {
                        _loc_11[_loc_13] = Map.getUnblockArea(_loc_12, Math.floor(Number(_loc_15.x) / 2), Math.floor(Number(_loc_15.y) / 2));
                        _splitMap[_loc_1 * 1000 + _loc_13] = {};
                        _loc_3 = 0;
                        while (_loc_3 < _loc_11[_loc_13].length)
                        {
                            
                            _splitMap[_loc_1 * 1000 + _loc_13][_loc_11[_loc_13][_loc_3].x + "_" + _loc_11[_loc_13][_loc_3].y] = true;
                            _loc_3 = _loc_3 + 1;
                        }
                        mapSplitMap[_loc_1].push(_splitMap[_loc_1 * 1000 + _loc_13]);
                        _map[_loc_1 * 1000 + _loc_13] = new District(_loc_1 * 1000 + _loc_13, 1);
                        if (Config._mapCost[_loc_1] != null)
                        {
                            _map[_loc_1 * 1000 + _loc_13].setCost(Number(Config._mapCost[_loc_1].cost));
                        }
                        _loc_16.push(_map[_loc_1 * 1000 + _loc_13]);
                        _loc_17[_loc_1 * 1000 + _loc_13] = Config._mapMap[_loc_1];
                        _loc_13 = _loc_13 + 1;
                    }
                    _loc_2 = _loc_2 + 1;
                }
            }
            for (_loc_1 in _map)
            {
                
                if (_loc_17[_loc_1].flagData != null && _loc_17[_loc_1].flagData.data != null)
                {
                    _loc_7 = _loc_17[_loc_1].flagData.data;
                    if (!(_loc_7 is Array))
                    {
                        _loc_7 = [_loc_7];
                    }
                }
                else
                {
                    _loc_7 = [];
                }
                _jumpMap[_loc_1] = {};
                _loc_2 = 0;
                while (_loc_2 < _loc_7.length)
                {
                    
                    _loc_15 = _loc_7[_loc_2];
                    if (_loc_15.type == "jump_map")
                    {
                        if (Number(_loc_15.mapId) != Number(_loc_1))
                        {
                            if (_splitMap[_loc_1] != null)
                            {
                                if (_splitMap[_loc_1][Math.floor(Number(_loc_15.x) / 2) + "_" + Math.floor(Number(_loc_15.y) / 2)])
                                {
                                    if (mapSplitMap[Number(_loc_15.mapId)] != null)
                                    {
                                        _loc_3 = 0;
                                        while (_loc_3 < mapSplitMap[Number(_loc_15.mapId)].length)
                                        {
                                            
                                            if (mapSplitMap[Number(_loc_15.mapId)][_loc_3][Math.floor(Number(_loc_15.mapX) / 2) + "_" + Math.floor(Number(_loc_15.mapY) / 2)])
                                            {
                                                if (_jumpMap[_loc_1][Number(_loc_15.mapId) * 1000 + _loc_3] == null)
                                                {
                                                    _jumpMap[_loc_1][Number(_loc_15.mapId) * 1000 + _loc_3] = [];
                                                }
                                                _map[_loc_1].setNeighbor(_map[Number(_loc_15.mapId) * 1000 + _loc_3]);
                                                _jumpMap[_loc_1][Number(_loc_15.mapId) * 1000 + _loc_3].push({_x:Number(_loc_15.x), _y:Number(_loc_15.y), jump:_loc_15});
                                            }
                                            _loc_3 = _loc_3 + 1;
                                        }
                                    }
                                    else
                                    {
                                        if (_jumpMap[_loc_1][Number(_loc_15.mapId)] == null)
                                        {
                                            _jumpMap[_loc_1][Number(_loc_15.mapId)] = [];
                                        }
                                        _map[_loc_1].setNeighbor(_map[Number(_loc_15.mapId)]);
                                        _jumpMap[_loc_1][Number(_loc_15.mapId)].push({_x:Number(_loc_15.x), _y:Number(_loc_15.y), jump:_loc_15});
                                    }
                                }
                            }
                            else if (mapSplitMap[Number(_loc_15.mapId)] != null)
                            {
                                _loc_3 = 0;
                                while (_loc_3 < mapSplitMap[Number(_loc_15.mapId)].length)
                                {
                                    
                                    if (mapSplitMap[Number(_loc_15.mapId)][_loc_3][Math.floor(Number(_loc_15.mapX) / 2) + "_" + Math.floor(Number(_loc_15.mapY) / 2)])
                                    {
                                        if (_jumpMap[_loc_1][Number(_loc_15.mapId) * 1000 + _loc_3] == null)
                                        {
                                            _jumpMap[_loc_1][Number(_loc_15.mapId) * 1000 + _loc_3] = [];
                                        }
                                        _map[_loc_1].setNeighbor(_map[Number(_loc_15.mapId) * 1000 + _loc_3]);
                                        _jumpMap[_loc_1][Number(_loc_15.mapId) * 1000 + _loc_3].push({_x:Number(_loc_15.x), _y:Number(_loc_15.y), jump:_loc_15});
                                    }
                                    _loc_3 = _loc_3 + 1;
                                }
                            }
                            else
                            {
                                if (_jumpMap[_loc_1][Number(_loc_15.mapId)] == null)
                                {
                                    _jumpMap[_loc_1][Number(_loc_15.mapId)] = [];
                                }
                                _map[_loc_1].setNeighbor(_map[Number(_loc_15.mapId)]);
                                _jumpMap[_loc_1][Number(_loc_15.mapId)].push({_x:Number(_loc_15.x), _y:Number(_loc_15.y), jump:_loc_15});
                            }
                        }
                    }
                    _loc_2 = _loc_2 + 1;
                }
                if (_loc_17[_loc_1].npcData != null && _loc_17[_loc_1].npcData.data != null)
                {
                    _loc_7 = _loc_17[_loc_1].npcData.data;
                    if (!(_loc_7 is Array))
                    {
                        _loc_7 = [_loc_7];
                    }
                }
                else
                {
                    _loc_7 = [];
                }
                _loc_22 = {};
                for (_loc_2 in Config._portalMap)
                {
                    
                    _loc_15 = Config._portalMap[_loc_2];
                    if (_loc_22[Number(_loc_15.portalId)] == null)
                    {
                        _loc_22[Number(_loc_15.portalId)] = [];
                    }
                    _loc_22[Number(_loc_15.portalId)].push(_loc_15);
                }
                _loc_2 = 0;
                while (_loc_2 < _loc_7.length)
                {
                    
                    _loc_15 = _loc_7[_loc_2];
                    _loc_19 = Config._npcMap[Number(_loc_15.id)];
                    if (_loc_19.portalId != 0)
                    {
                        _loc_20 = _loc_22[Number(_loc_19.portalId)];
                        _loc_3 = 0;
                        while (_loc_3 < _loc_20.length)
                        {
                            
                            _loc_21 = _loc_20[_loc_3];
                            if (Number(_loc_21.price) == 0)
                            {
                                _map[_loc_1].setNeighbor(_map[Number(_loc_21.mapId)], Number(_loc_21.lv));
                                if (_jumpMap[_loc_1][Number(_loc_21.mapId)] == null)
                                {
                                    _jumpMap[_loc_1][Number(_loc_21.mapId)] = [];
                                }
                                _jumpMap[_loc_1][Number(_loc_21.mapId)].push({_x:Number(_loc_15.x), _y:Number(_loc_15.y), portal:_loc_21, npcid:Number(_loc_15.id)});
                            }
                            _loc_3 = _loc_3 + 1;
                        }
                    }
                    _loc_2 = _loc_2 + 1;
                }
            }
            for (_loc_1 in Config._mapMap)
            {
                
                if (Config._mapMap[_loc_1].npcData != null && Config._mapMap[_loc_1].npcData.data != null)
                {
                    _loc_7 = Config._mapMap[_loc_1].npcData.data;
                    if (!(_loc_7 is Array))
                    {
                        _loc_7 = [_loc_7];
                    }
                }
                else
                {
                    _loc_7 = [];
                }
                _loc_2 = 0;
                while (_loc_2 < _loc_7.length)
                {
                    
                    _loc_15 = _loc_7[_loc_2];
                    if (mapSplitMap[_loc_1] == null)
                    {
                        _loc_18 = _loc_1;
                    }
                    else
                    {
                        _loc_3 = 0;
                        while (_loc_3 < mapSplitMap[_loc_1].length)
                        {
                            
                            if (mapSplitMap[_loc_1][_loc_3][Math.floor(Number(_loc_15.x) / 2) + "_" + Math.floor(Number(_loc_15.y) / 2)])
                            {
                                _loc_18 = _loc_1 * 1000 + _loc_3;
                                break;
                            }
                            _loc_3 = _loc_3 + 1;
                        }
                    }
                    _npcMap[Number(_loc_15.id)] = {id:Number(_loc_15.id), map:_loc_18, _x:Number(_loc_15.x), _y:Number(_loc_15.y)};
                    if (_mapNpcMatrix[_loc_18] == null)
                    {
                        _mapNpcMatrix[_loc_18] = [];
                    }
                    if (_mapNpcMatrix[_loc_18][Number(_loc_15.id)] == null)
                    {
                        _mapNpcMatrix[_loc_18][Number(_loc_15.id)] = [];
                    }
                    _mapNpcMatrix[_loc_18][Number(_loc_15.id)].push({_x:Number(_loc_15.x), _y:Number(_loc_15.y)});
                    if (_npcMapMatrix[Number(_loc_15.id)] == null)
                    {
                        _npcMapMatrix[Number(_loc_15.id)] = [];
                    }
                    if (_npcMapMatrix[Number(_loc_15.id)][_loc_18] == null)
                    {
                        _npcMapMatrix[Number(_loc_15.id)][_loc_18] = [];
                    }
                    _npcMapMatrix[Number(_loc_15.id)][_loc_18].push({_x:Number(_loc_15.x), _y:Number(_loc_15.y)});
                    _loc_2 = _loc_2 + 1;
                }
                if (Config._mapMap[_loc_1].monsterData != null && Config._mapMap[_loc_1].monsterData.data != null)
                {
                    _loc_7 = Config._mapMap[_loc_1].monsterData.data;
                    if (!(_loc_7 is Array))
                    {
                        _loc_7 = [_loc_7];
                    }
                }
                else
                {
                    _loc_7 = [];
                }
                _loc_2 = 0;
                while (_loc_2 < _loc_7.length)
                {
                    
                    _loc_15 = _loc_7[_loc_2];
                    if (mapSplitMap[_loc_1] == null)
                    {
                        _loc_18 = _loc_1;
                    }
                    else
                    {
                        _loc_3 = 0;
                        while (_loc_3 < mapSplitMap[_loc_1].length)
                        {
                            
                            if (mapSplitMap[_loc_1][_loc_3][Math.floor(_loc_15.x / 2) + "_" + Math.floor(_loc_15.y / 2)])
                            {
                                _loc_18 = _loc_1 * 1000 + _loc_3;
                                break;
                            }
                            _loc_3 = _loc_3 + 1;
                        }
                    }
                    _loc_8 = Config._monsterGroupMap[_loc_15.id];
                    if (_loc_8 != null)
                    {
                        _loc_3 = 1;
                        while (_loc_3 < 4)
                        {
                            
                            if (_loc_8["monsterid" + _loc_3] != 0)
                            {
                                if (_monsterMap[Number(_loc_8["monsterid" + _loc_3])] == null)
                                {
                                    _monsterMap[Number(_loc_8["monsterid" + _loc_3])] = [];
                                }
                                _monsterMap[Number(_loc_8["monsterid" + _loc_3])].push({id:Number(_loc_8["monsterid" + _loc_3]), map:_loc_18, _x:Number(_loc_15.x), _y:Number(_loc_15.y), _type:Number(_loc_8.refreshType)});
                                if (_mapMonsterMatrix[_loc_18] == null)
                                {
                                    _mapMonsterMatrix[_loc_18] = [];
                                }
                                if (_mapMonsterMatrix[_loc_18][_loc_8["monsterid" + _loc_3]] == null)
                                {
                                    _mapMonsterMatrix[_loc_18][_loc_8["monsterid" + _loc_3]] = [];
                                }
                                _mapMonsterMatrix[_loc_18][_loc_8["monsterid" + _loc_3]].push({_x:_loc_15.x, _y:_loc_15.y, _type:_loc_8.refreshType});
                                if (_monsterMapMatrix[_loc_8["monsterid" + _loc_3]] == null)
                                {
                                    _monsterMapMatrix[_loc_8["monsterid" + _loc_3]] = [];
                                }
                                if (_monsterMapMatrix[_loc_8["monsterid" + _loc_3]][_loc_18] == null)
                                {
                                    _monsterMapMatrix[_loc_8["monsterid" + _loc_3]][_loc_18] = [];
                                }
                                _monsterMapMatrix[_loc_8["monsterid" + _loc_3]][_loc_18].push({_x:_loc_15.x, _y:_loc_15.y, _type:_loc_8.refreshType});
                            }
                            _loc_3 = _loc_3 + 1;
                        }
                    }
                    _loc_2 = _loc_2 + 1;
                }
                if (Config._mapMap[_loc_1].gatherData != null && Config._mapMap[_loc_1].gatherData.data != null)
                {
                    _loc_7 = Config._mapMap[_loc_1].gatherData.data;
                    if (!(_loc_7 is Array))
                    {
                        _loc_7 = [_loc_7];
                    }
                }
                else
                {
                    _loc_7 = [];
                }
                _loc_2 = 0;
                while (_loc_2 < _loc_7.length)
                {
                    
                    _loc_15 = _loc_7[_loc_2];
                    if (mapSplitMap[_loc_1] == null)
                    {
                        _loc_18 = _loc_1;
                    }
                    else
                    {
                        _loc_3 = 0;
                        while (_loc_3 < mapSplitMap[_loc_1].length)
                        {
                            
                            if (mapSplitMap[_loc_1][_loc_3][Math.floor(Number(_loc_15.x) / 2) + "_" + Math.floor(Number(_loc_15.y) / 2)])
                            {
                                _loc_18 = _loc_1 * 1000 + _loc_3;
                                break;
                            }
                            _loc_3 = _loc_3 + 1;
                        }
                    }
                    _loc_8 = Config._gatherGroupMap[Number(_loc_15.id)];
                    if (_loc_8 != null)
                    {
                        _loc_3 = 1;
                        while (_loc_3 < 4)
                        {
                            
                            if (_loc_8["gatherid" + _loc_3] != 0)
                            {
                                _loc_9 = _loc_8["gatherid" + _loc_3];
                                if (Config._gatherMap[_loc_9] != null)
                                {
                                    if (_gatherMap[_loc_9] == null)
                                    {
                                        _gatherMap[_loc_9] = [];
                                    }
                                    _gatherMap[_loc_9].push({id:_loc_9, map:_loc_18, _x:_loc_15.x, _y:_loc_15.y, _type:_loc_8.refreshType});
                                    if (_mapGatherMatrix[_loc_18] == null)
                                    {
                                        _mapGatherMatrix[_loc_18] = [];
                                    }
                                    if (_mapGatherMatrix[_loc_18][_loc_9] == null)
                                    {
                                        _mapGatherMatrix[_loc_18][_loc_9] = [];
                                    }
                                    _mapGatherMatrix[_loc_18][_loc_9].push({_x:_loc_15.x, _y:_loc_15.y, _type:_loc_8.refreshType});
                                    if (_gatherMapMatrix[_loc_9] == null)
                                    {
                                        _gatherMapMatrix[_loc_9] = [];
                                    }
                                    if (_gatherMapMatrix[_loc_9][_loc_18] == null)
                                    {
                                        _gatherMapMatrix[_loc_9][_loc_18] = [];
                                    }
                                    _gatherMapMatrix[_loc_9][_loc_18].push({_x:_loc_15.x, _y:_loc_15.y, _type:_loc_8.refreshType});
                                }
                            }
                            _loc_3 = _loc_3 + 1;
                        }
                    }
                    _loc_2 = _loc_2 + 1;
                }
                _loc_2 = 0;
                while (_loc_2 < _loc_7.length)
                {
                    
                    _loc_15 = _loc_7[_loc_2];
                    if (String(_loc_15.type) == "task")
                    {
                        _loc_23 = Number(_loc_15.taskId);
                        _loc_24 = Number(_loc_15.eventId);
                        if (_tflagMap[_loc_23] == null)
                        {
                            _tflagMap[_loc_23] = [];
                        }
                        if (_tflagMap[_loc_23][_loc_24] == null)
                        {
                            _tflagMap[_loc_23][_loc_24] = [];
                        }
                        _tflagMap[_loc_23][_loc_24].push({mapId:_loc_18, _x:Number(_loc_15.x), _y:Number(_loc_15.y)});
                    }
                    _loc_2 = _loc_2 + 1;
                }
            }
            _astar.setMap(_loc_16);
            return;
        }// end function

    }
}
