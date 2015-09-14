package formationSettings
{
    import balloon.*;
    import button.*;
    import flash.display.*;
    import flash.geom.*;
    import formation.*;
    import message.*;
    import resource.*;

    public class FormationSelecter extends Object
    {
        private var _mcBase:MovieClip;
        private var _aFormationInfoAll:Array;
        private var _aFormationNewFlgAll:Array;
        private var _aFormationInfo:Array;
        private var _aFormationNewFlg:Array;
        private var _aFormationButton:Array;
        private var _aMcNewFormation:Array;
        private var _aFormationMc:Array;
        private var _tabList:TabList;
        private var _tabId:int;
        private var _page:PageButton;
        private var _pageIndex:int;
        private var _selectFormationId:int;
        private var _bScroll:Boolean;
        private var _nextPage:int;
        private var _bTabScroll:Boolean;
        private var _nextTab:int;
        private var _cbSelectFunc:Function;
        private var _numPlayer:int;
        private var _numIcon:int;
        private var _numBtn:int;
        private var _bBtnEnable:Boolean;
        private var _aBalloon:Array;
        private var _bBalloonCreated:Boolean;
        private static const _BALLOON_WAIT:Number = 0.1;
        private static const _LABEL_PAGE_STAY:String = "inStay";
        private static const _LABEL_PAGE_LEFT_OUT:String = "leftOut";
        private static const _LABEL_PAGE_LEFT_OUT_END:String = "leftOutEnd";
        private static const _LABEL_PAGE_LEFT_IN:String = "leftIn";
        private static const _LABEL_PAGE_LEFT_IN_END:String = "leftInEnd";
        private static const _LABEL_PAGE_RIGHT_OUT:String = "rhigtOut";
        private static const _LABEL_PAGE_RIGHT_OUT_END:String = "rhigtOutEnd";
        private static const _LABEL_PAGE_RIGHT_IN:String = "rightIn";
        private static const _LABEL_PAGE_RIGHT_IN_END:String = "rightInEnd";
        private static const _LABEL_TAB_DOWN_OUT:String = "DownOut";
        private static const _LABEL_TAB_DOWN_OUT_END:String = "DownOutEnd";
        private static const _LABEL_TAB_DOWN_IN:String = "DownIn";
        private static const _LABEL_TAB_DOWN_IN_END:String = "DownInEnd";
        private static const _TAB_FORMATION_5:int = 5;
        private static const _TAB_FORMATION_4:int = 4;
        private static const _TAB_FORMATION_3:int = 3;
        private static const _TAB_FORMATION_2:int = 2;
        private static const _TAB_FORMATION_1:int = 1;

        public function FormationSelecter(param1:MovieClip, param2:Array, param3:int, param4:int, param5:Function, param6:String = null)
        {
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = null;
            this._mcBase = param1;
            this._cbSelectFunc = param5;
            this._numPlayer = param4;
            this._numIcon = this._mcBase.formationPageMc.formationWakusMc.numChildren;
            this._numBtn = this._numIcon - 2;
            this._bBtnEnable = false;
            this._aBalloon = [];
            this._bBalloonCreated = false;
            this._tabId = Constant.EMPTY_ID;
            this._nextTab = Constant.EMPTY_ID;
            this._pageIndex = Constant.UNDECIDED;
            this._nextPage = Constant.UNDECIDED;
            this._aFormationInfoAll = [];
            this._aFormationNewFlgAll = [];
            this._aFormationInfo = [];
            this._aFormationNewFlg = [];
            for each (_loc_7 in param2)
            {
                
                _loc_10 = FormationManager.getInstance().getFormationInformation(_loc_7.formationId);
                if (_loc_10 != null)
                {
                    this._aFormationInfoAll.push(_loc_10);
                    this._aFormationNewFlgAll.push(_loc_7.bNew);
                }
            }
            _loc_8 = this._mcBase.formationPageMc.formationWakusMc;
            this._aFormationMc = [];
            _loc_9 = 0;
            while (_loc_9 < this._numIcon)
            {
                
                this._aFormationMc.push(_loc_8.getChildByName("formationWakuMc" + _loc_9));
                _loc_9++;
            }
            this._aFormationButton = [];
            this._aMcNewFormation = [];
            _loc_9 = 0;
            while (_loc_9 < this._numBtn)
            {
                
                param1 = _loc_8.getChildByName("formationWakuMc" + (_loc_9 + 1)) as MovieClip;
                _loc_11 = new ButtonBase(param1.formationSelectMc, this.cbSelectFormation);
                _loc_11.setId(_loc_9);
                _loc_11.enterSeId = ButtonBase.SE_CURSOR_ID;
                _loc_12 = param1.formationSelectMc.formationMousOverMc.getChildAt(0);
                _loc_11.setHitMovieClip(_loc_12);
                ButtonManager.getInstance().addButtonBase(_loc_11);
                this._aFormationButton.push(_loc_11);
                if (param6)
                {
                    _loc_13 = ResourceManager.getInstance().createMovieClip(param6, "newIconMc");
                    _loc_8.parent.parent.addChild(_loc_13);
                    _loc_14 = param1.localToGlobal(new Point());
                    _loc_15 = _loc_13.localToGlobal(new Point());
                    _loc_13.x = _loc_14.x - _loc_15.x;
                    _loc_13.y = _loc_14.y - _loc_15.y;
                    this._aMcNewFormation.push(_loc_13);
                }
                _loc_9++;
            }
            this._tabList = new TabList(this.cbChangeTab);
            this._tabList.addTab(this._mcBase.TabBtn01, MessageManager.getInstance().getMessage(MessageId.COMMON_FORMATION5), _TAB_FORMATION_5);
            this._tabList.addTab(this._mcBase.TabBtn02, MessageManager.getInstance().getMessage(MessageId.COMMON_FORMATION4), _TAB_FORMATION_4);
            this._tabList.addTab(this._mcBase.TabBtn03, MessageManager.getInstance().getMessage(MessageId.COMMON_FORMATION3), _TAB_FORMATION_3);
            this._tabList.addTab(this._mcBase.TabBtn04, MessageManager.getInstance().getMessage(MessageId.COMMON_FORMATION2), _TAB_FORMATION_2);
            this._tabList.addTab(this._mcBase.TabBtn05, MessageManager.getInstance().getMessage(MessageId.COMMON_FORMATION1), _TAB_FORMATION_1);
            this._page = new PageButton(this._mcBase, this.cbChangePage, 0, Math.ceil(this._aFormationInfo.length / this._numBtn));
            if (this._mcBase.formationChangeTitleMc)
            {
                TextControl.setIdText(this._mcBase.formationChangeTitleMc.textDt, MessageId.FORMATION_FORMATION_CHANGE);
            }
            this.selectFormation(param3);
            this.updateNewIcon();
            this.setDisableFlag(true);
            return;
        }// end function

        public function release() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            for each (_loc_1 in this._aBalloon)
            {
                
                BalloonManager.getInstance().removeBalloon(_loc_1);
            }
            this._aBalloon = null;
            for each (_loc_2 in this._aFormationButton)
            {
                
                ButtonManager.getInstance().removeButton(_loc_2);
            }
            this._aFormationButton = null;
            for each (_loc_3 in this._aMcNewFormation)
            {
                
                if (_loc_3 && _loc_3.parent)
                {
                    _loc_3.parent.removeChild(_loc_3);
                }
            }
            this._aMcNewFormation = null;
            if (this._page)
            {
                this._page.release();
            }
            this._page = null;
            if (this._tabList)
            {
                this._tabList.release();
            }
            this._tabList = null;
            if (this._mcBase && this._mcBase.parent)
            {
                this._mcBase.parent.removeChild(this._mcBase);
            }
            this._mcBase = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            if (this._bBalloonCreated == false && this._bBtnEnable)
            {
                _loc_2 = 0;
                while (_loc_2 < this._numBtn)
                {
                    
                    _loc_3 = this._aFormationMc[(_loc_2 + 1)];
                    _loc_4 = _loc_3.formationSelectMc.formationMousOverMc.getChildAt(0);
                    _loc_5 = new BalloonNormal(this._mcBase.parent.parent, _loc_4, _loc_3.balloonNull);
                    _loc_5.setPos((_loc_3.balloonNull as MovieClip).localToGlobal(new Point()));
                    BalloonManager.getInstance().addBalloon(_loc_5);
                    this._aBalloon.push(_loc_5);
                    _loc_2++;
                }
                this._bBalloonCreated = true;
                this.updateFormationSelectButton();
            }
            if (this._bScroll)
            {
                switch(this._mcBase.formationPageMc.currentLabel)
                {
                    case _LABEL_PAGE_LEFT_OUT_END:
                    {
                        this._mcBase.formationPageMc.gotoAndPlay(_LABEL_PAGE_LEFT_IN);
                        this.setFormationPage(this._nextPage);
                        break;
                    }
                    case _LABEL_PAGE_RIGHT_OUT_END:
                    {
                        this._mcBase.formationPageMc.gotoAndPlay(_LABEL_PAGE_RIGHT_IN);
                        this.setFormationPage(this._nextPage);
                        break;
                    }
                    case _LABEL_PAGE_RIGHT_IN_END:
                    case _LABEL_PAGE_LEFT_IN_END:
                    {
                        this._mcBase.formationPageMc.gotoAndPlay(_LABEL_PAGE_STAY);
                        this._bScroll = false;
                        this._nextPage = Constant.UNDECIDED;
                        this.setDisableFlag(false);
                        this.updateNewIcon();
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            if (this._bTabScroll)
            {
                switch(this._mcBase.formationPageMc.currentLabel)
                {
                    case _LABEL_TAB_DOWN_OUT_END:
                    {
                        this._mcBase.formationPageMc.gotoAndPlay(_LABEL_TAB_DOWN_IN);
                        this.setFormationFilter(this._nextTab);
                        this.setFormationPage(this._nextPage);
                        break;
                    }
                    case _LABEL_TAB_DOWN_IN_END:
                    {
                        this._mcBase.formationPageMc.gotoAndPlay(_LABEL_PAGE_STAY);
                        this._bTabScroll = false;
                        this._nextTab = Constant.EMPTY_ID;
                        this._nextPage = Constant.UNDECIDED;
                        this.setDisableFlag(false);
                        ButtonManager.getInstance().updateHit();
                        this.updateNewIcon();
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

        public function setDisableFlag(param1:Boolean) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            this._bBtnEnable = !param1;
            if (this._bBtnEnable)
            {
                this.updateFormationSelectButton();
            }
            else
            {
                for each (_loc_2 in this._aFormationButton)
                {
                    
                    _loc_2.setDisableFlag(!this._bBtnEnable);
                }
                for each (_loc_3 in this._aBalloon)
                {
                    
                    _loc_3.bEnable = this._bBtnEnable;
                }
            }
            this._page.btnEnable(this._bBtnEnable);
            this._tabList.btnEnable(this._bBtnEnable);
            return;
        }// end function

        public function setNumPlayer(param1:int) : void
        {
            this._numPlayer = param1;
            this.updateFormationSelectButton();
            return;
        }// end function

        public function selectFormation(param1:int) : void
        {
            this._selectFormationId = param1;
            var _loc_2:* = this.getTabIdAtFormationId(this._selectFormationId);
            this._tabList.changeTabId(_loc_2);
            this.setFormationFilter(_loc_2);
            this.setFormationPage(this.getPageIndexAtFormationId(this._selectFormationId));
            return;
        }// end function

        private function setFormationFilter(param1:int) : void
        {
            var _loc_4:* = null;
            if (this._tabId == param1)
            {
                return;
            }
            this._tabId = param1;
            this._aFormationInfo = [];
            this._aFormationNewFlg = [];
            var _loc_2:* = this._aFormationInfoAll.length;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = this._aFormationInfoAll[_loc_3];
                if (_loc_4.member == param1)
                {
                    this._aFormationInfo.push(_loc_4);
                    this._aFormationNewFlg.push(this._aFormationNewFlgAll[_loc_3]);
                }
                _loc_3++;
            }
            this._pageIndex = Constant.UNDECIDED;
            this._page.setPage(0, Math.ceil(this._aFormationInfo.length / this._numBtn));
            return;
        }// end function

        private function setFormationPage(param1:int) : void
        {
            if (this._pageIndex == param1)
            {
                return;
            }
            this._pageIndex = param1;
            this.updateFormationSelectButton();
            this._page.changePage(this._pageIndex);
            return;
        }// end function

        private function updateFormationSelectButton() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = false;
            var _loc_6:* = null;
            var _loc_7:* = false;
            var _loc_8:* = null;
            var _loc_1:* = 0;
            while (_loc_1 < this._numIcon)
            {
                
                _loc_2 = this._aFormationMc[_loc_1];
                _loc_3 = null;
                _loc_4 = this._pageIndex * this._numBtn + _loc_1 - 1;
                _loc_5 = false;
                if (_loc_4 >= 0 && _loc_4 < this._aFormationInfo.length)
                {
                    _loc_3 = this._aFormationInfo[_loc_4];
                }
                if (_loc_3 != null)
                {
                    _loc_2.visible = true;
                    _loc_2.formationSelectMc.formationMousOverMc.formationsMc.gotoAndStop("formation" + _loc_3.id);
                    _loc_2.gotoAndStop(this._selectFormationId == _loc_3.id ? ("on") : ("off"));
                }
                else
                {
                    _loc_2.visible = false;
                }
                if (_loc_1 > 0 && _loc_1 <= this._numBtn)
                {
                    _loc_6 = this._aFormationButton[(_loc_1 - 1)];
                    _loc_7 = _loc_3 == null || this._numPlayer > _loc_3.member;
                    _loc_6.setDisable(_loc_7);
                    _loc_6.setDisableFlag(!this._bBtnEnable || _loc_7);
                    if (this._bBalloonCreated)
                    {
                        _loc_8 = this._aBalloon[(_loc_1 - 1)] as BalloonNormal;
                        if (_loc_7)
                        {
                            _loc_8.setMessage(MessageManager.getInstance().getMessage(MessageId.FORMATION_OVER_FORMATION_NUMBER));
                            _loc_8.setBalloonType(BalloonNormal.TYPE_MIDDLE_U2);
                        }
                        else
                        {
                            if (_loc_3)
                            {
                                _loc_8.setMessage(_loc_3.name);
                            }
                            _loc_8.setBalloonType(BalloonNormal.TYPE_MIDDLE_U1);
                        }
                        _loc_8.bEnable = this._bBtnEnable && _loc_3 != null;
                    }
                }
                if (_loc_1 == 0 || _loc_1 >= (this._numIcon - 1))
                {
                    _loc_2.formationSelectMc.gotoAndStop("disable");
                }
                _loc_1++;
            }
            return;
        }// end function

        private function updateNewIcon() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_1:* = 0;
            for each (_loc_2 in this._aMcNewFormation)
            {
                
                _loc_3 = this._pageIndex * this._numBtn + _loc_1;
                _loc_2.visible = this._bScroll ? (false) : (this._aFormationNewFlg[_loc_3]);
                _loc_1++;
            }
            return;
        }// end function

        private function getPageIndexAtFormationId(param1:int) : int
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_2:* = 0;
            while (_loc_2 < this._page.pageMax)
            {
                
                _loc_3 = 0;
                while (_loc_3 < this._numBtn)
                {
                    
                    _loc_4 = _loc_2 * this._numBtn + _loc_3;
                    if (_loc_4 >= 0 && _loc_4 < this._aFormationInfo.length)
                    {
                        _loc_5 = this._aFormationInfo[_loc_4];
                        if (_loc_5 != null && _loc_5.id == param1)
                        {
                            return _loc_2;
                        }
                    }
                    _loc_3++;
                }
                _loc_2++;
            }
            return 0;
        }// end function

        private function getTabIdAtFormationId(param1:int) : int
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aFormationInfoAll)
            {
                
                if (_loc_2 != null && _loc_2.id == param1)
                {
                    return _loc_2.member;
                }
            }
            return 0;
        }// end function

        private function cbSelectFormation(param1:int) : void
        {
            var _loc_2:* = this._pageIndex * this._numBtn;
            var _loc_3:* = _loc_2 + param1;
            var _loc_4:* = 0;
            while (_loc_4 < this._aFormationMc.length)
            {
                
                this._aFormationMc[_loc_4].gotoAndStop(_loc_2 + _loc_4 == (_loc_3 + 1) ? ("on") : ("off"));
                _loc_4++;
            }
            if (_loc_3 >= this._aFormationInfo.length)
            {
                return;
            }
            var _loc_5:* = this._aFormationInfo[_loc_3];
            this._selectFormationId = _loc_5.id;
            this._cbSelectFunc(this._selectFormationId);
            return;
        }// end function

        private function cbChangePage(param1:int, param2:int) : Boolean
        {
            var _loc_3:* = null;
            this._nextPage = param1;
            this._bScroll = true;
            this.setDisableFlag(true);
            for each (_loc_3 in this._aBalloon)
            {
                
                _loc_3.setClose();
            }
            switch(param2)
            {
                case PageButton.PAGE_BUTTON_ID_LEFT:
                case PageButton.PAGE_BUTTON_ID_LEFT_LEFT:
                case PageButton.PAGE_BUTTON_ID_LEFT_END:
                {
                    this._mcBase.formationPageMc.gotoAndPlay(_LABEL_PAGE_RIGHT_OUT);
                    break;
                }
                case PageButton.PAGE_BUTTON_ID_RIGHT:
                case PageButton.PAGE_BUTTON_ID_RIGHT_RIGHT:
                case PageButton.PAGE_BUTTON_ID_RIGHT_END:
                {
                    this._mcBase.formationPageMc.gotoAndPlay(_LABEL_PAGE_LEFT_OUT);
                    break;
                }
                default:
                {
                    break;
                }
            }
            this.updateNewIcon();
            return false;
        }// end function

        private function cbChangeTab(param1:int, param2:int) : Boolean
        {
            this._nextPage = 0;
            this._nextTab = param2;
            this._bTabScroll = true;
            this.setDisableFlag(true);
            this._mcBase.formationPageMc.gotoAndPlay(_LABEL_TAB_DOWN_OUT);
            return true;
        }// end function

    }
}
