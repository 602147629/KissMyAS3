package battle
{
    import formation.*;
    import skill.*;
    import utility.*;

    public class BattleUtilityTarget extends Object
    {

        public function BattleUtilityTarget()
        {
            return;
        }// end function

        public static function getTargetEnemy(param1:Array) : PositionedTarget
        {
            var _loc_2:* = new PositionedTarget(BattleConstant.TARGET_ENEMY_ROW, BattleConstant.TARGET_ENEMY_COL, CommonConstant.BATTLE_TARGET_ENEMY_RAY_SIZE);
            _loc_2.setEnemy(param1);
            return _loc_2;
        }// end function

        public static function getTargetPlayer(param1:Array, param2:FormationInformation) : PositionedTarget
        {
            var _loc_3:* = new PositionedTarget(BattleConstant.TARGET_PLAYER_ROW, BattleConstant.TARGET_PLAYER_COL, CommonConstant.BATTLE_TARGET_PLAYER_RAY_SIZE);
            _loc_3.setPlayer(param1, param2);
            return _loc_3;
        }// end function

        public static function targetting(param1:int, param2:BattleCharacterBase, param3:AttackCharacterStatus, param4:Boolean, param5:PositionedTarget, param6:PositionedTarget, param7:BattleManager) : BattleTargetingResult
        {
            var _loc_8:* = SkillManager.getInstance().getSkillInformation(param1);
            var _loc_9:* = [];
            var _loc_10:* = _loc_8.targetType;
            if (_loc_8.invokeType == SkillConstant.INVOKE_TYPE_COUNTER)
            {
                _loc_10 = SkillConstant.TARGET_TYPE_SELF;
            }
            switch(_loc_10)
            {
                case SkillConstant.TARGET_TYPE_ENEMY:
                {
                    if (param2.division == BattleConstant.DIVISION_PLAYER && param4 == false || param2.division == BattleConstant.DIVISION_ENEMY && param4 == true)
                    {
                        _loc_9 = selectMainSubTarget(param6, _loc_8, param7);
                    }
                    else
                    {
                        _loc_9 = selectMainSubTarget(param5, _loc_8, param7);
                    }
                    break;
                }
                case SkillConstant.TARGET_TYPE_PLAYER:
                {
                    if (param2.division == BattleConstant.DIVISION_PLAYER && param4 == false || param2.division == BattleConstant.DIVISION_ENEMY && param4 == true)
                    {
                        _loc_9 = selectMainSubTarget(param5, _loc_8, param7);
                    }
                    else
                    {
                        _loc_9 = selectMainSubTarget(param6, _loc_8, param7);
                    }
                    break;
                }
                case SkillConstant.TARGET_TYPE_SELF:
                {
                    _loc_9 = [param3.questUniqueId];
                    break;
                }
                default:
                {
                    break;
                }
            }
            return new BattleTargetingResult(_loc_8, _loc_9);
        }// end function

        public static function targettingCounter(param1:int, param2:AttackCharacterStatus, param3:AttackCharacterStatus, param4:PositionedTarget, param5:PositionedTarget, param6:BattleManager) : BattleTargetingResult
        {
            var _loc_9:* = null;
            var _loc_7:* = SkillManager.getInstance().getSkillInformation(param1);
            var _loc_8:* = [];
            if (_loc_7.targetType != SkillConstant.TARGET_TYPE_SELF)
            {
                _loc_9 = param3.division == BattleConstant.DIVISION_PLAYER ? (param4) : (param5);
                _loc_8 = selectSubTarget(_loc_9, _loc_7, param3.questUniqueId);
            }
            else
            {
                _loc_8 = [param2.questUniqueId];
            }
            return new BattleTargetingResult(_loc_7, _loc_8);
        }// end function

        public static function selectMainSubTarget(param1:PositionedTarget, param2:SkillInformation, param3:BattleManager) : Array
        {
            var _loc_4:* = [];
            var _loc_5:* = param2.mainTarget;
            var _loc_6:* = param2.effectRange;
            switch(_loc_5)
            {
                case SkillConstant.MAIN_TARGET_DIRECT:
                {
                    _loc_4 = getTargetRangeNormal(param1);
                    break;
                }
                case SkillConstant.MAIN_TARGET_INDIRECT:
                {
                    _loc_4 = getTargetRangeLong(param1);
                    break;
                }
                case SkillConstant.MAIN_TARGET_RANGE_CUSTOM:
                {
                    _loc_4 = getTargetRangeCustom(param1, _loc_6);
                    break;
                }
                case SkillConstant.MAIN_TARGET_STATE_CUSTOM:
                {
                    _loc_4 = getTargetStatusCustom(param1, param2);
                    break;
                }
                case SkillConstant.MAIN_TARGET_RANDOM:
                {
                    _loc_4 = getTargetRamdom(param1);
                    break;
                }
                default:
                {
                    _loc_4 = getTargetRangeCustom(param1, _loc_6);
                    break;
                    break;
                }
            }
            return selectSubTarget(param1, param2, _loc_4[0]);
        }// end function

        public static function selectSubTarget(param1:PositionedTarget, param2:SkillInformation, param3:int) : Array
        {
            var _loc_4:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            _loc_4 = [param3];
            var _loc_5:* = null;
            switch(param2.effectRange)
            {
                case SkillConstant.EFFECT_RANGE_SINGLE:
                default:
                {
                    break;
                }
                case SkillConstant.EFFECT_RANGE_VERTICAL:
                {
                    _loc_6 = param1.getTargetRow(_loc_4[0]);
                    _loc_5 = param1.getSideLineTarget(_loc_6, param1.raySize);
                    break;
                }
                case SkillConstant.EFFECT_RANGE_ALL:
                {
                    _loc_7 = param1.getTargetCol(_loc_4[0]);
                    _loc_5 = param1.getVertLineTarget(_loc_7, param1.raySize);
                    break;
                }
                case :
                {
                    _loc_5 = getTargetRangeAll(param1);
                    break;
                    break;
                }
            }
            if (_loc_5 != null)
            {
                for each (_loc_8 in _loc_5)
                {
                    
                    if (_loc_4.indexOf(_loc_8) == -1)
                    {
                        _loc_4.push(_loc_8);
                    }
                }
            }
            return _loc_4;
        }// end function

        private static function getTargetRangeCustom(param1:PositionedTarget, param2:int) : Array
        {
            var _loc_3:* = [];
            switch(param2)
            {
                case SkillConstant.EFFECT_RANGE_SINGLE:
                default:
                {
                    _loc_3 = getTargetRangeNormal(param1);
                    break;
                }
                case SkillConstant.EFFECT_RANGE_VERTICAL:
                {
                    _loc_3 = getTargetRangeCustomMaxSide(param1);
                    break;
                }
                case SkillConstant.EFFECT_RANGE_ALL:
                {
                    _loc_3 = getTargetRangeCustomMaxVert(param1);
                    break;
                }
                case :
                {
                    _loc_3.push(param1.getFirstTarget());
                    break;
                    break;
                }
            }
            return _loc_3;
        }// end function

        private static function getTargetStatusCustom(param1:PositionedTarget, param2:SkillInformation) : Array
        {
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_10:* = 0;
            var _loc_3:* = [];
            var _loc_4:* = [];
            var _loc_5:* = 0;
            var _loc_6:* = BattleAddStatusCalc.recoveryBadStatusIdArray(param2);
            var _loc_7:* = param2.addStatus;
            for each (_loc_8 in param1.aTarget)
            {
                
                if (_loc_8 != 0)
                {
                    _loc_9 = param1.getTargetStatus(_loc_8);
                    if (_loc_9 == null)
                    {
                        continue;
                    }
                    _loc_10 = 0;
                    _loc_10 = _loc_10 + calcValueRecoveryBadStatus(_loc_9, _loc_6);
                    _loc_10 = _loc_10 + calcValueAddBadStatus(_loc_9, _loc_7);
                    if (_loc_5 < _loc_10)
                    {
                        _loc_5 = _loc_10;
                        _loc_4.length = 1;
                        _loc_4[0] = _loc_8;
                        continue;
                    }
                    if (_loc_10 == _loc_5)
                    {
                        _loc_4.push(_loc_8);
                    }
                }
            }
            _loc_3.push(_loc_4[Random.range(0, (_loc_4.length - 1))]);
            return _loc_3;
        }// end function

        public static function getTargetRamdom(param1:PositionedTarget) : Array
        {
            var _loc_4:* = 0;
            var _loc_2:* = [];
            var _loc_3:* = [];
            for each (_loc_4 in param1.aTarget)
            {
                
                if (_loc_4 != 0)
                {
                    _loc_3.push(_loc_4);
                }
            }
            _loc_2.push(_loc_3[Random.range(0, (_loc_3.length - 1))]);
            return _loc_2;
        }// end function

        public static function getTargetRangeLong(param1:PositionedTarget) : Array
        {
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_2:* = [];
            var _loc_3:* = [];
            var _loc_4:* = int.MAX_VALUE;
            for each (_loc_5 in param1.aTarget)
            {
                
                if (_loc_5 != 0)
                {
                    _loc_6 = param1.getTargetHp(_loc_5);
                    if (_loc_6 < _loc_4)
                    {
                        _loc_4 = _loc_6;
                        _loc_3.length = 1;
                        _loc_3[0] = _loc_5;
                        continue;
                    }
                    if (_loc_6 == _loc_4)
                    {
                        _loc_3.push(_loc_5);
                    }
                }
            }
            _loc_2.push(_loc_3[Random.range(0, (_loc_3.length - 1))]);
            return _loc_2;
        }// end function

        public static function getTargetRangeNormal(param1:PositionedTarget) : Array
        {
            var _loc_3:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_2:* = [];
            var _loc_4:* = [];
            _loc_3 = 0;
            while (_loc_3 < param1.row)
            {
                
                _loc_4.push(param1.getRowHeadCol(_loc_3));
                _loc_3++;
            }
            _loc_3 = 0;
            while (_loc_3 < param1.row)
            {
                
                if (_loc_4[_loc_3] < 0)
                {
                }
                else
                {
                    _loc_5 = searchRowHitTarget(param1, _loc_3, _loc_4);
                    for each (_loc_6 in _loc_5)
                    {
                        
                        if (_loc_6 != 0 && _loc_2.indexOf(_loc_6) == -1)
                        {
                            _loc_2.push(_loc_6);
                        }
                    }
                }
                _loc_3++;
            }
            _loc_2 = [lotProbability(param1, _loc_2)];
            return _loc_2;
        }// end function

        private static function getTargetRangeCustomMaxSide(param1:PositionedTarget) : Array
        {
            var _loc_4:* = 0;
            var _loc_6:* = 0;
            var _loc_2:* = [];
            var _loc_3:* = 0;
            var _loc_5:* = 0;
            while (_loc_5 < param1.row)
            {
                
                _loc_4 = param1.getRowHeadTarget(_loc_5);
                if (_loc_4 == 0)
                {
                }
                else
                {
                    _loc_6 = param1.getSideLineTarget(_loc_5, param1.raySize).length;
                    if (_loc_3 < _loc_6)
                    {
                        _loc_3 = _loc_6;
                        _loc_2.length = 1;
                        _loc_2[0] = _loc_4;
                    }
                    else if (_loc_3 == _loc_6)
                    {
                        _loc_2.push(_loc_4);
                    }
                }
                _loc_5++;
            }
            _loc_4 = _loc_2[Random.range(0, (_loc_2.length - 1))];
            _loc_2 = [_loc_4];
            return _loc_2;
        }// end function

        private static function getTargetRangeCustomMaxVert(param1:PositionedTarget) : Array
        {
            var _loc_4:* = 0;
            var _loc_6:* = 0;
            var _loc_2:* = [];
            var _loc_3:* = 0;
            var _loc_5:* = 0;
            while (_loc_5 < param1.col)
            {
                
                _loc_4 = param1.getColMiddleTarget(_loc_5);
                if (_loc_4 == 0)
                {
                }
                else
                {
                    _loc_6 = param1.getVertLineTarget(_loc_5, param1.raySize).length;
                    if (_loc_3 < _loc_6)
                    {
                        _loc_3 = _loc_6;
                        _loc_2.length = 1;
                        _loc_2[0] = _loc_4;
                    }
                    else if (_loc_3 == _loc_6)
                    {
                        _loc_2.push(_loc_4);
                    }
                }
                _loc_5++;
            }
            _loc_4 = _loc_2[Random.range(0, (_loc_2.length - 1))];
            _loc_2 = [_loc_4];
            return _loc_2;
        }// end function

        public static function getTargetRangeArea(param1:PositionedTarget, param2:Array) : Array
        {
            if (param2.length != 1)
            {
                return param2.concat();
            }
            var _loc_3:* = param2.concat();
            var _loc_4:* = param2[0];
            var _loc_5:* = param1.getTargetRow(_loc_4);
            var _loc_6:* = param1.getTargetCol(_loc_4);
            var _loc_7:* = 1 + param1.raySize;
            _loc_7 = 1 + param1.raySize - 1;
            getTargetRangeAreaHelper(_loc_3, param1, _loc_5, (_loc_6 - 1), _loc_7, 4 | 8);
            getTargetRangeAreaHelper(_loc_3, param1, (_loc_5 - 1), _loc_6, _loc_7, 8 | 1);
            getTargetRangeAreaHelper(_loc_3, param1, _loc_5, (_loc_6 + 1), _loc_7, 1 | 2);
            getTargetRangeAreaHelper(_loc_3, param1, (_loc_5 + 1), _loc_6, _loc_7, 2 | 4);
            return _loc_3;
        }// end function

        private static function getTargetRangeAreaHelper(param1:Array, param2:PositionedTarget, param3:int, param4:int, param5:int, param6:uint) : void
        {
            var _loc_7:* = param2.questUniqueId(param3, param4);
            if (param2.questUniqueId(param3, param4) != 0 && param1.indexOf(_loc_7) == -1)
            {
                param1.push(_loc_7);
            }
            if (param5 > 0)
            {
                param5 = param5 - 1;
                if ((param6 & 1) == 0)
                {
                    getTargetRangeAreaHelper(param1, param2, param3, (param4 - 1), param5, param6 | 4 | 8);
                }
                if ((param6 & 2) == 0)
                {
                    getTargetRangeAreaHelper(param1, param2, (param3 - 1), param4, param5, param6 | 8 | 1);
                }
                if ((param6 & 4) == 0)
                {
                    getTargetRangeAreaHelper(param1, param2, param3, (param4 + 1), param5, param6 | 1 | 2);
                }
                if ((param6 & 8) == 0)
                {
                    getTargetRangeAreaHelper(param1, param2, (param3 + 1), param4, param5, param6 | 2 | 4);
                }
            }
            return;
        }// end function

        public static function getTargetRangeAll(param1:PositionedTarget) : Array
        {
            var _loc_3:* = 0;
            var _loc_2:* = [];
            for each (_loc_3 in param1.aTarget)
            {
                
                if (_loc_3 != 0)
                {
                    _loc_2.push(_loc_3);
                }
            }
            return _loc_2;
        }// end function

        public static function getTargetRangePlayerAll(param1:Array) : Array
        {
            var _loc_3:* = 0;
            var _loc_2:* = [];
            for each (_loc_3 in param1)
            {
                
                if (_loc_3 != 0)
                {
                    _loc_2.push(_loc_3);
                }
            }
            return _loc_2;
        }// end function

        private static function lotProbability(param1:PositionedTarget, param2:Array) : int
        {
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_3:* = new LotList();
            var _loc_4:* = [];
            var _loc_5:* = 0;
            for each (_loc_6 in param2)
            {
                
                if (_loc_6 == 0)
                {
                    continue;
                }
                _loc_7 = param1.getTargetProbability(_loc_6);
                _loc_3.addTarget(_loc_6, _loc_7);
                _loc_4.push(_loc_6);
                _loc_5 = _loc_5 + _loc_7;
            }
            if (_loc_5 <= 0)
            {
                _loc_3.clearTarget();
                _loc_8 = 0;
                while (_loc_8 < _loc_4.length)
                {
                    
                    _loc_3.addTarget(_loc_4[_loc_8], 1);
                    _loc_8++;
                }
            }
            return Lot.lotTarget(_loc_3) as int;
        }// end function

        private static function searchRowHitTarget(param1:PositionedTarget, param2:int, param3:Array) : Array
        {
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_4:* = [];
            var _loc_5:* = param3[param2];
            if (param3[param2] >= 0)
            {
                _loc_6 = param1.raySize;
                _loc_7 = 0;
                while (_loc_7 < _loc_5)
                {
                    
                    if (searchRowHitTargetHelper_Check(param3, param2, _loc_7, _loc_6))
                    {
                        searchRowHitTargetHelper_Pick(_loc_4, param3, param2, _loc_7, _loc_6, param1);
                        break;
                    }
                    _loc_7++;
                }
                if (_loc_7 >= _loc_5)
                {
                    _loc_4 = [param1.questUniqueId(param2, _loc_5)];
                }
            }
            return _loc_4;
        }// end function

        private static function searchRowHitTargetHelper_Check(param1:Array, param2:int, param3:int, param4:int) : Boolean
        {
            var _loc_5:* = param2 - param4;
            while (_loc_5 <= param2 + param4)
            {
                
                if (_loc_5 >= 0 && _loc_5 < param1.length && param1[_loc_5] >= 0 && param1[_loc_5] <= param3)
                {
                    return true;
                }
                _loc_5++;
            }
            return false;
        }// end function

        private static function searchRowHitTargetHelper_Pick(param1:Array, param2:Array, param3:int, param4:int, param5:int, param6:PositionedTarget) : void
        {
            var _loc_8:* = 0;
            var _loc_7:* = param3 - param5;
            while (_loc_7 <= param3 + param5)
            {
                
                if (_loc_7 >= 0 && _loc_7 < param2.length && param2[_loc_7] >= 0 && param2[_loc_7] <= param4)
                {
                    _loc_8 = param6.questUniqueId(_loc_7, param2[_loc_7]);
                    if (_loc_8 != 0)
                    {
                        param1.push(_loc_8);
                    }
                }
                _loc_7++;
            }
            return;
        }// end function

        private static function calcValueRecoveryBadStatus(param1:AttackCharacterStatus, param2:Array) : int
        {
            var _loc_4:* = 0;
            var _loc_3:* = 0;
            for each (_loc_4 in param2)
            {
                
                if (param1.badStatus.isBadStatus(_loc_4))
                {
                    _loc_3++;
                    break;
                }
            }
            return _loc_3;
        }// end function

        private static function calcValueAddBadStatus(param1:AttackCharacterStatus, param2:int) : int
        {
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_3:* = 0;
            if (param2 != Constant.EMPTY_ID)
            {
                if (param1.badStatus.isBadStatus(param2) == false)
                {
                    _loc_3++;
                }
                _loc_4 = BattleInformationManager.getInstance().getStatusListData(param2);
                _loc_5 = _loc_4 ? (_loc_4.conflictId) : (Constant.EMPTY_ID);
                if (_loc_5 != Constant.EMPTY_ID)
                {
                    if (param1.badStatus.isBadStatus(_loc_5))
                    {
                        _loc_3++;
                    }
                }
            }
            return _loc_3;
        }// end function

    }
}
