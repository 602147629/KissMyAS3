package history
{
    import button.*;
    import flash.display.*;
    import message.*;
    import quest.*;
    import resource.*;

    public class HistoryList extends Object
    {
        private var _spr:Sprite;
        private var _baseMc:MovieClip;
        private var _scrollbar:HistoryScrollbar;
        private var _aBar:Array;
        private var _aListButton:Array;
        private var _aButton:Array;
        private var _aInfo:Array;
        private var _aDisplayInfo:Array;
        private var _nextChapterBtn:ButtonBase;
        private var _backChapterBtn:ButtonBase;
        private var _phase:int;
        private var _type:int;
        private var _chapter:int;
        private var _bScrollBar:Boolean;
        private var _targetX:Number;
        private var _targetY:Number;
        private var _barMoveY:Number;
        private var _moveX:Number;
        private var _moveY:Number;
        private var _topMax:Number;
        private var _bottomMax:Number;
        private var _leftMax:Number;
        private var _rightMax:Number;
        private var _displayTopMax:Number;
        private var _displayButtonMax:Number;
        private var _cbBarClick:Function;
        public static const TYPE_PAST_CYCLE:int = 1;
        public static const TYPE_NOW_CYCLE:int = 2;
        private static const PHASE_WAIT:int = 0;
        private static const PHASE_LIST_MOVE:int = 1;
        private static const PHASE_LIST_FADE_IN:int = 10;
        private static const PHASE_LIST_FADE_STAY:int = 11;
        private static const PHASE_LIST_FADE_OUT:int = 12;
        private static const BUTTON_LIST_UP:int = 1;
        private static const BUTTON_LIST_DOWN:int = 2;
        private static const BUTTON_LIST_ALL_UP:int = 3;
        private static const BUTTON_LIST_ALL_DOWN:int = 4;
        private static const BUTTON_CHAPTER_NEXT:int = 1;
        private static const BUTTON_CHAPTER_BACK:int = 2;
        private static const LIST_MOVE_X:int = 2;
        private static const LIST_MOVE_Y:int = 1;
        private static const DISPLAY_LIST_MAX:int = 5;

        public function HistoryList(param1:MovieClip, param2:Array, param3:Function)
        {
            this._baseMc = param1;
            this._aInfo = param2;
            this._cbBarClick = param3;
            this._spr = new Sprite();
            this._aBar = [];
            this._aListButton = [];
            this._aButton = [];
            this._scrollbar = new HistoryScrollbar(this._baseMc.ScrollBerSet, this.cbListMove);
            this._targetY = 0;
            this._chapter = 1;
            this._rightMax = this._baseMc.width;
            this._leftMax = -this._rightMax;
            if (this._baseMc.chronologicalWindNull0 != null)
            {
                this._baseMc.chronologicalWindNull1.addChild(this._spr);
                this._barMoveY = this._baseMc.chronologicalWindNull0.y - this._baseMc.chronologicalWindNull1.y;
                if (this._barMoveY < 0)
                {
                    this._barMoveY = this._barMoveY * -1;
                }
                this._type = TYPE_NOW_CYCLE;
                this._displayTopMax = -(this._barMoveY - 1);
                this._displayButtonMax = this._barMoveY * DISPLAY_LIST_MAX;
                this.createChronologyList();
            }
            else
            {
                this._baseMc.historyWindNull1.addChild(this._spr);
                this._barMoveY = this._baseMc.historyWindNull0.y - this._baseMc.historyWindNull1.y;
                if (this._barMoveY < 0)
                {
                    this._barMoveY = this._barMoveY * -1;
                }
                this._type = TYPE_PAST_CYCLE;
                this._displayTopMax = -(this._barMoveY - 1);
                this._displayButtonMax = this._barMoveY * DISPLAY_LIST_MAX;
                this.createChapterChange();
                this.createHistoryList();
                this.setChapter();
            }
            this.initList();
            this._scrollbar.updateMax(this._topMax, this._bottomMax);
            if ((this._aBar.length - 1) < DISPLAY_LIST_MAX)
            {
                this._scrollbar.setDisable(true);
            }
            return;
        }// end function

        public function release() : void
        {
            var _loc_1:* = null;
            this.removeList();
            if (this._scrollbar)
            {
                this._scrollbar.release();
            }
            this._scrollbar = null;
            this.removeButton();
            for each (_loc_1 in this._aButton)
            {
                
                _loc_1.release();
            }
            this._aButton = null;
            if (this._nextChapterBtn)
            {
                this._nextChapterBtn.release();
            }
            this._nextChapterBtn = null;
            if (this._backChapterBtn)
            {
                this._backChapterBtn.release();
            }
            this._backChapterBtn = null;
            if (this._baseMc && this._baseMc.parent != null)
            {
                this._baseMc.parent.removeChild(this._baseMc);
            }
            this._baseMc = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            switch(this._phase)
            {
                case PHASE_LIST_MOVE:
                {
                    this.controlListMove();
                    break;
                }
                case PHASE_LIST_FADE_IN:
                {
                    this.controlListFadeIn();
                    break;
                }
                case PHASE_LIST_FADE_STAY:
                {
                    this.controlListFadeStay();
                    break;
                }
                case PHASE_LIST_FADE_OUT:
                {
                    this.controlListFadeOut();
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (this._scrollbar)
            {
                this._scrollbar.updateMarkerPos(this._spr.y);
            }
            var _loc_2:* = 0;
            for each (_loc_3 in this._aBar)
            {
                
                _loc_4 = this._aListButton[_loc_2];
                if (_loc_3.y + this._spr.y < this._displayButtonMax && _loc_3.y + this._spr.y >= this._displayTopMax)
                {
                    _loc_3.visible = true;
                    _loc_4.setDisableFlag(false);
                }
                else
                {
                    _loc_3.visible = false;
                    _loc_4.setDisableFlag(true);
                }
                _loc_2++;
            }
            return;
        }// end function

        public function addButton() : void
        {
            var _loc_1:* = null;
            if ((this._aBar.length - 1) > DISPLAY_LIST_MAX)
            {
                this._scrollbar.setDisable(false);
            }
            for each (_loc_1 in this._aButton)
            {
                
                ButtonManager.getInstance().addButtonBase(_loc_1);
            }
            for each (_loc_1 in this._aListButton)
            {
                
                ButtonManager.getInstance().addButtonBase(_loc_1);
            }
            return;
        }// end function

        public function removeButton() : void
        {
            var _loc_1:* = null;
            if ((this._aBar.length - 1) > DISPLAY_LIST_MAX)
            {
                this._scrollbar.setDisable(true);
            }
            for each (_loc_1 in this._aButton)
            {
                
                ButtonManager.getInstance().removeArray(_loc_1);
            }
            for each (_loc_1 in this._aListButton)
            {
                
                ButtonManager.getInstance().removeArray(_loc_1);
            }
            return;
        }// end function

        public function setDisable(param1:Boolean) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aButton)
            {
                
                if (_loc_2)
                {
                    _loc_2.setDisableFlag(param1);
                }
            }
            for each (_loc_2 in this._aListButton)
            {
                
                if (_loc_2)
                {
                    _loc_2.setDisableFlag(param1);
                }
            }
            if ((this._aBar.length - 1) > DISPLAY_LIST_MAX)
            {
                this._scrollbar.setDisable(param1);
            }
            return;
        }// end function

        private function setPhase(param1:int) : void
        {
            if (this._phase != param1)
            {
                this._phase = param1;
                switch(this._phase)
                {
                    case PHASE_LIST_MOVE:
                    {
                        this.phaseListMove();
                        break;
                    }
                    case PHASE_LIST_FADE_IN:
                    {
                        this.phaseListFadeIn();
                        break;
                    }
                    case PHASE_LIST_FADE_STAY:
                    {
                        this.phaseListFadeStay();
                        break;
                    }
                    case PHASE_LIST_FADE_OUT:
                    {
                        this.phaseListFadeOut();
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

        private function phaseListMove() : void
        {
            return;
        }// end function

        private function controlListMove() : void
        {
            var _loc_1:* = false;
            this._moveY = this._moveY + (this._targetY > this._spr.y ? (LIST_MOVE_Y) : (-LIST_MOVE_Y));
            this._spr.y = this._spr.y + this._moveY;
            if (this._moveY > 0)
            {
                if (this._spr.y >= this._targetY)
                {
                    this._spr.y = this._targetY;
                    this._moveY = 0;
                    _loc_1 = true;
                }
            }
            else if (this._moveY < 0)
            {
                if (this._spr.y < this._targetY)
                {
                    this._spr.y = this._targetY;
                    this._moveY = 0;
                    _loc_1 = true;
                }
            }
            if (_loc_1)
            {
                this.setPhase(PHASE_WAIT);
            }
            return;
        }// end function

        private function phaseListFadeOut() : void
        {
            this._moveX = 0;
            return;
        }// end function

        private function controlListFadeOut() : void
        {
            var _loc_1:* = false;
            this._moveX = this._moveX + (this._targetX > this._spr.x ? (LIST_MOVE_X) : (-LIST_MOVE_X));
            this._spr.x = this._spr.x + this._moveX;
            if (this._moveX > 0)
            {
                if (this._spr.x >= this._targetX)
                {
                    this._spr.x = this._leftMax;
                    this._moveX = 0;
                    _loc_1 = true;
                }
            }
            else if (this._moveX < 0)
            {
                if (this._spr.x < this._targetX)
                {
                    this._spr.x = this._rightMax;
                    this._moveX = 0;
                    _loc_1 = true;
                }
            }
            if (_loc_1)
            {
                this.setPhase(PHASE_LIST_FADE_STAY);
            }
            return;
        }// end function

        private function phaseListFadeStay() : void
        {
            var _loc_1:* = null;
            this.removeList();
            this.createHistoryList();
            this.initList();
            if (this._scrollbar)
            {
                this._scrollbar.updateMax(this._topMax, this._bottomMax);
            }
            this.setChapter();
            for each (_loc_1 in this._aListButton)
            {
                
                ButtonManager.getInstance().addButtonBase(_loc_1);
            }
            return;
        }// end function

        private function controlListFadeStay() : void
        {
            this.setPhase(PHASE_LIST_FADE_IN);
            return;
        }// end function

        private function phaseListFadeIn() : void
        {
            this._targetX = 0;
            return;
        }// end function

        private function controlListFadeIn() : void
        {
            var _loc_1:* = false;
            this._moveX = this._moveX + (this._targetX > this._spr.x ? (LIST_MOVE_X) : (-LIST_MOVE_X));
            this._spr.x = this._spr.x + this._moveX;
            if (this._moveX > 0)
            {
                if (this._spr.x >= this._targetX)
                {
                    this._spr.x = this._targetX;
                    this._moveX = 0;
                    _loc_1 = true;
                }
            }
            else if (this._moveX < 0)
            {
                if (this._spr.x < this._targetX)
                {
                    this._spr.x = this._targetX;
                    this._moveX = 0;
                    _loc_1 = true;
                }
            }
            if (_loc_1)
            {
                this.setPhase(PHASE_WAIT);
            }
            return;
        }// end function

        private function setChapter() : void
        {
            if (this._baseMc.chapterTextMc == null)
            {
                return;
            }
            if (this._aBar.length > 0)
            {
                this._baseMc.chapterTextMc.gotoAndStop("usually");
            }
            else
            {
                this._baseMc.chapterTextMc.gotoAndStop("disable");
            }
            var _loc_1:* = MessageManager.getInstance().getMessage(MessageId.COMMON_CHAPTER);
            _loc_1 = _loc_1.replace("%d", this._chapter);
            TextControl.setText(this._baseMc.chapterTextMc.chapterText.textDt, _loc_1);
            var _loc_2:* = this.getChapterHistory((this._chapter + 1));
            if (_loc_2.length > 0)
            {
                this._backChapterBtn.setDisable(false);
            }
            else
            {
                this._backChapterBtn.setDisable(true);
            }
            _loc_2 = this.getChapterHistory((this._chapter - 1));
            if (_loc_2.length > 0)
            {
                this._nextChapterBtn.setDisable(false);
            }
            else
            {
                this._nextChapterBtn.setDisable(true);
            }
            if ((this._aBar.length - 1) < DISPLAY_LIST_MAX)
            {
                this._scrollbar.setDisable(true);
            }
            else
            {
                this._scrollbar.setDisable(false);
            }
            return;
        }// end function

        private function createChronologyList() : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            if (this._aBar.length > 0)
            {
                this.removeList();
            }
            this._aDisplayInfo = [];
            var _loc_1:* = 0;
            while (_loc_1 < this._aInfo.length)
            {
                
                _loc_3 = this._aInfo[_loc_1];
                _loc_4 = ResourceManager.getInstance().createMovieClip(ResourcePath.HOME_PATH + "UI_Chronology.swf", "chronologicalWindSetMc");
                if (_loc_3 != null)
                {
                    _loc_5 = new ButtonBase(_loc_4, this.cbBarClick);
                    _loc_5.setId(_loc_1);
                    _loc_5.enterSeId = ButtonBase.SE_CURSOR_ID;
                    this._aListButton.push(_loc_5);
                    this._aDisplayInfo.push(_loc_3);
                    if (_loc_3.clearCount == 0)
                    {
                        _loc_4.chronologicalWindMc.gotoAndStop("failure");
                    }
                    else
                    {
                        _loc_4.chronologicalWindMc.gotoAndStop("success");
                    }
                    TextControl.setAgYearText(_loc_4.chronologicalWindMc.questEra, _loc_4.chronologicalWindMc.questYear, _loc_3.year);
                    TextControl.setText(_loc_4.chronologicalWindMc.questDetailMc.textDt, _loc_3.questName);
                    this._aBar.push(_loc_4);
                }
                _loc_1++;
            }
            var _loc_2:* = this._aInfo.length > DISPLAY_LIST_MAX ? (this._aInfo.length - DISPLAY_LIST_MAX) : (0);
            this._topMax = -this._barMoveY * _loc_2;
            this._bottomMax = this._barMoveY * _loc_2 + this._barMoveY;
            this._bScrollBar = false;
            if (this._aBar.length > DISPLAY_LIST_MAX)
            {
                this._bScrollBar = true;
            }
            return;
        }// end function

        private function createHistoryList() : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            if (this._aBar.length > 0)
            {
                this.removeList();
            }
            this._aDisplayInfo = [];
            var _loc_1:* = this.getChapterHistory(this._chapter);
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1.length)
            {
                
                _loc_4 = _loc_1[_loc_2];
                if (_loc_4 != null)
                {
                    _loc_5 = ResourceManager.getInstance().createMovieClip(ResourcePath.HOME_PATH + "UI_Chronology.swf", "historyWindSetMc");
                    _loc_6 = new ButtonBase(_loc_5, this.cbBarClick);
                    _loc_6.setId(_loc_2);
                    _loc_6.enterSeId = ButtonBase.SE_CURSOR_ID;
                    this._aListButton.push(_loc_6);
                    this._aDisplayInfo.push(_loc_4);
                    _loc_7 = MessageManager.getInstance().getMessage(MessageId.HISTORY_CYCLE);
                    _loc_7 = _loc_7.replace("%d", _loc_4.cycle.toString());
                    TextControl.setText(_loc_5.historyWindMc.emperorYear.textDt, _loc_7);
                    TextControl.setText(_loc_5.historyWindMc.questDetailMc.textDt, _loc_4.questName);
                    _loc_8 = QuestManager.questRankLabel(_loc_4.achievementRate);
                    _loc_5.historyWindMc.resultRankMc.gotoAndStop(_loc_8);
                    this._aBar.push(_loc_5);
                }
                _loc_2++;
            }
            var _loc_3:* = this._aBar.length > DISPLAY_LIST_MAX ? (this._aBar.length - DISPLAY_LIST_MAX) : (0);
            this._topMax = -this._barMoveY * _loc_3;
            this._bottomMax = this._barMoveY * _loc_3 + this._barMoveY;
            this._bScrollBar = false;
            if (this._aBar.length > DISPLAY_LIST_MAX)
            {
                this._bScrollBar = true;
            }
            return;
        }// end function

        private function removeList() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            for each (_loc_1 in this._aBar)
            {
                
                if (_loc_1 != null && _loc_1.parent != null)
                {
                    _loc_1.parent.removeChild(_loc_1);
                }
            }
            this._aBar = [];
            for each (_loc_2 in this._aListButton)
            {
                
                ButtonManager.getInstance().removeArray(_loc_2);
                _loc_2.release();
            }
            this._aListButton = [];
            return;
        }// end function

        private function createChapterChange() : void
        {
            if (this._baseMc.pageBtnLeft1Mc == null || this._baseMc.pageBtnRight1Mc == null)
            {
                return;
            }
            this._nextChapterBtn = new ButtonBase(this._baseMc.pageBtnLeft1Mc, this.cbChapterChange);
            this._nextChapterBtn.setId(BUTTON_CHAPTER_BACK);
            this._nextChapterBtn.enterSeId = ButtonBase.SE_CURSOR_ID;
            this._aButton.push(this._nextChapterBtn);
            this._backChapterBtn = new ButtonBase(this._baseMc.pageBtnRight1Mc, this.cbChapterChange);
            this._backChapterBtn.setId(BUTTON_CHAPTER_NEXT);
            this._backChapterBtn.enterSeId = ButtonBase.SE_CURSOR_ID;
            this._aButton.push(this._backChapterBtn);
            return;
        }// end function

        private function initList() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = null;
            if (this._spr != null && this._aBar.length > 0)
            {
                this._spr.y = 0;
                this._targetY = 0;
                this._moveY = 0;
                _loc_1 = 0;
                while (_loc_1 < this._aBar.length)
                {
                    
                    _loc_2 = this._aBar[_loc_1];
                    _loc_2.y = this._barMoveY * _loc_1;
                    this._spr.addChild(_loc_2);
                    _loc_1++;
                }
            }
            return;
        }// end function

        private function getChapterHistory(param1:int) : Array
        {
            var _loc_4:* = null;
            var _loc_2:* = [];
            var _loc_3:* = 0;
            while (_loc_3 < this._aInfo.length)
            {
                
                _loc_4 = this._aInfo[_loc_3];
                if (_loc_4 != null && _loc_4.chapter == param1)
                {
                    _loc_2.push(_loc_4);
                }
                _loc_3++;
            }
            return _loc_2;
        }// end function

        private function cbBarClick(param1:int) : void
        {
            var _loc_2:* = null;
            if (this._aInfo[param1] != null && this._cbBarClick != null && this._phase == PHASE_WAIT)
            {
                for each (_loc_2 in this._aListButton)
                {
                    
                    _loc_2.getMoveClip().gotoAndStop("offMouse");
                }
                this._cbBarClick(this._aDisplayInfo[param1], this._type);
            }
            return;
        }// end function

        private function cbListMove(param1:int) : void
        {
            if (this._phase != PHASE_WAIT && this._phase != PHASE_LIST_MOVE)
            {
                return;
            }
            var _loc_2:* = this._targetY;
            switch(param1)
            {
                case HistoryScrollbar.BUTTON_LIST_UP:
                {
                    _loc_2 = _loc_2 - this._barMoveY;
                    break;
                }
                case HistoryScrollbar.BUTTON_LIST_DOWN:
                {
                    _loc_2 = _loc_2 + this._barMoveY;
                    break;
                }
                case HistoryScrollbar.BUTTON_LIST_ALL_UP:
                {
                    _loc_2 = -this._bottomMax;
                    break;
                }
                case HistoryScrollbar.BUTTON_LIST_ALL_DOWN:
                {
                    _loc_2 = 0;
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (_loc_2 < this._topMax)
            {
                _loc_2 = this._topMax;
            }
            if (_loc_2 > 0)
            {
                _loc_2 = 0;
            }
            this._targetY = _loc_2;
            this.setPhase(PHASE_LIST_MOVE);
            return;
        }// end function

        private function cbChapterChange(param1:int) : void
        {
            if (this._phase != PHASE_WAIT)
            {
                return;
            }
            if (param1 == BUTTON_CHAPTER_NEXT)
            {
                var _loc_2:* = this;
                var _loc_3:* = this._chapter + 1;
                _loc_2._chapter = _loc_3;
                this._targetX = this._leftMax;
                if (this._chapter > 4)
                {
                    this._chapter = 4;
                    this._targetX = 0;
                }
            }
            if (param1 == BUTTON_CHAPTER_BACK)
            {
                var _loc_2:* = this;
                var _loc_3:* = this._chapter - 1;
                _loc_2._chapter = _loc_3;
                this._targetX = this._rightMax;
                if (this._chapter < 1)
                {
                    this._chapter = 1;
                    this._targetX = 0;
                }
            }
            if (this._targetX != 0)
            {
                this.setPhase(PHASE_LIST_FADE_OUT);
            }
            return;
        }// end function

    }
}
