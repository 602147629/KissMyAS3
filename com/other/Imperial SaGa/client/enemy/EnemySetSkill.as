package enemy
{

    public class EnemySetSkill extends Object
    {
        private var _skillId:int;
        private var _rate:int;

        public function EnemySetSkill(param1:int, param2:int)
        {
            this._skillId = param1;
            this._rate = param2;
            return;
        }// end function

        public function get skillId() : int
        {
            return this._skillId;
        }// end function

        public function get rate() : int
        {
            return this._rate;
        }// end function

    }
}
