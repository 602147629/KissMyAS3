package user
{

    public class GetItemInfo extends Object
    {
        private var _aItemData:Array;
        private var _aPlayer:Array;
        private var _aWarehouseData:Array;
        public static const WAREHOUSE_ITEM_FLAG_ALL:int = 0;
        public static const WAREHOUSE_ITEM_FLAG_LIMIT:int = 1;
        public static const WAREHOUSE_ITEM_FLAG_TERMLESS:int = 2;

        public function GetItemInfo()
        {
            this._aItemData = [];
            this._aPlayer = [];
            this._aWarehouseData = [];
            return;
        }// end function

        public function get aItemData() : Array
        {
            return this._aItemData;
        }// end function

        public function get aPlayer() : Array
        {
            return this._aPlayer;
        }// end function

        public function get aWarehouseData() : Array
        {
            return this._aWarehouseData;
        }// end function

        public function setReceiveData(param1:Object) : void
        {
            if (param1)
            {
                if (param1.aItemData)
                {
                    this._aItemData = param1.aItemData;
                }
                if (param1.aPlayer)
                {
                    this._aPlayer = param1.aPlayer;
                }
                if (param1.aWarehouseData)
                {
                    this._aWarehouseData = param1.aWarehouseData;
                }
            }
            return;
        }// end function

        public static function aItemData(param1:Object) : Array
        {
            return param1 ? (param1.aItemData) : (null);
        }// end function

        public static function aPlayer(param1:Object) : Array
        {
            return param1 ? (param1.aPlayer) : (null);
        }// end function

        public static function aWarehouseData(param1:Object) : Array
        {
            return param1 ? (param1.aWarehouseData) : (null);
        }// end function

        public static function checkAnyWarehouse(param1:Object) : Boolean
        {
            var _loc_2:* = null;
            if (param1)
            {
                _loc_2 = param1.aWarehouseData;
                if (_loc_2)
                {
                    return _loc_2.length > 0;
                }
            }
            return false;
        }// end function

        public static function checkFilterWarehouse(param1:Object, param2:int) : Boolean
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (param1)
            {
                _loc_3 = param1.aWarehouseData;
                if (_loc_3)
                {
                    for each (_loc_4 in _loc_3)
                    {
                        
                        if (_loc_4.howToGet == param2 && _loc_4.num > 0)
                        {
                            return true;
                        }
                    }
                }
            }
            return false;
        }// end function

        public static function checkMaskedWarehouse(param1:Object, param2:int) : Boolean
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (param1)
            {
                _loc_3 = param1.aWarehouseData;
                if (_loc_3)
                {
                    for each (_loc_4 in _loc_3)
                    {
                        
                        if (_loc_4.howToGet != param2 && _loc_4.num > 0)
                        {
                            return true;
                        }
                    }
                }
            }
            return false;
        }// end function

        public static function getWarehouseNum(param1:Object, param2:int = 0) : int
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_3:* = 0;
            if (param1)
            {
                _loc_4 = param1.aWarehouseData;
                if (_loc_4)
                {
                    for each (_loc_5 in _loc_4)
                    {
                        
                        if (param2 == WAREHOUSE_ITEM_FLAG_LIMIT)
                        {
                            if (isLimitItem(_loc_5))
                            {
                                _loc_3++;
                            }
                            continue;
                        }
                        if (param2 == WAREHOUSE_ITEM_FLAG_TERMLESS)
                        {
                            if (!isLimitItem(_loc_5))
                            {
                                _loc_3++;
                            }
                            continue;
                        }
                        _loc_3++;
                    }
                }
            }
            return _loc_3;
        }// end function

        public static function getWarehouseEntryNum(param1:Object, param2:int = 0) : int
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_3:* = 0;
            if (param1)
            {
                _loc_4 = param1.aWarehouseData;
                if (_loc_4)
                {
                    for each (_loc_5 in _loc_4)
                    {
                        
                        if (_loc_5.entryAdd == 1)
                        {
                            if (param2 == WAREHOUSE_ITEM_FLAG_LIMIT)
                            {
                                if (isLimitItem(_loc_5))
                                {
                                    _loc_3++;
                                }
                                continue;
                            }
                            if (param2 == WAREHOUSE_ITEM_FLAG_TERMLESS)
                            {
                                if (!isLimitItem(_loc_5))
                                {
                                    _loc_3++;
                                }
                                continue;
                            }
                            _loc_3++;
                        }
                    }
                }
            }
            return _loc_3;
        }// end function

        private static function isLimitItem(param1:Object) : Boolean
        {
            if (param1)
            {
                if (param1.limitFlag == 1)
                {
                    return true;
                }
            }
            return false;
        }// end function

    }
}
