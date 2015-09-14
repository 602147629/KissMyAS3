package notice
{

    public class SimpleNoticeInfo extends Object
    {
        private var _uniqueId:int;
        private var _type:int;
        private var _epochTime:int;
        private var _itemType:int;
        private var _itemId:int;
        private var _itemNum:int;
        private var _commonNum:int;
        private var _commonString:String;
        private var _sortParam:int;
        private var _bWarehouse:Boolean;

        public function SimpleNoticeInfo()
        {
            return;
        }// end function

        public function setNoticeInfo(param1:Object) : void
        {
            this._uniqueId = param1.uniqueId;
            this._type = param1.type;
            this._epochTime = param1.time;
            this._itemType = param1.itemType;
            this._itemId = param1.itemId;
            this._itemNum = param1.itemNum;
            this._commonNum = param1.commonNum;
            this._commonString = param1.commonString;
            if (this._commonString == null)
            {
                this._commonString = "";
            }
            this._sortParam = this._type;
            if (this._type == CommonConstant.NOTICE_LV_UP_REMUNERATION)
            {
                this._sortParam = CommonConstant.NOTICE_LV_UP + 1;
            }
            if (this._type == CommonConstant.NOTICE_LV_UP_FORMATION)
            {
                this._sortParam = CommonConstant.NOTICE_LV_UP + 2;
            }
            if (this._type == CommonConstant.NOTICE_LV_UP_FACILITY)
            {
                this._sortParam = CommonConstant.NOTICE_LV_UP + 3;
            }
            return;
        }// end function

        public function get uniqueId() : int
        {
            return this._uniqueId;
        }// end function

        public function get type() : int
        {
            return this._type;
        }// end function

        public function get epochTime() : int
        {
            return this._epochTime;
        }// end function

        public function get itemType() : int
        {
            return this._itemType;
        }// end function

        public function get itemId() : int
        {
            return this._itemId;
        }// end function

        public function get itemNum() : int
        {
            return this._itemNum;
        }// end function

        public function get commonNum() : int
        {
            return this._commonNum;
        }// end function

        public function get commonString() : String
        {
            return this._commonString;
        }// end function

        public function get sortParam() : int
        {
            return this._sortParam;
        }// end function

        public function get bWarehouse() : Boolean
        {
            return this._bWarehouse;
        }// end function

        public function setWarehouse(param1:Boolean) : void
        {
            this._bWarehouse = param1;
            return;
        }// end function

    }
}
