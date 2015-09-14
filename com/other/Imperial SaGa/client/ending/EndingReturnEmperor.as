package ending
{
    import flash.display.*;
    import message.*;
    import popup.*;
    import utility.*;

    public class EndingReturnEmperor extends Object
    {
        private const _PHASE_OPEN:int = 1;
        private const _PHASE_WAIT:int = 10;
        private const _PHASE_FINISH:int = 20;
        private const _PHASE_CLOSE:int = 99;
        private var _phase:int;
        private var _backScreen:ColorScreen;

        public function EndingReturnEmperor(param1:DisplayObjectContainer)
        {
            this._backScreen = new ColorScreen(param1, 0);
            this.setPhase(this._PHASE_OPEN);
            return;
        }// end function

        public function get bEnd() : Boolean
        {
            return this._phase == this._PHASE_CLOSE;
        }// end function

        public function release() : void
        {
            if (this._backScreen)
            {
                this._backScreen.release();
            }
            this._backScreen = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            switch(this._phase)
            {
                case this._PHASE_OPEN:
                {
                    this.controlOpen();
                    break;
                }
                case this._PHASE_WAIT:
                {
                    this.controlWait(param1);
                    break;
                }
                case this._PHASE_FINISH:
                {
                    this.controlFinish(param1);
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
                    case this._PHASE_OPEN:
                    {
                        this.phaseOpen();
                        break;
                    }
                    case this._PHASE_WAIT:
                    {
                        this.phaseWait();
                        break;
                    }
                    case this._PHASE_FINISH:
                    {
                        this.phaseFinish();
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

        private function phaseOpen() : void
        {
            Main.GetProcess().fade.setFadeIn(0);
            return;
        }// end function

        private function controlOpen() : void
        {
            this.setPhase(this._PHASE_WAIT);
            return;
        }// end function

        private function phaseWait() : void
        {
            CommonPopup.getInstance().openEmperorReturnAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, MessageManager.getInstance().getMessage(MessageId.ENDING_REVIVAL_EMPERORS_NOTICE), function () : void
            {
                setPhase(_PHASE_FINISH);
                return;
            }// end function
            );
            return;
        }// end function

        private function controlWait(param1:int) : void
        {
            return;
        }// end function

        private function phaseFinish() : void
        {
            Main.GetProcess().fade.setFadeOut(0.3, this.cbFadeOut);
            return;
        }// end function

        private function controlFinish(param1:Number) : void
        {
            return;
        }// end function

        private function phaseClose() : void
        {
            return;
        }// end function

        private function controlClose() : void
        {
            return;
        }// end function

        private function cbFadeOut() : void
        {
            this.setPhase(this._PHASE_CLOSE);
            return;
        }// end function

    }
}
