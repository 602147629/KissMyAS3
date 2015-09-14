package dropdownList
{

    public class DropdownListData extends Object
    {
        private var _id:int;
        private var _text:String;

        public function DropdownListData(param1:int, param2:String)
        {
            this._id = param1;
            this._text = param2;
            return;
        }// end function

        public function get id() : int
        {
            return this._id;
        }// end function

        public function get text() : String
        {
            return this._text;
        }// end function

    }
}
