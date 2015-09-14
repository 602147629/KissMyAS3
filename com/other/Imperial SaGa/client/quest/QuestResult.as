package quest
{
    import button.*;
    import flash.display.*;
    import layer.*;
    import message.*;
    import resource.*;
    import sound.*;
    import tutorial.*;
    import utility.*;

    public class QuestResult extends Object
    {
        private const _WAIT_TIME:Number = 0.5;
        private const _DISRUPTNUM_COLOR_RATE_1:int = 0;
        private const _DISRUPTNUM_COLOR_RATE_2:int = 30;
        private const _DISRUPTNUM_COLOR_RATE_3:int = 60;
        private const _DISRUPTNUM_COLOR_RATE_4:int = 90;
        private const _DISRUPTNUM_COLOR_RATE_5:int = 100;
        private const _BUTTON_SKIP:int = 1;
        private const _BUTTON_NEXT:int = 2;
        private var _phase:int;
        private var _mc:MovieClip;
        private var _isoMain:InStayOut;
        private var _btnClose:ButtonBase;
        private var _bClose:Boolean;
        private var _questResultData:QuestResultData;
        private var _playMc:MovieClip;
        private var _playIndex:int;
        private var _waitTime:Number;
        private var _aDisplayMc:Array;
        private var _rankMc:MovieClip;
        private var _disruptMc:MovieClip;
        private var _strategyMc:MovieClip;
        private var _rewardSClearWindow:QuestResultRewardSClearPopup;
        private var _rewardFirstClearWindow:QuestResultRewardSClearPopup;
        private static const PHASE_NOTHING:int = 0;
        private static const PHASE_OPEN:int = 1;
        private static const PHASE_MAIN:int = 10;
        private static const PHASE_CLOSE:int = 30;
        private static const PHASE_END:int = 999;

        public function QuestResult(param1:MovieClip, param2:LayerQuest)
        {
            this._mc = param1;
            this._isoMain = new InStayOut(this._mc);
            var _loc_3:* = ResourceManager.getInstance().createMovieClip(QuestResultMain.getResource(), "SrankRewardPopup");
            var _loc_4:* = ResourceManager.getInstance().createMovieClip(QuestResultMain.getResource(), "SrankRewardPopup");
            this._bClose = false;
            this._questResultData = QuestManager.getInstance().questResultData;
            this._btnClose = ButtonManager.getInstance().addButton(this._mc.nextBtnMc, this.cbClose, this._BUTTON_SKIP);
            this._btnClose.setDisable(true);
            this._btnClose.enterSeId = ButtonBase.SE_DECIDE_ID;
            this._rewardSClearWindow = new QuestResultRewardSClearPopup(_loc_3, param2);
            this._rewardFirstClearWindow = new QuestResultRewardSClearPopup(_loc_4, param2);
            TextControl.setIdText(this._mc.nextBtnMc.textMc.textDt, MessageId.COMMON_BUTTON_SKIP);
            this.setResultData();
            return;
        }// end function

        public function get bClose() : Boolean
        {
            return this._bClose;
        }// end function

        public function release() : void
        {
            ButtonManager.getInstance().removeButton(this._btnClose);
            if (this._rewardFirstClearWindow)
            {
                this._rewardFirstClearWindow.release();
            }
            this._rewardFirstClearWindow = null;
            if (this._rewardSClearWindow)
            {
                this._rewardSClearWindow.release();
            }
            this._rewardSClearWindow = null;
            if (this._isoMain)
            {
                this._isoMain.release();
            }
            this._isoMain = null;
            this._mc = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            switch(this._phase)
            {
                case PHASE_OPEN:
                {
                    this.controlOpen();
                    break;
                }
                case PHASE_CLOSE:
                {
                    this.controlClose();
                    break;
                }
                case PHASE_MAIN:
                {
                    this.controlMain(param1);
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (this._rewardSClearWindow)
            {
                this._rewardSClearWindow.control(param1);
            }
            if (this._rewardFirstClearWindow)
            {
                this._rewardFirstClearWindow.control(param1);
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
                    case PHASE_OPEN:
                    {
                        this.phaseOpen();
                        break;
                    }
                    case PHASE_CLOSE:
                    {
                        this.phaseClose();
                        break;
                    }
                    case PHASE_MAIN:
                    {
                        this.phaseMain();
                        break;
                    }
                    case PHASE_END:
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

        private function phaseOpen() : void
        {
            this._isoMain.setIn();
            return;
        }// end function

        private function controlOpen() : void
        {
            if (this._isoMain && this._isoMain.bOpened)
            {
                this.setPhase(PHASE_MAIN);
            }
            return;
        }// end function

        private function phaseClose() : void
        {
            this._btnClose.setDisable(true);
            this._isoMain.setOut();
            TutorialManager.getInstance().hideTutorial();
            return;
        }// end function

        private function controlClose() : void
        {
            if (this._isoMain && this._isoMain.bEnd)
            {
                this.setPhase(PHASE_END);
            }
            return;
        }// end function

        private function phaseMain() : void
        {
            this._playIndex = 0;
            this._waitTime = this._WAIT_TIME;
            this._playMc = this._aDisplayMc[this._playIndex];
            this._playMc.gotoAndPlay("in");
            SoundManager.getInstance().playSe(SoundId.SE_CANNON);
            this._btnClose.setDisable(false);
            return;
        }// end function

        private function controlMain(param1:Number) : void
        {
            var _loc_2:* = false;
            if (this._playMc != null)
            {
                _loc_2 = false;
                if (this._playMc.currentLabel == "stay")
                {
                    this._waitTime = this._waitTime - param1;
                    if (this._waitTime <= 0)
                    {
                        var _loc_3:* = this;
                        var _loc_4:* = this._playIndex + 1;
                        _loc_3._playIndex = _loc_4;
                        _loc_2 = true;
                    }
                }
                if (_loc_2)
                {
                    this._playMc = this._aDisplayMc[this._playIndex];
                    if (this._playMc != null)
                    {
                        this._waitTime = this._WAIT_TIME;
                        this._playMc.gotoAndPlay("in");
                        if (this._playMc == this._rankMc)
                        {
                            SoundManager.getInstance().playSe(SoundId.SE_REV_RESULT_KEKKA);
                        }
                        else if (this._playMc == this._strategyMc || this._playMc == this._disruptMc)
                        {
                            SoundManager.getInstance().playSe(SoundId.SE_REV_RESULT_KEKKA);
                        }
                        else
                        {
                            SoundManager.getInstance().playSe(SoundId.SE_REV_RESULT_REWARD);
                        }
                    }
                    else
                    {
                        this.resultSkip();
                    }
                }
            }
            return;
        }// end function

        private function phaseEnd() : void
        {
            this._bClose = true;
            return;
        }// end function

        private function setResultData() : void
        {
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_1:* = [this._mc.resultSetMc.resultFailureMc, this._mc.resultSetMc.resultSuccessMc, this._mc.resultSetMc.resultGSuccessMc];
            var _loc_2:* = [this._mc.resultSetMc.resultRankSMc, this._mc.resultSetMc.resultRankAMc, this._mc.resultSetMc.resultRankBMc, this._mc.resultSetMc.resultRankCMc, this._mc.resultSetMc.resultRankDMc];
            var _loc_3:* = QuestManager.getInstance().questData;
            var _loc_4:* = _loc_1[(this._questResultData.resultType - 1)];
            var _loc_5:* = _loc_2[QuestManager.getInstance().questStrategyRank(this._questResultData.achievementRate)];
            for each (_loc_6 in _loc_1)
            {
                
                _loc_6.visible = false;
            }
            _loc_4.visible = true;
            TextControl.setText(_loc_4.textMc.textDt, QuestManager.getInstance().resultMessage(this._questResultData.resultMessageType, this._questResultData.resultType));
            TextControl.setText(this._mc.resultSetMc.questNameMc.textMc.textDt, _loc_3.title);
            TextControl.setIdText(this._mc.resultSetMc.textKekkaMc.textDt, MessageId.QUEST_RESULT_SUBJECT_NAME_RESULT);
            TextControl.setIdText(this._mc.resultSetMc.textDisruptMc.textDt, MessageId.QUEST_RESULT_SUBJECT_NAME_PERCENT_COMPLETE);
            TextControl.setIdText(this._mc.resultSetMc.textRankMc.textDt, MessageId.QUEST_RESULT_SUBJECT_NAME_RANK);
            _loc_7 = this._questResultData.achievementRate.toString();
            _loc_8 = [0, 0, 0];
            _loc_9 = 0;
            _loc_10 = 1;
            if (this._questResultData.achievementRate == this._DISRUPTNUM_COLOR_RATE_5)
            {
                _loc_10 = 5;
            }
            else if (this._questResultData.achievementRate >= this._DISRUPTNUM_COLOR_RATE_4)
            {
                _loc_10 = 4;
            }
            else if (this._questResultData.achievementRate >= this._DISRUPTNUM_COLOR_RATE_3)
            {
                _loc_10 = 3;
            }
            else if (this._questResultData.achievementRate >= this._DISRUPTNUM_COLOR_RATE_2)
            {
                _loc_10 = 2;
            }
            else
            {
                _loc_10 = 1;
            }
            _loc_9 = _loc_7.length - 1;
            while (_loc_9 >= 0)
            {
                
                _loc_8[_loc_9] = parseInt(_loc_7.charAt(_loc_9));
                _loc_9 = _loc_9 - 1;
            }
            _loc_9 = 0;
            while (_loc_9 < _loc_8.length)
            {
                
                if (_loc_9 >= _loc_7.length)
                {
                    this._mc.resultSetMc.disruptNumMc.disruptNum.numMc["n" + _loc_9].visible = false;
                }
                else
                {
                    this._mc.resultSetMc.disruptNumMc.disruptNum.gotoAndStop(_loc_10);
                    this._mc.resultSetMc.disruptNumMc.disruptNum.numMc["n" + _loc_9].visible = true;
                    this._mc.resultSetMc.disruptNumMc.disruptNum.numMc["n" + _loc_9].gotoAndStop((_loc_8[(_loc_7.length - 1) - _loc_9] + 1));
                }
                _loc_9++;
            }
            this._rankMc = _loc_5;
            this._strategyMc = _loc_4;
            this._disruptMc = this._mc.resultSetMc.disruptNumMc;
            this._aDisplayMc = [];
            this._aDisplayMc.push(this._mc.resultSetMc.questNameMc);
            this._aDisplayMc.push(_loc_4);
            this._aDisplayMc.push(this._disruptMc);
            this._aDisplayMc.push(_loc_5);
            this._aDisplayMc.push(null);
            return;
        }// end function

        private function resultSkip() : void
        {
            var mc:MovieClip;
            this._playMc = null;
            var _loc_2:* = 0;
            var _loc_3:* = this._aDisplayMc;
            while (_loc_3 in _loc_2)
            {
                
                mc = _loc_3[_loc_2];
                if (mc != null)
                {
                    mc.gotoAndStop("stay");
                }
            }
            this._phase = PHASE_NOTHING;
            this.checkSClearReward(function () : void
            {
                checkFirstClearReward(function () : void
                {
                    _btnClose.setDisable(false);
                    changeToNextButton();
                    return;
                }// end function
                );
                return;
            }// end function
            );
            return;
        }// end function

        private function changeToNextButton() : void
        {
            this._btnClose.setId(this._BUTTON_NEXT);
            TextControl.setIdText(this._btnClose.getMoveClip().textMc.textDt, MessageId.COMMON_BUTTON_NEXT);
            return;
        }// end function

        private function cbClose(param1:int) : void
        {
            if (param1 == this._BUTTON_SKIP)
            {
                this.resultSkip();
            }
            if (param1 == this._BUTTON_NEXT)
            {
                this.setPhase(PHASE_CLOSE);
            }
            return;
        }// end function

        public function setIn() : void
        {
            this.setPhase(PHASE_OPEN);
            return;
        }// end function

        private function checkSClearReward(param1:Function) : void
        {
            if (this._questResultData.aFirstRemuneration && this._questResultData.aFirstRemuneration.length > 0)
            {
                this._rewardSClearWindow.openPopupReward(param1, MessageManager.getInstance().getMessage(MessageId.QUEST_RESULT_RUNK_S_REWORD_TEXT), this._questResultData.aFirstRemuneration);
            }
            else if (param1 != null)
            {
                this.param1();
            }
            return;
        }// end function

        private function checkFirstClearReward(param1:Function) : void
        {
            if (this._questResultData.aFirstClearRemuneration && this._questResultData.aFirstClearRemuneration.length > 0)
            {
                this._rewardFirstClearWindow.openPopupReward(param1, MessageManager.getInstance().getMessage(MessageId.QUEST_RESULT_CLEAR_REWORD_TEXT), this._questResultData.aFirstClearRemuneration);
            }
            else if (param1 != null)
            {
                this.param1();
            }
            return;
        }// end function

    }
}
