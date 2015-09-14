package battle
{

    public class AttackDamage extends Object
    {
        private var _questUniqueId:uint;
        private var _attackerQuestUniqueId:uint;
        private var _targetDivision:int;
        private var _hitType:int;
        private var _damageHp:int;
        private var _damageLp:int;
        private var _recoveryHp:int;
        private var _bRecoveryHp:Boolean;
        private var _addBadStatus:BattleBadStatus;
        private var _recoveryBadStatus:BattleRecoveryBadStatus;
        private var _bBadStatusResist:Boolean;
        private var _bDead:Boolean;
        private var _bDeadDisable:Boolean;
        private var _sheld:int;
        private var _counterSkillId:int;
        private var _bCounter:Boolean;
        private var _bSkipDamage:Boolean;
        private var _bOutDamage:Boolean;
        private var _bBrokenItem:Boolean;
        private var _bAllyEffect:Boolean;

        public function AttackDamage()
        {
            this._sheld = BattleConstant.DEFENSE_SHIELD_NON;
            this._counterSkillId = Constant.EMPTY_ID;
            this._attackerQuestUniqueId = Constant.EMPTY_ID;
            this._addBadStatus = new BattleBadStatus();
            this._recoveryBadStatus = new BattleRecoveryBadStatus();
            return;
        }// end function

        public function get questUniqueId() : uint
        {
            return this._questUniqueId;
        }// end function

        public function set questUniqueId(param1:uint) : void
        {
            this._questUniqueId = param1;
            return;
        }// end function

        public function get attackerQuestUniqueId() : uint
        {
            return this._attackerQuestUniqueId;
        }// end function

        public function set attackerQuestUniqueId(param1:uint) : void
        {
            this._attackerQuestUniqueId = param1;
            return;
        }// end function

        public function get targetDivision() : int
        {
            return this._targetDivision;
        }// end function

        public function set targetDivision(param1:int) : void
        {
            this._targetDivision = param1;
            return;
        }// end function

        public function get hitType() : int
        {
            return this._hitType;
        }// end function

        public function set hitType(param1:int) : void
        {
            this._hitType = param1;
            return;
        }// end function

        public function get damageHp() : int
        {
            return this._damageHp;
        }// end function

        public function set damageHp(param1:int) : void
        {
            this._damageHp = param1;
            return;
        }// end function

        public function get damageLp() : int
        {
            return this._damageLp;
        }// end function

        public function set damageLp(param1:int) : void
        {
            this._damageLp = param1;
            return;
        }// end function

        public function get recoveryHp() : int
        {
            return this._recoveryHp;
        }// end function

        public function set recoveryHp(param1:int) : void
        {
            this._recoveryHp = param1;
            this._bRecoveryHp = true;
            return;
        }// end function

        public function get bRecoveryHp() : Boolean
        {
            return this._bRecoveryHp;
        }// end function

        public function get addBadStatus() : BattleBadStatus
        {
            return this._addBadStatus;
        }// end function

        public function setAddBadStatus(param1:BattleBadStatus) : void
        {
            this._addBadStatus.marge(param1);
            return;
        }// end function

        public function addAddBadStatusData(param1:BattleBadStatusData) : void
        {
            this._addBadStatus.addStatusData(param1);
            return;
        }// end function

        public function get recoveryBadStatus() : BattleRecoveryBadStatus
        {
            return this._recoveryBadStatus;
        }// end function

        public function setRecoveryBadStatus(param1:BattleRecoveryBadStatus) : void
        {
            this._recoveryBadStatus.marge(param1);
            return;
        }// end function

        public function get bBadStatusResist() : Boolean
        {
            return this._bBadStatusResist;
        }// end function

        public function set bBadStatusResist(param1:Boolean) : void
        {
            this._bBadStatusResist = param1;
            return;
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

        public function get bDeadDisable() : Boolean
        {
            return this._bDeadDisable;
        }// end function

        public function set bDeadDisable(param1:Boolean) : void
        {
            this._bDeadDisable = param1;
            return;
        }// end function

        public function get sheld() : int
        {
            return this._sheld;
        }// end function

        public function set sheld(param1:int) : void
        {
            this._sheld = param1;
            return;
        }// end function

        public function get counterSkillId() : int
        {
            return this._counterSkillId;
        }// end function

        public function set counterSkillId(param1:int) : void
        {
            this._counterSkillId = param1;
            return;
        }// end function

        public function get bCounter() : Boolean
        {
            return this._bCounter;
        }// end function

        public function set bCounter(param1:Boolean) : void
        {
            this._bCounter = param1;
            return;
        }// end function

        public function get bSkipDamage() : Boolean
        {
            return this._bSkipDamage;
        }// end function

        public function set bSkipDamage(param1:Boolean) : void
        {
            this._bSkipDamage = param1;
            return;
        }// end function

        public function get bOutDamage() : Boolean
        {
            return this._bOutDamage;
        }// end function

        public function set bOutDamage(param1:Boolean) : void
        {
            this._bOutDamage = param1;
            return;
        }// end function

        public function get bBrokenItem() : Boolean
        {
            return this._bBrokenItem;
        }// end function

        public function set bBrokenItem(param1:Boolean) : void
        {
            this._bBrokenItem = param1;
            return;
        }// end function

        public function get bAllyEffect() : Boolean
        {
            return this._bAllyEffect;
        }// end function

        public function set bAllyEffect(param1:Boolean) : void
        {
            this._bAllyEffect = param1;
            return;
        }// end function

        public function clone() : AttackDamage
        {
            var _loc_1:* = new AttackDamage();
            _loc_1._questUniqueId = this._questUniqueId;
            _loc_1._attackerQuestUniqueId = this._attackerQuestUniqueId;
            _loc_1._targetDivision = this._targetDivision;
            _loc_1._hitType = this._hitType;
            _loc_1._damageHp = this._damageHp;
            _loc_1._damageLp = this._damageLp;
            _loc_1._recoveryHp = this._recoveryHp;
            _loc_1._bRecoveryHp = this._bRecoveryHp;
            _loc_1._addBadStatus = this._addBadStatus.clone();
            _loc_1._recoveryBadStatus = this._recoveryBadStatus.clone();
            _loc_1._bBadStatusResist = this._bBadStatusResist;
            _loc_1._bDead = this._bDead;
            _loc_1._bDeadDisable = this._bDeadDisable;
            _loc_1._sheld = this._sheld;
            _loc_1._counterSkillId = this._counterSkillId;
            _loc_1._bCounter = this._bCounter;
            _loc_1._bSkipDamage = this._bSkipDamage;
            _loc_1._bOutDamage = this._bOutDamage;
            _loc_1._bBrokenItem = this._bBrokenItem;
            _loc_1._bAllyEffect = this._bAllyEffect;
            return _loc_1;
        }// end function

    }
}
