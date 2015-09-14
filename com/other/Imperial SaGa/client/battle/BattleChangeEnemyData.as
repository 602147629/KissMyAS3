package battle
{
    import enemy.*;

    public class BattleChangeEnemyData extends Object
    {
        private var _enemyPersonal:EnemyPersonal;
        private var _aUseSkill:Array;

        public function BattleChangeEnemyData(param1:EnemyPersonal)
        {
            this._enemyPersonal = param1;
            this._aUseSkill = [];
            return;
        }// end function

        public function get enemyPersonal() : EnemyPersonal
        {
            return this._enemyPersonal;
        }// end function

        public function get aUseSkill() : Array
        {
            return this._aUseSkill;
        }// end function

        public function release() : void
        {
            this._enemyPersonal = null;
            this._aUseSkill = [];
            return;
        }// end function

        public function setSkill(param1:Array) : void
        {
            this._aUseSkill = param1.concat();
            return;
        }// end function

    }
}
