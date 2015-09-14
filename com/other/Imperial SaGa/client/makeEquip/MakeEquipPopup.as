package makeEquip
{
    import button.*;
    import flash.display.*;
    import item.*;
    import message.*;
    import resource.*;
    import utility.*;

    public class MakeEquipPopup extends MakeEquipBase
    {
        private var _popupType:int;
        private var _bmpItem:Bitmap;
        private var _bEnable:Boolean;
        public var _fade:Fade;
        private var _itemIdArray:Array;
        private var _aItemSWindMc:Array;
        private var _aDecompoWindMc:Array;
        private var _parentclass:MakeEquipDecompositionSelect;
        private var closed:Boolean = false;
        public static const POPUP_TYPE_DECOMPO_START:int = 1;
        public static const POPUP_TYPE_DECOMPO_SUCCESS:int = 2;
        public static const POPUP_TYPE_DECOMPO_FAILURE:int = 3;
        public static const POPUP_TYPE_SHORTAGE:int = 4;

        public function MakeEquipPopup(param1:DisplayObjectContainer, param2:int, param3:Array, param4:Array, param5:MakeEquipDecompositionSelect)
        {
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = 0;
            var _loc_11:* = 0;
            var _loc_12:* = null;
            var _loc_13:* = 0;
            var _loc_14:* = null;
            this._parentclass = param5;
            this._itemIdArray = param3;
            this._fade = new Fade(param1, 0.5);
            this._fade.setFadeOut(Constant.FADE_OUT_TIME);
            super(param1, "decompoYNMc", true);
            for each (_loc_6 in this._aItemSWindMc)
            {
                
                if (_loc_6 != null)
                {
                    _loc_6.parent.removeChild(_loc_6);
                }
                _loc_6 = null;
            }
            this._aItemSWindMc = [];
            this._aDecompoWindMc = [_mc.decompoWindMc.itemSWind1Mc, _mc.decompoWindMc.itemSWind2Mc, _mc.decompoWindMc.itemSWind3Mc, _mc.decompoWindMc.itemSWind4Mc, _mc.decompoWindMc.itemSWind5Mc, _mc.decompoWindMc.itemSWind6Mc, _mc.decompoWindMc.itemSWind7Mc, _mc.decompoWindMc.itemSWind8Mc, _mc.decompoWindMc.itemSWind9Mc, _mc.decompoWindMc.itemSWind10Mc];
            TextControl.setIdText(_mc.decompoWindMc.InfoText01Mc.textDt, MessageId.MAKE_EQUIP_SELECT_DECOMPO_CHECK_TITLE);
            TextControl.setIdText(_mc.decompoWindMc.InfoText02Mc.textDt, MessageId.MAKE_EQUIP_SELECT_DECOMPO_CHECK_TEXT);
            for each (_loc_8 in this._aDecompoWindMc)
            {
                
                _loc_8.ItemOn.visible = false;
            }
            this._popupType = param2;
            switch(this._popupType)
            {
                case POPUP_TYPE_DECOMPO_START:
                {
                    _loc_10 = 0;
                    while (_loc_10 < this._itemIdArray.length)
                    {
                        
                        _loc_11 = this._itemIdArray[_loc_10];
                        _loc_12 = ItemManager.getInstance().getItemInformation(_loc_11);
                        this._bmpItem = ResourceManager.getInstance().createBitmap(ResourcePath.EQUIPMENT_IMG_PATH + _loc_12.fileName);
                        this._bmpItem.smoothing = true;
                        switch(_loc_10)
                        {
                            case 0:
                            {
                                _loc_7 = _mc.decompoWindMc.itemSWind1Mc;
                                this._aItemSWindMc.push(_loc_7);
                                break;
                            }
                            case 1:
                            {
                                _loc_7 = _mc.decompoWindMc.itemSWind2Mc;
                                this._aItemSWindMc.push(_loc_7);
                                break;
                            }
                            case 2:
                            {
                                _loc_7 = _mc.decompoWindMc.itemSWind3Mc;
                                this._aItemSWindMc.push(_loc_7);
                                break;
                            }
                            case 3:
                            {
                                _loc_7 = _mc.decompoWindMc.itemSWind4Mc;
                                this._aItemSWindMc.push(_loc_7);
                                break;
                            }
                            case 4:
                            {
                                _loc_7 = _mc.decompoWindMc.itemSWind5Mc;
                                this._aItemSWindMc.push(_loc_7);
                                break;
                            }
                            case 5:
                            {
                                _loc_7 = _mc.decompoWindMc.itemSWind6Mc;
                                this._aItemSWindMc.push(_loc_7);
                                break;
                            }
                            case 6:
                            {
                                _loc_7 = _mc.decompoWindMc.itemSWind7Mc;
                                this._aItemSWindMc.push(_loc_7);
                                break;
                            }
                            case 7:
                            {
                                _loc_7 = _mc.decompoWindMc.itemSWind8Mc;
                                this._aItemSWindMc.push(_loc_7);
                                break;
                            }
                            case 8:
                            {
                                _loc_7 = _mc.decompoWindMc.itemSWind9Mc;
                                this._aItemSWindMc.push(_loc_7);
                                break;
                            }
                            case 9:
                            {
                                _loc_7 = _mc.decompoWindMc.itemSWind10Mc;
                                this._aItemSWindMc.push(_loc_7);
                                break;
                            }
                            default:
                            {
                                break;
                            }
                        }
                        _loc_7.itemNull.addChild(this._bmpItem);
                        TextControl.setText(_loc_7.textMc.textDt, _loc_12.name);
                        _loc_10++;
                    }
                    _loc_13 = this._itemIdArray.length;
                    while (_loc_13 < this._aDecompoWindMc.length)
                    {
                        
                        _loc_9 = this._aDecompoWindMc[_loc_13];
                        _loc_9.gotoAndStop("disable");
                        TextControl.setText(_loc_9.textMc.textDt, "");
                        _loc_13++;
                    }
                    break;
                }
                case POPUP_TYPE_DECOMPO_SUCCESS:
                case POPUP_TYPE_DECOMPO_FAILURE:
                {
                    _mc.visible = false;
                    this.close();
                    break;
                }
                case POPUP_TYPE_SHORTAGE:
                {
                    _mc.decompoWind2Mc.gotoAndStop("shortage");
                    break;
                }
                default:
                {
                    break;
                }
            }
            TextControl.setIdText(_mc.decisionBtnMc.textMc.textDt, MessageId.COMMON_BUTTON_YES);
            TextControl.setIdText(_mc.returnBtnMc.textMc.textDt, MessageId.COMMON_BUTTON_NO);
            if (this._popupType == POPUP_TYPE_DECOMPO_START)
            {
                _loc_14 = ButtonManager.getInstance().addButton(_mc.decisionBtnMc, this.cbEnter);
                _loc_14.enterSeId = ButtonBase.SE_DECIDE_ID;
                _aButton.push(_loc_14);
                _loc_14 = ButtonManager.getInstance().addButton(_mc.returnBtnMc, this.cbReturn);
                _loc_14.enterSeId = ButtonBase.SE_CANCEL_ID;
                _aButton.push(_loc_14);
            }
            ButtonManager.getInstance().seal(_aButton);
            return;
        }// end function

        public function get bEnable() : Boolean
        {
            return this._bEnable;
        }// end function

        public function get isClosed() : Boolean
        {
            return this.closed;
        }// end function

        override public function get bEnd() : Boolean
        {
            return super.bEnd;
        }// end function

        override public function close() : void
        {
            super.close();
            this._fade.setFadeIn(Constant.FADE_IN_TIME);
            return;
        }// end function

        override public function release() : void
        {
            var _loc_1:* = null;
            ButtonManager.getInstance().unseal();
            super.release();
            for each (_loc_1 in this._aItemSWindMc)
            {
                
                if (_loc_1 != null)
                {
                    _loc_1.parent.removeChild(_loc_1);
                }
                _loc_1 = null;
            }
            this.releaseBmp(this._bmpItem);
            this._bmpItem = null;
            if (this._fade != null)
            {
                this._fade.release();
            }
            this._fade = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            if (this._fade)
            {
                this._fade.control(param1);
            }
            return;
        }// end function

        private function releaseBmp(param1:Bitmap) : void
        {
            var _loc_2:* = null;
            if (param1)
            {
                _loc_2 = param1.bitmapData;
                if (_loc_2 != null)
                {
                    _loc_2.dispose();
                }
                if (param1.parent)
                {
                    param1.parent.removeChild(param1);
                }
            }
            return;
        }// end function

        private function cbEnter(param1:int) : void
        {
            this._bEnable = true;
            _aButton[0].setDisable(true);
            _aButton[1].setDisable(true);
            this.close();
            return;
        }// end function

        private function cbReturn(param1:int) : void
        {
            this.closed = true;
            _aButton[0].setDisable(true);
            _aButton[1].setDisable(true);
            this.close();
            return;
        }// end function

    }
}
