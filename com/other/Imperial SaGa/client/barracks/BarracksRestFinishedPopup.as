package barracks
{
    import button.*;
    import flash.display.*;
    import input.*;
    import resource.*;
    import sound.*;
    import utility.*;

    public class BarracksRestFinishedPopup extends Object
    {
        private var _phase:int;
        private var _mcBase:MovieClip;
        private var _mcInfo:MovieClip;
        private var _isoMain:InStayOut;
        private var _btnNext:ButtonBase;
        private var _cbNext:Function;
        private var _aMessage:Array;
        private var _messageIndex:int;
        private static const _PHASE_OPEN:int = 1;
        private static const _PHASE_MAIN:int = 2;
        private static const _PHASE_CLOSE:int = 3;

        public function BarracksRestFinishedPopup(param1:DisplayObjectContainer, param2:Function)
        {
            this._mcBase = ResourceManager.getInstance().createMovieClip(ResourcePath.FACILITY_PATH + "UI_Barracks.swf", "RecoveryFinishMc");
            this._mcInfo = this._mcBase.successInfoMc;
            this._btnNext = new ButtonBase(null, this.cbNextButton);
            this._btnNext.setHitMovieClip(this._mcBase);
            this._btnNext.enterSeId = ButtonBase.SE_DECIDE_ID;
            this._btnNext.overSeId = Constant.UNDECIDED;
            ButtonManager.getInstance().addButtonBase(this._btnNext);
            param1.addChild(this._mcBase);
            this._cbNext = param2;
            this._isoMain = new InStayOut(this._mcBase);
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
            }
            this._btnNext = null;
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
                this._btnNext.setDisableFlag(true);
            }
            ButtonManager.getInstance().seal([this._btnNext]);
            InputManager.getInstance().setDisable(true);
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
                this._btnNext.setDisableFlag(false);
            }
            return;
        }// end function

        private function initPhaseClose() : void
        {
            if (this._btnNext)
            {
                this._btnNext.setDisableFlag(true);
            }
            this._isoMain.setOut(function () : void
            {
                InputManager.getInstance().setDisable(false);
                ButtonManager.getInstance().unseal();
                if (_cbNext != null)
                {
                    _cbNext();
                }
                return;
            }// end function
            );
            return;
        }// end function

        private function cbNextButton(param1:int) : void
        {
            this.setPhase(_PHASE_CLOSE);
            return;
        }// end function

    }
}
