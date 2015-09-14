package battle
{

    public class DamageData extends Object
    {
        private var _damage:int;
        private var _hitType:int;
        private var _bMiss:Boolean;
        private var _bCounter:Boolean;
        private var _bBigDisp:Boolean;
        private var _addBadStatus:BattleBadStatus;
        private var _recoveryBadStatus:BattleRecoveryBadStatus;
        private var _dispStatusId:int;
        private var _questUniqueId:int;
        private var _attacerQuestUniqueId:int;
        private var _type:int;
        private var _bDeadDisable:Boolean;
        private var _bSkip:Boolean;
        private var _bAllyEffect:Boolean;
        private var _bBrokenItem:Boolean;
        public static const TYPE_HP:int = 0;
        public static const TYPE_LP:int = 1;
        public static const TYPE_BAD_STATUS:int = 2;
        public static const TYPE_BAD_STATUS_RECOVERY:int = 3;
        public static const TYPE_RECOVERY_HP:int = 4;
        public static const TYPE_BAD_STATUS_RESIST:int = 5;

        public function DamageData(param1:int, param2:int, param3:int, param4:int)
        {
            this._questUniqueId = param1;
            this._attacerQuestUniqueId = param2;
            this._damage = param3;
            this._type = param4;
            this._hitType = BattleConstant.HIT_TYPE_NORMAL;
            return;
        }// end function

        public function get damage() : int
        {
            return this._damage;
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

        public function get bMiss() : Boolean
        {
            return this._bMiss;
        }// end function

        public function set bMiss(param1:Boolean) : void
        {
            this._bMiss = param1;
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

        public function get bBigDisp() : Boolean
        {
            return this._bBigDisp;
        }// end function

        public function set bBigDisp(param1:Boolean) : void
        {
            this._bBigDisp = param1;
            return;
        }// end function

        public function get addBadStatus() : BattleBadStatus
        {
            return this._addBadStatus;
        }// end function

        public function set addBadStatus(param1:BattleBadStatus) : void
        {
            this._addBadStatus = param1;
            return;
        }// end function

        public function get recoveryBadStatus() : BattleRecoveryBadStatus
        {
            return this._recoveryBadStatus;
        }// end function

        public function set recoveryBadStatus(param1:BattleRecoveryBadStatus) : void
        {
            this._recoveryBadStatus = param1;
            return;
        }// end function

        public function get dispStatusId() : int
        {
            return this._dispStatusId;
        }// end function

        public function set dispStatusId(param1:int) : void
        {
            this._dispStatusId = param1;
            return;
        }// end function

        public function get questUniqueId() : int
        {
            return this._questUniqueId;
        }// end function

        public function get attacerQuestUniqueId() : int
        {
            return this._attacerQuestUniqueId;
        }// end function

        public function get type() : int
        {
            return this._type;
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

        public function get bSkip() : Boolean
        {
            return this._bSkip;
        }// end function

        public function set bSkip(param1:Boolean) : void
        {
            this._bSkip = param1;
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

        public function get bBrokenItem() : Boolean
        {
            return this._bBrokenItem;
        }// end function

        public function set bBrokenItem(param1:Boolean) : void
        {
            this._bBrokenItem = param1;
            return;
        }// end function

    }
}
