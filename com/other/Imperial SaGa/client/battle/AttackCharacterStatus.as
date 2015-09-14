package battle
{
    import character.*;
    import player.*;

    public class AttackCharacterStatus extends Object
    {
        private var _questUniqueId:int;
        private var _division:int;
        private var _formationIndex:int;
        private var _hp:int;
        private var _lp:int;
        private var _badStatus:BattleBadStatus;
        private var _badStatusRecoveryTurn:BattleRecoveryBadStatus;
        private var _bDead:Boolean;
        private var _bGuard:Boolean;
        private var _counterSkillId:int;
        private var _lpCoveringNum:int;

        public function AttackCharacterStatus(param1:BattleCharacterBase)
        {
            var _loc_2:* = param1.personal;
            this._questUniqueId = _loc_2.questUniqueId;
            this._division = param1.division;
            this._formationIndex = param1.formationIndex;
            this._hp = _loc_2.hp;
            this._lp = _loc_2.lp;
            this._bDead = _loc_2.bDead;
            if (_loc_2 is PlayerPersonal)
            {
                this._lpCoveringNum = 0;
            }
            this._badStatus = param1.status.badStatus.clone();
            this._badStatusRecoveryTurn = new BattleRecoveryBadStatus();
            this._bGuard = param1.isDefense();
            this._counterSkillId = Constant.EMPTY_ID;
            return;
        }// end function

        public function get questUniqueId() : int
        {
            return this._questUniqueId;
        }// end function

        public function get division() : int
        {
            return this._division;
        }// end function

        public function get formationIndex() : int
        {
            return this._formationIndex;
        }// end function

        public function get hp() : int
        {
            return this._hp;
        }// end function

        public function set hp(param1:int) : void
        {
            this._hp = param1;
            return;
        }// end function

        public function get lp() : int
        {
            return this._lp;
        }// end function

        public function set lp(param1:int) : void
        {
            this._lp = param1;
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

        public function addBadStatusData(param1:BattleBadStatusData) : void
        {
            this._badStatus.addStatusData(param1);
            this._badStatus.conflict();
            return;
        }// end function

        public function badStatusRecovery(param1:BattleRecoveryBadStatus) : void
        {
            this._badStatus.recoverBadStatus(param1);
            this._badStatusRecoveryTurn.marge(param1);
            return;
        }// end function

        public function get badStatusRecoveryTurn() : BattleRecoveryBadStatus
        {
            return this._badStatusRecoveryTurn;
        }// end function

        public function get bDead() : Boolean
        {
            return this._bDead;
        }// end function

        public function set bDead(param1:Boolean) : void
        {
            this._bDead = param1;
            return;
        }// end function

        public function isDefense() : Boolean
        {
            return this._bGuard;
        }// end function

        public function clearDefense() : void
        {
            this._bGuard = false;
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

        public function get lpCoveringNum() : int
        {
            return 0;
        }// end function

        public function substituteLp() : void
        {
            var _loc_1:* = this;
            var _loc_2:* = this._lpCoveringNum - 1;
            _loc_1._lpCoveringNum = _loc_2;
            return;
        }// end function

    }
}
