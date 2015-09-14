package script
{

    public class ScriptSelectChoice extends Object
    {
        private var _message:String;
        private var _label:String;
        private var _no:int;
        private var _passive:Boolean;

        public function ScriptSelectChoice()
        {
            return;
        }// end function

        public function get message() : String
        {
            return this._message;
        }// end function

        public function get label() : String
        {
            return this._label;
        }// end function

        public function get no() : int
        {
            return this._no;
        }// end function

        public function get passive() : Boolean
        {
            return this._passive;
        }// end function

        public function setParam(param1:String, param2:String, param3:int, param4:Boolean = true) : void
        {
            this._message = param1;
            this._label = param2;
            this._no = param3;
            this._passive = param4;
            return;
        }// end function

    }
}
