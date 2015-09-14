package battle
{
    import flash.display.*;
    import player.*;
    import skill.*;

    public class BattlePlayer extends BattleCharacterBase
    {
        private var _playerPersonal:PlayerPersonal;
        private var _startHp:int;
        private var _fixDamage:int;
        private var _playerInfo:PlayerInformation;
        private var _defaultSkillId:int;

        public function BattlePlayer(param1:DisplayObjectContainer, param2:PlayerPersonal, param3:int)
        {
            super(param1, param2, param3);
            this._playerPersonal = param2;
            this._startHp = this._playerPersonal.hp;
            this._fixDamage = Constant.UNDECIDED;
            var _loc_4:* = new BattleActionPlayer(param1, this.playerPersonal.playerId, this, _status);
            _characterAction = _loc_4;
            this._playerInfo = _loc_4.playerDisplay.info;
            initAfterCharacterAction();
            this._defaultSkillId = BattleManager.getDefaultSkillId(this._playerInfo);
            _characterAction.setUseSkillId(this._defaultSkillId);
            this.updateTolerance();
            _division = BattleConstant.DIVISION_PLAYER;
            return;
        }// end function

        public function get playerPersonal() : PlayerPersonal
        {
            return this._playerPersonal;
        }// end function

        public function fixRecoverTargetDamage() : void
        {
            this._fixDamage = this._startHp - this._playerPersonal.hp;
            if (this._fixDamage < 0)
            {
                this._fixDamage = 0;
            }
            return;
        }// end function

        public function getRecoverTargetDamage() : int
        {
            var _loc_1:* = this._fixDamage >= 0 ? (this._fixDamage) : (this._startHp - this._playerPersonal.hp);
            if (_loc_1 < 0)
            {
                _loc_1 = 0;
            }
            return _loc_1;
        }// end function

        override public function get sex() : int
        {
            return this._playerInfo.sex;
        }// end function

        public function get defaultSkillId() : int
        {
            return this._defaultSkillId;
        }// end function

        override public function getGrowthTotal() : int
        {
            return this._playerPersonal.getGrowthTotal();
        }// end function

        override public function getSkillPower(param1:SkillInformation) : int
        {
            var _loc_2:* = this._playerPersonal.getOwnSkillData(param1.id);
            if (_loc_2)
            {
                return _loc_2.powerTotal;
            }
            return param1.power;
        }// end function

        override public function getSkillHit(param1:SkillInformation) : int
        {
            var _loc_2:* = this._playerPersonal.getOwnSkillData(param1.id);
            if (_loc_2)
            {
                return _loc_2.hitTotal;
            }
            return param1.hit;
        }// end function

        public function getSkillUseSp(param1:SkillInformation) : int
        {
            var _loc_2:* = this._playerPersonal.getOwnSkillData(param1.id);
            if (_loc_2)
            {
                return _loc_2.spTotal;
            }
            return param1.sp;
        }// end function

        override public function release() : void
        {
            super.release();
            this._playerInfo = null;
            this._playerPersonal = null;
            return;
        }// end function

        override public function dealDamage(param1:int) : void
        {
            if (this._playerPersonal.bDead)
            {
                return;
            }
            this.playerPersonal.addSp(BattleCalc.calcAttackRecoverSp(this, param1));
            return;
        }// end function

        public function updateTolerance() : void
        {
            if (this._playerPersonal)
            {
                _status.aDefenseTolerance = this._playerPersonal.getDefenseToleranceTotal();
                _status.aBadStatusTolerance = this._playerPersonal.getBadStatusToleranceTotal();
            }
            return;
        }// end function

    }
}
