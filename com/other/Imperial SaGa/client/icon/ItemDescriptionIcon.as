package icon
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import input.*;
    import item.*;
    import message.*;
    import resource.*;
    import status.*;

    public class ItemDescriptionIcon extends Object
    {
        protected var _mc:MovieClip;
        protected var _hitTestMc:MovieClip;
        protected var _itemIcon:Bitmap;
        protected var _simpleStatus:ItemSimpleStatus;
        protected var _bMouseOverEnable:Boolean;
        protected var _bMouseOver:Boolean;
        private var _inputGroup:uint;

        public function ItemDescriptionIcon(param1:MovieClip, param2:int, param3:int, param4:int, param5:uint = 1)
        {
            this._mc = param1;
            this._hitTestMc = this._mc.itemNull;
            this._bMouseOverEnable = false;
            this._bMouseOver = false;
            this.setItem(param2, param3, param4);
            this._inputGroup = param5;
            InputManager.getInstance().addMouseCallback(this, this.cbMouseMove);
            InputManager.getInstance().setInputGroupMouseCallback(this, this._inputGroup);
            return;
        }// end function

        public function release() : void
        {
            InputManager.getInstance().delMouseCallback(this);
            this.deleteStatus();
            this.deleteIcon();
            this._mc = null;
            return;
        }// end function

        public function setItem(param1:int, param2:int, param3:int) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            this.deleteStatus();
            this.deleteIcon();
            if (param1 != Constant.EMPTY_ID)
            {
                if (param1 != CommonConstant.ITEM_KIND_CROWN && param2 == Constant.EMPTY_ID)
                {
                    TextControl.setText(this._mc.itemNameTextMc.textDt, "");
                }
                else
                {
                    _loc_4 = ItemManager.getInstance().getItemPng(param1, param2);
                    _loc_5 = ItemManager.getInstance().getItemName(param1, param2);
                    _loc_6 = ItemManager.getInstance().getItemDescription(param1, param2);
                    if (_loc_4 && _loc_4 != "")
                    {
                        this.createIcon(_loc_4);
                        if (this._mc.itemNameTextMc)
                        {
                            TextControl.setText(this._mc.itemNameTextMc.textDt, _loc_5 + MessageManager.getInstance().getMessage(MessageId.QUEST_SELECT_ITEM_NUM) + param3.toString());
                        }
                        if (param1 == CommonConstant.ITEM_KIND_CROWN)
                        {
                            this.createStatus("", "");
                            this.setMouseOverEnable(false);
                        }
                        else
                        {
                            this.createStatus(_loc_5, _loc_6);
                        }
                    }
                }
            }
            else
            {
                TextControl.setText(this._mc.itemNameTextMc.textDt, "");
            }
            return;
        }// end function

        public function setMouseOverEnable(param1:Boolean) : void
        {
            if (this._bMouseOverEnable != param1)
            {
                this._bMouseOverEnable = param1;
                if (this._simpleStatus)
                {
                    if (!this._bMouseOverEnable && this._simpleStatus.isShow())
                    {
                        this._simpleStatus.hide();
                    }
                }
            }
            this._bMouseOver = false;
            return;
        }// end function

        public function setVisible(param1:Boolean) : void
        {
            this._mc.visible = param1;
            if (param1 == false)
            {
                if (this._simpleStatus && this._simpleStatus.isShow())
                {
                    this._simpleStatus.hide();
                }
                this._bMouseOver = false;
            }
            return;
        }// end function

        public function setHitTestMc(param1:MovieClip) : void
        {
            this._hitTestMc = param1;
            return;
        }// end function

        protected function createIcon(param1:String) : void
        {
            this._itemIcon = ResourceManager.getInstance().createBitmap(param1);
            this._itemIcon.smoothing = true;
            this._mc.itemNull.addChild(this._itemIcon);
            return;
        }// end function

        protected function deleteIcon() : void
        {
            if (this._itemIcon)
            {
                if (this._itemIcon.parent)
                {
                    this._itemIcon.parent.removeChild(this._itemIcon);
                }
                this._itemIcon = null;
            }
            return;
        }// end function

        protected function createStatus(param1:String, param2:String) : void
        {
            this._simpleStatus = new ItemSimpleStatus(this._mc.parent);
            this._simpleStatus.setStatus(param1, param2);
            if (this._bMouseOver)
            {
                this.showSimpleStatus();
            }
            return;
        }// end function

        protected function deleteStatus() : void
        {
            if (this._simpleStatus)
            {
                this._simpleStatus.release();
            }
            this._simpleStatus = null;
            return;
        }// end function

        private function cbMouseMove(event:MouseEvent) : void
        {
            if (!this._bMouseOverEnable || !this._mc.visible)
            {
                return;
            }
            var _loc_2:* = this._hitTestMc ? (InputManager.getInstance().isHitTest(this._hitTestMc, this._inputGroup)) : (false);
            if (this._bMouseOver != _loc_2)
            {
                this._bMouseOver = _loc_2;
                if (this._simpleStatus == null)
                {
                    return;
                }
                if (_loc_2)
                {
                    this.showSimpleStatus();
                }
                else if (this._simpleStatus)
                {
                    this._simpleStatus.hide();
                }
            }
            return;
        }// end function

        private function showSimpleStatus() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = new Point();
            var _loc_3:* = new Point();
            _loc_1 = this._mc.BalloonAmbitNull;
            _loc_2.x = _loc_1.x;
            _loc_2.y = _loc_1.y;
            _loc_2 = _loc_1.parent.localToGlobal(_loc_2);
            _loc_2 = this._mc.parent.globalToLocal(_loc_2);
            _loc_1 = this._mc.BalloonNull;
            if (_loc_1)
            {
                _loc_3.x = _loc_1.x;
                _loc_3.y = _loc_1.y;
                _loc_3 = _loc_1.parent.localToGlobal(_loc_3);
            }
            else
            {
                _loc_3.x = _loc_2.x;
                _loc_3.y = _loc_2.y;
            }
            this._simpleStatus.show();
            this._simpleStatus.setPosition(_loc_2);
            this._simpleStatus.setArrowTargetPosition(_loc_3);
            return;
        }// end function

    }
}
