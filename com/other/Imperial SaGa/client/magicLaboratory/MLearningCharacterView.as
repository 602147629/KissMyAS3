package magicLaboratory
{
    import button.*;
    import flash.display.*;
    import flash.geom.*;
    import message.*;
    import player.*;
    import skill.*;
    import tutorial.*;
    import user.*;
    import utility.*;

    public class MLearningCharacterView extends Object
    {
        private const _PHASE_HIDE:int = 1;
        private const _PHASE_OPEN:int = 10;
        private const _PHASE_WAIT:int = 30;
        private const _PHASE_CLOSE:int = 90;
        private var _baseMc:MovieClip;
        private var _charaMc:MovieClip;
        private var _isoBase:InStayOut;
        private var _isoChara:InStayOut;
        private var _magicLearningData:MagicLearningData;
        private var _playerDisplay:PlayerDisplay;
        private var _instantBtn:InstantButton;
        private var _learningTime:NumericNumberMc;
        private var _phase:int;

        public function MLearningCharacterView(param1:MovieClip, param2:MovieClip, param3:int, param4:MagicLearningData)
        {
            this._baseMc = param1;
            this._charaMc = param2;
            this._isoBase = new InStayOut(this._baseMc, true);
            this._isoBase.setEnd();
            this._isoChara = new InStayOut(this._charaMc);
            this._isoChara.setEnd();
            this._playerDisplay = new PlayerDisplay(this._charaMc, Constant.EMPTY_ID, Constant.EMPTY_ID);
            this._instantBtn = new InstantButton(this._baseMc.spotRemainingBtnMc, MessageId.MAGIC_LEARN_BUTTON_PROMPTLY, this.cbImmidiate);
            this._learningTime = new NumericNumberMc(this._baseMc.timeInfoMc.remainingTimeMc, 0, 0);
            this._magicLearningData = param4;
            this.setPhase(this._PHASE_HIDE);
            return;
        }// end function

        public function getPlayerDisplay() : PlayerDisplay
        {
            return this._playerDisplay;
        }// end function

        public function get instantBtn() : InstantButton
        {
            return this._instantBtn;
        }// end function

        public function release() : void
        {
            if (this._instantBtn)
            {
                this._instantBtn.release();
            }
            this._instantBtn = null;
            if (this._isoBase)
            {
                this._isoBase.release();
            }
            this._isoBase = null;
            if (this._isoChara)
            {
                this._isoChara.release();
            }
            this._isoChara = null;
            if (this._playerDisplay)
            {
                this._playerDisplay.release();
            }
            this._playerDisplay = null;
            return;
        }// end function

        public function getPlayerPersonal() : PlayerPersonal
        {
            var _loc_1:* = null;
            if (this._magicLearningData.uniqueId != Constant.EMPTY_ID)
            {
                _loc_1 = UserDataManager.getInstance().userData;
                return _loc_1.getPlayerPersonal(this._magicLearningData.uniqueId);
            }
            return null;
        }// end function

        public function getPlayerCenterPosition() : Point
        {
            var _loc_1:* = this._baseMc.parent.localToGlobal(new Point(this._baseMc.x, this._baseMc.y));
            if (this._playerDisplay && this._playerDisplay.mc)
            {
                _loc_1 = _loc_1.add(new Point(this._playerDisplay.effectNull.x, this._playerDisplay.effectNull.y));
            }
            return _loc_1;
        }// end function

        public function control(param1:Number) : void
        {
            switch(this._phase)
            {
                case this._PHASE_HIDE:
                {
                    this.controlHide();
                    break;
                }
                case this._PHASE_OPEN:
                {
                    this.controlOpen(param1);
                    break;
                }
                case this._PHASE_CLOSE:
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
            if (param1 != this._phase)
            {
                this._phase = param1;
                switch(this._phase)
                {
                    case this._PHASE_HIDE:
                    {
                        this.phaseHide();
                        break;
                    }
                    case this._PHASE_OPEN:
                    {
                        this.phaseOpen();
                        break;
                    }
                    case this._PHASE_CLOSE:
                    {
                        this.phaseClose();
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

        private function updateView() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            if (this._magicLearningData.uniqueId != this._playerDisplay.uniqueId)
            {
                _loc_2 = UserDataManager.getInstance().userData;
                _loc_3 = _loc_2.getPlayerPersonal(this._magicLearningData.uniqueId);
                if (_loc_3 != null)
                {
                    this._playerDisplay.setId(_loc_3.playerId, _loc_3.uniqueId);
                    this._playerDisplay.setAnimation(PlayerDisplay.LABEL_ACTION_SELECT_MAGIC);
                }
                else
                {
                    this._playerDisplay.setId(Constant.EMPTY_ID, Constant.EMPTY_ID);
                }
            }
            var _loc_1:* = SkillManager.getInstance().getSkillInformation(this._magicLearningData.skillId);
            if (_loc_1)
            {
                TextControl.setText(this._baseMc.timeInfoMc.textMc.textDt, _loc_1.name);
            }
            else
            {
                TextControl.setText(this._baseMc.timeInfoMc.textMc.textDt, "");
            }
            if (this._magicLearningData.noticeId != Constant.EMPTY_ID)
            {
                if (MagicLabolatoryManager.getInstance().isLearningTimeOut(this._magicLearningData))
                {
                    this._magicLearningData.alertFinish();
                    this._learningTime.setNum(0);
                }
                else
                {
                    _loc_4 = MagicLabolatoryManager.getInstance().getLearningWaitTime(this._magicLearningData);
                    _loc_5 = _loc_4 % 60;
                    _loc_6 = _loc_4 / 60 % 60;
                    _loc_7 = _loc_4 / 60 / 60;
                    this._learningTime.setNum(_loc_7 * 10000 + _loc_6 * 100 + _loc_5);
                }
            }
            if (TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_MAGIC_LABO_LEARNING_4))
            {
                this._instantBtn.setLearning(0);
                this._instantBtn.setEndTime(uint.MAX_VALUE);
            }
            else
            {
                _loc_8 = MagicLearnUtility.getLearnInstantLearningNum(this._magicLearningData.endTime, TimeClock.getNowTime());
                this._instantBtn.setLearning(_loc_8);
                this._instantBtn.setEndTime(this._magicLearningData.endTime);
            }
            this.setButtonEnable(this._magicLearningData.noticeId != 0);
            return;
        }// end function

        private function setIn() : void
        {
            if (this._isoBase.bClosed)
            {
                this._isoBase.setInLabel("charaIn");
            }
            return;
        }// end function

        private function setOut() : void
        {
            if (this._isoBase.bOpened)
            {
                this._isoBase.setOutLabel("charaOut");
            }
            return;
        }// end function

        public function setButtonEnable(param1:Boolean) : void
        {
            this._instantBtn.setDisable(!param1 || this._isoBase.bClosed);
            return;
        }// end function

        private function phaseHide() : void
        {
            return;
        }// end function

        private function controlHide() : void
        {
            if (this._magicLearningData.uniqueId != Constant.EMPTY_ID)
            {
                this.setPhase(this._PHASE_OPEN);
            }
            return;
        }// end function

        private function phaseOpen() : void
        {
            if (this._isoChara.bClosed)
            {
                this._isoChara.setInLabel("charaIn");
            }
            if (this._isoBase.bClosed)
            {
                this._isoBase.setInLabel("charaIn");
            }
            return;
        }// end function

        private function controlOpen(param1:Number) : void
        {
            this.updateView();
            if (this._instantBtn)
            {
                this._instantBtn.control(param1);
            }
            if (this._magicLearningData.uniqueId == Constant.EMPTY_ID)
            {
                this.setPhase(this._PHASE_CLOSE);
            }
            return;
        }// end function

        private function phaseClose() : void
        {
            if (this._isoBase.bOpened)
            {
                this._isoBase.setOutLabel("charaOut");
            }
            if (this._isoChara.bOpened)
            {
                this._isoChara.setOutLabel("charaOut");
            }
            return;
        }// end function

        private function controlClose() : void
        {
            if (this._isoBase.bClosed && this._isoChara.bClosed)
            {
                this.setPhase(this._PHASE_HIDE);
            }
            return;
        }// end function

        private function cbImmidiate(param1:int) : void
        {
            if (this._magicLearningData.noticeId != Constant.EMPTY_ID)
            {
                this._magicLearningData.alertFastFinish();
            }
            return;
        }// end function

    }
}
