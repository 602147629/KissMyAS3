package battle
{

    public class AttackDataFormation extends AttackDataBase
    {
        private var _aQuestUniqueId:Array;
        private var _formationSkillId:int;

        public function AttackDataFormation()
        {
            _attackType = BattleConstant.ATTACK_DATA_TYPE_FORMATION;
            this._aQuestUniqueId = [];
            this._formationSkillId = 0;
            return;
        }// end function

        public function get aQuestUniqueId() : Array
        {
            return this._aQuestUniqueId;
        }// end function

        public function set aQuestUniqueId(param1:Array) : void
        {
            this._aQuestUniqueId = param1.concat();
            return;
        }// end function

        public function get formationSkillId() : int
        {
            return this._formationSkillId;
        }// end function

        public function set formationSkillId(param1:int) : void
        {
            this._formationSkillId = param1;
            return;
        }// end function

    }
}
