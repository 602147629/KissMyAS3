package trainingRoom
{
    import button.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import message.*;
    import resource.*;
    import skill.*;
    import sound.*;
    import utility.*;

    public class TrainingRoomStartSuccessMessage extends Object
    {
        private var _type:int;
        private var _subType:int;
        private var _phase:int;
        private var _mcBase:MovieClip;
        private var _mcInfo:MovieClip;
        private var _isoMain:InStayOut;
        private var _btnNext:ButtonBase;
        private var _cbNext:Function;
        private var _timer:Timer;
        private var _aMessage:Array;
        private var _messageIndex:int;
        public static const MESSAGE_TYPE_START:int = 0;
        public static const MESSAGE_TYPE_SUCCESS:int = 1;
        public static const MESSAGE_TYPE_BIG_SUCCESS:int = 2;
        public static const MESSAGE_SUBTYPE_KUMITE:int = 0;
        public static const MESSAGE_SUBTYPE_TRAINING:int = 1;
        private static const _PHASE_OPEN:int = 1;
        private static const _PHASE_MAIN:int = 2;
        private static const _PHASE_CLOSE:int = 3;

        public function TrainingRoomStartSuccessMessage(param1:int, param2:int, param3:DisplayObjectContainer, param4:Array, param5:Function)
        {
            this._type = param1;
            this._subType = param2;
            switch(this._type)
            {
                case MESSAGE_TYPE_START:
                {
                    this._mcBase = ResourceManager.getInstance().createMovieClip(ResourcePath.FACILITY_PATH + "UI_Training.swf", "TrainingStartMc");
                    this._mcInfo = null;
                    this._btnNext = null;
                    break;
                }
                case MESSAGE_TYPE_SUCCESS:
                {
                    this._mcBase = ResourceManager.getInstance().createMovieClip(ResourcePath.FACILITY_PATH + "UI_Training.swf", this._subType == MESSAGE_SUBTYPE_KUMITE ? ("TrainingSuccessMc") : ("TrainingSuccess2Mc"));
                    this._mcInfo = this._mcBase.successInfoMc;
                    this._btnNext = ButtonManager.getInstance().addButton(this._mcBase.nextBtnMc, this.cbNextButton);
                    this._btnNext.enterSeId = ButtonBase.SE_DECIDE_ID;
                    TextControl.setIdText(this._mcBase.nextBtnMc.textMc.textDt, MessageId.COMMON_BUTTON_NEXT);
                    this.createMessage(param4);
                    TextControl.setText(this._mcBase.successInfoMc.textMc.textDt, this._aMessage.length > 0 ? (this._aMessage[0]) : (""));
                    break;
                }
                case MESSAGE_TYPE_BIG_SUCCESS:
                {
                    this._mcBase = ResourceManager.getInstance().createMovieClip(ResourcePath.FACILITY_PATH + "UI_Training.swf", this._subType == MESSAGE_SUBTYPE_KUMITE ? ("TrainingBigSuccessMc") : ("TrainingBigSuccess2Mc"));
                    this._mcInfo = this._mcBase.successInfoMc;
                    this._btnNext = ButtonManager.getInstance().addButton(this._mcBase.nextBtnMc, this.cbNextButton);
                    this._btnNext.enterSeId = ButtonBase.SE_DECIDE_ID;
                    TextControl.setIdText(this._mcBase.nextBtnMc.textMc.textDt, MessageId.COMMON_BUTTON_NEXT);
                    this.createMessage(param4);
                    TextControl.setText(this._mcBase.successInfoMc.textMc.textDt, this._aMessage.length > 0 ? (this._aMessage[0]) : (""));
                    break;
                }
                default:
                {
                    break;
                }
            }
            param3.addChild(this._mcBase);
            this._cbNext = param5;
            this._isoMain = new InStayOut(this._mcBase);
            this._timer = null;
            this.setPhase(_PHASE_OPEN);
            return;
        }// end function

        public function get bClose() : Boolean
        {
            return this._phase == _PHASE_CLOSE && (this._isoMain && this._isoMain.bClosed);
        }// end function

        public function release() : void
        {
            if (this._btnNext)
            {
                ButtonManager.getInstance().removeButton(this._btnNext);
                this._btnNext = null;
            }
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

        private function initPhaseOpen() : void
        {
            if (this._btnNext)
            {
                this._btnNext.setDisable(true);
            }
            SoundManager.getInstance().playSe(SoundId.SE_COMPOSE_SUCSESS);
            this._isoMain.setIn(function () : void
            {
                setPhase(_PHASE_MAIN);
                return;
            }// end function
            );
            return;
        }// end function

        private function initPhaseMain() : void
        {
            if (this._btnNext)
            {
                this._btnNext.setDisable(false);
            }
            if (this._type == MESSAGE_TYPE_START)
            {
                this._timer = new Timer(1000, 1);
                this._timer.addEventListener(TimerEvent.TIMER_COMPLETE, this.cbTimer);
                this._timer.start();
            }
            return;
        }// end function

        private function initPhaseClose() : void
        {
            if (this._btnNext)
            {
                this._btnNext.setDisable(true);
            }
            this._isoMain.setOut(function () : void
            {
                if (_cbNext != null)
                {
                    _cbNext();
                }
                return;
            }// end function
            );
            return;
        }// end function

        private function createMessage(param1:Array) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            this._messageIndex = 0;
            this._aMessage = [];
            for each (_loc_2 in param1)
            {
                
                _loc_3 = SkillManager.getInstance().getSkillInformation(_loc_2.skillId);
                _loc_4 = _loc_3.name;
                if (_loc_2.bTraining)
                {
                    if (_loc_2.spChange == 0)
                    {
                        _loc_4 = _loc_4 + ("は\n" + MessageManager.getInstance().getMessage(MessageId.TRAINING_ROOM_RESULT_TEXT07));
                    }
                    else
                    {
                        _loc_4 = _loc_4 + ("の\n" + TextControl.formatIdText(MessageId.TRAINING_ROOM_RESULT_TEXT06, MessageManager.getInstance().getMessage(MessageId.COMMON_SKILL_STATUS_SP), _loc_2.spBase, _loc_2.spBase + _loc_2.spChange));
                    }
                }
                else
                {
                    _loc_4 = _loc_4 + "の";
                    if (_loc_2.powerChange != 0)
                    {
                        _loc_4 = _loc_4 + ("\n" + TextControl.formatIdText(_loc_2.powerChange > 0 ? (MessageId.TRAINING_ROOM_RESULT_TEXT02) : (MessageId.TRAINING_ROOM_RESULT_TEXT03), MessageManager.getInstance().getMessage(MessageId.COMMON_SKILL_STATUS_POWER)));
                    }
                    if (_loc_2.hitChange != 0)
                    {
                        _loc_4 = _loc_4 + ("\n" + TextControl.formatIdText(_loc_2.hitChange > 0 ? (MessageId.TRAINING_ROOM_RESULT_TEXT02) : (MessageId.TRAINING_ROOM_RESULT_TEXT03), MessageManager.getInstance().getMessage(MessageId.COMMON_SKILL_STATUS_HIT)));
                    }
                    if (_loc_2.spChange != 0)
                    {
                        _loc_4 = _loc_4 + ("\n" + TextControl.formatIdText(_loc_2.spChange > 0 ? (MessageId.TRAINING_ROOM_RESULT_TEXT04) : (MessageId.TRAINING_ROOM_RESULT_TEXT05), MessageManager.getInstance().getMessage(MessageId.COMMON_SKILL_STATUS_SP)));
                    }
                }
                this._aMessage.push(_loc_4);
            }
            if (param1.length == 0)
            {
                this._aMessage.push(MessageManager.getInstance().getMessage(MessageId.TRAINING_ROOM_RESULT_TEXT08));
            }
            this.updateNextBtn();
            return;
        }// end function

        private function updateNextBtn() : void
        {
            if (this._messageIndex >= (this._aMessage.length - 1))
            {
                TextControl.setIdText(this._mcBase.nextBtnMc.textMc.textDt, MessageId.COMMON_BUTTON_CLOSE);
            }
            return;
        }// end function

        private function cbNextButton(param1:int) : void
        {
            if (this._messageIndex < (this._aMessage.length - 1))
            {
                var _loc_2:* = this;
                var _loc_3:* = this._messageIndex + 1;
                _loc_2._messageIndex = _loc_3;
                TextControl.setText(this._mcBase.successInfoMc.textMc.textDt, this._aMessage[this._messageIndex]);
                this.updateNextBtn();
            }
            else
            {
                this.setPhase(_PHASE_CLOSE);
            }
            return;
        }// end function

        private function cbTimer(event:TimerEvent) : void
        {
            this._timer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.cbTimer);
            this._timer = null;
            this.setPhase(_PHASE_CLOSE);
            return;
        }// end function

    }
}
