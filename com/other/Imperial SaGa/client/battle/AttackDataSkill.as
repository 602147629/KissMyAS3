package battle
{

    public class AttackDataSkill extends AttackDataBase
    {
        private var _questUniqueId:int;
        private var _invokeType:int;
        private var _skillId:int;
        private var _bDefaultSkill:Boolean;
        private var _comboCount:int;
        private var _bComeUp:Boolean;
        private var _aComboDeadId:Array;
        private var _counterSkillId:int;

        public function AttackDataSkill()
        {
            _attackType = BattleConstant.ATTACK_DATA_TYPE_SKILL;
            this._aComboDeadId = [];
            this._counterSkillId = Constant.EMPTY_ID;
            return;
        }// end function

        public function get questUniqueId() : int
        {
            return this._questUniqueId;
        }// end function

        public function set questUniqueId(param1:int) : void
        {
            this._questUniqueId = param1;
            return;
        }// end function

        public function get invokeType() : int
        {
            return this._invokeType;
        }// end function

        public function set invokeType(param1:int) : void
        {
            this._invokeType = param1;
            return;
        }// end function

        public function get skillId() : int
        {
            return this._skillId;
        }// end function

        public function set skillId(param1:int) : void
        {
            this._skillId = param1;
            return;
        }// end function

        public function get bDefaultSkill() : Boolean
        {
            return this._bDefaultSkill;
        }// end function

        public function set bDefaultSkill(param1:Boolean) : void
        {
            this._bDefaultSkill = param1;
            return;
        }// end function

        public function get comboCount() : int
        {
            return this._comboCount;
        }// end function

        public function set comboCount(param1:int) : void
        {
            this._comboCount = param1;
            return;
        }// end function

        public function get bComeUp() : Boolean
        {
            return this._bComeUp;
        }// end function

        public function set bComeUp(param1:Boolean) : void
        {
            this._bComeUp = param1;
            return;
        }// end function

        public function get aComboDeadId() : Array
        {
            return this._aComboDeadId;
        }// end function

        public function addComboDeadId(param1:uint) : void
        {
            this._aComboDeadId.push(param1);
            return;
        }// end function

        public function get counterSkillId() : int
        {
            return this._counterSkillId;
        }// end function

        public function setCounterSkillId(param1:int) : void
        {
            this._counterSkillId = param1;
            return;
        }// end function

        public function get totalDamage() : int
        {
            var _loc_2:* = null;
            var _loc_1:* = 0;
            for each (_loc_2 in aDamage)
            {
                
                _loc_1 = _loc_1 + _loc_2.damageHp;
            }
            return _loc_1;
        }// end function

    }
}
