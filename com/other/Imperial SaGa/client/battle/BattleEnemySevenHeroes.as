package battle
{
    import enemy.*;
    import flash.display.*;

    public class BattleEnemySevenHeroes extends BattleEnemyMetamorphoseBase
    {
        private const _LAST_ENEMY_ID:int = 52086;
        private const _aMetamorphoseEnemyId:Array;
        private var _metamorphoseIndex:int;

        public function BattleEnemySevenHeroes(param1:DisplayObjectContainer, param2:EnemyPersonal, param3:int, param4:Array)
        {
            this._aMetamorphoseEnemyId = [EnemyId.id_mons_SevenHeroes_First_RS2, EnemyId.id_mons_SevenHeroes_Second_RS2, EnemyId.id_mons_SevenHeroes_Thrid_RS2, EnemyId.id_mons_SevenHeroes_Forth_RS2, EnemyId.id_mons_SevenHeroes_Fifth_RS2, EnemyId.id_mons_SevenHeroes_Sixth_RS2, EnemyId.id_mons_SevenHeroes_Final_RS2];
            super(param1, param2, param3, param4);
            var _loc_5:* = this._aMetamorphoseEnemyId.slice(0, (this._aMetamorphoseEnemyId.length - 1));
            setDeadImmortalEnemyId(_loc_5);
            this._metamorphoseIndex = 0;
            return;
        }// end function

        override public function get bBattleDead() : Boolean
        {
            var _loc_1:* = null;
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
            var _loc_2:* = 0;
            _bMetamorphose = false;
            if (_enemyPersonal.infoId == this._LAST_ENEMY_ID)
            {
                return;
            }
            if (this._metamorphoseIndex >= this._aMetamorphoseEnemyId.length)
            {
                return;
            }
            if (_enemyPersonal.bDead)
            {
                var _loc_3:* = this;
                var _loc_4:* = this._metamorphoseIndex + 1;
                _loc_3._metamorphoseIndex = _loc_4;
                _loc_2 = this._aMetamorphoseEnemyId[this._metamorphoseIndex];
                _metamorphoseEnemyId = _loc_2;
                _bMetamorphose = true;
            }
            return;
        }// end function

    }
}
