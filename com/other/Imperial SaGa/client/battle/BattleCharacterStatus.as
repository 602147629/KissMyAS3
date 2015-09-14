package battle
{

    public class BattleCharacterStatus extends Object
    {
        private var _bGuard:Boolean;
        private var _badStatus:BattleBadStatus;
        protected var _aDefenseTolerance:Array;
        protected var _aBadStatusTolerance:Array;
        protected var _shield:int;
        protected var _counter:Boolean;
        protected var _counterSkillId:int;
        protected var _bCounterHit:Boolean;
        private var _battleCharacter:BattleCharacterBase;

        public function BattleCharacterStatus(param1:BattleCharacterBase)
        {
            this._battleCharacter = param1;
            this._badStatus = new BattleBadStatus();
            this._aDefenseTolerance = [];
            this._aBadStatusTolerance = [];
            this.clearShield();
            this.clearCounterSkill();
            return;
        }// end function

        public function get bGuard() : Boolean
        {
            return this._bGuard;
        }// end function

        public function set bGuard(param1:Boolean) : void
        {
            this._bGuard = param1;
            return;
        }// end function

        public function get badStatus() : BattleBadStatus
        {
            return this._badStatus;
        }// end function

        public function badStatusAdd(param1:BattleBadStatus) : void
        {
            if (param1.bBadStatus)
            {
                this._badStatus.marge(param1);
                this._badStatus.conflict();
            }
            return;
        }// end function

        public function badStatusRecovery(param1:BattleRecoveryBadStatus) : void
        {
            this._badStatus.recoverBadStatus(param1);
            return;
        }// end function

        public function badStatusClear() : void
        {
            this._badStatus.clear();
            return;
        }// end function

        public function get aDefenseTolerance() : Array
        {
            return this._aDefenseTolerance;
        }// end function

        public function set aDefenseTolerance(param1:Array) : void
        {
            this._aDefenseTolerance = param1.concat();
            return;
        }// end function

        public function get aBadStatusTolerance() : Array
        {
            return this._aBadStatusTolerance;
        }// end function

        public function set aBadStatusTolerance(param1:Array) : void
        {
            this._aBadStatusTolerance = param1.concat();
            return;
        }// end function

        public function get shield() : int
        {
            return this._shield;
        }// end function

        public function clearShield() : void
        {
            this._shield = BattleConstant.DEFENSE_SHIELD_NON;
            return;
        }// end function

        public function setShield(param1:int) : void
        {
            this._shield = param1;
            return;
        }// end function

        public function get bCounter() : Boolean
        {
            return this._counterSkillId != Constant.EMPTY_ID;
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

        public function clearCounterSkill() : void
        {
            this._counterSkillId = Constant.EMPTY_ID;
            return;
        }// end function

        public function get bCounterHit() : Boolean
        {
            return this._bCounterHit;
        }// end function

        public function set bCounterHit(param1:Boolean) : void
        {
            this._bCounterHit = param1;
            return;
        }// end function

        public function get attack() : int
        {
            var _loc_1:* = this._battleCharacter.personal.attackTotal;
            var _loc_2:* = this._badStatus.getAttackBonus(_loc_1);
            return _loc_1 + _loc_2;
        }// end function

        public function get defense() : int
        {
            var _loc_1:* = this._battleCharacter.personal.defenseTotal;
            var _loc_2:* = this._badStatus.getDefenseBonus(_loc_1);
            return _loc_1 + _loc_2;
        }// end function

        public function get speed() : int
        {
            var _loc_1:* = this._battleCharacter.personal.speedTotal;
            var _loc_2:* = this._badStatus.getSpeedBonus(_loc_1);
            return _loc_1 + _loc_2;
        }// end function

        public function getDefenseToleranceRate(param1:int) : int
        {
            return BattleToleranceData.getToleranceRate(this._aDefenseTolerance, param1);
        }// end function

        public function getBadStatusToleranceRate(param1:int) : int
        {
            return BattleToleranceData.getToleranceRate(this._aBadStatusTolerance, param1);
        }// end function

    }
}
