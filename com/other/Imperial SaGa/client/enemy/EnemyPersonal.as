package enemy
{
    import character.*;

    public class EnemyPersonal extends CharacterPersonal
    {
        private var _infoId:int;
        private var _rank:int;

        public function EnemyPersonal()
        {
            this.initialize();
            return;
        }// end function

        public function get infoId() : int
        {
            return this._infoId;
        }// end function

        public function get rank() : int
        {
            return this._rank;
        }// end function

        override public function setParameter(param1:Object) : void
        {
            super.setParameter(param1);
            _questUniqueId = int(param1.questUniqueId);
            this._infoId = int(param1.enemyId);
            var _loc_2:* = EnemyManager.getInstance().getEnemyInformation(this._infoId);
            _hpMax = _loc_2.hp + param1.addHp;
            _hp = _hpMax;
            _attack = _loc_2.attack + param1.addAtk;
            _defense = _loc_2.defense + param1.addDef;
            _speed = _loc_2.speed + param1.addSpd;
            this._rank = _loc_2.rank + param1.addWeaponLv;
            _magicReasonable = _loc_2.magicReasonable;
            _useSkillId = Constant.EMPTY_ID;
            if (_hp <= 0)
            {
                _bDead = true;
            }
            return;
        }// end function

        override public function get magicReasonableTotal() : int
        {
            return Math.max(0, super.magicReasonable);
        }// end function

        public function clone() : EnemyPersonal
        {
            var _loc_1:* = new EnemyPersonal();
            _loc_1.copyParam(this);
            return _loc_1;
        }// end function

        private function initialize() : void
        {
            this._rank = 0;
            return;
        }// end function

        protected function copyParam(param1:EnemyPersonal) : void
        {
            super.copyParameter(param1);
            this._rank = param1.rank;
            return;
        }// end function

        public function recoveryHp(param1:int) : void
        {
            _hp = _hp + param1;
            if (_hp > _hpMax)
            {
                _hp = _hpMax;
            }
            return;
        }// end function

    }
}
