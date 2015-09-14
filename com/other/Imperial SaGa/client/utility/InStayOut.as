package utility
{
    import flash.display.*;
    import flash.events.*;

    public class InStayOut extends Object
    {
        private const _LABEL_WAIT:String = "stop";
        private const _LABEL_IN:String = "in";
        private const _LABEL_STAY:String = "stay";
        private const _LABEL_OUT:String = "out";
        private const _LABEL_END:String = "end";
        private const _PHASE_WAIT:int = 0;
        private const _PHASE_IN:int = 1;
        private const _PHASE_STAY:int = 2;
        private const _PHASE_OUT:int = 3;
        private const _PHASE_OUT_TO_STAY:int = 4;
        private const _PHASE_END:int = 5;
        private var _mc:MovieClip;
        private var _phase:int = 0;
        private var _setLabel:String;
        private var _nextPhase:int;
        private var _callFunc:Function;
        private var _bVisible:Boolean;

        public function InStayOut(param1:MovieClip, param2:Boolean = false)
        {
            this._bVisible = param2;
            this._mc = param1;
            this._mc.visible = this._bVisible;
            this._mc.gotoAndStop(this._LABEL_WAIT);
            this._mc.addEventListener(Event.ENTER_FRAME, this.enterFrame);
            this._phase = this._PHASE_WAIT;
            return;
        }// end function

        public function get bWait() : Boolean
        {
            return this._phase == this._PHASE_WAIT;
        }// end function

        public function get bOpened() : Boolean
        {
            return this._phase == this._PHASE_STAY;
        }// end function

        public function get bClosed() : Boolean
        {
            return this._phase == this._PHASE_END || this._phase == this._PHASE_WAIT;
        }// end function

        public function get bEnd() : Boolean
        {
            return this._phase == this._PHASE_END;
        }// end function

        public function get bAnimetion() : Boolean
        {
            return this._phase == this._PHASE_IN || this._phase == this._PHASE_OUT;
        }// end function

        public function get bAnimetionOpen() : Boolean
        {
            return this._phase == this._PHASE_IN;
        }// end function

        public function get bAnimetionClose() : Boolean
        {
            return this._phase == this._PHASE_OUT;
        }// end function

        public function release() : void
        {
            this._mc.removeEventListener(Event.ENTER_FRAME, this.enterFrame);
            this._mc = null;
            return;
        }// end function

        private function enterFrame(event:Event) : void
        {
            switch(this._phase)
            {
                case this._PHASE_IN:
                {
                    if (this._mc.currentLabel != this._setLabel)
                    {
                        this._phase = this._nextPhase;
                        if (this._callFunc != null)
                        {
                            this._callFunc();
                        }
                    }
                    break;
                }
                case this._PHASE_OUT:
                {
                    if (this._mc.currentLabel != this._setLabel)
                    {
                        if (this._mc.currentLabel == this._LABEL_END)
                        {
                            this._mc.visible = this._bVisible;
                        }
                        this._phase = this._nextPhase;
                        if (this._callFunc != null)
                        {
                            this._callFunc();
                        }
                    }
                    break;
                }
                case this._PHASE_OUT_TO_STAY:
                {
                    if (this._mc.currentLabel != this._setLabel)
                    {
                        this._mc.gotoAndStop(this._LABEL_STAY);
                        this._phase = this._nextPhase;
                        if (this._callFunc != null)
                        {
                            this._callFunc();
                        }
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

        public function setIn(param1:Function = null) : void
        {
            this._mc.visible = true;
            this.setInOut(this._LABEL_IN, this._PHASE_IN, this._PHASE_STAY, param1);
            return;
        }// end function

        public function setInLabel(param1:String, param2:Function = null) : void
        {
            this._mc.visible = true;
            this.setInOut(param1, this._PHASE_IN, this._PHASE_STAY, param2);
            return;
        }// end function

        public function setStay() : void
        {
            this._mc.visible = true;
            this.setInOut(this._LABEL_STAY, this._PHASE_STAY, this._PHASE_STAY, null);
            return;
        }// end function

        public function setOut(param1:Function = null) : void
        {
            this.setInOut(this._LABEL_OUT, this._PHASE_OUT, this._PHASE_END, param1);
            return;
        }// end function

        public function setOutLabel(param1:String, param2:Function = null) : void
        {
            this.setInOut(param1, this._PHASE_OUT, this._PHASE_END, param2);
            return;
        }// end function

        public function setOutToStayLabel(param1:String, param2:Function = null) : void
        {
            this.setInOut(param1, this._PHASE_OUT_TO_STAY, this._PHASE_STAY, param2);
            return;
        }// end function

        public function setEnd() : void
        {
            this._phase = this._PHASE_END;
            this._callFunc = null;
            this._mc.gotoAndStop(this._LABEL_END);
            return;
        }// end function

        private function setInOut(param1:String, param2:int, param3:int, param4:Function) : void
        {
            this._mc.gotoAndPlay(param1);
            this._phase = param2;
            this._setLabel = param1;
            this._nextPhase = param3;
            this._callFunc = param4;
            return;
        }// end function

    }
}
