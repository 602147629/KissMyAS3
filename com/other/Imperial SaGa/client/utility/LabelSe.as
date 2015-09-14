package utility
{

    public class LabelSe extends Object
    {
        private var _label:String;
        private var _seId:int;

        public function LabelSe(param1:String, param2:int)
        {
            this._label = param1;
            this._seId = param2;
            return;
        }// end function

        public function get label() : String
        {
            return this._label;
        }// end function

        public function set label(param1:String) : void
        {
            this._label = param1;
            return;
        }// end function

        public function get seId() : int
        {
            return this._seId;
        }// end function

        public function set seId(param1:int) : void
        {
            this._seId = param1;
            return;
        }// end function

    }
}
