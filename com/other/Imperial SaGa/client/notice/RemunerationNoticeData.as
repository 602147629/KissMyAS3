package notice
{

    public class RemunerationNoticeData extends Object
    {
        private var _uniqueId:int;
        private var _noticeType:int;
        private var _category:int;
        private var _itemId:int;
        private var _num:int;
        private var _bWarehouse:Boolean;

        public function RemunerationNoticeData()
        {
            return;
        }// end function

        public function get uniqueId() : int
        {
            return this._uniqueId;
        }// end function

        public function get noticeType() : int
        {
            return this._noticeType;
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

        public function get bWarehouse() : Boolean
        {
            return this._bWarehouse;
        }// end function

        public function setRemuneration(param1:int, param2:int, param3:int, param4:int, param5:int, param6:Boolean) : void
        {
            this._uniqueId = param1;
            this._noticeType = param2;
            this._category = param3;
            this._itemId = param4;
            this._num = param5;
            this._bWarehouse = param6;
            return;
        }// end function

    }
}
