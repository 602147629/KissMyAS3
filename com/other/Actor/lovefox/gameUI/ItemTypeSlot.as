package lovefox.gameUI
{
    import flash.display.*;

    public class ItemTypeSlot extends Slot
    {
        public var _icon:Bitmap;
        public var _itemId:Object;
        private var _amountTxt:Object;
        public var _relatedId:Object;
        private var _changedArray:Object;
        private static var _slotArray:Array = [];

        public function ItemTypeSlot(param1, param2)
        {
            super(param1, param2);
            this.init();
            _slotArray.push(this);
            return;
        }// end function

        override public function init()
        {
            super.init();
            this._icon = new Bitmap();
            _container.addChild(this._icon);
            this._amountTxt = Config.getSimpleTextField();
            this._amountTxt.autoSize = TextFieldAutoSize.RIGHT;
            this._amountTxt.textColor = 16777215;
            this._amountTxt.y = _size - 16;
            this._amountTxt.x = _size - 5;
            this._amountTxt.filters = [new GlowFilter(0, 1, 3, 3, 10)];
            addChild(this._amountTxt);
            return;
        }// end function

        public function setId(param1)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            if (param1 > 0)
            {
                this.buttonMode = true;
                this._itemId = param1;
                if (Config._itemMap[param1] != null)
                {
                    _loc_3 = Config._itemMap[param1];
                }
                _loc_2 = Config.findIcon(Item.getXmlIcon(_loc_3));
                this._icon.bitmapData = _loc_2;
                this._relatedId = Number(_loc_3.relatedId);
                _loc_4 = new Date();
                setCd(Math.max(0, Item._cdStack[this._relatedId] - _loc_4.getTime()), Item._cdMaxStack[this._relatedId]);
                this.testItemId();
            }
            else
            {
                this.buttonMode = false;
                this._icon.bitmapData = null;
                this._itemId = null;
                this._amountTxt.text = "";
                this._relatedId = null;
                setCd(0);
            }
            return;
        }// end function

        public function get item()
        {
            if (this._itemId == null || this._itemId == 0)
            {
                return null;
            }
            return Config.ui._charUI.getOneItem(this._itemId);
        }// end function

        public function set item(param1)
        {
            var _loc_2:* = undefined;
            if (this._icon.bitmapData != null)
            {
                this._icon.bitmapData.dispose();
            }
            if (param1 != null)
            {
                if (param1 is Item)
                {
                    this.setId(param1._itemData.baseID);
                }
                else
                {
                    this.setId(param1);
                }
            }
            else
            {
                this.setId(0);
            }
            return;
        }// end function

        public function testItemId()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            this._amountTxt.text = Config.ui._charUI.getItemAmount(this._itemId);
            return;
        }// end function

        public static function testPropSlot()
        {
            var _loc_1:* = undefined;
            _loc_1 = 0;
            while (_loc_1 < _slotArray.length)
            {
                
                if (_slotArray[_loc_1]._itemId != null)
                {
                    _slotArray[_loc_1].testItemId();
                }
                _loc_1 = _loc_1 + 1;
            }
            return;
        }// end function

    }
}
