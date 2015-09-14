package makeEquip
{
    import button.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import home.*;
    import item.*;
    import message.*;
    import resource.*;
    import status.*;
    import tutorial.*;
    import user.*;
    import utility.*;

    public class MakeEquipDecompositionSelect extends MakeEquipBase
    {
        private var _MAX_PAGE_ITEM:int = 10;
        private var _ADVANCE_PAGE_NEXT:int = 1;
        private var _ADVANCE_PAGE_NEXT10:int = 2;
        private var _ADVANCE_PAGE_LAST:int = 3;
        private var _ADVANCE_PAGE_PREVIEW:int = 4;
        private var _ADVANCE_PAGE_PREVIEW10:int = 5;
        private var _ADVANCE_PAGE_FIRST:int = 6;
        private var _aMcWindow:Array;
        public var _aItemButton:Array;
        private var _bResource:Boolean;
        private var _pageNo:int;
        private var _lastPageNo:int;
        private var _aItemId:Array;
        private var _aItemImage:Array;
        private var _enableButtonCount:int;
        private var _btnNext:ButtonBase;
        private var _btnNext10:ButtonBase;
        private var _btnLast:ButtonBase;
        private var _btnPreview:ButtonBase;
        private var _btnPreview10:ButtonBase;
        private var _btnFirst:ButtonBase;
        private var NumChoosen:int = 0;
        private var _btnReturn:ButtonBase;
        private var _btnReset:ButtonBase;
        private var _btnStart:ButtonBase;
        private var _totalCounter:NumericNumberMc;
        private var _pageCounter:NumericNumberMc;
        private var _popup:MakeEquipPopup;
        private var _popupParent:DisplayObjectContainer;
        private var _bEndTime:Boolean = false;
        private var _selectItemId:uint;
        private var _aSelectItemIdArray:Array;
        private var _aSelectItemButtomIndex:Array;
        private var _aSelectItemUniqArray:Array;
        private var _aStatusPopUp:Array;
        private var _aEnterItemId:Array;
        private var _enterItemId:uint;
        private var startButtonDisabled:Boolean = false;
        private var resetButtonDisabled:Boolean = false;

        public function MakeEquipDecompositionSelect(param1:DisplayObjectContainer, param2:DisplayObjectContainer)
        {
            var StatusPopUp1:EquipSimpleStatus;
            var StatusPopUp2:EquipSimpleStatus;
            var StatusPopUp3:EquipSimpleStatus;
            var StatusPopUp4:EquipSimpleStatus;
            var StatusPopUp5:EquipSimpleStatus;
            var StatusPopUp6:EquipSimpleStatus;
            var StatusPopUp7:EquipSimpleStatus;
            var StatusPopUp8:EquipSimpleStatus;
            var StatusPopUp9:EquipSimpleStatus;
            var StatusPopUp10:EquipSimpleStatus;
            var btn:DecompositionSelectButton;
            var parent:* = param1;
            var popupParent:* = param2;
            this._aItemId = [];
            this._aItemImage = [];
            this._aItemButton = [];
            this._aSelectItemIdArray = [];
            this._aSelectItemButtomIndex = [];
            this._aSelectItemUniqArray = [];
            this._aStatusPopUp = [];
            this._aEnterItemId = [];
            this._enableButtonCount = 0;
            this._pageNo = 0;
            this._lastPageNo = 0;
            this._popupParent = popupParent;
            this._selectItemId = Constant.EMPTY_ID;
            this._enterItemId = Constant.EMPTY_ID;
            super(parent, "decompoSelectMc", false);
            this._aMcWindow = [_mc.decompoWindMc.itemSWind1Mc, _mc.decompoWindMc.itemSWind2Mc, _mc.decompoWindMc.itemSWind3Mc, _mc.decompoWindMc.itemSWind4Mc, _mc.decompoWindMc.itemSWind5Mc, _mc.decompoWindMc.itemSWind6Mc, _mc.decompoWindMc.itemSWind7Mc, _mc.decompoWindMc.itemSWind8Mc, _mc.decompoWindMc.itemSWind9Mc, _mc.decompoWindMc.itemSWind10Mc];
            TextControl.setText(_mc.decompoWindMc.TextSetMc.NumTextMc.textDt, this._aSelectItemUniqArray.length.toString());
            TextControl.setText(_mc.decompoWindMc.TextSetMc.MaxTextMc.textDt, "10");
            TextControl.setIdText(_mc.decompoWindMc.TextSetMc.InfoTextMc.textDt, MessageId.MAKE_EQUIP_SELECT_DECOMPO_TEXT);
            var buttonlistener1:* = _mc.decompoWindMc.itemSWind1Mc;
            StatusPopUp1 = new EquipSimpleStatus(_mc);
            var StatusPopUpPosRight1:* = new Point(_mc.decompoWindMc.BalloonAmbitRightNull.x + 173.5, _mc.decompoWindMc.y + buttonlistener1.y + buttonlistener1.height);
            StatusPopUp1.setPosition(StatusPopUpPosRight1);
            StatusPopUp1.setArrowTargetPosition(new Point(_mc.decompoWindMc.itemSWind1Mc.BalloonNull.x + _mc.decompoWindMc.itemSWind1Mc.x + _mc.decompoWindMc.x + _mc.x - 30, _mc.decompoWindMc.itemSWind1Mc.BalloonNull.y + _mc.decompoWindMc.itemSWind1Mc.y + _mc.decompoWindMc.y + _mc.y + buttonlistener1.height / 2));
            StatusPopUp1.hide();
            buttonlistener1.addEventListener(MouseEvent.MOUSE_OVER, function () : void
            {
                if (_aItemButton[0].isEnable())
                {
                    StatusPopUp1.show();
                }
                return;
            }// end function
            );
            buttonlistener1.addEventListener(MouseEvent.MOUSE_OUT, function () : void
            {
                StatusPopUp1.hide();
                return;
            }// end function
            );
            this._aStatusPopUp.push(StatusPopUp1);
            var buttonlistener2:* = _mc.decompoWindMc.itemSWind2Mc;
            StatusPopUp2 = new EquipSimpleStatus(_mc);
            var StatusPopUpPosLeft2:* = new Point(_mc.decompoWindMc.BalloonAmbitLeftNull.x + 173.5, _mc.decompoWindMc.y + buttonlistener2.y + buttonlistener2.height);
            StatusPopUp2.setPosition(StatusPopUpPosLeft2);
            StatusPopUp2.setArrowTargetPosition(new Point(_mc.decompoWindMc.itemSWind2Mc.BalloonNull.x + _mc.decompoWindMc.itemSWind2Mc.x + _mc.decompoWindMc.x + _mc.x, _mc.decompoWindMc.itemSWind2Mc.BalloonNull.y + _mc.decompoWindMc.itemSWind2Mc.y + _mc.decompoWindMc.y + _mc.y + buttonlistener2.height / 2));
            StatusPopUp2.hide();
            buttonlistener2.addEventListener(MouseEvent.MOUSE_OVER, function () : void
            {
                if (_aItemButton[1].isEnable())
                {
                    StatusPopUp2.show();
                }
                return;
            }// end function
            );
            buttonlistener2.addEventListener(MouseEvent.MOUSE_OUT, function () : void
            {
                StatusPopUp2.hide();
                return;
            }// end function
            );
            this._aStatusPopUp.push(StatusPopUp2);
            var buttonlistener3:* = _mc.decompoWindMc.itemSWind3Mc;
            StatusPopUp3 = new EquipSimpleStatus(_mc);
            var StatusPopUpPosRight3:* = new Point(_mc.decompoWindMc.BalloonAmbitRightNull.x + 173.5, _mc.decompoWindMc.y + buttonlistener3.y + buttonlistener3.height);
            StatusPopUp3.setPosition(StatusPopUpPosRight3);
            StatusPopUp3.setArrowTargetPosition(new Point(_mc.decompoWindMc.itemSWind3Mc.BalloonNull.x + _mc.decompoWindMc.itemSWind3Mc.x + _mc.decompoWindMc.x + _mc.x - 30, _mc.decompoWindMc.itemSWind3Mc.BalloonNull.y + _mc.decompoWindMc.itemSWind3Mc.y + _mc.decompoWindMc.y + _mc.y + buttonlistener3.height / 2));
            StatusPopUp3.hide();
            buttonlistener3.addEventListener(MouseEvent.MOUSE_OVER, function () : void
            {
                if (_aItemButton[2].isEnable())
                {
                    StatusPopUp3.show();
                }
                return;
            }// end function
            );
            buttonlistener3.addEventListener(MouseEvent.MOUSE_OUT, function () : void
            {
                StatusPopUp3.hide();
                return;
            }// end function
            );
            this._aStatusPopUp.push(StatusPopUp3);
            var buttonlistener4:* = _mc.decompoWindMc.itemSWind4Mc;
            StatusPopUp4 = new EquipSimpleStatus(_mc);
            var StatusPopUpPosLeft4:* = new Point(_mc.decompoWindMc.BalloonAmbitLeftNull.x + 173.5, _mc.decompoWindMc.y + buttonlistener4.y + buttonlistener4.height);
            StatusPopUp4.setPosition(StatusPopUpPosLeft4);
            StatusPopUp4.setArrowTargetPosition(new Point(_mc.decompoWindMc.itemSWind4Mc.BalloonNull.x + _mc.decompoWindMc.itemSWind4Mc.x + _mc.decompoWindMc.x + _mc.x, _mc.decompoWindMc.itemSWind4Mc.BalloonNull.y + _mc.decompoWindMc.itemSWind4Mc.y + _mc.decompoWindMc.y + _mc.y + buttonlistener4.height / 2));
            StatusPopUp4.hide();
            buttonlistener4.addEventListener(MouseEvent.MOUSE_OVER, function () : void
            {
                if (_aItemButton[3].isEnable())
                {
                    StatusPopUp4.show();
                }
                return;
            }// end function
            );
            buttonlistener4.addEventListener(MouseEvent.MOUSE_OUT, function () : void
            {
                StatusPopUp4.hide();
                return;
            }// end function
            );
            this._aStatusPopUp.push(StatusPopUp4);
            var buttonlistener5:* = _mc.decompoWindMc.itemSWind5Mc;
            StatusPopUp5 = new EquipSimpleStatus(_mc);
            var StatusPopUpPosRight5:* = new Point(_mc.decompoWindMc.BalloonAmbitRightNull.x + 173.5, _mc.decompoWindMc.y + buttonlistener5.y + buttonlistener5.height);
            StatusPopUp5.setPosition(StatusPopUpPosRight5);
            StatusPopUp5.setArrowTargetPosition(new Point(_mc.decompoWindMc.itemSWind5Mc.BalloonNull.x + _mc.decompoWindMc.itemSWind5Mc.x + _mc.decompoWindMc.x + _mc.x - 30, _mc.decompoWindMc.itemSWind5Mc.BalloonNull.y + _mc.decompoWindMc.itemSWind5Mc.y + _mc.decompoWindMc.y + _mc.y + buttonlistener5.height / 2));
            StatusPopUp5.hide();
            buttonlistener5.addEventListener(MouseEvent.MOUSE_OVER, function () : void
            {
                if (_aItemButton[4].isEnable())
                {
                    StatusPopUp5.show();
                }
                return;
            }// end function
            );
            buttonlistener5.addEventListener(MouseEvent.MOUSE_OUT, function () : void
            {
                StatusPopUp5.hide();
                return;
            }// end function
            );
            this._aStatusPopUp.push(StatusPopUp5);
            var buttonlistener6:* = _mc.decompoWindMc.itemSWind6Mc;
            StatusPopUp6 = new EquipSimpleStatus(_mc);
            var StatusPopUpPosLeft6:* = new Point(_mc.decompoWindMc.BalloonAmbitLeftNull.x + 173.5, _mc.decompoWindMc.y + buttonlistener6.y + buttonlistener6.height);
            StatusPopUp6.setPosition(StatusPopUpPosLeft6);
            StatusPopUp6.setArrowTargetPosition(new Point(_mc.decompoWindMc.itemSWind6Mc.BalloonNull.x + _mc.decompoWindMc.itemSWind6Mc.x + _mc.decompoWindMc.x + _mc.x, _mc.decompoWindMc.itemSWind6Mc.BalloonNull.y + _mc.decompoWindMc.itemSWind6Mc.y + _mc.decompoWindMc.y + _mc.y + buttonlistener6.height / 2));
            StatusPopUp6.hide();
            buttonlistener6.addEventListener(MouseEvent.MOUSE_OVER, function () : void
            {
                if (_aItemButton[5].isEnable())
                {
                    StatusPopUp6.show();
                }
                return;
            }// end function
            );
            buttonlistener6.addEventListener(MouseEvent.MOUSE_OUT, function () : void
            {
                StatusPopUp6.hide();
                return;
            }// end function
            );
            this._aStatusPopUp.push(StatusPopUp6);
            var buttonlistener7:* = _mc.decompoWindMc.itemSWind7Mc;
            StatusPopUp7 = new EquipSimpleStatus(_mc);
            var StatusPopUpPosRight7:* = new Point(_mc.decompoWindMc.BalloonAmbitRightNull.x + 173.5, _mc.decompoWindMc.y + buttonlistener7.y + buttonlistener7.height);
            StatusPopUp7.setPosition(StatusPopUpPosRight7);
            StatusPopUp7.setArrowTargetPosition(new Point(_mc.decompoWindMc.itemSWind7Mc.BalloonNull.x + _mc.decompoWindMc.itemSWind7Mc.x + _mc.decompoWindMc.x + _mc.x - 30, _mc.decompoWindMc.itemSWind7Mc.BalloonNull.y + _mc.decompoWindMc.itemSWind7Mc.y + _mc.decompoWindMc.y + _mc.y + buttonlistener7.height / 2));
            StatusPopUp7.hide();
            buttonlistener7.addEventListener(MouseEvent.MOUSE_OVER, function () : void
            {
                if (_aItemButton[6].isEnable())
                {
                    StatusPopUp7.show();
                }
                return;
            }// end function
            );
            buttonlistener7.addEventListener(MouseEvent.MOUSE_OUT, function () : void
            {
                StatusPopUp7.hide();
                return;
            }// end function
            );
            this._aStatusPopUp.push(StatusPopUp7);
            var buttonlistener8:* = _mc.decompoWindMc.itemSWind8Mc;
            StatusPopUp8 = new EquipSimpleStatus(_mc);
            var StatusPopUpPosLeft8:* = new Point(_mc.decompoWindMc.BalloonAmbitLeftNull.x + 173.5, _mc.decompoWindMc.y + buttonlistener8.y + buttonlistener8.height);
            StatusPopUp8.setPosition(StatusPopUpPosLeft8);
            StatusPopUp8.setArrowTargetPosition(new Point(_mc.decompoWindMc.itemSWind8Mc.BalloonNull.x + _mc.decompoWindMc.itemSWind8Mc.x + _mc.decompoWindMc.x + _mc.x, _mc.decompoWindMc.itemSWind8Mc.BalloonNull.y + _mc.decompoWindMc.itemSWind8Mc.y + _mc.decompoWindMc.y + _mc.y + buttonlistener8.height / 2));
            StatusPopUp8.hide();
            buttonlistener8.addEventListener(MouseEvent.MOUSE_OVER, function () : void
            {
                if (_aItemButton[7].isEnable())
                {
                    StatusPopUp8.show();
                }
                return;
            }// end function
            );
            buttonlistener8.addEventListener(MouseEvent.MOUSE_OUT, function () : void
            {
                StatusPopUp8.hide();
                return;
            }// end function
            );
            this._aStatusPopUp.push(StatusPopUp8);
            var buttonlistener9:* = _mc.decompoWindMc.itemSWind9Mc;
            StatusPopUp9 = new EquipSimpleStatus(_mc);
            var StatusPopUpPosRight9:* = new Point(_mc.decompoWindMc.BalloonAmbitRightNull.x + 173.5, _mc.decompoWindMc.y + buttonlistener9.y + buttonlistener9.height);
            StatusPopUp9.setPosition(StatusPopUpPosRight9);
            StatusPopUp9.setArrowTargetPosition(new Point(_mc.decompoWindMc.itemSWind9Mc.BalloonNull.x + _mc.decompoWindMc.itemSWind9Mc.x + _mc.decompoWindMc.x + _mc.x - 30, _mc.decompoWindMc.itemSWind9Mc.BalloonNull.y + _mc.decompoWindMc.itemSWind9Mc.y + _mc.decompoWindMc.y + _mc.y + buttonlistener9.height / 2));
            StatusPopUp9.hide();
            buttonlistener9.addEventListener(MouseEvent.MOUSE_OVER, function () : void
            {
                if (_aItemButton[8].isEnable())
                {
                    StatusPopUp9.show();
                }
                return;
            }// end function
            );
            buttonlistener9.addEventListener(MouseEvent.MOUSE_OUT, function () : void
            {
                StatusPopUp9.hide();
                return;
            }// end function
            );
            this._aStatusPopUp.push(StatusPopUp9);
            var buttonlistener10:* = _mc.decompoWindMc.itemSWind10Mc;
            StatusPopUp10 = new EquipSimpleStatus(_mc);
            var StatusPopUpPosLeft10:* = new Point(_mc.decompoWindMc.BalloonAmbitLeftNull.x + 173.5, _mc.decompoWindMc.y + buttonlistener10.y + buttonlistener10.height);
            StatusPopUp10.setPosition(StatusPopUpPosLeft10);
            StatusPopUp10.setArrowTargetPosition(new Point(_mc.decompoWindMc.itemSWind10Mc.BalloonNull.x + _mc.decompoWindMc.itemSWind10Mc.x + _mc.decompoWindMc.x + _mc.x, _mc.decompoWindMc.itemSWind10Mc.BalloonNull.y + _mc.decompoWindMc.itemSWind10Mc.y + _mc.decompoWindMc.y + _mc.y + buttonlistener10.height / 2));
            StatusPopUp10.hide();
            buttonlistener10.addEventListener(MouseEvent.MOUSE_OVER, function () : void
            {
                if (_aItemButton[9].isEnable())
                {
                    StatusPopUp10.show();
                }
                return;
            }// end function
            );
            buttonlistener10.addEventListener(MouseEvent.MOUSE_OUT, function () : void
            {
                StatusPopUp10.hide();
                return;
            }// end function
            );
            this._aStatusPopUp.push(StatusPopUp10);
            var i:int;
            while (i < this._aMcWindow.length)
            {
                
                btn = new DecompositionSelectButton(this._aMcWindow[i], this._aSelectItemUniqArray, this.cbSelectItem, this.cbShowStatusPopUp, this.cbHideStatusPopUp);
                btn.setId(i);
                ButtonManager.getInstance().addButtonBase(btn);
                btn.setHitMovieClip(this._aMcWindow[i].windowMc);
                btn.enterSeId = ButtonBase.SE_DECIDE_ID;
                this._aItemButton.push(btn);
                i = (i + 1);
            }
            _aButton = _aButton.concat(this._aItemButton);
            this._btnNext = ButtonManager.getInstance().addButton(_mc.decompoWindMc.pageBtnSetGuidMc.pageBtnRight1Mc, this.cbPage, this._ADVANCE_PAGE_NEXT);
            this._btnNext.enterSeId = ButtonBase.SE_CURSOR_ID;
            this._btnNext10 = ButtonManager.getInstance().addButton(_mc.decompoWindMc.pageBtnSetGuidMc.pageBtnRight2Mc, this.cbPage, this._ADVANCE_PAGE_NEXT10);
            this._btnNext10.enterSeId = ButtonBase.SE_CURSOR_ID;
            this._btnLast = ButtonManager.getInstance().addButton(_mc.decompoWindMc.pageBtnSetGuidMc.pageBtnRight3Mc, this.cbPage, this._ADVANCE_PAGE_LAST);
            this._btnLast.enterSeId = ButtonBase.SE_CURSOR_ID;
            this._btnPreview = ButtonManager.getInstance().addButton(_mc.decompoWindMc.pageBtnSetGuidMc.pageBtnLeft1Mc, this.cbPage, this._ADVANCE_PAGE_PREVIEW);
            this._btnPreview.enterSeId = ButtonBase.SE_CURSOR_ID;
            this._btnPreview10 = ButtonManager.getInstance().addButton(_mc.decompoWindMc.pageBtnSetGuidMc.pageBtnLeft2Mc, this.cbPage, this._ADVANCE_PAGE_PREVIEW10);
            this._btnPreview10.enterSeId = ButtonBase.SE_CURSOR_ID;
            this._btnFirst = ButtonManager.getInstance().addButton(_mc.decompoWindMc.pageBtnSetGuidMc.pageBtnLeft3Mc, this.cbPage, this._ADVANCE_PAGE_FIRST);
            this._btnFirst.enterSeId = ButtonBase.SE_CURSOR_ID;
            _aButton.push(this._btnNext);
            _aButton.push(this._btnNext10);
            _aButton.push(this._btnLast);
            _aButton.push(this._btnPreview);
            _aButton.push(this._btnPreview10);
            _aButton.push(this._btnFirst);
            this._btnReturn = ButtonManager.getInstance().addButton(_mc.returnBtnMc, this.cbReturn);
            this._btnReturn.enterSeId = ButtonBase.SE_CANCEL_ID;
            _aButton.push(this._btnReturn);
            TextControl.setIdText(_mc.returnBtnMc.textMc.textDt, MessageId.COMMON_BUTTON_RETURN);
            this._btnReset = ButtonManager.getInstance().addButton(_mc.resetBtnMc, this.cbReset);
            this._btnReset.enterSeId = ButtonBase.SE_DECIDE_ID;
            _aButton.push(this._btnReset);
            TextControl.setIdText(_mc.resetBtnMc.textMc.textDt, MessageId.CRAFT_ROOM_DECOMPOSITION_CLEAR_BUTTON);
            this._btnStart = ButtonManager.getInstance().addButton(_mc.startBtnMc, this.cbStart);
            this._btnStart.enterSeId = ButtonBase.SE_DECIDE_ID;
            _aButton.push(this._btnStart);
            TextControl.setIdText(_mc.startBtnMc.textMc.textDt, MessageId.COMMON_BUTTON_DECIDE);
            setButtonDisable(true);
            this._aItemId = this.createItemIdList();
            this.setLastPageNo();
            this._totalCounter = new NumericNumberMc(_mc.decompoWindMc.pageBtnSetGuidMc.pageNumTextMc.pageNum1, (this._lastPageNo + 1), 0, false);
            this._pageCounter = new NumericNumberMc(_mc.decompoWindMc.pageBtnSetGuidMc.pageNumTextMc.pageNum2, 0, 0, false);
            this.setPageInit(0);
            return;
        }// end function

        public function get enterItemId() : Array
        {
            return this._aEnterItemId;
        }// end function

        public function getWindowMovieClip() : MovieClip
        {
            return _mc;
        }// end function

        public function get bOpened() : Boolean
        {
            return _isoMain.bOpened;
        }// end function

        public function get bClosed() : Boolean
        {
            return _isoMain.bClosed;
        }// end function

        private function setLastPageNo() : void
        {
            this._lastPageNo = int(this._aItemId.length / this._MAX_PAGE_ITEM) - 1;
            if (this._aItemId.length % this._MAX_PAGE_ITEM > 0)
            {
                var _loc_1:* = this;
                var _loc_2:* = this._lastPageNo + 1;
                _loc_1._lastPageNo = _loc_2;
            }
            if (this._lastPageNo < 0)
            {
                this._lastPageNo = 0;
            }
            return;
        }// end function

        override public function release() : void
        {
            super.release();
            this.releaseItemImage();
            this._aMcWindow = [];
            this._aItemButton = [];
            this._btnNext = null;
            this._btnLast = null;
            this._btnPreview = null;
            this._btnFirst = null;
            this._btnReturn = null;
            this._popupParent = null;
            return;
        }// end function

        private function releaseItemImage() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aItemImage)
            {
                
                if (_loc_1.bitmapData)
                {
                    _loc_1.bitmapData.dispose();
                }
                if (_loc_1.parent)
                {
                    _loc_1.parent.removeChild(_loc_1);
                }
            }
            this._aItemImage = [];
            return;
        }// end function

        public function control(param1:Number) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_2:* = UserDataManager.getInstance().userData.getInstitutionInfo(CommonConstant.FACILITY_ID_MAKE_EQUIP);
            var _loc_3:* = TimeClock.getNowTime();
            if (_loc_2.upgradeEnd > _loc_3 && _loc_2.upgradeEnd != 0)
            {
                this._bEndTime = true;
            }
            if (this._aSelectItemUniqArray.length == 0 && this.startButtonDisabled == false)
            {
                this._btnStart.setDisable(true);
                this.startButtonDisabled = true;
            }
            if (this._aSelectItemUniqArray.length != 0 && this.startButtonDisabled == true)
            {
                this._btnStart.setDisable(false);
                this.startButtonDisabled = false;
            }
            if (this._aSelectItemUniqArray.length == 0 && this.resetButtonDisabled == false)
            {
                this._btnReset.setDisable(true);
                this.resetButtonDisabled = true;
            }
            if (this._aSelectItemUniqArray.length != 0 && this.resetButtonDisabled == true)
            {
                this._btnReset.setDisable(false);
                this.resetButtonDisabled = false;
            }
            if (this._bResource)
            {
                if (ResourceManager.getInstance().isLoaded())
                {
                    this._bResource = false;
                    this.displayPage();
                    if (_isoMain.bClosed)
                    {
                        _isoMain.setIn(this.cbIn);
                    }
                    else if (this._bEndTime)
                    {
                        setButtonDisable(true);
                    }
                    else
                    {
                        this.switchButtonEnable(true);
                    }
                }
            }
            if (this._popup)
            {
                this._popup.control(param1);
                if (this._popup.bEnable)
                {
                    _mc.resetBtnMc.visible = false;
                    _mc.startBtnMc.visible = false;
                    _mc.decompoWindMc.visible = false;
                }
                if (this._popup.bEnd)
                {
                    for each (_loc_4 in this._aItemButton)
                    {
                        
                        _loc_4.unseal(true);
                    }
                    for each (_loc_5 in _aButton)
                    {
                        
                        _loc_5.unseal(true);
                    }
                    if (this._popup.bEnable)
                    {
                        this._aEnterItemId = this._aSelectItemIdArray;
                    }
                    this._popup.release();
                    this._popup = null;
                }
            }
            return;
        }// end function

        private function cbIn() : void
        {
            if (this._bEndTime)
            {
                this.ButtonDisable(false);
            }
            else
            {
                this.switchButtonEnable(true);
            }
            return;
        }// end function

        private function createItemIdList() : Array
        {
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_1:* = UserDataManager.getInstance().userData;
            var _loc_2:* = _loc_1.getOwnItem(CommonConstant.ITEM_KIND_ACCESSORIES);
            var _loc_3:* = [];
            for each (_loc_4 in _loc_2)
            {
                
                if (_loc_4.itemCategory != CommonConstant.ITEM_KIND_ACCESSORIES)
                {
                    continue;
                }
                if (ItemManager.getInstance().isPaymetEquip(_loc_4.itemId))
                {
                    continue;
                }
                _loc_5 = _loc_1.getEquipItemNum(_loc_4.itemId);
                _loc_6 = 0;
                while (_loc_6 < _loc_4.num - _loc_5)
                {
                    
                    _loc_3.push(_loc_4.itemId);
                    _loc_6++;
                }
            }
            return _loc_3;
        }// end function

        private function setPageInit(param1:int) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            this._pageNo = param1;
            this._enableButtonCount = 0;
            var _loc_2:* = 0;
            while (_loc_2 < this._MAX_PAGE_ITEM && this._pageNo * this._MAX_PAGE_ITEM + _loc_2 < this._aItemId.length)
            {
                
                _loc_3 = this._aItemId[this._pageNo * this._MAX_PAGE_ITEM + _loc_2];
                _loc_4 = ItemManager.getInstance().getItemInformation(_loc_3);
                ResourceManager.getInstance().loadResource(ResourcePath.EQUIPMENT_IMG_PATH + _loc_4.fileName);
                _loc_2++;
            }
            this._bResource = true;
            return;
        }// end function

        private function displayPage() : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            this.releaseItemImage();
            var _loc_1:* = 0;
            while (_loc_1 < this._MAX_PAGE_ITEM && this._pageNo * this._MAX_PAGE_ITEM + _loc_1 < this._aItemId.length)
            {
                
                _loc_2 = this._aItemId[this._pageNo * this._MAX_PAGE_ITEM + _loc_1];
                _loc_3 = this._aMcWindow[_loc_1];
                _loc_4 = this._aStatusPopUp[_loc_1];
                _loc_4.setItemData(_loc_2);
                _loc_4.mc.alpha = 1;
                _loc_5 = ItemManager.getInstance().getItemInformation(_loc_2);
                _loc_6 = ResourceManager.getInstance().createBitmap(ResourcePath.EQUIPMENT_IMG_PATH + _loc_5.fileName);
                _loc_6.smoothing = true;
                _loc_3.itemNull.addChild(_loc_6);
                this._aItemImage.push(_loc_6);
                TextControl.setText(_loc_3.textMc.textDt, _loc_5.name);
                var _loc_10:* = this;
                var _loc_11:* = this._enableButtonCount + 1;
                _loc_10._enableButtonCount = _loc_11;
                _loc_1++;
            }
            while (_loc_1 < this._MAX_PAGE_ITEM)
            {
                
                _loc_7 = this._aMcWindow[_loc_1];
                _loc_8 = this._aItemButton[_loc_1];
                _loc_8.setDisable(true);
                _loc_7.gotoAndStop("disable");
                _loc_9 = this._aStatusPopUp[_loc_1];
                _loc_9.mc.alpha = 0;
                TextControl.setText(_loc_7.textMc.textDt, "");
                _loc_1++;
            }
            this._pageCounter.setNum((this._pageNo + 1));
            return;
        }// end function

        public function switchButtonEnable(param1:Boolean) : void
        {
            var _loc_3:* = null;
            if (param1 == false)
            {
                setButtonDisable(true);
                return;
            }
            var _loc_2:* = 0;
            while (_loc_2 < this._enableButtonCount)
            {
                
                _loc_3 = this._aItemButton[_loc_2];
                _loc_3.setDisable(false);
                _loc_2++;
            }
            this._btnReturn.setDisable(false);
            this._btnNext.setDisable(this._pageNo >= this._lastPageNo);
            this._btnNext10.setDisable(this._pageNo >= this._lastPageNo);
            this._btnLast.setDisable(this._pageNo >= this._lastPageNo);
            this._btnPreview.setDisable(this._pageNo == 0);
            this._btnPreview10.setDisable(this._pageNo == 0);
            this._btnFirst.setDisable(this._pageNo == 0);
            return;
        }// end function

        public function ButtonDisable(param1:Boolean) : void
        {
            if (param1 == false)
            {
                setButtonDisable(true);
                this._btnReturn.setDisable(false);
                return;
            }
            return;
        }// end function

        private function cbSelectItem(param1:int) : void
        {
            var _loc_5:* = 0;
            var _loc_2:* = this._pageNo * this._MAX_PAGE_ITEM + param1;
            var _loc_3:* = false;
            this._selectItemId = this._aItemId[_loc_2];
            var _loc_4:* = ItemManager.getInstance().getItemInformation(this._selectItemId);
            if (this._aSelectItemUniqArray.length != 0)
            {
                _loc_5 = 0;
                while (_loc_5 < this._aSelectItemUniqArray.length)
                {
                    
                    if (_loc_2 == this._aSelectItemUniqArray[_loc_5])
                    {
                        this._aSelectItemUniqArray.splice(_loc_5, 1);
                        _loc_3 = true;
                        TextControl.setText(_mc.decompoWindMc.TextSetMc.NumTextMc.textDt, this._aSelectItemUniqArray.length.toString());
                    }
                    _loc_5++;
                }
            }
            if (this._aSelectItemUniqArray.length != 0 && _loc_3 == false)
            {
                this._aSelectItemUniqArray.push(_loc_2);
                TextControl.setText(_mc.decompoWindMc.TextSetMc.NumTextMc.textDt, this._aSelectItemUniqArray.length.toString());
            }
            if (this._aSelectItemUniqArray.length == 0 && _loc_3 == false)
            {
                this._aSelectItemUniqArray.push(_loc_2);
                TextControl.setText(_mc.decompoWindMc.TextSetMc.NumTextMc.textDt, this._aSelectItemUniqArray.length.toString());
            }
            return;
        }// end function

        private function cbPage(param1:int) : void
        {
            switch(param1)
            {
                case this._ADVANCE_PAGE_NEXT:
                {
                    this.setPageInit((this._pageNo + 1));
                    break;
                }
                case this._ADVANCE_PAGE_NEXT10:
                {
                    if (this._lastPageNo >= this._pageNo + 10)
                    {
                        this.setPageInit(this._pageNo + 10);
                    }
                    else
                    {
                        this.setPageInit(this._lastPageNo);
                    }
                    break;
                }
                case this._ADVANCE_PAGE_LAST:
                {
                    this.setPageInit(this._lastPageNo);
                    break;
                }
                case this._ADVANCE_PAGE_PREVIEW:
                {
                    this.setPageInit((this._pageNo - 1));
                    break;
                }
                case this._ADVANCE_PAGE_PREVIEW10:
                {
                    if (this._pageNo - 10 < 0)
                    {
                        this.setPageInit(0);
                    }
                    else
                    {
                        this.setPageInit(this._pageNo - 10);
                    }
                    break;
                }
                case this._ADVANCE_PAGE_FIRST:
                {
                    this.setPageInit(0);
                    break;
                }
                default:
                {
                    break;
                }
            }
            this.updateHighlitedButtons();
            return;
        }// end function

        private function updateHighlitedButtons() : void
        {
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_1:* = [];
            var _loc_2:* = 0;
            var _loc_3:* = this._pageNo * this._MAX_PAGE_ITEM;
            while (_loc_3 < this._pageNo * this._MAX_PAGE_ITEM + this._MAX_PAGE_ITEM)
            {
                
                for each (_loc_6 in this._aSelectItemUniqArray)
                {
                    
                    if (_loc_6 == _loc_3)
                    {
                        _loc_1.push(_loc_2);
                    }
                }
                _loc_2++;
                _loc_3++;
            }
            for each (_loc_4 in this._aItemButton)
            {
                
                _loc_4.setHighlighted(false);
            }
            for each (_loc_5 in _loc_1)
            {
                
                this._aItemButton[_loc_5].setHighlighted(true);
            }
            return;
        }// end function

        private function cbReturn(param1:int) : void
        {
            close();
            return;
        }// end function

        private function cbReset(param1:int) : void
        {
            this._aSelectItemUniqArray = [];
            var _loc_2:* = 0;
            while (_loc_2 < this._aItemButton.length)
            {
                
                this._aItemButton[_loc_2]._mc.ItemOn.visible = false;
                this._aItemButton[_loc_2]._selectedItemsButton = this._aSelectItemUniqArray;
                _loc_2++;
            }
            TextControl.setText(_mc.decompoWindMc.TextSetMc.NumTextMc.textDt, this._aSelectItemUniqArray.length.toString());
            return;
        }// end function

        private function cbStart(param1:int) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = null;
            this._aSelectItemIdArray = [];
            for each (_loc_2 in this._aSelectItemUniqArray)
            {
                
                this._aSelectItemIdArray.push(this._aItemId[_loc_2]);
            }
            for each (_loc_3 in _aButton)
            {
                
                _loc_3.seal(true);
            }
            for each (_loc_4 in this._aItemButton)
            {
                
                _loc_4.seal(true);
            }
            this._popup = new MakeEquipPopup(this._popupParent, MakeEquipPopup.POPUP_TYPE_DECOMPO_START, this._aSelectItemIdArray, null, this);
            return;
        }// end function

        private function cbShowStatusPopUp(param1:int) : void
        {
            return;
        }// end function

        private function cbHideStatusPopUp(param1:int) : void
        {
            return;
        }// end function

        override protected function cbMainIn() : void
        {
            super.cbMainIn();
            if (TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_MAKE_EQUIP_DECOMPOSITION_1))
            {
                TutorialManager.getInstance().stepChange(4);
            }
            return;
        }// end function

    }
}
