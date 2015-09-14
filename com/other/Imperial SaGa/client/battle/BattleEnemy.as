package battle
{
    import character.*;
    import enemy.*;
    import flash.display.*;

    public class BattleEnemy extends BattleCharacterBase
    {
        protected var _enemyPersonal:EnemyPersonal;
        private var _enemyInfo:EnemyInformation;
        protected var _aUseSkill:Array;

        public function BattleEnemy(param1:DisplayObjectContainer, param2:EnemyPersonal, param3:int)
        {
            this._aUseSkill = [];
            super(param1, param2, param3);
            var _loc_4:* = new BattleActionEnemy(param1, this.enemyPersonal.infoId, this, _status);
            _characterAction = _loc_4;
            this._enemyInfo = _loc_4.enemyDisplay.info;
            initAfterCharacterAction();
            this.setStatus(this._enemyInfo);
            _division = BattleConstant.DIVISION_ENEMY;
            return;
        }// end function

        public function get enemyPersonal() : EnemyPersonal
        {
            return this._enemyPersonal;
        }// end function

        override public function get sex() : int
        {
            return this._enemyInfo.sex;
        }// end function

        override public function get armyType() : int
        {
            return this._enemyInfo.armyType;
        }// end function

        public function get aUseSkill() : Array
        {
            return this._aUseSkill.concat();
        }// end function

        override protected function setPersonal(param1:CharacterPersonal) : void
        {
            super.setPersonal(param1);
            this._enemyPersonal = param1 as EnemyPersonal;
            return;
        }// end function

        override public function release() : void
        {
            super.release();
            this._enemyInfo = null;
            this._enemyPersonal = null;
            return;
        }// end function

        public function setUserSkill(param1:int) : void
        {
            this._aUseSkill = EnemyManager.getInstance().getUseSkill(this._enemyPersonal.infoId);
            return;
        }// end function

        protected function setStatus(param1:EnemyInformation) : void
        {
            _status.aDefenseTolerance = param1.aDefenseTolerance;
            _status.aBadStatusTolerance = param1.aBadStatusTolerance;
            return;
        }// end function

    }
}
