package questSelect
{
    import area.*;
    import button.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import input.*;
    import message.*;
    import popup.*;
    import tutorial.*;
    import utility.*;
    import window.*;

    public class AreaQuestList extends Object
    {
        private var _phase:int;
        private var _sortButton:ButtonBase;
        private var _mc:MovieClip;
        private var _isoMain:InStayOut;
        private var _areaId:int;
        private var _aAreaQuest:Array;
        private var _aAreaQuestPrimarily:Array;
        private var _pageIndex:int;
        private var _aLine:Array;
        private var _aButton:Array;
        private var _sortWindow:WindowMenu;
        private var _sort:int;
        private var _cbInPage:Function;
        private var _cbOutPage:Function;
        private var _bTutorial:Boolean;
        private var _bTutorialStart:Boolean;
        private var _bBtnEnable:Boolean;
        private static const _BUTTON_INDEX_PREVIEW:int = 1;
        private static const _BUTTON_INDEX_PREVIEW_HI:int = 2;
        private static const _BUTTON_INDEX_NEXT:int = 3;
        private static const _BUTTON_INDEX_NEXT_HI:int = 4;
        private static const _PAGE_LINE_MAX:int = 5;
        private static const _LINE_WAIT:Number = 0.1;
        private static const _PHASE_LINE_WAIT:int = 0;
        private static const _PHASE_LINE_IN:int = 1;
        private static const _PHASE_LINE_OUT:int = 2;
        private static const _PHASE_LINE_OUT_END:int = 3;

        public function AreaQuestList(param1:MovieClip, param2:Function, param3:Function, param4:Function)
        {
            this._mc = param1;
            this._isoMain = new InStayOut(this._mc);
            this._aButton = new Array();
            this.createButton(this._mc.questListWindowMc.lpage1BtnMc, _BUTTON_INDEX_PREVIEW_HI);
            this.createButton(this._mc.questListWindowMc.lpage2BtnMc, _BUTTON_INDEX_PREVIEW);
            this.createButton(this._mc.questListWindowMc.rpage1BtnMc, _BUTTON_INDEX_NEXT_HI);
            this.createButton(this._mc.questListWindowMc.rpage2BtnMc, _BUTTON_INDEX_NEXT);
            this._aLine = new Array();
            this._aLine.push(new AreaQuestListInformation(this._mc.questListWindowMc.questList1Mc, param2, param3, param4));
            this._aLine.push(new AreaQuestListInformation(this._mc.questListWindowMc.questList2Mc, param2, param3, param4));
            this._aLine.push(new AreaQuestListInformation(this._mc.questListWindowMc.questList3Mc, param2, param3, param4));
            this._aLine.push(new AreaQuestListInformation(this._mc.questListWindowMc.questList4Mc, param2, param3, param4));
            this._aLine.push(new AreaQuestListInformation(this._mc.questListWindowMc.questList5Mc, param2, param3, param4));
            TextControl.setIdText(this._mc.questListWindowMc.questListTitleMc.textDt, MessageId.QUEST_LIST_NAME);
            this._sortButton = new ButtonBase(this._mc.questListWindowMc.sortBtnMc, this.cbSortClick, this.cbSortOver);
            ButtonManager.getInstance().addButtonBase(this._sortButton);
            this._sortButton.enterSeId = ButtonBase.SE_CURSOR_ID;
            this._sortButton.setDisable(true);
            this._bTutorial = false;
            this._bTutorialStart = false;
            InputManager.getInstance().addMouseCallback(this, null, this.cbMouseClick);
            return;
        }// end function

        public function get bSortWindowOpen() : Boolean
        {
            return this._sortWindow != null;
        }// end function

        public function get bOpen() : Boolean
        {
            return this._isoMain.bOpened;
        }// end function

        public function get bClose() : Boolean
        {
            return this._isoMain.bClosed;
        }// end function

        public function get bLineOpen() : Boolean
        {
            return this._phase == _PHASE_LINE_WAIT;
        }// end function

        public function get bLineClose() : Boolean
        {
            return this._phase == _PHASE_LINE_OUT_END;
        }// end function

        public function set bTutorial(param1:Boolean) : void
        {
            this._bTutorial = param1;
            return;
        }// end function

        public function get bBtnEnable() : Boolean
        {
            return this._bBtnEnable;
        }// end function

        public function setPageCallback(param1:Function, param2:Function) : void
        {
            this._cbInPage = param1;
            this._cbOutPage = param2;
            return;
        }// end function

        public function release() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            InputManager.getInstance().delMouseCallback(this);
            for each (_loc_1 in this._aButton)
            {
                
                ButtonManager.getInstance().removeButton(_loc_1);
            }
            this._aButton = null;
            if (this._sortButton)
            {
                ButtonManager.getInstance().removeArray(this._sortButton);
                this._sortButton.release();
            }
            for each (_loc_2 in this._aLine)
            {
                
                _loc_2.release();
            }
            this._aLine = null;
            if (this._mc)
            {
                if (this._mc.parent)
                {
                    this._mc.parent.removeChild(this._mc);
                }
            }
            this._mc = null;
            return;
        }// end function

        private function createButton(param1:MovieClip, param2:int) : void
        {
            var _loc_3:* = new ButtonBase(param1, this.cbPageChangeBtn);
            _loc_3.setId(param2);
            _loc_3.enterSeId = ButtonBase.SE_CURSOR_ID;
            this._aButton.push(_loc_3);
            return;
        }// end function

        private function switchButtonOn(param1:Boolean) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = false;
            var _loc_2:* = this._pageIndex * _PAGE_LINE_MAX;
            for each (_loc_3 in this._aButton)
            {
                
                _loc_4 = false;
                switch(_loc_3.id)
                {
                    case _BUTTON_INDEX_PREVIEW_HI:
                    case _BUTTON_INDEX_PREVIEW:
                    {
                        if (param1)
                        {
                            _loc_4 = _loc_2 > 0;
                        }
                        break;
                    }
                    case _BUTTON_INDEX_NEXT_HI:
                    case _BUTTON_INDEX_NEXT:
                    {
                        if (param1 && this._aAreaQuest)
                        {
                            _loc_4 = _loc_2 + _PAGE_LINE_MAX < this._aAreaQuest.length;
                        }
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                _loc_3.setDisable(_loc_4 == false);
            }
            if (param1)
            {
                ButtonManager.getInstance().updateHit();
            }
            return;
        }// end function

        public function control(param1:Number) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = false;
            var _loc_4:* = null;
            var _loc_5:* = false;
            var _loc_6:* = null;
            for each (_loc_2 in this._aLine)
            {
                
                _loc_2.control(param1);
            }
            switch(this._phase)
            {
                case _PHASE_LINE_WAIT:
                {
                    if (!this._bTutorial && TutorialManager.getInstance().isTutorial())
                    {
                        if (!CommonPopup.isUse() && this._bTutorialStart)
                        {
                            this._bTutorial = true;
                            TutorialManager.getInstance().setTutorialArrow((this._aLine[0] as AreaQuestListInformation).mc.hitNullMc, TutorialManager.TUTORIAL_ARROW_DIRECTION_RIGHT);
                            TutorialManager.getInstance().setTutorialBalloon(MessageManager.getInstance().getMessage(MessageId.TUTORIAL_BALLOON_QUEST_SELECT_001), TutorialManager.TUTORIAL_BALLOON_POS_BOTTOM);
                        }
                    }
                    break;
                }
                case _PHASE_LINE_IN:
                {
                    _loc_3 = true;
                    for each (_loc_4 in this._aLine)
                    {
                        
                        if (_loc_4.isQuestFound() && _loc_4.bOpen == false)
                        {
                            _loc_3 = false;
                            break;
                        }
                    }
                    if (_loc_3)
                    {
                        this.switchButtonOn(true);
                        this.switchSortButton(false);
                        for each (_loc_4 in this._aLine)
                        {
                            
                            if (_loc_4.isQuestFound() && _loc_4.isSelect())
                            {
                                _loc_4.setHitEnable();
                            }
                        }
                        this.setPhase(_PHASE_LINE_WAIT);
                    }
                    break;
                }
                case _PHASE_LINE_OUT:
                {
                    _loc_5 = true;
                    for each (_loc_6 in this._aLine)
                    {
                        
                        if (_loc_6.isQuestFound() && _loc_6.bClose == false)
                        {
                            _loc_5 = false;
                            break;
                        }
                    }
                    if (_loc_5)
                    {
                        this.setPhase(_PHASE_LINE_OUT_END);
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function setPhase(param1:int) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            this._phase = param1;
            switch(this._phase)
            {
                case _PHASE_LINE_WAIT:
                {
                    break;
                }
                case _PHASE_LINE_IN:
                {
                    _loc_2 = 0;
                    while (_loc_2 < _PAGE_LINE_MAX)
                    {
                        
                        _loc_3 = this._aLine[_loc_2];
                        _loc_5 = null;
                        _loc_4 = this._pageIndex * _PAGE_LINE_MAX + _loc_2;
                        if (_loc_4 <= this._aAreaQuest.length)
                        {
                            _loc_5 = this._aAreaQuest[_loc_4];
                        }
                        _loc_3.setIn(_loc_5, _loc_2 * _LINE_WAIT);
                        if (_loc_5 != null)
                        {
                        }
                        _loc_2++;
                    }
                    this.updatePageCount();
                    if (this._cbInPage != null)
                    {
                        this._cbInPage();
                    }
                    break;
                }
                case _PHASE_LINE_OUT:
                {
                    this.switchButtonOn(false);
                    this.switchSortButton(true);
                    _loc_2 = 0;
                    while (_loc_2 < _PAGE_LINE_MAX)
                    {
                        
                        _loc_3 = this._aLine[_loc_2];
                        _loc_4 = this._pageIndex * _PAGE_LINE_MAX + _loc_2;
                        _loc_3.setOut(_loc_2 * _LINE_WAIT);
                        _loc_2++;
                    }
                    if (this._cbOutPage != null)
                    {
                        this._cbOutPage();
                    }
                    break;
                }
                case _PHASE_LINE_OUT_END:
                {
                    this.setPhase(_PHASE_LINE_IN);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function getQuestLIst() : Array
        {
            var _loc_1:* = this._aAreaQuest.concat();
            _loc_1 = _loc_1.splice(this._pageIndex * _PAGE_LINE_MAX, 5);
            return _loc_1;
        }// end function

        private function updatePageCount() : void
        {
            var _loc_1:* = this._aAreaQuest.length / _PAGE_LINE_MAX;
            if (this._aAreaQuest.length % _PAGE_LINE_MAX > 0)
            {
                _loc_1++;
            }
            var _loc_2:* = new NumericNumberMc(this._mc.questListWindowMc.pageNumTextMc.pageNum2, (this._pageIndex + 1), 0, false);
            var _loc_3:* = new NumericNumberMc(this._mc.questListWindowMc.pageNumTextMc.pageNum1, _loc_1 > 0 ? (_loc_1) : (1), 0, false);
            return;
        }// end function

        public function setIn(param1:int, param2:Array) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            this._areaId = param1;
            this._aAreaQuestPrimarily = param2.concat();
            this._aAreaQuest = this._aAreaQuestPrimarily.concat();
            this.questSort(AreaQuestSort.getInstance().sortId);
            for each (_loc_3 in this._aButton)
            {
                
                ButtonManager.getInstance().addButtonBase(_loc_3);
            }
            _loc_4 = AreaManager.getInstance().getArea(param1);
            TextControl.setText(this._mc.questListWindowMc.areaNameTextMc.textDt, _loc_4.name);
            this.switchButtonOn(false);
            this.switchSortButton(true);
            this.updatePageCount();
            this._sortButton.setDisable(false);
            this._isoMain.setIn(this.cbIn);
            return;
        }// end function

        private function cbIn() : void
        {
            this._pageIndex = 0;
            this.setPhase(_PHASE_LINE_IN);
            this._bTutorialStart = true;
            return;
        }// end function

        public function setOut() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            for each (_loc_1 in this._aLine)
            {
                
                _loc_1.removeEvent();
            }
            for each (_loc_2 in this._aButton)
            {
                
                ButtonManager.getInstance().removeArray(_loc_2);
            }
            if (this._cbOutPage != null)
            {
                this._cbOutPage();
            }
            this._sortButton.setDisable(true);
            this._isoMain.setOut(this.cbOut);
            return;
        }// end function

        private function cbOut() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aLine)
            {
                
                _loc_1.setEnd();
            }
            return;
        }// end function

        public function setLineIn() : void
        {
            this.setPhase(_PHASE_LINE_IN);
            return;
        }// end function

        private function cbPageChangeBtn(param1:int) : void
        {
            var _loc_2:* = 0;
            switch(param1)
            {
                case _BUTTON_INDEX_PREVIEW_HI:
                {
                    this._pageIndex = 0;
                    break;
                }
                case _BUTTON_INDEX_PREVIEW:
                {
                    var _loc_3:* = this;
                    var _loc_4:* = this._pageIndex - 1;
                    _loc_3._pageIndex = _loc_4;
                    break;
                }
                case _BUTTON_INDEX_NEXT_HI:
                {
                    _loc_2 = this._aAreaQuest.length;
                    this._pageIndex = _loc_2 / _PAGE_LINE_MAX - 1;
                    if (_loc_2 % _PAGE_LINE_MAX > 0)
                    {
                        var _loc_3:* = this;
                        var _loc_4:* = this._pageIndex + 1;
                        _loc_3._pageIndex = _loc_4;
                    }
                    break;
                }
                case _BUTTON_INDEX_NEXT:
                {
                    var _loc_3:* = this;
                    var _loc_4:* = this._pageIndex + 1;
                    _loc_3._pageIndex = _loc_4;
                    break;
                }
                default:
                {
                    break;
                }
            }
            this.setPhase(_PHASE_LINE_OUT);
            return;
        }// end function

        public function setSelectLine(param1:int) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aLine)
            {
                
                if (_loc_2.quest != null && _loc_2.quest.no == param1)
                {
                    _loc_2.setMouseOverDisplay();
                    break;
                }
            }
            return;
        }// end function

        public function setNotSelectLine(param1:int) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aLine)
            {
                
                if (_loc_2.quest != null && _loc_2.quest.no == param1)
                {
                    _loc_2.setMouseOutDisplay();
                    break;
                }
            }
            return;
        }// end function

        public function setLineEnabe(param1:Boolean) : void
        {
            var _loc_2:* = null;
            this._bBtnEnable = param1;
            for each (_loc_2 in this._aLine)
            {
                
                _loc_2.bEnable = param1;
            }
            this.switchButtonOn(param1);
            this.switchSortButton(param1 == false);
            return;
        }// end function

        private function switchSortButton(param1:Boolean) : void
        {
            if (this._sortButton)
            {
                this._sortButton.setDisableFlag(param1);
            }
            return;
        }// end function

        private function cbSortOver(param1:int) : void
        {
            return;
        }// end function

        private function cbSortClick(param1:int) : void
        {
            if (this._sortWindow)
            {
                WindowManager.getInstance().removeWindow(this._sortWindow);
            }
            this._sortWindow = null;
            ButtonManager.getInstance().push();
            this.setLineEnabe(false);
            var _loc_2:* = [new WindowTextButton(AreaQuestSort.getSortTitle(AreaQuestSort.SORT_ID_DIFICALTY_UP), this.cbSortMenuClick, AreaQuestSort.SORT_ID_DIFICALTY_UP), new WindowTextButton(AreaQuestSort.getSortTitle(AreaQuestSort.SORT_ID_DIFICALTY_DOWN), this.cbSortMenuClick, AreaQuestSort.SORT_ID_DIFICALTY_DOWN), new WindowTextButton(AreaQuestSort.getSortTitle(AreaQuestSort.SORT_ID_NEW_QUEST), this.cbSortMenuClick, AreaQuestSort.SORT_ID_NEW_QUEST), new WindowTextButton(AreaQuestSort.getSortTitle(AreaQuestSort.SORT_ID_CLEAR_QUEST), this.cbSortMenuClick, AreaQuestSort.SORT_ID_CLEAR_QUEST), new WindowTextButton(AreaQuestSort.getSortTitle(AreaQuestSort.SORT_ID_NAME), this.cbSortMenuClick, AreaQuestSort.SORT_ID_NAME), new WindowTextButton(AreaQuestSort.getSortTitle(AreaQuestSort.SORT_ID_CLEAR_COUNT_MANY), this.cbSortMenuClick, AreaQuestSort.SORT_ID_CLEAR_COUNT_MANY), new WindowTextButton(AreaQuestSort.getSortTitle(AreaQuestSort.SORT_ID_CLEAR_COUNT_SMALL), this.cbSortMenuClick, AreaQuestSort.SORT_ID_CLEAR_COUNT_SMALL), new WindowTextButton(AreaQuestSort.getSortTitle(AreaQuestSort.SORT_ID_RATE_MANY), this.cbSortMenuClick, AreaQuestSort.SORT_ID_RATE_MANY), new WindowTextButton(AreaQuestSort.getSortTitle(AreaQuestSort.SORT_ID_RATE_SMALL), this.cbSortMenuClick, AreaQuestSort.SORT_ID_RATE_SMALL)];
            var _loc_3:* = new WindowStyle();
            this._sortWindow = WindowManager.getInstance().createMenuWindow(Main.GetProcess(), _loc_2, _loc_3, new Point(800, 180));
            return;
        }// end function

        private function questSort(param1:int) : Boolean
        {
            this.setSortText(param1);
            this._sort = param1;
            AreaQuestSort.getInstance().sortId = this._sort;
            this._aAreaQuest = AreaQuestSort.sortAreaQuest(this._aAreaQuestPrimarily, this._sort, this._areaId);
            Main.GetApplicationData().userConfigData.questSortType = this._sort;
            Main.GetApplicationData().userConfigData.save();
            this._pageIndex = 0;
            return true;
        }// end function

        private function setSortText(param1:int) : void
        {
            TextControl.setText(this._mc.questListWindowMc.sortTextMc.textDt, AreaQuestSort.getSortTitle(param1));
            return;
        }// end function

        private function cbMouseClick(event:MouseEvent) : void
        {
            if (this._sortWindow)
            {
                if (!this._sortWindow.hitTestPoint(event.stageX, event.stageY) && !this._sortButton.getHitMoveClip().hitTestPoint(event.stageX, event.stageY))
                {
                    WindowManager.getInstance().removeWindow(this._sortWindow);
                    ButtonManager.getInstance().pop();
                    this.setLineEnabe(true);
                    this._sortWindow = null;
                    return;
                }
            }
            return;
        }// end function

        private function cbSortMenuClick(param1:int) : void
        {
            if (this._sortWindow)
            {
                WindowManager.getInstance().removeWindow(this._sortWindow);
            }
            this._sortWindow = null;
            ButtonManager.getInstance().pop();
            this.setLineEnabe(true);
            if (param1 == this._sort)
            {
                return;
            }
            var _loc_2:* = this.questSort(param1);
            if (_loc_2)
            {
                this.setPhase(_PHASE_LINE_OUT);
            }
            return;
        }// end function

    }
}
