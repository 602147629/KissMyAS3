package battle
{
    import effect.*;
    import enemy.*;
    import flash.display.*;
    import utility.*;

    public class BattleEnemyDestroyer extends BattleEnemyMetamorphoseBase
    {
        private const _CHANGE_COUNT_RESET:int = 1;
        private const _FIRST_ENEMY_ID:int = 53090;
        private const _LAST_ENEMY_ID:int = 53091;
        private const _aMetamorphoseEnemyId:Array;
        private var _changeCount:int;

        public function BattleEnemyDestroyer(param1:DisplayObjectContainer, param2:EnemyPersonal, param3:int, param4:Array)
        {
            this._aMetamorphoseEnemyId = [EnemyId.id_mons_Destryer_5th_RS3, EnemyId.id_mons_Destryer_6th_RS3, EnemyId.id_mons_Destryer_7th_RS3, EnemyId.id_mons_Destryer_8th_RS3];
            super(param1, param2, param3, param4);
            var _loc_5:* = [this._FIRST_ENEMY_ID];
            _loc_5 = [this._FIRST_ENEMY_ID].concat(this._aMetamorphoseEnemyId);
            setDeadImmortalEnemyId(_loc_5);
            this._changeCount = this._CHANGE_COUNT_RESET;
            return;
        }// end function

        override public function get bBattleDead() : Boolean
        {
            var _loc_1:* = null;
            _loc_1 = _aMetamorphoseEnemyData[this._FIRST_ENEMY_ID];
            if (_loc_1.enemyPersonal.bDead == false)
            {
                return false;
            }
            _loc_1 = _aMetamorphoseEnemyData[this._LAST_ENEMY_ID];
            if (_loc_1.enemyPersonal.bDead == false)
            {
                return false;
            }
            return true;
        }// end function

        override public function checkMetamorphose() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = 0;
            _bMetamorphose = false;
            if (_enemyPersonal.infoId == this._LAST_ENEMY_ID)
            {
                return;
            }
            var _loc_4:* = this;
            var _loc_5:* = this._changeCount - 1;
            _loc_4._changeCount = _loc_5;
            if (this._changeCount <= 0 || _enemyPersonal.bDead)
            {
                switch(_enemyPersonal.infoId)
                {
                    case this._FIRST_ENEMY_ID:
                    {
                        if (_enemyPersonal.bDead)
                        {
                            _metamorphoseEnemyId = this._LAST_ENEMY_ID;
                            _bMetamorphose = true;
                            break;
                        }
                        _loc_2 = [];
                        for each (_loc_3 in this._aMetamorphoseEnemyId)
                        {
                            
                            _loc_1 = _aMetamorphoseEnemyData[_loc_3];
                            if (_loc_1.enemyPersonal.bDead == false)
                            {
                                _loc_2.push(_loc_3);
                            }
                        }
                        if (_loc_2.length > 0)
                        {
                            _metamorphoseEnemyId = _loc_2[Random.range(0, (_loc_2.length - 1))];
                            _bMetamorphose = true;
                        }
                        break;
                    }
                    default:
                    {
                        _metamorphoseEnemyId = this._FIRST_ENEMY_ID;
                        _bMetamorphose = true;
                        break;
                        break;
                    }
                }
                this._changeCount = this._CHANGE_COUNT_RESET;
            }
            return;
        }// end function

        override protected function changeEnemyTiming(param1:EnemyDisplayMetamorphoseBase, param2:EnemyDisplayMetamorphoseBase) : void
        {
            super.changeEnemyTiming(param1, param2);
            var _loc_3:* = param1 as EnemyBossDestryer;
            var _loc_4:* = param2 as EnemyBossDestryer;
            var _loc_5:* = (param2 as EnemyBossDestryer).effectFireMain;
            var _loc_6:* = _loc_4.effectWaterMain;
            _loc_3.setEffectData(_loc_5.bmpData, _loc_6.bmpData);
            _loc_5.clearBmp();
            _loc_6.clearBmp();
            return;
        }// end function

    }
}
