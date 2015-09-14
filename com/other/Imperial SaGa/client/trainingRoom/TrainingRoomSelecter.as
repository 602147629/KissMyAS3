package trainingRoom
{
    import asset.*;
    import button.*;
    import flash.display.*;
    import flash.geom.*;
    import message.*;
    import player.*;
    import resource.*;
    import sound.*;
    import status.*;
    import utility.*;

    public class TrainingRoomSelecter extends Object
    {
        private var _type:int;
        private var _phase:int;
        private var _mcBase:MovieClip;
        private var _isoMain:InStayOut;
        private var _btnClose:ButtonBase;
        private var _btnDecide:ButtonBase;
        private var _assetIcon:AssetIcon;
        private var _aBtnList:Array;
        private var _aSkillList:Array;
        private var _skillSimpleStatus:SkillSimpleStatus;
        private var _overSkillData:OwnSkillData;
        private var _fade:Fade;
        private var _page:PageButton;
        private var _pageAnim:PageAnim;
        private var _cbOpen:Function;
        private var _cbClose:Function;
        private var _listCount:int;
        private var _pp:PlayerPersonal;
        private var _aData:Array;
        private var _selectedIndex:int;
        private var _selectedParam:int;
        public static const SELECTER_TYPE_PARAM:int = 0;
        public static const SELECTER_TYPE_SKILL:int = 1;
        public static const SELECTER_TYPE_TIME:int = 2;
        private static const _PHASE_OPEN:int = 1;
        private static const _PHASE_MAIN:int = 2;
        private static const _PHASE_CLOSE:int = 3;

        public function TrainingRoomSelecter(param1:int, param2:PlayerPersonal, param3:Array, param4:DisplayObjectContainer, param5:Function, param6:Function)
        {
            var _loc_7:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = null;
            var _loc_16:* = 0;
            var _loc_17:* = null;
            this._type = param1;
            this._pp = param2;
            this._aData = param3;
            this._selectedIndex = -1;
            this._selectedParam = -1;
            this._aBtnList = [];
            this._aSkillList = [];
            this._fade = new Fade(param4);
            this._fade.maxAlpha = 0.5;
            this._fade.setFadeIn(0);
            var _loc_8:* = 0;
            switch(this._type)
            {
                case SELECTER_TYPE_PARAM:
                {
                    _loc_7 = ResourceManager.getInstance().createMovieClip(ResourcePath.FACILITY_PATH + "UI_Training.swf", "ParamSelectListPopupMc");
                    this._mcBase = _loc_7.paramSelectListMc;
                    this._listCount = 2;
                    this._page = null;
                    this._pageAnim = null;
                    _loc_8 = 0;
                    while (_loc_8 < this._listCount)
                    {
                        
                        _loc_9 = ButtonManager.getInstance().addButton(this._mcBase.listMc["listBtn" + (_loc_8 + 1) + "Mc"], this.cbClickListButton, _loc_8);
                        _loc_9.enterSeId = ButtonBase.SE_DECIDE_ID;
                        this._aBtnList.push(_loc_9);
                        TextControl.setText(this._mcBase.listMc["listBtn" + (_loc_8 + 1) + "Mc"].contentText1Mc.textDt, "");
                        _loc_8++;
                    }
                    TextControl.setIdText(this._mcBase.listMc.titleMc.textDt, MessageId.TRAINING_ROOM_SELECTER_PARAM_GUIDE);
                    break;
                }
                case SELECTER_TYPE_SKILL:
                {
                    _loc_7 = ResourceManager.getInstance().createMovieClip(ResourcePath.FACILITY_PATH + "UI_Training.swf", "SkillSelectListPopupMc");
                    this._mcBase = _loc_7.skillSelectListMc;
                    this._listCount = 4;
                    this._page = new PageButton(this._mcBase.listMc, this.cbChangePage, 0, Math.ceil(this._aData.length / this._listCount));
                    this._pageAnim = null;
                    _loc_8 = 0;
                    while (_loc_8 < this._listCount)
                    {
                        
                        _loc_12 = this._mcBase.listMc["listBtn" + (_loc_8 + 1) + "Mc"];
                        _loc_13 = new TrainingRoomSkillInfoButton(_loc_12, _loc_12.BalloonAmbitNull, 0, _loc_8, this.cbClickListButton_Power, this.cbClickListButton_Hit);
                        this._aSkillList.push(_loc_13);
                        _loc_8++;
                    }
                    this._skillSimpleStatus = new SkillSimpleStatus(param4);
                    this._skillSimpleStatus.hide();
                    this._overSkillData = null;
                    TextControl.setIdText(this._mcBase.listMc.titleMc.textDt, MessageId.TRAINING_ROOM_SELECTER_SKILL_GUIDE);
                    break;
                }
                case SELECTER_TYPE_TIME:
                {
                    _loc_7 = ResourceManager.getInstance().createMovieClip(ResourcePath.FACILITY_PATH + "UI_Training.swf", "TimeSelectListPopupMc");
                    this._mcBase = _loc_7.timeSelectListMc;
                    this._listCount = 10;
                    this._page = new PageButton(this._mcBase.listMc.pageBtnSetGuidMc, this.cbChangePage_AnimStart, 0, Math.ceil(this._aData.length / this._listCount));
                    this._pageAnim = new PageAnim(this._mcBase.listMc.skillListMc, this.cbPageAnimChange, this.cbPageAnimEnd);
                    _loc_10 = null;
                    _loc_11 = this._mcBase.listMc.skillListMc.skillListGuideMc;
                    _loc_8 = 0;
                    while (_loc_8 < this._listCount)
                    {
                        
                        _loc_14 = _loc_11["skill" + (_loc_8 + 1) + "Mc"];
                        _loc_15 = _loc_8 & 1 ? (_loc_11.BalloonAmbitLeftNull) : (_loc_11.BalloonAmbitRightNull);
                        if (_loc_10 == null)
                        {
                            _loc_10 = _loc_14;
                        }
                        _loc_16 = _loc_14.y - _loc_10.y;
                        _loc_17 = new TrainingRoomSkillInfoButton(_loc_14, _loc_15, _loc_16, _loc_8, null, null);
                        this._aSkillList.push(_loc_17);
                        _loc_8++;
                    }
                    this._skillSimpleStatus = new SkillSimpleStatus(this._mcBase);
                    this._skillSimpleStatus.hide();
                    this._overSkillData = null;
                    TextControl.setIdText(this._mcBase.listMc.titleMc.textDt, MessageId.TRAINING_ROOM_SELECTER_AVAILABLE);
                    TextControl.setIdText(this._mcBase.listMc.TrainingDetailMc.contentTitleText1Mc.textDt, MessageId.TRAINING_ROOM_SELECTER_TIME_TRAINING_TIME);
                    TextControl.setIdText(this._mcBase.listMc.TrainingDetailMc.contentTitleText2Mc.textDt, MessageId.TRAINING_ROOM_SELECTER_TIME_TARGET_SKILL_COUNT);
                    TextControl.setText(this._mcBase.listMc.TrainingDetailMc.contentTitleText3Mc.textDt, TextControl.formatIdText(MessageId.TRAINING_ROOM_SELECTER_RESOURCE, AssetListManager.getInstance().getAssetName(AssetId.ASSET_TRAINING)));
                    TextControl.setIdText(this._mcBase.listMc.TrainingDetailMc.DetailTextMc.CostNum.textDt1, MessageId.QUEST_SELECT_ITEM_NUM);
                    this._assetIcon = new AssetIcon(this._mcBase.listMc.TrainingDetailMc.dsNull, AssetId.ASSET_TRAINING);
                    this._btnDecide = ButtonManager.getInstance().addButton(this._mcBase.startBtnMc, this.cbTrainingButton);
                    this._btnDecide.enterSeId = ButtonBase.SE_DECIDE_ID;
                    TextControl.setIdText(this._mcBase.startBtnMc.textMc.textDt, MessageId.COMMON_BUTTON_DECIDE);
                    break;
                }
                default:
                {
                    break;
                    break;
                }
            }
            param4.addChild(this._mcBase);
            this._cbOpen = param5;
            this._cbClose = param6;
            this._isoMain = new InStayOut(this._mcBase);
            this._btnClose = ButtonManager.getInstance().addButton(this._mcBase.closeBtnMc, this.cbCloseButton);
            this._btnClose.enterSeId = ButtonBase.SE_CANCEL_ID;
            TextControl.setIdText(this._mcBase.closeBtnMc.textMc.textDt, MessageId.COMMON_BUTTON_CLOSE);
            this.updateList();
            this.setPhase(_PHASE_OPEN);
            return;
        }// end function

        public function get type() : int
        {
            return this._type;
        }// end function

        public function get bClose() : Boolean
        {
            return this._phase == _PHASE_CLOSE && (this._isoMain && this._isoMain.bClosed);
        }// end function

        public function release() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            if (this._fade)
            {
                this._fade.release();
            }
            this._fade = null;
            if (this._btnDecide)
            {
                ButtonManager.getInstance().removeButton(this._btnDecide);
            }
            this._btnDecide = null;
            ButtonManager.getInstance().removeButton(this._btnClose);
            this._btnClose = null;
            if (this._assetIcon)
            {
                this._assetIcon.release();
            }
            this._assetIcon = null;
            if (this._skillSimpleStatus)
            {
                this._skillSimpleStatus.release();
            }
            this._skillSimpleStatus = null;
            this._overSkillData = null;
            for each (_loc_1 in this._aSkillList)
            {
                
                _loc_1.release();
            }
            this._aSkillList = null;
            for each (_loc_2 in this._aBtnList)
            {
                
                ButtonManager.getInstance().removeButton(_loc_2);
            }
            this._aBtnList = null;
            if (this._page)
            {
                this._page.release();
            }
            this._page = null;
            if (this._isoMain)
            {
                this._isoMain.release();
            }
            this._isoMain = null;
            if (this._mcBase && this._mcBase.parent)
            {
                this._mcBase.parent.removeChild(this._mcBase);
            }
            this._mcBase = null;
            this._aData = null;
            this._pp = null;
            return;
        }// end function

        private function setPhase(param1:int) : void
        {
            this._phase = param1;
            switch(this._phase)
            {
                case _PHASE_OPEN:
                {
                    this.initPhaseOpen();
                    break;
                }
                case _PHASE_MAIN:
                {
                    this.initPhaseMain();
                    break;
                }
                case _PHASE_CLOSE:
                {
                    this.initPhaseClose();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function control(param1:Number) : void
        {
            switch(this._phase)
            {
                case _PHASE_MAIN:
                {
                    this.controlPhaseMain(param1);
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (this._fade)
            {
                this._fade.control(param1);
            }
            return;
        }// end function

        private function initPhaseOpen() : void
        {
            this._fade.setFadeOut(Constant.FADE_OUT_TIME);
            this.btnEnable(false);
            this._isoMain.setIn(function () : void
            {
                if (_cbOpen != null)
                {
                    _cbOpen();
                }
                setPhase(_PHASE_MAIN);
                return;
            }// end function
            );
            return;
        }// end function

        private function initPhaseMain() : void
        {
            this.btnEnable(true);
            return;
        }// end function

        private function controlPhaseMain(param1:Number) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            if (this._skillSimpleStatus)
            {
                _loc_2 = null;
                _loc_3 = null;
                _loc_4 = 0;
                _loc_5 = 0;
                while (_loc_5 < this._aSkillList.length)
                {
                    
                    _loc_2 = this._aSkillList[_loc_5];
                    if (_loc_2.isHitTest())
                    {
                        _loc_3 = _loc_2.ownSkillData;
                        _loc_4 = _loc_5;
                        break;
                    }
                    _loc_5++;
                }
                if (this._overSkillData != _loc_3)
                {
                    this._overSkillData = _loc_3;
                    if (this._overSkillData != null && _loc_2.balloonAmbitNull != null)
                    {
                        if (this._type == SELECTER_TYPE_TIME)
                        {
                            SoundManager.getInstance().playSe(ButtonBase.SE_SELECT_ID);
                        }
                        this._skillSimpleStatus.setOwnSkillData(this._overSkillData);
                        _loc_6 = _loc_2.balloonAmbitNull;
                        _loc_7 = new Point(_loc_6.x, _loc_6.y + _loc_2.ambitOffs);
                        _loc_7 = _loc_6.parent.localToGlobal(_loc_7);
                        this._skillSimpleStatus.setPosition(_loc_7);
                        _loc_6 = _loc_2.balloonNull;
                        _loc_8 = new Point(_loc_6.x, _loc_6.y);
                        _loc_8 = _loc_6.parent.localToGlobal(_loc_8);
                        this._skillSimpleStatus.setArrowTargetPosition(_loc_8);
                        this._skillSimpleStatus.show();
                    }
                    else if (this._skillSimpleStatus.isShow())
                    {
                        this._skillSimpleStatus.hide();
                    }
                }
            }
            return;
        }// end function

        private function initPhaseClose() : void
        {
            this._fade.setFadeIn(Constant.FADE_IN_TIME);
            this.btnEnable(false);
            this._isoMain.setOut(function () : void
            {
                var _loc_1:* = null;
                if (_cbClose != null)
                {
                    if (_type == SELECTER_TYPE_SKILL)
                    {
                        if (_selectedIndex != -1)
                        {
                            _loc_1 = _aData[_selectedIndex] as OwnSkillData;
                            _cbClose(_loc_1, _selectedParam);
                        }
                        else
                        {
                            _cbClose(null, Constant.UNDECIDED);
                        }
                    }
                    else
                    {
                        _cbClose(_selectedIndex);
                    }
                }
                return;
            }// end function
            );
            return;
        }// end function

        private function btnEnable(param1:Boolean) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = null;
            this._btnClose.setDisableFlag(!param1);
            if (this._btnDecide)
            {
                this._btnDecide.setDisableFlag(!param1);
            }
            if (this._page)
            {
                this._page.btnDisable(!param1);
            }
            _loc_2 = 0;
            while (_loc_2 < this._aBtnList.length)
            {
                
                _loc_3 = this._aBtnList[_loc_2] as ButtonBase;
                _loc_3.setDisable(!param1 || !_loc_3.getMoveClip().visible);
                _loc_2++;
            }
            _loc_2 = 0;
            while (_loc_2 < this._aSkillList.length)
            {
                
                _loc_4 = this._aSkillList[_loc_2] as TrainingRoomSkillInfoButton;
                _loc_4.setDisable(!param1 || !_loc_4.getMoveClip().visible);
                _loc_2++;
            }
            return;
        }// end function

        private function updateList() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_4:* = 0;
            if (this._type == SELECTER_TYPE_PARAM)
            {
                _loc_4 = 0;
                while (_loc_4 < this._aBtnList.length)
                {
                    
                    _loc_5 = this._aBtnList[_loc_4] as ButtonBase;
                    if (_loc_4 < this._aData.length)
                    {
                        TextControl.setText(_loc_5.getMoveClip().contentText1Mc.textDt, this._aData[_loc_4] as String);
                        _loc_5.setDisable(false);
                        _loc_5.getMoveClip().visible = true;
                    }
                    else
                    {
                        _loc_5.setDisable(true);
                        _loc_5.getMoveClip().visible = false;
                    }
                    _loc_4++;
                }
            }
            else if (this._type == SELECTER_TYPE_SKILL)
            {
                _loc_2 = this._page.pageIndex * this._listCount;
                _loc_4 = 0;
                while (_loc_4 < this._aSkillList.length)
                {
                    
                    _loc_1 = this._aSkillList[_loc_4] as TrainingRoomSkillInfoButton;
                    _loc_3 = _loc_2 + _loc_4;
                    if (_loc_3 < this._aData.length)
                    {
                        _loc_1.setKumiteSkillData(this._aData[_loc_3] as OwnSkillData);
                        _loc_1.setDisable(false);
                        _loc_1.getMoveClip().visible = true;
                    }
                    else
                    {
                        _loc_1.setDisable(true);
                        _loc_1.getMoveClip().visible = false;
                    }
                    _loc_4++;
                }
            }
            else if (this._type == SELECTER_TYPE_TIME)
            {
                _loc_2 = this._page.pageIndex * this._listCount;
                _loc_4 = 0;
                while (_loc_4 < this._aSkillList.length)
                {
                    
                    _loc_1 = this._aSkillList[_loc_4] as TrainingRoomSkillInfoButton;
                    _loc_3 = _loc_2 + _loc_4;
                    if (_loc_3 < this._aData.length)
                    {
                        _loc_1.setTrainingSkillData(this._aData[_loc_3] as OwnSkillData);
                        _loc_1.setDisable(false);
                        _loc_1.getMoveClip().visible = true;
                    }
                    else
                    {
                        _loc_1.setDisable(true);
                        _loc_1.getMoveClip().visible = false;
                    }
                    _loc_4++;
                }
                _loc_6 = this._mcBase.listMc.TrainingDetailMc.DetailTextMc;
                _loc_7 = TrainingRoomTable.calcTrainingSkillNum(this._aData);
                TextControl.setText(_loc_6.TimeNum.textDt, TrainingRoomTable.getTrainingTimeText(this._pp, _loc_7));
                TextControl.setText(_loc_6.SkillNum.textDt, _loc_7.toString());
                TextControl.setText(_loc_6.CostNum.textDt2, TrainingRoomTable.getTrainingResourceNum(this._pp, _loc_7).toString());
            }
            return;
        }// end function

        private function cbCloseButton(param1:int) : void
        {
            this.setPhase(_PHASE_CLOSE);
            return;
        }// end function

        private function cbChangePage(param1:int, param2:int) : Boolean
        {
            this.updateList();
            return true;
        }// end function

        private function cbChangePage_AnimStart(param1:int, param2:int) : Boolean
        {
            this.btnEnable(false);
            switch(param2)
            {
                case PageButton.PAGE_BUTTON_ID_LEFT:
                case PageButton.PAGE_BUTTON_ID_LEFT_LEFT:
                case PageButton.PAGE_BUTTON_ID_LEFT_END:
                {
                    this._pageAnim.setRight(param1);
                    break;
                }
                case PageButton.PAGE_BUTTON_ID_RIGHT:
                case PageButton.PAGE_BUTTON_ID_RIGHT_RIGHT:
                case PageButton.PAGE_BUTTON_ID_RIGHT_END:
                {
                    this._pageAnim.setLeft(param1);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return false;
        }// end function

        private function cbPageAnimChange(param1:int) : void
        {
            this._page.changePage(param1);
            this.updateList();
            return;
        }// end function

        private function cbPageAnimEnd() : void
        {
            this.btnEnable(true);
            return;
        }// end function

        private function cbClickListButton(param1:int) : void
        {
            var _loc_2:* = 0;
            if (this._page)
            {
                _loc_2 = this._page.pageIndex * this._listCount;
            }
            this._selectedIndex = _loc_2 + param1;
            this.setPhase(_PHASE_CLOSE);
            return;
        }// end function

        private function cbClickListButton_Power(param1:int) : void
        {
            this._selectedParam = CommonConstant.TRAINING_ROOM_KUMITE_TYPE_POWER;
            this.cbClickListButton(param1);
            return;
        }// end function

        private function cbClickListButton_Hit(param1:int) : void
        {
            this._selectedParam = CommonConstant.TRAINING_ROOM_KUMITE_TYPE_HIT;
            this.cbClickListButton(param1);
            return;
        }// end function

        private function cbTrainingButton(param1:int) : void
        {
            this._selectedIndex = TrainingRoomTable.calcTrainingSkillNum(this._aData);
            this.setPhase(_PHASE_CLOSE);
            return;
        }// end function

    }
}
