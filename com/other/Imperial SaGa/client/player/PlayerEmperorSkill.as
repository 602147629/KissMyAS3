package player
{

    public class PlayerEmperorSkill extends Object
    {
        private var _charId:int;
        private var _range:int;
        private var _target:int;
        private var _val:int;

        public function PlayerEmperorSkill()
        {
            return;
        }// end function

        public function get charId() : int
        {
            return this._charId;
        }// end function

        public function get range() : int
        {
            return this._range;
        }// end function

        public function get target() : int
        {
            return this._target;
        }// end function

        public function get val() : int
        {
            return this._val;
        }// end function

        public function setXml(param1:XML) : void
        {
            this._charId = param1.charId;
            this._range = param1.range;
            this._target = param1.target;
            this._val = param1.value;
            return;
        }// end function

    }
}
