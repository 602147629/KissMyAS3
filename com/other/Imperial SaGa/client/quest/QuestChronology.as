package quest
{
    import button.*;
    import flash.display.*;
    import flash.geom.*;
    import message.*;
    import resource.*;
    import tutorial.*;
    import utility.*;

    public class QuestChronology extends Object
    {
        private const _PHASE_WAIT:int = 0;
        private const _PHASE_SCROLL:int = 1;
        private const _PHASE_TARGET_FADEOUT:int = 2;
        private const _PHASE_TARGET_FADEIN:int = 4;
        private const _PHASE_SKIP:int = 5;
        private const _PHASE_NOTICE:int = 6;
        private const _PHASE_END:int = 7;
        private const _BLACK_OUT:Number = 0.4;
        private var _sprite:Sprite;
        private var _phase:int;
        private var _isoMain:InStayOut;
        private var _baseMc:MovieClip;
        private var _historyMc:MovieClip;
        private var _targetBar:QuestHistoryBar;
        private var _targetHistory:QuestHistoryData;
        private var _questResutlYearsNotice:QuestResultYearsNotice;
        private var _aHistory:Array;
        private var _aHistoryMc:Array;
        private var _addY:Number;
        private var _scrollMax:Number;
        private var _scrollStop:Number;
        private var _fadeInY:Number;
        private var _vecY:Number;
        private var _btnClose:ButtonBase;
        private var _bEnd:Boolean;
        private var _bUpdate:Boolean;
        private var _bScroll:Boolean;
        private var _bSkip:Boolean;
        private var _bClose:Boolean;

        public function QuestChronology(param1:MovieClip)
        {
            this._baseMc = param1;
            this._historyMc = this._baseMc.chronologicalSetMc;
            this._isoMain = new InStayOut(this._baseMc);
            this._baseMc.ScrollBerSet.visible = false;
            this._sprite = new Sprite();
            this._historyMc.chronologySwindNull5.addChild(this._sprite);
            this._aHistory = QuestManager.getInstance().questResultData.aQuestHistory;
            this._targetHistory = null;
            if (this._aHistory.length > 0)
            {
                this._targetHistory = this._aHistory[(this._aHistory.length - 1)];
                this._aHistory.pop();
            }
            this._bUpdate = false;
            this._bScroll = false;
            this._bClose = false;
            this._bEnd = false;
            this._bSkip = false;
            this._addY = this._historyMc.chronologySwindNull1.y - this._historyMc.chronologySwindNull0.y;
            this._btnClose = ButtonManager.getInstance().addButton(this._baseMc.nextBtnMc, this.cbClose);
            this._btnClose.setDisable(true);
            this._btnClose.enterSeId = ButtonBase.SE_DECIDE_ID;
            TextControl.setIdText(this._baseMc.nextBtnMc.textMc.textDt, MessageId.COMMON_BUTTON_SKIP);
            this._vecY = 0;
            this.createHistoryBar();
            this._phase = this._PHASE_WAIT;
            return;
        }// end function

        public function get bClose() : Boolean
        {
            return this._bClose;
        }// end function

        public function release() : void
        {
            var _loc_1:* = null;
            ButtonManager.getInstance().removeButton(this._btnClose);
            this._btnClose = null;
            if (this._questResutlYearsNotice)
            {
                this._questResutlYearsNotice.release();
            }
            this._questResutlYearsNotice = null;
            for each (_loc_1 in this._aHistoryMc)
            {
                
                _loc_1.release();
            }
            this._aHistoryMc = null;
            if (this._targetBar)
            {
                this._targetBar.release();
            }
            this._targetBar = null;
            if (this._isoMain)
            {
                this._isoMain.release();
            }
            this._isoMain = null;
            if (this._baseMc && this._baseMc.parent)
            {
                this._baseMc.parent.removeChild(this._baseMc);
            }
            this._baseMc = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            var _loc_2:* = null;
            switch(this._phase)
            {
                case this._PHASE_SCROLL:
                {
                    this.controlScroll();
                    break;
                }
                case this._PHASE_TARGET_FADEIN:
                {
                    this.controlTargetFadeIn();
                    break;
                }
                case this._PHASE_TARGET_FADEOUT:
                {
                    this.controlTargetFadeOut();
                    break;
                }
                case this._PHASE_SKIP:
                {
                    this.controlSkip();
                    break;
                }
                case this._PHASE_NOTICE:
                {
                    this.controlNotice();
                    break;
                }
                default:
                {
                    break;
                }
            }
            for each (_loc_2 in this._aHistoryMc)
            {
                
                if (_loc_2 != null)
                {
                    _loc_2.control(param1);
                }
                if (_loc_2.bRemove == true && _loc_2.bVisible == true)
                {
                    _loc_2.invisible();
                }
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
                    case this._PHASE_SCROLL:
                    {
                        this.phaseScroll();
                        break;
                    }
                    case this._PHASE_TARGET_FADEIN:
                    {
                        this.phaseTargetFadeIn();
                        break;
                    }
                    case this._PHASE_TARGET_FADEOUT:
                    {
                        this.phaseTargetFadeOut();
                        break;
                    }
                    case this._PHASE_SKIP:
                    {
                        this.phaseSkip();
                        break;
                    }
                    case this._PHASE_NOTICE:
                    {
                        this.phaseNotice();
                        break;
                    }
                    case this._PHASE_END:
                    {
                        this.phaseEnd();
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

        private function phaseScroll() : void
        {
            this._bScroll = true;
            return;
        }// end function

        private function controlScroll() : void
        {
            var _loc_1:* = NaN;
            var _loc_2:* = 0;
            if (this._bScroll == true)
            {
                _loc_1 = 0;
                if (this._bUpdate && this._scrollStop != 0)
                {
                    _loc_1 = this._scrollStop;
                }
                else
                {
                    _loc_1 = this._scrollMax;
                }
                if (this._sprite.y > _loc_1)
                {
                    this._vecY = this._vecY + QuestConstant.HISTORY_SCROLL_SPEED;
                    if (this._vecY > QuestConstant.HISTORY_SCROLL_SPEED_MAX)
                    {
                        this._vecY = QuestConstant.HISTORY_SCROLL_SPEED_MAX;
                    }
                    this._sprite.y = this._sprite.y - this._vecY;
                }
                else
                {
                    _loc_2 = this._PHASE_WAIT;
                    if (this._bUpdate)
                    {
                        if (this._scrollStop != 0)
                        {
                            _loc_2 = this._PHASE_TARGET_FADEOUT;
                        }
                        else
                        {
                            _loc_2 = this._PHASE_TARGET_FADEIN;
                        }
                    }
                    else
                    {
                        this._bSkip = true;
                        _loc_2 = this._PHASE_WAIT;
                        this.dispEnd();
                    }
                    this._vecY = 0;
                    this.setPhase(_loc_2);
                }
            }
            return;
        }// end function

        private function phaseTargetFadeIn() : void
        {
            this._targetBar.addParent();
            this._targetBar.setHistoryData(this._targetHistory);
            this._targetBar.setPos(new Point(this._targetBar.pos.x, this._fadeInY));
            this._targetBar.setTargetPos(new Point(this._targetBar.pos.x - this._targetBar.width, this._targetBar.pos.y));
            this._targetBar.setMoveing(true);
            return;
        }// end function

        private function controlTargetFadeIn() : void
        {
            if (this._targetBar.bMoveing == false)
            {
                this._bUpdate = false;
                this.setPhase(this._PHASE_SCROLL);
            }
            return;
        }// end function

        private function phaseTargetFadeOut() : void
        {
            this._targetBar.setTargetPos(new Point(this._targetBar.pos.x + this._targetBar.width, this._targetBar.pos.y));
            this._targetBar.setMoveing(true);
            return;
        }// end function

        private function controlTargetFadeOut() : void
        {
            if (this._targetBar.bMoveing == false)
            {
                this._targetBar.removeParent();
                this._scrollStop = 0;
                this.setPhase(this._PHASE_SCROLL);
            }
            return;
        }// end function

        private function phaseSkip() : void
        {
            var _loc_2:* = null;
            if (this._sprite != null && this._sprite.parent != null)
            {
                this._sprite.parent.removeChild(this._sprite);
            }
            this._sprite.y = 0;
            this._historyMc.chronologySwindNull1.addChild(this._sprite);
            var _loc_1:* = 0;
            while (_loc_1 < this._aHistoryMc.length)
            {
                
                _loc_2 = this._aHistoryMc[_loc_1];
                if (_loc_2 != null && (this._targetBar == null || _loc_2.index != this._targetBar.index))
                {
                    _loc_2.release();
                }
                _loc_1++;
            }
            this._aHistoryMc = [];
            if (this._targetBar)
            {
                this._targetBar.release();
            }
            this._targetBar = null;
            this._bSkip = true;
            this.dispEnd();
            this.createSkipHistoryBar();
            return;
        }// end function

        private function controlSkip() : void
        {
            return;
        }// end function

        private function phaseNotice() : void
        {
            var _loc_1:* = this._baseMc.transform.colorTransform;
            _loc_1.blueMultiplier = this._BLACK_OUT;
            _loc_1.greenMultiplier = this._BLACK_OUT;
            _loc_1.redMultiplier = this._BLACK_OUT;
            this._baseMc.transform.colorTransform = _loc_1;
            this._btnClose.setDisable(true);
            this._btnClose.setDisableFlag(true);
            return;
        }// end function

        private function controlNotice() : void
        {
            if (this._questResutlYearsNotice != null && this._questResutlYearsNotice.bClose)
            {
                this.setPhase(this._PHASE_END);
            }
            return;
        }// end function

        private function phaseEnd() : void
        {
            this._bScroll = false;
            this._bUpdate = false;
            this._bEnd = true;
            this._bSkip = true;
            this.dispEnd();
            if (this._questResutlYearsNotice != null)
            {
                this._questResutlYearsNotice.setOut();
            }
            this._btnClose.setDisableFlag(true);
            this._isoMain.setOut(this.cbOut);
            return;
        }// end function

        private function createHistoryBar() : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_7:* = 0;
            var _loc_9:* = null;
            var _loc_10:* = NaN;
            var _loc_1:* = this._historyMc.chronologySwindNull0.y - this._historyMc.chronologySwindNull5.y;
            var _loc_2:* = this._historyMc.chronologySwindNull0.y - this._historyMc.chronologySwindNull2.y;
            var _loc_3:* = this._historyMc.chronologySwindNull1.y - this._historyMc.chronologySwindNull0.y;
            this._scrollMax = _loc_1 - _loc_2;
            this._scrollStop = 0;
            this._aHistoryMc = [];
            this._bUpdate = false;
            var _loc_6:* = this._targetHistory != null;
            var _loc_8:* = 0;
            while (_loc_8 < this._aHistory.length)
            {
                
                _loc_5 = this._aHistory[_loc_8];
                if (_loc_5 == null)
                {
                }
                else
                {
                    _loc_4 = this.createBar(_loc_8, _loc_1);
                    _loc_4.setLabel(QuestHistoryBar.NORMAL);
                    _loc_4.setPos(new Point(0, this._addY * _loc_8));
                    if (_loc_5.questNo == this._targetHistory.questNo)
                    {
                        _loc_4.setLabel(QuestHistoryBar.TARGET);
                        if (this.bQuestRank(_loc_5.totalComplete, this._targetHistory.totalComplete) == true)
                        {
                            this._targetBar = _loc_4;
                            this._scrollStop = this._scrollMax - this._targetBar.pos.y;
                            if (_loc_8 != (this._aHistory.length - 1) || _loc_8 == 0)
                            {
                                this._scrollStop = this._scrollStop - _loc_3;
                            }
                            if (_loc_8 == 1 && this._aHistory.length < 3)
                            {
                                this._scrollStop = this._scrollMax - this._targetBar.pos.y;
                            }
                            _loc_7 = _loc_8;
                            this._bUpdate = true;
                            _loc_6 = false;
                        }
                        else
                        {
                            this._bUpdate = false;
                            _loc_6 = false;
                        }
                    }
                    _loc_4.setHistoryData(_loc_5);
                    this._aHistoryMc.push(_loc_4);
                }
                _loc_8++;
            }
            if (this._bUpdate == false && _loc_6 == true)
            {
                _loc_9 = this.createBar(this._aHistoryMc.length, _loc_1);
                _loc_9.setLabel(QuestHistoryBar.TARGET);
                _loc_9.setHistoryData(this._targetHistory);
                _loc_9.setPos(new Point(0, this._addY * this._aHistoryMc.length));
                this._aHistoryMc.push(_loc_9);
                this._aHistory.push(this._targetHistory);
                if (this._aHistoryMc.length < 3)
                {
                    this._scrollMax = this._scrollMax - _loc_3;
                }
                else
                {
                    this._scrollMax = this._scrollMax - this._addY * (this._aHistoryMc.length - 1);
                }
            }
            if (this._bUpdate == true && _loc_6 == false)
            {
                if (_loc_7 == (this._aHistoryMc.length - 1))
                {
                    this._fadeInY = this._targetBar.pos.y;
                    this._scrollMax = this._scrollStop;
                }
                else
                {
                    this._fadeInY = this._addY * this._aHistoryMc.length;
                    this._scrollMax = this._scrollMax - this._addY * this._aHistoryMc.length;
                }
            }
            if (this._bUpdate == false && _loc_6 == false)
            {
                _loc_10 = _loc_3;
                if (this._aHistoryMc.length > 2)
                {
                    _loc_10 = this._addY * (this._aHistory.length - 1);
                }
                this._scrollMax = this._scrollMax - _loc_10;
            }
            return;
        }// end function

        private function createSkipHistoryBar() : void
        {
            var _loc_3:* = null;
            var _loc_5:* = null;
            var _loc_1:* = 0;
            var _loc_2:* = false;
            var _loc_4:* = this._aHistory.length - 1;
            while (_loc_4 >= 0)
            {
                
                _loc_3 = this._aHistory[_loc_4];
                if (_loc_3.questNo == this._targetHistory.questNo)
                {
                    if (this.bQuestRank(_loc_3.totalComplete, this._targetHistory.totalComplete) == true)
                    {
                        this._aHistory.splice(_loc_4, 1);
                        _loc_2 = true;
                    }
                    break;
                }
                _loc_4 = _loc_4 - 1;
            }
            if (_loc_2)
            {
                this._aHistory.push(this._targetHistory);
            }
            _loc_1 = 1;
            if (this._aHistory.length == 1)
            {
                _loc_1 = 0;
            }
            _loc_4 = this._aHistory.length - 1;
            while (_loc_4 >= 0)
            {
                
                _loc_5 = this.createBar(_loc_1, 0);
                _loc_3 = this._aHistory[_loc_4];
                _loc_5.setLabel(QuestHistoryBar.NORMAL);
                if (_loc_3.questNo == this._targetHistory.questNo)
                {
                    _loc_5.setLabel(QuestHistoryBar.TARGET);
                }
                _loc_5.setPos(new Point(0, this._addY * _loc_1));
                _loc_5.setHistoryData(_loc_3);
                _loc_5.setMoveing(false);
                this._aHistoryMc.push(_loc_5);
                _loc_1 = _loc_1 - 1;
                if (this._aHistoryMc.length == 2 || _loc_1 < 0)
                {
                    break;
                }
                _loc_4 = _loc_4 - 1;
            }
            return;
        }// end function

        private function dispEnd() : void
        {
            TextControl.setIdText(this._btnClose.getMoveClip().textMc.textDt, MessageId.COMMON_BUTTON_NEXT);
            if (TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL_2, TutorialManager.BASIC_TUTORIAL_FLAG_CHRONOLOGY))
            {
                TutorialManager.getInstance().basicTutorialPopup(CommonConstant.USER_STATE_TUTORIAL_2, TutorialManager.BASIC_TUTORIAL_FLAG_CHRONOLOGY);
            }
            return;
        }// end function

        private function createBar(param1:int, param2:Number) : QuestHistoryBar
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            _loc_3 = ResourceManager.getInstance().createMovieClip(ResourcePath.RESULT_PATH + "UI_Result.swf", "chronologicalSwindMc");
            _loc_4 = new QuestHistoryBar(this._sprite, _loc_3, param1, param2);
            return _loc_4;
        }// end function

        private function bQuestRank(param1:int, param2:int) : Boolean
        {
            var _loc_3:* = QuestManager.getInstance().questStrategyRank(param1);
            var _loc_4:* = QuestManager.getInstance().questStrategyRank(param2);
            return QuestManager.getInstance().questStrategyRank(param2) < _loc_3;
        }// end function

        private function cbClose(param1:int) : void
        {
            if (this._bScroll)
            {
                if (this._bSkip == false)
                {
                    this.setPhase(this._PHASE_SKIP);
                }
                else
                {
                    this.setPhase(this._PHASE_END);
                }
            }
            return;
        }// end function

        public function setIn() : void
        {
            this._isoMain.setIn(this.cbIn);
            return;
        }// end function

        private function cbIn() : void
        {
            this._btnClose.setDisable(false);
            this.setPhase(this._PHASE_SCROLL);
            return;
        }// end function

        private function cbOut() : void
        {
            this._bClose = true;
            return;
        }// end function

    }
}
