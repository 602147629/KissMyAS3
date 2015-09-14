package storage
{
    import item.*;
    import message.*;
    import player.*;

    public class StorageItemData extends Object
    {
        private var _uniqueId:int;
        private var _category:int;
        private var _itemId:int;
        private var _num:int;
        private var _howtoGetId:int;
        private var _reasonText:String;
        private var _getTime:uint;
        private var _expiredTime:uint;
        private var _acceptTime:uint;

        public function StorageItemData(param1:Object)
        {
            this._uniqueId = param1.uniqueId;
            this._category = param1.category;
            this._itemId = param1.itemId;
            this._num = param1.num;
            this._howtoGetId = param1.howToGet;
            this._reasonText = param1.reasonText;
            if (this._reasonText == null)
            {
                this._reasonText = "";
            }
            this._getTime = param1.getTime;
            this._expiredTime = param1.expiredTime;
            this._acceptTime = param1.acceptTime;
            return;
        }// end function

        public function get uniqueId() : int
        {
            return this._uniqueId;
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

        public function get howtoGetId() : int
        {
            return this._howtoGetId;
        }// end function

        public function get reasonText() : String
        {
            return this._reasonText;
        }// end function

        public function get getTime() : uint
        {
            return this._getTime;
        }// end function

        public function get getTimeString() : String
        {
            return TextControl.createDateString(this._getTime);
        }// end function

        public function get expiredTime() : uint
        {
            return this._expiredTime;
        }// end function

        public function get expiredTimeString() : String
        {
            return TextControl.createDateString(this._expiredTime);
        }// end function

        public function get acceptTime() : uint
        {
            return this._acceptTime;
        }// end function

        public function get acceptTimeString() : String
        {
            return TextControl.createDateString(this._acceptTime);
        }// end function

        public function getItemName() : String
        {
            var _loc_1:* = null;
            switch(this.category)
            {
                case CommonConstant.ITEM_KIND_CROWN:
                {
                    return this.num + MessageManager.getInstance().getMessage(MessageId.COMMON_MONEY);
                }
                case CommonConstant.ITEM_KIND_WARRIOR:
                {
                    _loc_1 = PlayerManager.getInstance().getPlayerInformation(this.itemId);
                    return _loc_1.name;
                }
                default:
                {
                    return ItemManager.getInstance().getItemName(this.category, this.itemId);
                    break;
                }
            }
        }// end function

    }
}
