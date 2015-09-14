package battle
{
    import character.*;

    public class BattleBadStatus extends Object
    {
        private var _aBadStatusData:Array;

        public function BattleBadStatus()
        {
            this._aBadStatusData = [];
            return;
        }// end function

        public function get aBadStatusData() : Array
        {
            return this._aBadStatusData.concat();
        }// end function

        public function get bBadStatus() : Boolean
        {
            return this._aBadStatusData.length > 0;
        }// end function

        public function clone() : BattleBadStatus
        {
            var _loc_1:* = new BattleBadStatus();
            _loc_1._aBadStatusData = this.aBadStatusData;
            return _loc_1;
        }// end function

        public function clear() : void
        {
            this._aBadStatusData = [];
            return;
        }// end function

        public function marge(param1:BattleBadStatus) : void
        {
            this.addStatusDataArray(param1._aBadStatusData);
            return;
        }// end function

        public function conflict() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_1:* = this._aBadStatusData.concat();
            _loc_3 = 0;
            while (_loc_3 < _loc_1.length)
            {
                
                _loc_2 = _loc_1[_loc_3];
                if (_loc_2 == null)
                {
                }
                else
                {
                    _loc_5 = BattleInformationManager.getInstance().getStatusListData(_loc_2.id);
                    if (_loc_5 && _loc_5.conflictId)
                    {
                        _loc_6 = this.getBadStatusIndex(_loc_5.conflictId);
                        if (_loc_6 >= 0)
                        {
                            _loc_1[_loc_3] = null;
                            _loc_1[_loc_6] = null;
                        }
                    }
                }
                _loc_3++;
            }
            var _loc_4:* = Constant.EMPTY_ID;
            _loc_3 = _loc_1.length - 1;
            while (_loc_3 >= 0)
            {
                
                _loc_2 = _loc_1[_loc_3];
                if (_loc_2 == null)
                {
                }
                else if (_loc_2.id == BattleConstant.BAD_STATUS_ID_ADD_ATTRIBUTE_HEAT || _loc_2.id == BattleConstant.BAD_STATUS_ID_ADD_ATTRIBUTE_ICY || _loc_2.id == BattleConstant.BAD_STATUS_ID_ADD_ATTRIBUTE_THUNDER)
                {
                    if (_loc_4 == Constant.EMPTY_ID)
                    {
                        _loc_4 = _loc_2.id;
                    }
                    else
                    {
                        _loc_1[_loc_3] = null;
                    }
                }
                _loc_3 = _loc_3 - 1;
            }
            this._aBadStatusData.length = 0;
            _loc_3 = 0;
            while (_loc_3 < _loc_1.length)
            {
                
                if (_loc_1[_loc_3] != null)
                {
                    this._aBadStatusData.push(_loc_1[_loc_3]);
                }
                _loc_3++;
            }
            return;
        }// end function

        public function conflictCheck(param1:int) : Boolean
        {
            var _loc_2:* = BattleInformationManager.getInstance().getStatusListData(param1);
            if (_loc_2 && _loc_2.conflictId)
            {
                return this.getBadStatusIndex(_loc_2.conflictId) >= 0;
            }
            return false;
        }// end function

        public function trunRecovery() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = this._aBadStatusData.length - 1;
            while (_loc_1 >= 0)
            {
                
                _loc_2 = this._aBadStatusData[_loc_1];
                if (_loc_2.id == BattleConstant.BAD_STATUS_ID_INSTANT_DEATH || _loc_2.id == BattleConstant.BAD_STATUS_ID_STONE)
                {
                }
                else if (_loc_2.turn <= 0)
                {
                    this._aBadStatusData.splice(_loc_1, 1);
                }
                else
                {
                    this._aBadStatusData[_loc_1] = new BattleBadStatusData(_loc_2.id, (_loc_2.turn - 1));
                }
                _loc_1 = _loc_1 - 1;
            }
            return;
        }// end function

        public function getBadStatus(param1:int) : BattleBadStatusData
        {
            var _loc_3:* = null;
            var _loc_2:* = 0;
            while (_loc_2 < this._aBadStatusData.length)
            {
                
                _loc_3 = this._aBadStatusData[_loc_2];
                if (_loc_3.id == param1)
                {
                    return _loc_3;
                }
                _loc_2++;
            }
            return null;
        }// end function

        private function getBadStatusIndex(param1:int) : int
        {
            var _loc_3:* = null;
            var _loc_2:* = 0;
            while (_loc_2 < this._aBadStatusData.length)
            {
                
                _loc_3 = this._aBadStatusData[_loc_2];
                if (_loc_3.id == param1)
                {
                    return _loc_2;
                }
                _loc_2++;
            }
            return -1;
        }// end function

        public function isBadStatus(param1:int) : Boolean
        {
            return this.getBadStatus(param1) != null;
        }// end function

        public function addStatusData(param1:BattleBadStatusData) : void
        {
            var _loc_2:* = this.getBadStatusIndex(param1.id);
            if (_loc_2 >= 0)
            {
                this._aBadStatusData[_loc_2] = param1;
            }
            else
            {
                this._aBadStatusData.push(param1);
            }
            return;
        }// end function

        public function addStatusDataArray(param1:Array) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in param1)
            {
                
                this.addStatusData(_loc_2);
            }
            return;
        }// end function

        public function removeBadStatus(param1:int) : void
        {
            var _loc_2:* = this.getBadStatusIndex(param1);
            if (_loc_2 >= 0)
            {
                this._aBadStatusData.splice(_loc_2, 1);
            }
            return;
        }// end function

        public function removeBadStatusArray(param1:Array) : void
        {
            var _loc_2:* = 0;
            for each (_loc_2 in param1)
            {
                
                this.removeBadStatus(_loc_2);
            }
            return;
        }// end function

        public function subBadStatus(param1:BattleRecoveryBadStatus) : void
        {
            this.removeBadStatusArray(param1.aStatusId);
            return;
        }// end function

        public function recoverBadStatus(param1:BattleRecoveryBadStatus) : void
        {
            this.removeBadStatusArray(param1.aStatusId);
            return;
        }// end function

        public function getAttackBonus(param1:int) : int
        {
            var _loc_2:* = 0;
            if (this.isBadStatus(BattleConstant.BAD_STATUS_ID_ATTACK_UP))
            {
                _loc_2 = _loc_2 + param1 * getParam(BattleConstant.BAD_STATUS_ID_ATTACK_UP) / 1000;
            }
            if (this.isBadStatus(BattleConstant.BAD_STATUS_ID_ATTACK_DOWN))
            {
                _loc_2 = _loc_2 - param1 * getParam(BattleConstant.BAD_STATUS_ID_ATTACK_DOWN) / 1000;
            }
            return _loc_2;
        }// end function

        public function getDefenseBonus(param1:int) : int
        {
            var _loc_2:* = 0;
            if (this.isBadStatus(BattleConstant.BAD_STATUS_ID_DEFENSE_UP))
            {
                _loc_2 = _loc_2 + param1 * getParam(BattleConstant.BAD_STATUS_ID_DEFENSE_UP) / 1000;
            }
            if (this.isBadStatus(BattleConstant.BAD_STATUS_ID_DEFENSE_DOWN))
            {
                _loc_2 = _loc_2 - param1 * getParam(BattleConstant.BAD_STATUS_ID_DEFENSE_DOWN) / 1000;
            }
            return _loc_2;
        }// end function

        public function getSpeedBonus(param1:int) : int
        {
            var _loc_2:* = 0;
            if (this.isBadStatus(BattleConstant.BAD_STATUS_ID_SPEED_UP))
            {
                _loc_2 = _loc_2 + param1 * getParam(BattleConstant.BAD_STATUS_ID_SPEED_UP) / 1000;
            }
            if (this.isBadStatus(BattleConstant.BAD_STATUS_ID_SPEED_DOWN))
            {
                _loc_2 = _loc_2 - param1 * getParam(BattleConstant.BAD_STATUS_ID_SPEED_DOWN) / 1000;
            }
            return _loc_2;
        }// end function

        public function getMagicBonus(param1:int) : int
        {
            var _loc_2:* = 0;
            if (this.isBadStatus(BattleConstant.BAD_STATUS_ID_MAGIC_UP))
            {
                _loc_2 = _loc_2 + param1 * getParam(BattleConstant.BAD_STATUS_ID_MAGIC_UP) / 1000;
            }
            if (this.isBadStatus(BattleConstant.BAD_STATUS_ID_MAGIC_DOWN))
            {
                _loc_2 = _loc_2 - param1 * getParam(BattleConstant.BAD_STATUS_ID_MAGIC_DOWN) / 1000;
            }
            return _loc_2;
        }// end function

        public function getDefenseToleranceBonus(param1:int) : int
        {
            var _loc_2:* = 0;
            switch(param1)
            {
                case CharacterConstant.ATTRIBUTE_SLASH:
                {
                    _loc_2 = this.getToleranceBonus(BattleConstant.BAD_STATUS_ID_SLASH_TOLERANCE_UP, BattleConstant.BAD_STATUS_ID_SLASH_TOLERANCE_DOWN);
                    break;
                }
                case CharacterConstant.ATTRIBUTE_PUNCH:
                {
                    _loc_2 = this.getToleranceBonus(BattleConstant.BAD_STATUS_ID_PUNCH_TOLERANCE_UP, BattleConstant.BAD_STATUS_ID_PUNCH_TOLERANCE_DOWN);
                    break;
                }
                case CharacterConstant.ATTRIBUTE_THRUST:
                {
                    _loc_2 = this.getToleranceBonus(BattleConstant.BAD_STATUS_ID_THRUST_TOLERANCE_UP, BattleConstant.BAD_STATUS_ID_THRUST_TOLERANCE_DOWN);
                    break;
                }
                case CharacterConstant.ATTRIBUTE_HEAT:
                {
                    _loc_2 = this.getToleranceBonus(BattleConstant.BAD_STATUS_ID_HEAT_TOLERANCE_UP, BattleConstant.BAD_STATUS_ID_HEAT_TOLERANCE_DOWN);
                    break;
                }
                case CharacterConstant.ATTRIBUTE_ICY:
                {
                    _loc_2 = this.getToleranceBonus(BattleConstant.BAD_STATUS_ID_ICY_TOLERANCE_UP, BattleConstant.BAD_STATUS_ID_ICY_TOLERANCE_DOWN);
                    break;
                }
                case CharacterConstant.ATTRIBUTE_THUNDER:
                {
                    _loc_2 = this.getToleranceBonus(BattleConstant.BAD_STATUS_ID_THUNDER_TOLERANCE_UP, BattleConstant.BAD_STATUS_ID_THUNDER_TOLERANCE_DOWN);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_2;
        }// end function

        private function getToleranceBonus(param1:int, param2:int) : int
        {
            var _loc_3:* = 0;
            if (this.isBadStatus(param1))
            {
                _loc_3 = _loc_3 + getParam(param1);
            }
            if (this.isBadStatus(param2))
            {
                _loc_3 = _loc_3 - getParam(param2);
            }
            return _loc_3;
        }// end function

        public function getAddAttributeFlags() : uint
        {
            var _loc_2:* = null;
            var _loc_1:* = 0;
            for each (_loc_2 in this._aBadStatusData)
            {
                
                if (_loc_2.id == BattleConstant.BAD_STATUS_ID_ADD_ATTRIBUTE_HEAT)
                {
                    _loc_1 = _loc_1 | CharacterConstant.ATTRIBUTE_HEAT;
                }
                if (_loc_2.id == BattleConstant.BAD_STATUS_ID_ADD_ATTRIBUTE_ICY)
                {
                    _loc_1 = _loc_1 | CharacterConstant.ATTRIBUTE_ICY;
                }
                if (_loc_2.id == BattleConstant.BAD_STATUS_ID_ADD_ATTRIBUTE_THUNDER)
                {
                    _loc_1 = _loc_1 | CharacterConstant.ATTRIBUTE_THUNDER;
                }
            }
            return _loc_1;
        }// end function

        private static function getParam(param1:int) : int
        {
            var _loc_2:* = BattleInformationManager.getInstance().getStatusListData(param1);
            return _loc_2.param0;
        }// end function

    }
}
