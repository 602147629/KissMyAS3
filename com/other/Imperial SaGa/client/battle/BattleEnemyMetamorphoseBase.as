package battle
{
    import enemy.*;
    import flash.display.*;

    public class BattleEnemyMetamorphoseBase extends BattleEnemy
    {
        protected var _aMetamorphoseEnemyData:Array;
        protected var _bMetamorphose:Boolean;
        protected var _metamorphoseEnemyId:int;

        public function BattleEnemyMetamorphoseBase(param1:DisplayObjectContainer, param2:EnemyPersonal, param3:int, param4:Array)
        {
            this._aMetamorphoseEnemyData = [];
            this._bMetamorphose = false;
            super(param1, param2, param3);
            this.setChangeEnemyData(param4);
            return;
        }// end function

        public function get bMetamorphose() : Boolean
        {
            return this._bMetamorphose;
        }// end function

        override public function release() : void
        {
            var _loc_1:* = null;
            super.release();
            for each (_loc_1 in this._aMetamorphoseEnemyData)
            {
                
                _loc_1.release();
            }
            this._aMetamorphoseEnemyData = [];
            _parent = null;
            return;
        }// end function

        protected function setDeadImmortalEnemyId(param1:Array) : void
        {
            var _loc_2:* = _characterAction as BattleActionEnemy;
            if (_loc_2 != null)
            {
                _loc_2.aDeadImmortalEnemyId = param1;
            }
            return;
        }// end function

        protected function setChangeEnemyData(param1:Array) : void
        {
            var _loc_2:* = null;
            if (param1.length > 0)
            {
                this._aMetamorphoseEnemyData[_enemyPersonal.infoId] = new BattleChangeEnemyData(_enemyPersonal);
                for each (_loc_2 in param1)
                {
                    
                    if (_loc_2.questUniqueId == _enemyPersonal.questUniqueId)
                    {
                        this._aMetamorphoseEnemyData[_loc_2.infoId] = new BattleChangeEnemyData(_loc_2);
                    }
                }
            }
            return;
        }// end function

        override public function setUserSkill(param1:int) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            super.setUserSkill(param1);
            for each (_loc_2 in this._aMetamorphoseEnemyData)
            {
                
                _loc_3 = _loc_2.enemyPersonal;
                _loc_2.setSkill(EnemyManager.getInstance().getUseSkill(_loc_3.infoId));
            }
            return;
        }// end function

        public function checkMetamorphose() : void
        {
            return;
        }// end function

        override public function get bBattleDead() : Boolean
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            for (_loc_1 in this._aMetamorphoseEnemyData)
            {
                
                _loc_2 = this._aMetamorphoseEnemyData[_loc_1];
                if (_loc_2.enemyPersonal.bDead == false)
                {
                    return false;
                }
            }
            return true;
        }// end function

        public function setMetamorphose() : void
        {
            var _loc_1:* = _characterAction as BattleActionEnemy;
            var _loc_2:* = _loc_1.enemyDisplay as EnemyDisplayMetamorphoseBase;
            var _loc_3:* = this._aMetamorphoseEnemyData[this._metamorphoseEnemyId];
            this.updatePersonal(_loc_3.enemyPersonal);
            _loc_1.setDisplay(_parent, this._metamorphoseEnemyId, _enemyPersonal.questUniqueId);
            initAfterCharacterAction();
            _loc_1.enemyDisplay.pos = _loc_2.pos;
            setStatus(_loc_1.enemyDisplay.info);
            _aUseSkill = _loc_3.aUseSkill;
            _characterAction.setActionMetamorphoseEnd();
            this.changeEnemyTiming(_loc_1.enemyDisplay as EnemyDisplayMetamorphoseBase, _loc_2);
            _loc_2.release();
            this._bMetamorphose = false;
            return;
        }// end function

        protected function changeEnemyTiming(param1:EnemyDisplayMetamorphoseBase, param2:EnemyDisplayMetamorphoseBase) : void
        {
            return;
        }// end function

        private function updatePersonal(param1:EnemyPersonal) : void
        {
            setPersonal(param1);
            return;
        }// end function

    }
}
