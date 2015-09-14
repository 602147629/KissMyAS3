package battle
{

    public class BattleStatusListData extends Object
    {
        private var _id:int;
        private var _group:int;
        private var _effectRate:int;
        private var _turnMin:int;
        private var _turnMax:int;
        private var _param0:int;
        private var _bDamageRecovery:Boolean;
        private var _conflictId:int;

        public function BattleStatusListData()
        {
            return;
        }// end function

        public function get id() : int
        {
            return this._id;
        }// end function

        public function get group() : int
        {
            return this._group;
        }// end function

        public function get effectRate() : int
        {
            return this._effectRate;
        }// end function

        public function get turnMin() : int
        {
            return this._turnMin;
        }// end function

        public function get turnMax() : int
        {
            return this._turnMax;
        }// end function

        public function get param0() : int
        {
            return this._param0;
        }// end function

        public function get bDamageRecovery() : Boolean
        {
            return this._bDamageRecovery;
        }// end function

        public function get conflictId() : int
        {
            return this._conflictId;
        }// end function

        public function setXml(param1:XML) : void
        {
            this._id = int(param1.id);
            this._group = int(param1.group);
            this._effectRate = int(param1.effectRate);
            this._turnMin = int(param1.turnMin);
            this._turnMax = int(param1.turnMax);
            this._param0 = int(param1.param0);
            this._bDamageRecovery = int(param1.damageRecovery) == 1;
            this._conflictId = Constant.EMPTY_ID;
            switch(this._id)
            {
                case BattleConstant.BAD_STATUS_ID_ATTACK_DOWN:
                {
                    this._conflictId = BattleConstant.BAD_STATUS_ID_ATTACK_UP;
                    break;
                }
                case BattleConstant.BAD_STATUS_ID_ATTACK_UP:
                {
                    this._conflictId = BattleConstant.BAD_STATUS_ID_ATTACK_DOWN;
                    break;
                }
                case BattleConstant.BAD_STATUS_ID_DEFENSE_DOWN:
                {
                    this._conflictId = BattleConstant.BAD_STATUS_ID_DEFENSE_UP;
                    break;
                }
                case BattleConstant.BAD_STATUS_ID_DEFENSE_UP:
                {
                    this._conflictId = BattleConstant.BAD_STATUS_ID_DEFENSE_DOWN;
                    break;
                }
                case BattleConstant.BAD_STATUS_ID_SPEED_DOWN:
                {
                    this._conflictId = BattleConstant.BAD_STATUS_ID_SPEED_UP;
                    break;
                }
                case BattleConstant.BAD_STATUS_ID_SPEED_UP:
                {
                    this._conflictId = BattleConstant.BAD_STATUS_ID_SPEED_DOWN;
                    break;
                }
                case BattleConstant.BAD_STATUS_ID_MAGIC_DOWN:
                {
                    this._conflictId = BattleConstant.BAD_STATUS_ID_MAGIC_UP;
                    break;
                }
                case BattleConstant.BAD_STATUS_ID_MAGIC_UP:
                {
                    this._conflictId = BattleConstant.BAD_STATUS_ID_MAGIC_DOWN;
                    break;
                }
                case BattleConstant.BAD_STATUS_ID_SLASH_TOLERANCE_DOWN:
                {
                    this._conflictId = BattleConstant.BAD_STATUS_ID_SLASH_TOLERANCE_UP;
                    break;
                }
                case BattleConstant.BAD_STATUS_ID_SLASH_TOLERANCE_UP:
                {
                    this._conflictId = BattleConstant.BAD_STATUS_ID_SLASH_TOLERANCE_DOWN;
                    break;
                }
                case BattleConstant.BAD_STATUS_ID_PUNCH_TOLERANCE_DOWN:
                {
                    this._conflictId = BattleConstant.BAD_STATUS_ID_PUNCH_TOLERANCE_UP;
                    break;
                }
                case BattleConstant.BAD_STATUS_ID_PUNCH_TOLERANCE_UP:
                {
                    this._conflictId = BattleConstant.BAD_STATUS_ID_PUNCH_TOLERANCE_DOWN;
                    break;
                }
                case BattleConstant.BAD_STATUS_ID_THRUST_TOLERANCE_DOWN:
                {
                    this._conflictId = BattleConstant.BAD_STATUS_ID_THRUST_TOLERANCE_UP;
                    break;
                }
                case BattleConstant.BAD_STATUS_ID_THRUST_TOLERANCE_UP:
                {
                    this._conflictId = BattleConstant.BAD_STATUS_ID_THRUST_TOLERANCE_DOWN;
                    break;
                }
                case BattleConstant.BAD_STATUS_ID_HEAT_TOLERANCE_DOWN:
                {
                    this._conflictId = BattleConstant.BAD_STATUS_ID_HEAT_TOLERANCE_UP;
                    break;
                }
                case BattleConstant.BAD_STATUS_ID_HEAT_TOLERANCE_UP:
                {
                    this._conflictId = BattleConstant.BAD_STATUS_ID_HEAT_TOLERANCE_DOWN;
                    break;
                }
                case BattleConstant.BAD_STATUS_ID_ICY_TOLERANCE_DOWN:
                {
                    this._conflictId = BattleConstant.BAD_STATUS_ID_ICY_TOLERANCE_UP;
                    break;
                }
                case BattleConstant.BAD_STATUS_ID_ICY_TOLERANCE_UP:
                {
                    this._conflictId = BattleConstant.BAD_STATUS_ID_ICY_TOLERANCE_DOWN;
                    break;
                }
                case BattleConstant.BAD_STATUS_ID_THUNDER_TOLERANCE_DOWN:
                {
                    this._conflictId = BattleConstant.BAD_STATUS_ID_THUNDER_TOLERANCE_UP;
                    break;
                }
                case BattleConstant.BAD_STATUS_ID_THUNDER_TOLERANCE_UP:
                {
                    this._conflictId = BattleConstant.BAD_STATUS_ID_THUNDER_TOLERANCE_DOWN;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

    }
}
