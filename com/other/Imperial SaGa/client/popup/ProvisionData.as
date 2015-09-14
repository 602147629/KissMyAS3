package popup
{

    public class ProvisionData extends Object
    {
        private var _category:int;
        private var _itemId:int;
        private var _num:int;
        private var _message:String;

        public function ProvisionData(param1:int, param2:int, param3:int, param4:String)
        {
            this._category = param1;
            this._itemId = param2;
            this._num = param3;
            this._message = param4;
            return;
        }// end function

        public function get category() : int
        {
            return this._category;
        }// end function

        public function get itemId() : int
        {
            return this._itemId;
        }// end function

        public function get num() : int
        {
            return this._num;
        }// end function

        public function get message() : String
        {
            return this._message;
        }// end function

    }
}
