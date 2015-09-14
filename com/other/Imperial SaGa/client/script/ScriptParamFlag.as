package script
{

    public class ScriptParamFlag extends ScriptParamBase
    {
        private var _id:int;
        private var _value:Boolean;

        public function ScriptParamFlag()
        {
            return;
        }// end function

        public function get id() : int
        {
            return this._id;
        }// end function

        public function get value() : Boolean
        {
            return this._value;
        }// end function

        public function set value(param1:Boolean) : void
        {
            this._value = param1;
            return;
        }// end function

        public function setParam(param1:int, param2:Boolean) : void
        {
            this._id = param1;
            this._value = param2;
            return;
        }// end function

        public function clone() : ScriptParamFlag
        {
            var _loc_1:* = new ScriptParamFlag();
            _loc_1.setParam(this.id, this.value);
            return _loc_1;
        }// end function

    }
}
