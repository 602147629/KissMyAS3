package battle
{
    import formation.*;

    public class PositionedTarget extends Object
    {
        private var _row:int;
        private var _col:int;
        private var _raySize:int;
        private var _aAttackStatus:Array;
        private var _aAll:Array;
        private var _aTarget:Array;
        private var _aProbability:Array;

        public function PositionedTarget(param1:int, param2:int, param3:int)
        {
            this._row = param1;
            this._col = param2;
            this._raySize = param3;
            this._aAttackStatus = [];
            var _loc_4:* = this._row * this._col;
            this._aAll = new Array(_loc_4);
            this._aTarget = new Array(_loc_4);
            this._aProbability = new Array(_loc_4);
            this.clear();
            return;
        }// end function

        public function get row() : int
        {
            return this._row;
        }// end function

        public function get col() : int
        {
            return this._col;
        }// end function

        public function get raySize() : int
        {
            return this._raySize;
        }// end function

        public function get aTarget() : Array
        {
            return this._aTarget;
        }// end function

        public function get aProbability() : Array
        {
            return this._aProbability;
        }// end function

        public function index(param1:int, param2:int) : int
        {
            return param1 * this._col + param2;
        }// end function

        public function toRow(param1:int) : int
        {
            return param1 / this._col;
        }// end function

        public function toCol(param1:int) : int
        {
            return param1 % this._col;
        }// end function

        public function clear() : void
        {
            var _loc_1:* = 0;
            while (_loc_1 < this._aTarget.length)
            {
                
                this._aAll[_loc_1] = 0;
                this._aTarget[_loc_1] = 0;
                this._aProbability[_loc_1] = 0;
                _loc_1++;
            }
            return;
        }// end function

        public function setEnemy(param1:Array) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            this._aAttackStatus = param1;
            for each (_loc_2 in param1)
            {
                
                _loc_3 = _loc_2.formationIndex / this._col;
                _loc_4 = _loc_2.formationIndex % this._col;
                _loc_4 = (this._col - 1) - _loc_4;
                _loc_5 = this.index(_loc_3, _loc_4);
                this._aAll[_loc_5] = _loc_2.questUniqueId;
                if (_loc_2.bDead)
                {
                    continue;
                }
                this._aTarget[_loc_5] = _loc_2.questUniqueId;
                if (_loc_4 == 0)
                {
                    this._aProbability[_loc_5] = CommonConstant.BATTLE_TARGET_PROBABILITY_FRONT;
                    continue;
                }
                if (_loc_4 == (this._col - 1))
                {
                    this._aProbability[_loc_5] = CommonConstant.BATTLE_TARGET_PROBABILITY_BACK;
                    continue;
                }
                this._aProbability[_loc_5] = CommonConstant.BATTLE_TARGET_PROBABILITY_MIDDLE;
            }
            return;
        }// end function

        public function setPlayer(param1:Array, param2:FormationInformation) : void
        {
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            this._aAttackStatus = param1;
            var _loc_3:* = param2.aRowPosition;
            var _loc_4:* = param2.aColumnPosition;
            var _loc_5:* = param2.aProbability;
            for each (_loc_6 in param1)
            {
                
                _loc_7 = _loc_3[_loc_6.formationIndex] - 1;
                _loc_8 = _loc_4[_loc_6.formationIndex] - 1;
                _loc_9 = this.index(_loc_7, _loc_8);
                this._aAll[_loc_9] = _loc_6.questUniqueId;
                if (_loc_6.bDead)
                {
                    continue;
                }
                this._aTarget[_loc_9] = _loc_6.questUniqueId;
                this._aProbability[_loc_9] = _loc_5[_loc_6.formationIndex];
            }
            return;
        }// end function

        public function getEntryCount() : int
        {
            var _loc_2:* = 0;
            var _loc_1:* = 0;
            for each (_loc_2 in this._aTarget)
            {
                
                if (_loc_2 != 0)
                {
                    _loc_1++;
                }
            }
            return _loc_1;
        }// end function

        public function getRowHeadCol(param1:int) : int
        {
            var _loc_3:* = 0;
            var _loc_2:* = 0;
            while (_loc_2 < this._col)
            {
                
                _loc_3 = this.questUniqueId(param1, _loc_2);
                if (_loc_3 != 0)
                {
                    return _loc_2;
                }
                _loc_2++;
            }
            return -1;
        }// end function

        public function questUniqueId(param1:int, param2:int) : int
        {
            return this._aTarget[this.index(param1, param2)];
        }// end function

        public function getSideLineTarget(param1:int, param2:int = 0) : Array
        {
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_3:* = [];
            var _loc_4:* = 0;
            while (_loc_4 < this._col)
            {
                
                _loc_5 = param1 - param2;
                while (_loc_5 <= param1 + param2)
                {
                    
                    if (_loc_5 < 0 || this._row <= _loc_5)
                    {
                    }
                    else
                    {
                        _loc_6 = this.questUniqueId(_loc_5, _loc_4);
                        if (_loc_6 != 0)
                        {
                            _loc_3.push(_loc_6);
                        }
                    }
                    _loc_5++;
                }
                _loc_4++;
            }
            return _loc_3;
        }// end function

        public function getVertLineTarget(param1:int, param2:int = 0) : Array
        {
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_3:* = [];
            var _loc_4:* = 0;
            while (_loc_4 < this._row)
            {
                
                _loc_5 = param1 - param2;
                while (_loc_5 <= param1 + param2)
                {
                    
                    if (_loc_5 < 0 || this._col <= _loc_5)
                    {
                    }
                    else
                    {
                        _loc_6 = this.questUniqueId(_loc_4, _loc_5);
                        if (_loc_6 != 0)
                        {
                            _loc_3.push(_loc_6);
                        }
                    }
                    _loc_5++;
                }
                _loc_4++;
            }
            return _loc_3;
        }// end function

        public function getRowHeadTarget(param1:int) : int
        {
            var _loc_3:* = 0;
            var _loc_2:* = 0;
            while (_loc_2 < this._col)
            {
                
                _loc_3 = this.questUniqueId(param1, _loc_2);
                if (_loc_3 != 0)
                {
                    return _loc_3;
                }
                _loc_2++;
            }
            return Constant.EMPTY_ID;
        }// end function

        public function getColMiddleTarget(param1:int) : int
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            if (this._row > 0)
            {
                _loc_2 = this._row / 2;
                _loc_3 = this.questUniqueId(_loc_2, param1);
                if (_loc_3 != 0)
                {
                    return _loc_3;
                }
                _loc_4 = 1;
                while (_loc_4 <= _loc_2)
                {
                    
                    if (_loc_2 - _loc_4 >= 0)
                    {
                        _loc_3 = this.questUniqueId(_loc_2 - _loc_4, param1);
                        if (_loc_3 != 0)
                        {
                            return _loc_3;
                        }
                    }
                    if (_loc_2 + _loc_4 < this._row)
                    {
                        _loc_3 = this.questUniqueId(_loc_2 + _loc_4, param1);
                        if (_loc_3 != 0)
                        {
                            return _loc_3;
                        }
                    }
                    _loc_4++;
                }
            }
            return Constant.EMPTY_ID;
        }// end function

        public function getFirstTarget() : int
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aAttackStatus)
            {
                
                if (_loc_1.bDead)
                {
                    continue;
                }
                return _loc_1.questUniqueId;
            }
            return Constant.EMPTY_ID;
        }// end function

        public function getTargetHp(param1:int) : int
        {
            var _loc_2:* = null;
            if (param1 != Constant.EMPTY_ID)
            {
                for each (_loc_2 in this._aAttackStatus)
                {
                    
                    if (param1 == _loc_2.questUniqueId)
                    {
                        return _loc_2.hp;
                    }
                }
            }
            return 0;
        }// end function

        public function getTargetStatus(param1:int) : AttackCharacterStatus
        {
            var _loc_2:* = null;
            if (param1 != Constant.EMPTY_ID)
            {
                for each (_loc_2 in this._aAttackStatus)
                {
                    
                    if (param1 == _loc_2.questUniqueId)
                    {
                        return _loc_2;
                    }
                }
            }
            return null;
        }// end function

        public function getTargetProbability(param1:int) : int
        {
            var _loc_2:* = 0;
            if (param1 != Constant.EMPTY_ID)
            {
                _loc_2 = this._aTarget.indexOf(param1);
                if (_loc_2 >= 0)
                {
                    return this._aProbability[_loc_2];
                }
            }
            return 0;
        }// end function

        public function getTargetRow(param1:int) : int
        {
            var _loc_2:* = 0;
            if (param1 != Constant.EMPTY_ID)
            {
                _loc_2 = this._aAll.indexOf(param1);
                if (_loc_2 >= 0)
                {
                    return this.toRow(_loc_2);
                }
            }
            return this._row / 2;
        }// end function

        public function getTargetCol(param1:int) : int
        {
            var _loc_2:* = 0;
            if (param1 != Constant.EMPTY_ID)
            {
                _loc_2 = this._aAll.indexOf(param1);
                if (_loc_2 >= 0)
                {
                    return this.toCol(_loc_2);
                }
            }
            return this._col / 2;
        }// end function

    }
}
