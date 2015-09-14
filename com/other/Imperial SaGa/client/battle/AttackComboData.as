package battle
{

    public class AttackComboData extends Object
    {
        private var _comboCount:int = 1;
        private var _aComboTarget:Array;
        private var _lastPlayerAttackIndex:int;
        private var _comboStartIndex:int;
        private var _aDeadEnemyQuestUniqueId:Array;
        private var _lastUseSkillId:int;
        private var _division:int;
        private var _bComboLater:Boolean;
        private var _bSubsequent:Boolean;

        public function AttackComboData()
        {
            this._lastPlayerAttackIndex = 0;
            this._comboStartIndex = 0;
            this.clear();
            return;
        }// end function

        public function get comboCount() : int
        {
            return this._comboCount;
        }// end function

        public function addComboCount() : void
        {
            var _loc_1:* = this;
            var _loc_2:* = this._comboCount + 1;
            _loc_1._comboCount = _loc_2;
            return;
        }// end function

        public function get aComboTarget() : Array
        {
            return this._aComboTarget.concat();
        }// end function

        public function clearComboTarget() : void
        {
            this._aComboTarget = [];
            return;
        }// end function

        public function get lastPlayerAttackIndex() : int
        {
            return this._lastPlayerAttackIndex;
        }// end function

        public function set lastPlayerAttackIndex(param1:int) : void
        {
            this._lastPlayerAttackIndex = param1;
            return;
        }// end function

        public function get comboStartIndex() : int
        {
            return this._comboStartIndex;
        }// end function

        public function set comboStartIndex(param1:int) : void
        {
            this._comboStartIndex = param1;
            return;
        }// end function

        public function get aDeadEnemyQuestUniqueId() : Array
        {
            return this._aDeadEnemyQuestUniqueId.concat();
        }// end function

        public function addDeadEnemyQuestUniqueId(param1:uint) : void
        {
            if (this._aDeadEnemyQuestUniqueId.indexOf(param1) == -1)
            {
                this._aDeadEnemyQuestUniqueId.push(param1);
            }
            return;
        }// end function

        public function get lastUseSkillId() : int
        {
            return this._lastUseSkillId;
        }// end function

        public function set lastUseSkillId(param1:int) : void
        {
            this._lastUseSkillId = param1;
            return;
        }// end function

        public function get Division() : int
        {
            return this._division;
        }// end function

        public function set Division(param1:int) : void
        {
            this._division = param1;
            return;
        }// end function

        public function get bComboLater() : Boolean
        {
            return this._bComboLater;
        }// end function

        public function set bComboLater(param1:Boolean) : void
        {
            this._bComboLater = param1;
            return;
        }// end function

        public function get bSubsequent() : Boolean
        {
            return this._bSubsequent;
        }// end function

        public function set bSubsequent(param1:Boolean) : void
        {
            this._bSubsequent = param1;
            return;
        }// end function

        public function clear() : void
        {
            this._comboCount = 1;
            this.clearComboTarget();
            this._aDeadEnemyQuestUniqueId = [];
            this._lastUseSkillId = Constant.EMPTY_ID;
            this._division = BattleConstant.DIVISION_PLAYER;
            this._bSubsequent = false;
            this._bComboLater = false;
            return;
        }// end function

        public function clone() : AttackComboData
        {
            var _loc_1:* = new AttackComboData();
            _loc_1.copy(this);
            return _loc_1;
        }// end function

        public function copy(param1:AttackComboData) : void
        {
            this._comboCount = param1.comboCount;
            this._aComboTarget = param1.aComboTarget;
            this._lastPlayerAttackIndex = param1.lastPlayerAttackIndex;
            this._comboStartIndex = param1.comboStartIndex;
            this._aDeadEnemyQuestUniqueId = param1.aDeadEnemyQuestUniqueId;
            this._lastUseSkillId = param1.lastUseSkillId;
            this._division = param1.Division;
            this._bComboLater = param1.bComboLater;
            this._bSubsequent = param1.bSubsequent;
            return;
        }// end function

        public function checkComboTarget(param1:Array) : Boolean
        {
            var _loc_2:* = null;
            for each (_loc_2 in param1)
            {
                
                if (_loc_2.bAttackHit && this._aComboTarget.indexOf(_loc_2.questUniqueId) >= 0)
                {
                    return true;
                }
            }
            return false;
        }// end function

        public function setComboTarget(param1:Array) : void
        {
            var _loc_2:* = null;
            this._aComboTarget = [];
            for each (_loc_2 in param1)
            {
                
                this._aComboTarget.push(_loc_2.questUniqueId);
            }
            return;
        }// end function

    }
}
