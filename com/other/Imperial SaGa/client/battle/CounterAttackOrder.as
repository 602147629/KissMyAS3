package battle
{

    public class CounterAttackOrder extends Object
    {
        private var _questUniqueId:int;
        private var _targetUniqueId:int;
        private var _counterSkillId:int;

        public function CounterAttackOrder(param1:int, param2:int, param3:int)
        {
            this._questUniqueId = param1;
            this._targetUniqueId = param2;
            this._counterSkillId = param3;
            return;
        }// end function

        public function get questUniqueId() : int
        {
            return this._questUniqueId;
        }// end function

        public function get targetUniqueId() : int
        {
            return this._targetUniqueId;
        }// end function

        public function get counterSkillId() : int
        {
            return this._counterSkillId;
        }// end function

    }
}
