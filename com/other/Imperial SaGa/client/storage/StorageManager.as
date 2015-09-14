package storage
{
    import message.*;
    import utility.*;

    public class StorageManager extends Object
    {
        private var _aStorageItem:Array;
        private var _aStorageUnlimitedItem:Array;
        private var _aReceiveItem:Array;
        private var _filterId:int;
        private var _warehouseGiftCount:int;
        private var _warehouseUnlimitedGiftCount:int;
        private var _warehouseGiftDleted:int;
        private static var _instance:StorageManager = null;
        private static var _bInternalAccess:Boolean = false;
        private static const WAREHOUSE_GIFT_DLETED_TIME_OVER:int = 1;
        private static const WAREHOUSE_GIFT_DLETED_RECORD_OVER:int = 2;
        private static const WAREHOUSE_GIFT_DLETED_BOTH:int = 3;

        public function StorageManager()
        {
            if (_bInternalAccess)
            {
                _bInternalAccess = false;
                this.init();
            }
            else
            {
                Assert.print("ItemStoreManagerはシングルトンクラスです");
            }
            return;
        }// end function

        private function init() : void
        {
            this._aStorageUnlimitedItem = [];
            this._aStorageItem = [];
            this._aReceiveItem = [];
            return;
        }// end function

        public function setStorageItem(param1:Array) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            this._aStorageItem = [];
            for each (_loc_2 in param1)
            {
                
                _loc_3 = new StorageItemData(_loc_2);
                if (_loc_3.category == 0 && _loc_3.itemId == 0)
                {
                    continue;
                }
                this._aStorageItem.push(_loc_3);
            }
            this.setUnlimitedGiftCount(this._aStorageItem.length);
            return;
        }// end function

        public function deleteStorageItem(param1:Array) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            for each (_loc_2 in param1)
            {
                
                _loc_3 = this.getStorageItem(_loc_2.uniqueId);
                if (_loc_3)
                {
                    this._aStorageItem.splice(this._aStorageItem.indexOf(_loc_3), 1);
                }
            }
            this.setGiftCount(this._aStorageItem.length);
            return;
        }// end function

        public function setStorageUnlimitedItem(param1:Array) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            this._aStorageUnlimitedItem = [];
            for each (_loc_2 in param1)
            {
                
                _loc_3 = new StorageItemData(_loc_2);
                if (_loc_3.category == 0 && _loc_3.itemId == 0)
                {
                    continue;
                }
                this._aStorageUnlimitedItem.push(_loc_3);
            }
            this.setUnlimitedGiftCount(this._aStorageUnlimitedItem.length);
            return;
        }// end function

        public function deleteStorageUnlimitedItem(param1:Array) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            for each (_loc_2 in param1)
            {
                
                _loc_3 = this.getStorageItem(_loc_2.uniqueId);
                if (_loc_3)
                {
                    this._aStorageUnlimitedItem.splice(this._aStorageUnlimitedItem.indexOf(_loc_3), 1);
                }
            }
            this.setUnlimitedGiftCount(this._aStorageUnlimitedItem.length);
            return;
        }// end function

        public function addReceiveItem(param1:Array) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = [];
            _loc_3 = this._aReceiveItem.concat();
            var _loc_4:* = param1.length - 1;
            while (_loc_4 >= 0)
            {
                
                _loc_2 = param1[_loc_4];
                _loc_3.unshift(new StorageItemData(_loc_2));
                _loc_4 = _loc_4 - 1;
            }
            this._aReceiveItem = _loc_3.slice(0, _loc_3.length > StorageConstant.HISTORY_LIMIT ? (StorageConstant.HISTORY_LIMIT) : (_loc_3.length));
            return;
        }// end function

        public function setReceiveItem(param1:Array) : void
        {
            this._aReceiveItem = [];
            this.addReceiveItem(param1);
            return;
        }// end function

        public function getStorageItem(param1:int) : StorageItemData
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aStorageUnlimitedItem)
            {
                
                if (param1 == _loc_2.uniqueId)
                {
                    return _loc_2;
                }
            }
            for each (_loc_2 in this._aStorageItem)
            {
                
                if (param1 == _loc_2.uniqueId)
                {
                    return _loc_2;
                }
            }
            for each (_loc_2 in this._aReceiveItem)
            {
                
                if (param1 == _loc_2.uniqueId)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        public function get isLimitBuying() : Boolean
        {
            return this._warehouseGiftCount >= StorageConstant.ITEM_LIMIT_WARN;
        }// end function

        public function getAllStorageItemId(param1:int, param2:int) : Array
        {
            var _loc_4:* = null;
            this._filterId = param1;
            var _loc_3:* = [];
            if (param2 == StorageConstant.STORAGE_KIND_UNLIMITED_ITEM)
            {
                _loc_4 = this._aStorageUnlimitedItem.filter(this.cbFilter);
            }
            else if (param2 == StorageConstant.STORAGE_KIND_LIMIT_ITEM)
            {
                _loc_4 = this._aStorageItem.filter(this.cbFilter);
            }
            else if (param2 == StorageConstant.STORAGE_KIND_HISTORY)
            {
                _loc_4 = this._aReceiveItem.filter(this.cbFilter);
            }
            var _loc_5:* = 0;
            while (_loc_5 < _loc_4.length)
            {
                
                _loc_3.push(_loc_4[_loc_5].uniqueId);
                _loc_5++;
            }
            return _loc_3;
        }// end function

        public function getHowtoGetText(param1:int) : String
        {
            if (param1 < 0 || param1 >= StorageConstant.REASON_MESSAGE.length)
            {
                return "unknown reason :: " + param1;
            }
            var _loc_2:* = StorageConstant.REASON_MESSAGE[param1];
            if (_loc_2 == Constant.UNDECIDED)
            {
                return "no data";
            }
            return MessageManager.getInstance().getMessage(_loc_2);
        }// end function

        private function cbFilter(param1:StorageItemData, param2:int, param3:Array) : Boolean
        {
            switch(this._filterId)
            {
                case StorageConstant.ITEM_FILTER_NONE:
                {
                    return true;
                }
                case StorageConstant.ITEM_FILTER_ITEM:
                {
                    return param1.category == CommonConstant.ITEM_KIND_ACCESSORIES || param1.category == CommonConstant.ITEM_KIND_PAYMENT_ITEM || param1.category == CommonConstant.ITEM_KIND_ASSET;
                }
                case StorageConstant.ITEM_FILTER_CROWN:
                {
                    return param1.category == CommonConstant.ITEM_KIND_CROWN;
                }
                case StorageConstant.ITEM_FILTER_CHARACTER:
                {
                    return param1.category == CommonConstant.ITEM_KIND_WARRIOR;
                }
                case StorageConstant.ITEM_FILTER_DESTINY_STONE:
                {
                    return param1.category == CommonConstant.ITEM_KIND_DESTINY_STONE;
                }
                default:
                {
                    break;
                }
            }
            return false;
        }// end function

        public function warehouseTotalGiftCount() : int
        {
            return this._warehouseGiftCount + this._warehouseUnlimitedGiftCount;
        }// end function

        public function warehouseGiftCount() : int
        {
            return this._warehouseGiftCount;
        }// end function

        public function setGiftCount(param1:int) : void
        {
            this._warehouseGiftCount = param1;
            return;
        }// end function

        public function warehouseUnlimitedGiftCount() : int
        {
            return this._warehouseUnlimitedGiftCount;
        }// end function

        public function setUnlimitedGiftCount(param1:int) : void
        {
            this._warehouseUnlimitedGiftCount = param1;
            return;
        }// end function

        public function isWarehouseGiftDleted() : Boolean
        {
            return this._warehouseGiftDleted != 0;
        }// end function

        public function setWarehouseGiftDleted(param1:int) : void
        {
            this._warehouseGiftDleted = param1;
            return;
        }// end function

        public function getWarehouseGiftDletedText() : String
        {
            switch(this._warehouseGiftDleted)
            {
                case WAREHOUSE_GIFT_DLETED_TIME_OVER:
                {
                    return MessageManager.getInstance().getMessage(MessageId.HOME_STORAGE_DELETE_MESSAGE);
                }
                case WAREHOUSE_GIFT_DLETED_RECORD_OVER:
                {
                    return MessageManager.getInstance().getMessage(MessageId.HOME_STORAGE_OVER_MESSAGE);
                }
                case WAREHOUSE_GIFT_DLETED_BOTH:
                {
                    return MessageManager.getInstance().getMessage(MessageId.HOME_STORAGE_DELETE_AND_OVER_MESSAGE);
                }
                default:
                {
                    break;
                }
            }
            return "";
        }// end function

        public function getStorageItemDataLog() : void
        {
            return;
        }// end function

        public function getItemCategoryNameId(param1:StorageItemData) : int
        {
            switch(param1.category)
            {
                case CommonConstant.ITEM_KIND_ACCESSORIES:
                case CommonConstant.ITEM_KIND_PAYMENT_ITEM:
                case CommonConstant.ITEM_KIND_ASSET:
                {
                    return MessageId.STORAGE_FILTER_ITEM;
                }
                case CommonConstant.ITEM_KIND_CROWN:
                {
                    return MessageId.STORAGE_FILTER_CROWN;
                }
                case CommonConstant.ITEM_KIND_WARRIOR:
                {
                    return MessageId.STORAGE_FILTER_CHARACTER;
                }
                case CommonConstant.ITEM_KIND_DESTINY_STONE:
                {
                    return MessageId.STORAGE_FILTER_DESTINY_STONE;
                }
                default:
                {
                    break;
                }
            }
            return Constant.EMPTY_ID;
        }// end function

        public static function getInstance() : StorageManager
        {
            if (_instance == null)
            {
                _bInternalAccess = true;
                _instance = new StorageManager;
            }
            return _instance;
        }// end function

    }
}
