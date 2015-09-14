package status
{
    import asset.*;
    import flash.display.*;
    import flash.geom.*;
    import item.*;

    public class CommonSimpleStatus extends Object
    {
        private var _mcResultReward:MovieClip;
        private var _mcResultRewardXX:MovieClip;
        private var _isShow:Boolean;
        private var _categoryId:int;
        private var _itemId:int;
        private var _itemSimpleStatus:ItemSimpleStatus;
        private var _playerSimpleStatus:PlayerSimpleStatus;
        private var _equipSimpleStatus:EquipSimpleStatus;

        public function CommonSimpleStatus(param1:DisplayObjectContainer)
        {
            this._itemSimpleStatus = new ItemSimpleStatus(param1);
            this._itemSimpleStatus.hide();
            this._playerSimpleStatus = new PlayerSimpleStatus(param1);
            this._playerSimpleStatus.hide();
            this._equipSimpleStatus = new EquipSimpleStatus(param1);
            this._equipSimpleStatus.hide();
            return;
        }// end function

        public function release() : void
        {
            if (this._equipSimpleStatus)
            {
                this._equipSimpleStatus.release();
            }
            this._equipSimpleStatus = null;
            if (this._playerSimpleStatus)
            {
                this._playerSimpleStatus.release();
            }
            this._playerSimpleStatus = null;
            if (this._itemSimpleStatus)
            {
                this._itemSimpleStatus.release();
            }
            this._itemSimpleStatus = null;
            return;
        }// end function

        public function setPosition(param1:Point) : void
        {
            if (this._playerSimpleStatus)
            {
                this._playerSimpleStatus.setPosition(param1);
            }
            if (this._equipSimpleStatus)
            {
                this._equipSimpleStatus.setPosition(param1);
            }
            if (this._itemSimpleStatus)
            {
                this._itemSimpleStatus.setPosition(param1);
            }
            return;
        }// end function

        public function setArrowTargetPosition(param1:Point) : void
        {
            if (this._playerSimpleStatus)
            {
                this._playerSimpleStatus.setArrowTargetPosition(param1);
            }
            if (this._equipSimpleStatus)
            {
                this._equipSimpleStatus.setArrowTargetPosition(param1);
            }
            if (this._itemSimpleStatus)
            {
                this._itemSimpleStatus.setArrowTargetPosition(param1);
            }
            return;
        }// end function

        public function setData(param1:int, param2:int) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            this._categoryId = param1;
            this._itemId = param2;
            if (param1 == CommonConstant.ITEM_KIND_WARRIOR)
            {
                if (this._playerSimpleStatus)
                {
                    this._playerSimpleStatus.setStatusByPlayerId(param2);
                }
            }
            else if (param1 == CommonConstant.ITEM_KIND_ACCESSORIES)
            {
                if (this._equipSimpleStatus)
                {
                    this._equipSimpleStatus.setItemData(param2);
                }
            }
            else
            {
                _loc_3 = "";
                _loc_4 = "";
                if (param1 == CommonConstant.ITEM_KIND_ASSET)
                {
                    _loc_5 = ItemManager.getInstance().getAssetInformation(param2);
                    if (_loc_5)
                    {
                        _loc_3 = _loc_5.name;
                        _loc_4 = _loc_5.description;
                    }
                }
                else if (param1 == CommonConstant.ITEM_KIND_PAYMENT_ITEM)
                {
                    _loc_6 = ItemManager.getInstance().getPaymentItemInformation(param2);
                    if (_loc_6)
                    {
                        _loc_3 = _loc_6.name;
                        _loc_4 = _loc_6.description;
                    }
                }
                else
                {
                    _loc_7 = ItemManager.getInstance().getItemInformation(param2);
                    if (_loc_7)
                    {
                        _loc_3 = _loc_7.name;
                        _loc_4 = _loc_7.explanation;
                    }
                }
                if (this._itemSimpleStatus)
                {
                    this._itemSimpleStatus.setStatus(_loc_3, _loc_4);
                }
            }
            return;
        }// end function

        public function show() : void
        {
            var _loc_1:* = false;
            var _loc_2:* = false;
            var _loc_3:* = false;
            if (this._categoryId == CommonConstant.ITEM_KIND_WARRIOR)
            {
                if (this._playerSimpleStatus)
                {
                    this._playerSimpleStatus.show();
                    _loc_1 = true;
                    this._isShow = true;
                }
            }
            else if (this._categoryId == CommonConstant.ITEM_KIND_ACCESSORIES)
            {
                if (this._equipSimpleStatus)
                {
                    this._equipSimpleStatus.show();
                    _loc_2 = true;
                    this._isShow = true;
                }
            }
            else if (this._categoryId == CommonConstant.ITEM_KIND_DESTINY_STONE || this._categoryId == CommonConstant.ITEM_KIND_PAYMENT_ITEM || this._categoryId == CommonConstant.ITEM_KIND_ASSET)
            {
                if (this._itemSimpleStatus)
                {
                    this._itemSimpleStatus.show();
                    _loc_3 = true;
                    this._isShow = true;
                }
            }
            if (_loc_1 == false)
            {
                if (this._playerSimpleStatus && this._playerSimpleStatus.isShow())
                {
                    this._playerSimpleStatus.hide();
                }
            }
            if (_loc_2 == false)
            {
                if (this._equipSimpleStatus && this._equipSimpleStatus.isShow())
                {
                    this._equipSimpleStatus.hide();
                }
            }
            if (_loc_3 == false)
            {
                if (this._itemSimpleStatus && this._itemSimpleStatus.isShow())
                {
                    this._itemSimpleStatus.hide();
                }
            }
            return;
        }// end function

        public function hide() : void
        {
            if (this._itemSimpleStatus && this._itemSimpleStatus.isShow())
            {
                this._itemSimpleStatus.hide();
            }
            if (this._playerSimpleStatus && this._playerSimpleStatus.isShow())
            {
                this._playerSimpleStatus.hide();
            }
            if (this._equipSimpleStatus && this._equipSimpleStatus.isShow())
            {
                this._equipSimpleStatus.hide();
            }
            this._isShow = false;
            return;
        }// end function

        public function isShow() : Boolean
        {
            return this._isShow;
        }// end function

        public static function loadResource() : void
        {
            ItemSimpleStatus.loadResource();
            PlayerSimpleStatus.loadResource();
            EquipSimpleStatus.loadResource();
            return;
        }// end function

        public static function getCategoryId() : Array
        {
            var _loc_1:* = [CommonConstant.ITEM_KIND_WARRIOR, CommonConstant.ITEM_KIND_ACCESSORIES, CommonConstant.ITEM_KIND_ASSET, CommonConstant.ITEM_KIND_PAYMENT_ITEM];
            return _loc_1;
        }// end function

        public static function isCategoryId(param1:int) : Boolean
        {
            var _loc_4:* = 0;
            var _loc_2:* = false;
            var _loc_3:* = getCategoryId();
            for each (_loc_4 in _loc_3)
            {
                
                if (param1 == _loc_4)
                {
                    _loc_2 = true;
                    break;
                }
            }
            return _loc_2;
        }// end function

    }
}
