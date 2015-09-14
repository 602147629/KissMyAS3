package trainingRoom
{
    import flash.display.*;
    import message.*;
    import player.*;
    import utility.*;

    public class TrainingRoomTopInfo extends Object
    {
        private var _phase:int;
        private var _mcBase:MovieClip;
        private var _isoMain:InStayOut;
        private var _numericTrainingTime:NumericNumberTimeMc;
        private var _skillInfoBox:TrainingRoomSkillInfoBox;
        private var _trainingTimeSec:uint;
        private var _trainingEndTime:uint;
        private var _maxTimeSec:uint;
        private var _bCountStop:Boolean;
        private var _timeCount:Number;
        private static const _PHASE_OPEN_WAIT:int = 0;
        private static const _PHASE_OPEN:int = 1;
        private static const _PHASE_MAIN:int = 2;
        private static const _PHASE_CLOSE:int = 3;

        public function TrainingRoomTopInfo(param1:MovieClip)
        {
            this._mcBase = param1;
            this._isoMain = new InStayOut(this._mcBase);
            this._numericTrainingTime = new NumericNumberTimeMc(this._mcBase.trainingInfoMc.timeMc, 0, 1);
            this._skillInfoBox = null;
            if (this._mcBase.trainingInfoMc.skillTextMc)
            {
                this._skillInfoBox = new TrainingRoomSkillInfoBox(this._mcBase.trainingInfoMc.skillTextMc);
            }
            TextControl.setText(this._mcBase.trainingInfoMc.paramTextMc.textDt, "");
            this._trainingTimeSec = 0;
            this._trainingEndTime = 0;
            this._maxTimeSec = 0;
            this._bCountStop = false;
            this._timeCount = 0;
            this.setPhase(_PHASE_OPEN_WAIT);
            return;
        }// end function

        public function get bTimeOver() : Boolean
        {
            return this._trainingTimeSec <= 0;
        }// end function

        public function get bOpenWait() : Boolean
        {
            return this._phase == _PHASE_OPEN_WAIT;
        }// end function

        public function get bClosing() : Boolean
        {
            return this._phase == _PHASE_CLOSE;
        }// end function

        public function get bClose() : Boolean
        {
            return this._phase == _PHASE_CLOSE && (this._isoMain && this._isoMain.bClosed);
        }// end function

        public function release() : void
        {
            if (this._numericTrainingTime)
            {
                this._numericTrainingTime.release();
            }
            this._numericTrainingTime = null;
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
                case _PHASE_OPEN_WAIT:
                {
                    this.initPhaseOpenWait();
                    break;
                }
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
            this._timeCount = this._timeCount + param1;
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
            return;
        }// end function

        private function initPhaseOpenWait() : void
        {
            return;
        }// end function

        private function initPhaseOpen() : void
        {
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
            return;
        }// end function

        private function controlPhaseMain(param1:Number) : void
        {
            var _loc_2:* = 0;
            if (this._trainingTimeSec > 0 && this._timeCount >= 1 && !this._bCountStop)
            {
                _loc_2 = Math.floor(this._timeCount);
                this.countTime(_loc_2);
                this._timeCount = this._timeCount - _loc_2;
            }
            return;
        }// end function

        private function initPhaseClose() : void
        {
            this._isoMain.setOut(function () : void
            {
                setPhase(_PHASE_OPEN_WAIT);
                return;
            }// end function
            );
            return;
        }// end function

        private function countTime(param1:int) : void
        {
            this._trainingTimeSec = this._trainingTimeSec > param1 ? (this._trainingTimeSec - param1) : (0);
            var _loc_2:* = TimeClock.getNowTime();
            var _loc_3:* = this.getTrainingSec(_loc_2);
            if (this._trainingTimeSec + 5 < _loc_3)
            {
                this._trainingTimeSec = _loc_3;
            }
            var _loc_4:* = Math.min(this._maxTimeSec, this._trainingTimeSec);
            var _loc_5:* = Math.min(this._maxTimeSec, this._trainingTimeSec) % 60;
            var _loc_6:* = _loc_4 / 60 % 60;
            var _loc_7:* = _loc_4 / 60 / 60;
            var _loc_8:* = _loc_4 / 60 / 60 * 10000 + _loc_6 * 100 + _loc_5;
            this._numericTrainingTime.setNum(_loc_8);
            return;
        }// end function

        public function open() : void
        {
            this.setPhase(_PHASE_OPEN);
            return;
        }// end function

        public function close() : void
        {
            this.setPhase(_PHASE_CLOSE);
            return;
        }// end function

        public function setData(param1:OwnSkillData, param2:String, param3:uint, param4:uint, param5:uint, param6:Boolean) : void
        {
            if (this._skillInfoBox && param1)
            {
                this._skillInfoBox.setSkillData(param1);
            }
            TextControl.setText(this._mcBase.trainingInfoMc.paramTextMc.textDt, param2);
            this._trainingEndTime = param4;
            this._trainingTimeSec = param5;
            this._maxTimeSec = param5;
            this._bCountStop = param6;
            this._timeCount = 0;
            this._trainingTimeSec = this.getTrainingSec(param3);
            this.countTime(0);
            return;
        }// end function

        public function instantEnd() : void
        {
            this._trainingTimeSec = 0;
            this._trainingEndTime = TimeClock.getNowTime();
            this._timeCount = 0;
            this.countTime(0);
            return;
        }// end function

        private function getTrainingSec(param1:uint) : uint
        {
            if (this._bCountStop)
            {
                return this._maxTimeSec;
            }
            return this._trainingEndTime > param1 ? (this._trainingEndTime - param1) : (0);
        }// end function

    }
}
