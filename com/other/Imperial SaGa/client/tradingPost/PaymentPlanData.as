package tradingPost
{
    import asset.*;
    import item.*;
    import message.*;
    import resource.*;
    import utility.*;

    public class PaymentPlanData extends Object
    {
        private var _planId:int;
        private var _tab:int;
        private var _page:int;
        private var _line:int;
        public var _row:int;
        private var _priceType:int;
        private var _price:int;
        private var _stock:int;
        private var _endTime:uint;
        private var _name:String;
        private var _file:String;
        private var _description:String;
        private var _itemList:Array;
        public static const TAB_NORMAL:int = 1;
        public static const TAB_INSIGNIA:int = 2;
        public static const TAB_SPECIAL:int = 3;

        public function PaymentPlanData()
        {
            return;
        }// end function

        public function get planId() : uint
        {
            return this._planId;
        }// end function

        public function get tab() : int
        {
            return this._tab;
        }// end function

        public function get page() : int
        {
            return this._page;
        }// end function

        public function get line() : int
        {
            return this._line;
        }// end function

        public function get row() : int
        {
            return this._row;
        }// end function

        public function calcPosIndex() : int
        {
            return (this._line - 1) * 4 + this._row - 1;
        }// end function

        public function calcPlanIndex(param1:int) : int
        {
            return this.calcPosIndex() + (this._page - 1) * param1;
        }// end function

        public function get priceType() : int
        {
            return this._priceType;
        }// end function

        public function get price() : uint
        {
            return this._price;
        }// end function

        public function get stock() : int
        {
            return this._stock;
        }// end function

        public function stockDown(param1:int) : void
        {
            if (this._stock > 0)
            {
                this._stock = this._stock - param1;
                if (this._stock < 0)
                {
                    this._stock = 0;
                }
            }
            return;
        }// end function

        public function get endTime() : uint
        {
            return this._endTime;
        }// end function

        public function get itemList() : Array
        {
            return this._itemList;
        }// end function

        public function get itemNum() : int
        {
            return this._itemList.length;
        }// end function

        public function get bSetItem() : Boolean
        {
            return this._itemList.length > 1;
        }// end function

        public function setRecieve(param1:Object) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            this._planId = param1.planId;
            this._tab = param1.tab;
            this._page = param1.page;
            this._line = param1.line;
            this._row = param1.row;
            this._priceType = param1.priceType;
            this._price = param1.price;
            this._stock = param1.stock;
            this._endTime = param1.endTime;
            this._name = param1.name;
            if (this._name == "")
            {
                this._name = null;
            }
            this._file = param1.file;
            if (this._file == "")
            {
                this._file = null;
            }
            if (this._file != null)
            {
                if (this._file == "item_amulet_sts_up")
                {
                    this._file = "item_amulet_sts_up.png";
                }
                if (this._file == "item_amulet_sts_up_10")
                {
                    this._file = "item_amulet_sts_up_10.png";
                }
                this._file = ResourcePath.ITEM_IMG_PATH + this._file;
            }
            this._description = param1.description;
            if (this._description == "")
            {
                this._description = null;
            }
            this._itemList = [];
            for each (_loc_2 in param1.itemList)
            {
                
                _loc_3 = new PaymentPlanItem();
                _loc_3.setRecieve(_loc_2);
                if (_loc_3.checkEnable())
                {
                    this._itemList.push(_loc_3);
                }
            }
            return;
        }// end function

        public function checkEnable() : Boolean
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._itemList)
            {
                
                if (_loc_1.checkEnable())
                {
                    return true;
                }
            }
            return false;
        }// end function

        public function checkEndTimeOver() : Boolean
        {
            if (this._endTime > 0)
            {
                return TimeClock.bProgressTime(this._endTime);
            }
            return false;
        }// end function

        public function hasItem(param1:int, param2:int) : Boolean
        {
            return this.searchItem(param1, param2) >= 0;
        }// end function

        public function getItem(param1:int, param2:int) : PaymentPlanItem
        {
            var _loc_3:* = this.searchItem(param1, param2);
            return _loc_3 >= 0 ? (this._itemList[_loc_3]) : (null);
        }// end function

        public function getCategoryItem(param1:int) : PaymentPlanItem
        {
            var _loc_2:* = this.searchCategoryItem(param1);
            return _loc_2 >= 0 ? (this._itemList[_loc_2]) : (null);
        }// end function

        public function searchItem(param1:int, param2:int) : int
        {
            var _loc_4:* = null;
            var _loc_3:* = 0;
            while (_loc_3 < this._itemList.length)
            {
                
                _loc_4 = this._itemList[_loc_3];
                if (_loc_4.category == param1 && _loc_4.itemId == param2)
                {
                    return _loc_3;
                }
                _loc_3++;
            }
            return -1;
        }// end function

        public function searchCategoryItem(param1:int) : int
        {
            var _loc_3:* = null;
            var _loc_2:* = 0;
            while (_loc_2 < this._itemList.length)
            {
                
                _loc_3 = this._itemList[_loc_2];
                if (_loc_3.category == param1)
                {
                    return _loc_2;
                }
                _loc_2++;
            }
            return -1;
        }// end function

        public function getPriceTypeName() : String
        {
            if (this._priceType == CommonConstant.TRADE_PRICE_TYPE_CROWN)
            {
                return MessageManager.getInstance().getMessage(MessageId.COMMON_NAME_CROWN);
            }
            if (this._priceType == CommonConstant.TRADE_PRICE_TYPE_SILVER_INSIGNIA)
            {
                return ItemManager.getInstance().getItemName(CommonConstant.ITEM_KIND_ASSET, AssetId.ASSET_SILVER_INSIGNIA);
            }
            if (this._priceType == CommonConstant.TRADE_PRICE_TYPE_GOLD_INSIGNIA)
            {
                return ItemManager.getInstance().getItemName(CommonConstant.ITEM_KIND_ASSET, AssetId.ASSET_GOLD_INSIGNIA);
            }
            return "";
        }// end function

        public function getName() : String
        {
            if (this._name == null)
            {
                this._name = this.getItemName(0);
            }
            return this._name;
        }// end function

        public function getFileName() : String
        {
            if (this._file == null)
            {
                this._file = this.getItemFileName(0);
            }
            return this._file;
        }// end function

        public function getDescription() : String
        {
            if (this._description == null)
            {
                this._description = this.getItemDescription(0);
            }
            return this._description;
        }// end function

        private function getItemName(param1:int) : String
        {
            var _loc_2:* = this._itemList[param1];
            return _loc_2 ? (_loc_2.getName()) : ("");
        }// end function

        private function getItemFileName(param1:int) : String
        {
            var _loc_2:* = this._itemList[param1];
            return _loc_2 ? (_loc_2.getFileName()) : ("");
        }// end function

        private function getItemDescription(param1:int) : String
        {
            var _loc_2:* = this._itemList[param1];
            return _loc_2 ? (_loc_2.getDescription()) : ("");
        }// end function

    }
}
