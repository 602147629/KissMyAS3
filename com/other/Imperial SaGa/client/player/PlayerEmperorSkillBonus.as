package player
{

    public class PlayerEmperorSkillBonus extends Object
    {
        private var _uniqueId:int;
        private var _emperorId:int;
        private var _bonus:int;

        public function PlayerEmperorSkillBonus(param1:int, param2:int, param3:int)
        {
            this._uniqueId = param1;
            this._emperorId = param2;
            this._bonus = param3;
            return;
        }// end function

        public function get uniqueId() : int
        {
            return this._uniqueId;
        }// end function

        public function set uniqueId(param1:int) : void
        {
            this._uniqueId = param1;
            return;
        }// end function

        public function get emperorId() : int
        {
            return this._emperorId;
        }// end function

        public function set emperorId(param1:int) : void
        {
            this._emperorId = param1;
            return;
        }// end function

        public function get bonus() : int
        {
            return this._bonus;
        }// end function

        public function set bonus(param1:int) : void
        {
            this._bonus = param1;
            return;
        }// end function

    }
}
