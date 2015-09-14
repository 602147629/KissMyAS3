package battle
{

    public class BattleAddStatusResult extends Object
    {
        private var _bDamageHp:Boolean;
        private var _damageHp:int;
        public var _bRecoveryHp:Boolean;
        private var _recoveryHp:int;
        private var _bDamageLp:Boolean;
        private var _bMiss:Boolean;
        private var _bResist:Boolean;
        private var _badStatus:BattleBadStatus;
        private var _recoveryBadStatus:BattleRecoveryBadStatus;
        private var _bCounterWait:Boolean;
        private var _counterSkillId:int;

        public function BattleAddStatusResult()
        {
            this._bDamageHp = false;
            this._damageHp = 0;
            this._bDamageLp = false;
            this._bMiss = false;
            this._bResist = false;
            this._badStatus = new BattleBadStatus();
            this._recoveryBadStatus = new BattleRecoveryBadStatus();
            this._bCounterWait = false;
            this._counterSkillId = Constant.EMPTY_ID;
            return;
        }// end function

        public function get bDamageHp() : Boolean
        {
            return this._bDamageHp;
        }// end function

        public function get damageHp() : int
        {
            return this._damageHp;
        }// end function

        public function setDamageHp(param1:int) : void
        {
            this._bDamageHp = true;
            this._damageHp = param1;
            return;
        }// end function

        public function get bRecoveryHp() : Boolean
        {
            return this._bRecoveryHp;
        }// end function

        public function get recoveryHp() : int
        {
            return this._recoveryHp;
        }// end function

        public function setRecoveryHp(param1:int) : void
        {
            this._recoveryHp = param1;
            this._bRecoveryHp = true;
            return;
        }// end function

        public function get bDamageLp() : Boolean
        {
            return this._bDamageLp;
        }// end function

        public function setDamageLp() : void
        {
            this._bDamageLp = true;
            return;
        }// end function

        public function setMiss() : void
        {
            this._bMiss = true;
            return;
        }// end function

        public function get bResist() : Boolean
        {
            return this._bResist;
        }// end function

        public function setResist() : void
        {
            this._bResist = true;
            return;
        }// end function

        public function get bBadStatus() : Boolean
        {
            return this._badStatus.bBadStatus;
        }// end function

        public function get badStatus() : BattleBadStatus
        {
            return this._badStatus;
        }// end function

        public function get bRecoveryBadStatus() : Boolean
        {
            return this._recoveryBadStatus.bRecovery;
        }// end function

        public function get recoveryBadStatus() : BattleRecoveryBadStatus
        {
            return this._recoveryBadStatus;
        }// end function

        public function get bCounterWait() : Boolean
        {
            return this._bCounterWait;
        }// end function

        public function get counterSkillId() : int
        {
            return this._counterSkillId;
        }// end function

        public function setCounterSkillId(param1:int) : void
        {
            this._counterSkillId = param1;
            this._bCounterWait = true;
            return;
        }// end function

    }
}
