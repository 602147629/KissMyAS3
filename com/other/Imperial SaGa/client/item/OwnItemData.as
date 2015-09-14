package item
{

    public class OwnItemData extends Object
    {
        private var _itemId:int;
        private var _itemCategory:int;
        private var _num:int;

        public function OwnItemData(param1:int, param2:int, param3:int)
        {
            this._itemId = param1;
            this._itemCategory = param2;
            this._num = param3;
            return;
        }// end function

        public function get itemId() : int
        {
            return this._itemId;
        }// end function

        public function get itemCategory() : int
        {
            return this._itemCategory;
        }// end function

        public function get num() : int
        {
            return this._num;
        }// end function

        public function setNum(param1:int) : void
        {
            this._num = param1;
            if (this._num < 0)
            {
                this._num = 0;
            }
            return;
        }// end function

    }
}
