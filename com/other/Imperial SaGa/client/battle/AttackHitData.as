package battle
{

    public class AttackHitData extends Object
    {
        private var _questUniqueId:int;
        private var _bAttackHit:Boolean;
        private var _bCritical:Boolean;
        private var _bRefuse:Boolean;
        private var _bHit:Boolean;
        private var _bCountered:Boolean;
        private var _shield:int;
        private var _bAddStatusMiss:Boolean;

        public function AttackHitData(param1:int)
        {
            this._questUniqueId = param1;
            this._bAttackHit = false;
            this._bCritical = false;
            this._bRefuse = false;
            this._bHit = false;
            this._bCountered = false;
            this._shield = BattleConstant.DEFENSE_SHIELD_NON;
            this._bAddStatusMiss = false;
            return;
        }// end function

        public function get questUniqueId() : int
        {
            return this._questUniqueId;
        }// end function

        public function get bAttackHit() : Boolean
        {
            return this._bAttackHit;
        }// end function

        public function set bAttackHit(param1:Boolean) : void
        {
            this._bAttackHit = param1;
            return;
        }// end function

        public function get bCritical() : Boolean
        {
            return this._bCritical;
        }// end function

        public function set bCritical(param1:Boolean) : void
        {
            this._bCritical = param1;
            return;
        }// end function

        public function get bRefuse() : Boolean
        {
            return this._bRefuse;
        }// end function

        public function set bRefuse(param1:Boolean) : void
        {
            this._bRefuse = param1;
            return;
        }// end function

        public function get bHit() : Boolean
        {
            return this._bHit;
        }// end function

        public function set bHit(param1:Boolean) : void
        {
            this._bHit = param1;
            return;
        }// end function

        public function get bCountered() : Boolean
        {
            return this._bCountered;
        }// end function

        public function set bCountered(param1:Boolean) : void
        {
            this._bCountered = param1;
            return;
        }// end function

        public function get shield() : int
        {
            return this._shield;
        }// end function

        public function set shield(param1:int) : void
        {
            this._shield = param1;
            return;
        }// end function

        public function get bAddStatusMiss() : Boolean
        {
            return this._bAddStatusMiss;
        }// end function

        public function set bAddStatusMiss(param1:Boolean) : void
        {
            this._bAddStatusMiss = param1;
            return;
        }// end function

        public function getAttackHitType(param1:int) : int
        {
            return AttackHitData.getAttackHitType(this._bHit, param1, this._bCritical, this._bRefuse);
        }// end function

        public static function getAttackHitType(param1:Boolean, param2:int, param3:Boolean, param4:Boolean = false) : int
        {
            var _loc_5:* = param1 ? (BattleConstant.HIT_TYPE_NORMAL) : (BattleConstant.HIT_TYPE_MISS);
            if (param1 && param2 > 0)
            {
                if (param3)
                {
                    _loc_5 = BattleConstant.HIT_TYPE_CRITICAL;
                }
                if (param4)
                {
                    _loc_5 = BattleConstant.HIT_TYPE_REFUSE;
                }
            }
            return _loc_5;
        }// end function

    }
}
