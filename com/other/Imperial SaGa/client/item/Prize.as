package item
{

    public class Prize extends Object
    {
        private var _itemType:int;
        private var _itemId:int;
        private var _itemNum:int;

        public function Prize()
        {
            this.setData(0, Constant.EMPTY_ID, 0);
            return;
        }// end function

        public function get category() : int
        {
            return this._itemType;
        }// end function

        public function get itemId() : int
        {
            return this._itemId;
        }// end function

        public function get num() : uint
        {
            return this._itemNum;
        }// end function

        public function setReceive(param1:Object) : void
        {
            this.setData(param1.itemType, param1.itemId, param1.itemNum);
            return;
        }// end function

        public function setData(param1:int, param2:int, param3:int) : void
        {
            this._itemType = param1;
            this._itemId = param2;
            this._itemNum = param3;
            return;
        }// end function

    }
}
