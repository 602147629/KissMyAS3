package subdualPoint
{

    public class SubdualPointRewardData extends Object
    {
        private var _status:int;
        private var _point:int;
        private var _itemType:int;
        private var _itemId:int;
        private var _num:int;
        private static const _STATUS_UNATTAINED:int = 0;
        private static const _STATUS_ACHIEVED:int = 1;
        private static const _STATUS_RECEIPT:int = 2;

        public function SubdualPointRewardData()
        {
            return;
        }// end function

        public function get bAchieved() : Boolean
        {
            return this._status == _STATUS_ACHIEVED;
        }// end function

        public function get bGet() : Boolean
        {
            return this._status == _STATUS_RECEIPT;
        }// end function

        public function get point() : int
        {
            return this._point;
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
            return this._num;
        }// end function

        public function setRecieve(param1:Object) : void
        {
            this._status = param1.status;
            this._point = param1.point;
            this._itemType = param1.itemType;
            this._itemId = param1.itemId;
            this._num = param1.itemNum;
            return;
        }// end function

        public function changeStatusReceipt() : void
        {
            this._status = _STATUS_RECEIPT;
            return;
        }// end function

    }
}
