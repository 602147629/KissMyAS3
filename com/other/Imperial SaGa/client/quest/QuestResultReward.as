package quest
{
    import button.*;
    import flash.display.*;
    import layer.*;
    import message.*;
    import popup.*;
    import tutorial.*;
    import utility.*;

    public class QuestResultReward extends Object
    {
        private const _BUTTON_SKIP:int = 1;
        private const _BUTTON_NEXT:int = 2;
        private var _phase:int;
        private var _mcResultReward:MovieClip;
        private var _isoMain:InStayOut;
        private var _btnClose:ButtonBase;
        private var _bClose:Boolean;
        private var _questResultData:QuestResultData;
        private var _clearRewardList:QuestResultRewardList;
        private var _dropList:QuestResultRewardList;
        private static const PHASE_NOTHING:int = 0;
        private static const PHASE_OPEN:int = 1;
        private static const PHASE_REWARD:int = 10;
        private static const PHASE_DROP:int = 20;
        private static const PHASE_NEXT_WAIT:int = 30;
        private static const PHASE_CLOSE:int = 90;
        private static const PHASE_END:int = 999;

        public function QuestResultReward(param1:MovieClip, param2:LayerQuest)
        {
            this._mcResultReward = param1;
            this._isoMain = new InStayOut(this._mcResultReward);
            this._bClose = false;
            this._btnClose = ButtonManager.getInstance().addButton(this._mcResultReward.nextBtnMc, this.cbClose, this._BUTTON_SKIP);
            this._btnClose.setDisable(true);
            this._btnClose.enterSeId = ButtonBase.SE_DECIDE_ID;
            TextControl.setIdText(this._mcResultReward.nextBtnMc.textMc.textDt, MessageId.COMMON_BUTTON_SKIP);
            TextControl.setIdText(this._mcResultReward.resultSetMc.textClearMc.textDt, MessageId.QUEST_RESULT_CLEAR_REWORD_TITLE);
            TextControl.setIdText(this._mcResultReward.resultSetMc.textFindMc.textDt, MessageId.QUEST_RESULT_DROP_REWORD_TITLE);
            this._questResultData = QuestManager.getInstance().questResultData;
            if (this._clearRewardList == null)
            {
                this._clearRewardList = new QuestResultRewardList(this._mcResultReward, this._mcResultReward.resultSetMc.resultReward00, this._questResultData.aClearRemuneration, param2);
            }
            if (this._dropList == null)
            {
                this._dropList = new QuestResultRewardList(this._mcResultReward, this._mcResultReward.resultSetMc.resultReward01, this._questResultData.aRoadRemuneration, param2);
            }
            return;
        }// end function

        public function get bClose() : Boolean
        {
            return this._bClose;
        }// end function

        public function release() : void
        {
            ButtonManager.getInstance().removeButton(this._btnClose);
            if (this._clearRewardList != null)
            {
                this._clearRewardList.release();
                this._clearRewardList = null;
            }
            if (this._dropList != null)
            {
                this._dropList.release();
                this._dropList = null;
            }
            if (this._isoMain)
            {
                this._isoMain.release();
            }
            this._isoMain = null;
            if (this._mcResultReward)
            {
                if (this._mcResultReward.parent)
                {
                    this._mcResultReward.parent.removeChild(this._mcResultReward);
                }
            }
            this._mcResultReward = null;
            this._questResultData = null;
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
                case PHASE_REWARD:
                {
                    this.controlReward(param1);
                    break;
                }
                case PHASE_DROP:
                {
                    this.controlDrop(param1);
                    break;
                }
                case PHASE_NEXT_WAIT:
                {
                    this.controlNextWait();
                    break;
                }
                case PHASE_CLOSE:
                {
                    this.controlClose();
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
                    case PHASE_REWARD:
                    {
                        this.phaseReward();
                        break;
                    }
                    case PHASE_DROP:
                    {
                        this.phaseDrop();
                        break;
                    }
                    case PHASE_NEXT_WAIT:
                    {
                        this.phaseNextWait();
                        break;
                    }
                    case PHASE_CLOSE:
                    {
                        this.phaseClose();
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
            this._btnClose.setDisable(false);
            return;
        }// end function

        private function controlOpen() : void
        {
            if (this._isoMain && this._isoMain.bOpened)
            {
                this.setPhase(PHASE_REWARD);
            }
            return;
        }// end function

        private function phaseReward() : void
        {
            if (this._clearRewardList != null)
            {
                this._clearRewardList.setIn();
            }
            return;
        }// end function

        private function controlReward(param1:Number) : void
        {
            if (this._clearRewardList.bEnd)
            {
                this.setPhase(PHASE_DROP);
            }
            this._clearRewardList.control(param1);
            return;
        }// end function

        private function phaseDrop() : void
        {
            if (this._dropList != null)
            {
                this._dropList.setIn();
            }
            return;
        }// end function

        private function controlDrop(param1:Number) : void
        {
            if (this._dropList.bEnd)
            {
                this.setPhase(PHASE_NEXT_WAIT);
            }
            this._dropList.control(param1);
            return;
        }// end function

        private function phaseNextWait() : void
        {
            this.resultSkipAll();
            return;
        }// end function

        private function controlNextWait() : void
        {
            return;
        }// end function

        private function phaseClose() : void
        {
            this._btnClose.setDisable(true);
            if (this._clearRewardList)
            {
                this._clearRewardList.setBtnEnableAll(false);
            }
            if (this._dropList)
            {
                this._dropList.setBtnEnableAll(false);
            }
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

        private function phaseEnd() : void
        {
            this._bClose = true;
            return;
        }// end function

        private function resultSkip() : void
        {
            if (this._phase == PHASE_REWARD)
            {
                if (this._clearRewardList != null)
                {
                    this._clearRewardList.resultSkip();
                }
            }
            else if (this._phase == PHASE_DROP)
            {
                if (this._dropList != null)
                {
                    this._dropList.resultSkip();
                }
            }
            return;
        }// end function

        private function resultSkipAll() : void
        {
            if (this._clearRewardList != null)
            {
                this._clearRewardList.resultSkipAll();
            }
            if (this._dropList != null)
            {
                this._dropList.resultSkipAll();
            }
            if (this._questResultData.bWarehouse)
            {
                CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, MessageManager.getInstance().getMessage(MessageId.CONFIRM_SEND_STRAGE), function () : void
            {
                _btnClose.setDisable(false);
                changeToNextButton();
                return;
            }// end function
            );
            }
            else
            {
                this._btnClose.setDisable(false);
                this.changeToNextButton();
            }
            return;
        }// end function

        private function changeToNextButton() : void
        {
            this._btnClose.setId(this._BUTTON_NEXT);
            TextControl.setIdText(this._btnClose.getMoveClip().textMc.textDt, MessageId.COMMON_BUTTON_NEXT);
            if (TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL, TutorialManager.BASIC_TUTORIAL_FLAG_TUTORIAL_QUEST_END))
            {
                TutorialManager.getInstance().setTutorialArrow(this._btnClose.getMoveClip());
                TutorialManager.getInstance().setTutorialBalloon(MessageManager.getInstance().getMessage(MessageId.TUTORIAL_BALLOON_TUTORIAL_QUEST_RESULT_001), TutorialManager.TUTORIAL_BALLOON_POS_BOTTOM);
            }
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

    }
}
