package status
{
    import asset.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import input.*;
    import message.*;
    import resource.*;
    import user.*;

    public class UserResourceBox extends Object
    {
        protected var _mcBase:MovieClip;
        protected var _statusLayer:DisplayObjectContainer;
        protected var _itemIcon:Bitmap;
        protected var _simpleStatus:ItemSimpleStatus;
        protected var _bMouseOverEnable:Boolean;
        protected var _bMouseOver:Boolean;

        public function UserResourceBox(param1:MovieClip, param2:int, param3:DisplayObjectContainer = null)
        {
            this._mcBase = param1;
            this._statusLayer = param3 == null ? (this._mcBase.parent) : (param3);
            this._bMouseOverEnable = false;
            this._bMouseOver = false;
            var _loc_4:* = AssetListManager.getInstance().getAssetInfomation(param2);
            if (AssetListManager.getInstance().getAssetInfomation(param2))
            {
                this.createIcon(AssetListManager.getInstance().getAssetPng(param2));
                this.createStatus(_loc_4.name, _loc_4.description);
            }
            this.updateNum();
            InputManager.getInstance().addMouseCallback(this, this.cbMouseMove);
            return;
        }// end function

        public function release() : void
        {
            InputManager.getInstance().delMouseCallback(this);
            this.deleteStatus();
            this.deleteIcon();
            this._statusLayer = null;
            this._mcBase = null;
            return;
        }// end function

        public function updateNum() : void
        {
            var _loc_1:* = UserDataManager.getInstance().userData.kumiteResource;
            TextControl.setText(this._mcBase.NumTextMc.textDt, _loc_1.toString());
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
            this._mcBase.visible = param1;
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

        protected function createIcon(param1:String) : void
        {
            this._itemIcon = ResourceManager.getInstance().createBitmap(param1);
            this._itemIcon.smoothing = true;
            this._mcBase.dsNull.addChild(this._itemIcon);
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
            this._simpleStatus = new ItemSimpleStatus(this._statusLayer);
            this._simpleStatus.setStatus(param1, param2);
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
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            if (!this._bMouseOverEnable || !this._mcBase.visible)
            {
                return;
            }
            var _loc_2:* = InputManager.getInstance().isHitTest(this._mcBase);
            if (this._bMouseOver != _loc_2)
            {
                this._bMouseOver = _loc_2;
                if (this._simpleStatus == null)
                {
                    return;
                }
                if (_loc_2)
                {
                    _loc_4 = new Point();
                    _loc_5 = new Point();
                    _loc_3 = this._mcBase.PopNull;
                    _loc_4.x = _loc_3.x;
                    _loc_4.y = _loc_3.y;
                    _loc_4 = _loc_3.parent.localToGlobal(_loc_4);
                    _loc_3 = this._mcBase.SettingPopNull;
                    if (_loc_3)
                    {
                        _loc_5.x = _loc_3.x;
                        _loc_5.y = _loc_3.y;
                        _loc_5 = _loc_3.parent.localToGlobal(_loc_5);
                    }
                    else
                    {
                        _loc_5.x = _loc_4.x;
                        _loc_5.y = _loc_4.y;
                    }
                    _loc_4 = this._statusLayer.globalToLocal(_loc_4);
                    this._simpleStatus.show();
                    this._simpleStatus.setPosition(_loc_4);
                    this._simpleStatus.setArrowTargetPosition(_loc_5);
                }
                else if (this._simpleStatus)
                {
                    this._simpleStatus.hide();
                }
            }
            return;
        }// end function

    }
}
