package questSelect
{
    import button.*;
    import flash.display.*;
    import item.*;
    import message.*;
    import resource.*;
    import sound.*;
    import user.*;

    public class UseItemButton extends ButtonBase
    {
        private var _errorSeId:int;
        private var _itemIcon:Bitmap;
        private var _bFree:Boolean;
        private var _selectMode:int;
        private var _cbSelect:Function;
        private var _cbBlockBunc:Function;
        private var _num:int;
        private var _bSelectable:Boolean;
        private var _bSelected:Boolean;
        public static const SELECT_MODE_NORMAL:int = 0;
        public static const SELECT_MODE_TUTORIAL_TARGET:int = 1;
        public static const SELECT_MODE_TUTORIAL_OUT:int = 2;

        public function UseItemButton(param1:MovieClip, param2:int, param3:Boolean, param4:int, param5:Function, param6:Function)
        {
            var _loc_7:* = null;
            super(param1, this.cbClick);
            _id = param2;
            _enterSeId = ButtonBase.SE_DECIDE_ID;
            this._bFree = param3 && param4 != SELECT_MODE_TUTORIAL_TARGET;
            this._selectMode = param4;
            this._cbSelect = param5;
            this._cbBlockBunc = param6;
            if (param2 != Constant.EMPTY_ID)
            {
                _loc_7 = ItemManager.getInstance().getPaymentItemInformation(param2);
                this._itemIcon = ResourceManager.getInstance().createBitmap(ItemManager.getInstance().getItemPng(CommonConstant.ITEM_KIND_PAYMENT_ITEM, param2));
                if (this._itemIcon)
                {
                    this._itemIcon.smoothing = true;
                    _mc.dsNull.addChild(this._itemIcon);
                }
                this._num = UserDataManager.getInstance().userData.getOwnPaymentItemNum(param2);
                if (this._selectMode == SELECT_MODE_TUTORIAL_TARGET)
                {
                    if (this._num < 0)
                    {
                        this._num = 0;
                    }
                    (this._num + 1);
                }
                this._bSelectable = (this._bFree || this._num > 0) && this._selectMode != SELECT_MODE_TUTORIAL_OUT;
            }
            else
            {
                this._num = 0;
                this._bSelectable = false;
            }
            if (this._bFree)
            {
                TextControl.setText(_mc.NumTextMc.textDt, "");
                _mc.NumTextMc.visible = false;
            }
            else
            {
                TextControl.setText(_mc.NumTextMc.textDt, MessageManager.getInstance().getMessage(MessageId.QUEST_SELECT_ITEM_NUM) + this._num.toString());
                _mc.NumTextMc.visible = true;
            }
            _mc.FreeAssaultIcon.visible = this._bSelectable && this._bFree;
            this.updateLabel();
            return;
        }// end function

        public function get mcBase() : MovieClip
        {
            return _mc;
        }// end function

        public function get paymentItemId() : int
        {
            return _id;
        }// end function

        public function set errorSeId(param1:int) : void
        {
            this._errorSeId = param1;
            return;
        }// end function

        public function get bFree() : Boolean
        {
            return this._bFree;
        }// end function

        public function get num() : int
        {
            return this._num;
        }// end function

        public function get bSelect() : Boolean
        {
            return this._bSelected;
        }// end function

        public function get bMouseOver() : Boolean
        {
            return _bMouseOver;
        }// end function

        override public function release() : void
        {
            if (this._itemIcon && this._itemIcon.parent)
            {
                this._itemIcon.parent.removeChild(this._itemIcon);
            }
            this._itemIcon = null;
            this._cbBlockBunc = null;
            this._cbSelect = null;
            super.release();
            return;
        }// end function

        public function setSelect(param1:Boolean) : void
        {
            if (param1)
            {
                param1 = this._bSelectable && this._cbBlockBunc == null;
            }
            if (this._bSelected != param1)
            {
                this._bSelected = param1;
                this.updateLabel();
            }
            return;
        }// end function

        private function cbClick(param1:int) : void
        {
            if (this._bSelectable)
            {
                this._bSelected = !this._bSelected;
            }
            else
            {
                this._bSelected = false;
            }
            this.updateLabel();
            if (this._cbSelect != null)
            {
                this._cbSelect();
            }
            return;
        }// end function

        private function updateLabel() : void
        {
            if (_bMouseOver)
            {
                if (this._bSelectable)
                {
                    labelChange(_LABEL_MOUSE_OVER);
                }
                else
                {
                    labelChange(_LABEL_DISABLE);
                }
            }
            else if (this._bSelectable)
            {
                labelChange(_LABEL_MOUSE_OUT);
            }
            else
            {
                labelChange(_LABEL_DISABLE);
            }
            _mc.ItemOn.visible = this._bSelected;
            return;
        }// end function

        override public function setClick() : void
        {
            if (this._bSelectable)
            {
                if (this._cbBlockBunc != null)
                {
                    if (this._errorSeId != Constant.UNDECIDED)
                    {
                        SoundManager.getInstance().playSe(this._errorSeId);
                    }
                    this._cbBlockBunc(_id);
                    return;
                }
                labelChange(_LABEL_CLICK);
                if (_enterSeId != Constant.UNDECIDED)
                {
                    SoundManager.getInstance().playSe(_enterSeId);
                }
                if (_cbClickFunc != null)
                {
                    _cbClickFunc(_id);
                }
            }
            else if (this._errorSeId != Constant.UNDECIDED)
            {
                SoundManager.getInstance().playSe(this._errorSeId);
            }
            return;
        }// end function

        override public function setMouseOver() : void
        {
            if (this._selectMode == SELECT_MODE_TUTORIAL_OUT)
            {
                return;
            }
            if (_bMouseOver == false && _bDisable == false)
            {
                if (_overSeId != Constant.UNDECIDED)
                {
                    SoundManager.getInstance().playSe(_overSeId);
                }
                if (this._bSelectable)
                {
                    labelChange(_LABEL_MOUSE_OVER);
                }
                else
                {
                    labelChange(_LABEL_DISABLE);
                }
                if (_cbOverFunc != null)
                {
                    _cbOverFunc(_id);
                }
            }
            _bMouseOver = true;
            return;
        }// end function

        override public function setMouseOut() : void
        {
            if (_bMouseOver == true && _bDisable == false)
            {
                if (this._bSelectable)
                {
                    labelChange(_LABEL_MOUSE_OUT);
                }
                else
                {
                    labelChange(_LABEL_DISABLE);
                }
                if (_cbOutFunc != null)
                {
                    _cbOutFunc(_id);
                }
            }
            _bMouseOver = false;
            return;
        }// end function

        override public function setDisable(param1:Boolean) : void
        {
            setDisableFlag(param1);
            _bMouseOver = false;
            return;
        }// end function

        override public function seal(param1:Boolean = false) : void
        {
            super.seal(param1);
            this.updateLabel();
            return;
        }// end function

        override public function unseal(param1:Boolean = false) : void
        {
            super.unseal(param1);
            this.updateLabel();
            return;
        }// end function

    }
}
