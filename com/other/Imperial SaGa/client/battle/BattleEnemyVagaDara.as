package battle
{
    import enemy.*;
    import flash.display.*;
    import flash.geom.*;
    import utility.*;

    public class BattleEnemyVagaDara extends BattleEnemyMetamorphoseBase
    {
        private const _aMetamorphoseEnemyId:Array;
        private var _monsBg:EnemyBossVagaDaraBg;

        public function BattleEnemyVagaDara(param1:DisplayObjectContainer, param2:EnemyPersonal, param3:int, param4:Array)
        {
            this._aMetamorphoseEnemyId = [EnemyId.id_mons_VagaDara_Sword_IS, EnemyId.id_mons_VagaDara_Harp_IS, EnemyId.id_mons_VagaDara_Spear_IS];
            super(param1, param2, param3, param4);
            var _loc_5:* = _characterAction as BattleActionEnemy;
            this._monsBg = new EnemyBossVagaDaraBg(_parent, _loc_5.enemyDisplay);
            return;
        }// end function

        override public function release() : void
        {
            super.release();
            if (this._monsBg != null)
            {
                this._monsBg.release();
            }
            this._monsBg = null;
            return;
        }// end function

        override public function control(param1:Number) : void
        {
            super.control(param1);
            if (this._monsBg != null)
            {
                this._monsBg.control(param1);
            }
            return;
        }// end function

        override protected function changeEnemyTiming(param1:EnemyDisplayMetamorphoseBase, param2:EnemyDisplayMetamorphoseBase) : void
        {
            super.changeEnemyTiming(param1, param2);
            this._monsBg.release();
            this._monsBg = new EnemyBossVagaDaraBg(_parent, param1);
            return;
        }// end function

        override public function get bBattleDead() : Boolean
        {
            var _loc_1:* = null;
            for each (_loc_1 in _aMetamorphoseEnemyData)
            {
                
                if (_loc_1.enemyPersonal.bDead)
                {
                    return true;
                }
            }
            return false;
        }// end function

        override public function checkMetamorphose() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            _bMetamorphose = false;
            var _loc_1:* = _enemyPersonal.hp;
            for each (_loc_2 in _aMetamorphoseEnemyData)
            {
                
                _loc_2.enemyPersonal.setHp(_loc_1);
            }
            if (_enemyPersonal.bDead == false)
            {
                _loc_4 = this._aMetamorphoseEnemyId.indexOf(_enemyPersonal.infoId);
                _loc_5 = this._aMetamorphoseEnemyId[_loc_4];
                this._aMetamorphoseEnemyId.splice(_loc_4, 1);
                _loc_6 = Random.range(0, (this._aMetamorphoseEnemyId.length - 1));
                _loc_7 = this._aMetamorphoseEnemyId[_loc_6];
                this._aMetamorphoseEnemyId.unshift(_loc_5);
                _metamorphoseEnemyId = _loc_7;
                _bMetamorphose = true;
            }
            return;
        }// end function

        override public function setPosition(param1:Point) : void
        {
            super.setPosition(param1);
            if (this._monsBg)
            {
                this._monsBg.updatePosition(param1);
            }
            return;
        }// end function

    }
}
