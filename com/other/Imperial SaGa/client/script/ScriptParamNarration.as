package script
{
    import flash.display.*;
    import flash.geom.*;
    import message.*;
    import resource.*;
    import sound.*;
    import utility.*;

    public class ScriptParamNarration extends ScriptParamBase
    {
        private var _name:String;
        private var _mes:String;
        private var _mc:MovieClip;
        private var _pos:Point;
        private var _isoMain:InStayOut;
        private var _cbWindowClick:Function;
        private var _textControl:TextControl;
        private var _messageSeId:int;
        private var _messageSpeed:int;
        private var _messageWait:Number;
        private var _wait:Number;
        private var _bMessageStep:Boolean;

        public function ScriptParamNarration()
        {
            this._name = "";
            this._mes = "";
            this._pos = new Point();
            this._mc = null;
            this._messageSeId = Constant.UNDECIDED;
            this.setMessageSpeed(ScriptConstant.MESSAGE_SHOW_SPEED_NORMAL);
            this._messageWait = 0;
            this._wait = 0;
            return;
        }// end function

        public function get name() : String
        {
            return this._name;
        }// end function

        public function get mc() : MovieClip
        {
            return this._mc;
        }// end function

        public function get bOpen() : Boolean
        {
            return this._isoMain.bOpened;
        }// end function

        public function get bClose() : Boolean
        {
            return this._isoMain.bClosed;
        }// end function

        public function set messageSeId(param1:int) : void
        {
            this._messageSeId = param1;
            return;
        }// end function

        public function setMessageSpeed(param1:int) : void
        {
            switch(param1)
            {
                case ScriptComConstant.MESSAGE_SPEED_NORMAL:
                {
                    this._messageSpeed = ScriptConstant.MESSAGE_SHOW_SPEED_NORMAL;
                    break;
                }
                case ScriptComConstant.MESSAGE_SPEED_FAST:
                {
                    this._messageSpeed = ScriptConstant.MESSAGE_SHOW_SPEED_FAST;
                    break;
                }
                case ScriptComConstant.MESSAGE_SPEED_SLOW:
                {
                    this._messageSpeed = ScriptConstant.MESSAGE_SHOW_SPEED_SLOW;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function set messageWait(param1:Number) : void
        {
            this._messageWait = param1;
            return;
        }// end function

        override public function release() : void
        {
            this._textControl.release();
            this._textControl = null;
            if (this._isoMain)
            {
                this._isoMain.release();
            }
            this._isoMain = null;
            if (this._mc)
            {
                if (this._mc.parent)
                {
                    this._mc.parent.removeChild(this._mc);
                }
            }
            this._mc = null;
            return;
        }// end function

        public function setParam(param1:String, param2:Point) : void
        {
            this._name = param1;
            this._pos = param2.clone();
            this._mc = ResourceManager.getInstance().createMovieClip(ScriptManager.getResourcePath(), "EventNarrationMc");
            this._isoMain = new InStayOut(this._mc);
            this._mc.x = this._pos.x;
            this._mc.y = this._pos.y;
            this.setNextIcon(false);
            return;
        }// end function

        public function setMessage(param1:String, param2:Boolean, param3:Function) : void
        {
            this._mes = param1;
            this._textControl = new TextControl(this._mc.narrationBalloonMc.textMc.textDt);
            this._textControl.startMessage(this._mes);
            this.setNextIcon(param2);
            if (this._isoMain.bClosed)
            {
                this.param3();
                this._cbWindowClick = null;
            }
            else
            {
                this._cbWindowClick = param3;
                ScriptManager.getInstance().openNextButton(this);
            }
            this._bMessageStep = true;
            this._wait = this._messageWait;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            if (this._bMessageStep == false)
            {
                return;
            }
            if (this._textControl != null && this._messageSpeed != 0)
            {
                this._wait = this._wait - param1;
                if (this._wait <= 0)
                {
                    this._wait = this._messageWait;
                    if (this._messageSeId != Constant.UNDECIDED)
                    {
                        SoundManager.getInstance().playSe(this._messageSeId);
                    }
                    if (this._textControl.nextMessage(this._messageSpeed) == false)
                    {
                        this._bMessageStep = false;
                    }
                }
            }
            return;
        }// end function

        public function setAdvance() : void
        {
            if (this._cbWindowClick != null)
            {
                this._cbWindowClick();
                this._cbWindowClick = null;
            }
            return;
        }// end function

        private function setNextIcon(param1:Boolean) : void
        {
            this._mc.narrationBalloonMc.pageSkipMc.visible = param1;
            return;
        }// end function

        public function setIn(param1:Function, param2:Function) : void
        {
            this._isoMain.setIn(param1);
            this._cbWindowClick = param2;
            ScriptManager.getInstance().openNextButton(this);
            return;
        }// end function

        public function setStay() : void
        {
            this._isoMain.setStay();
            return;
        }// end function

        public function setOut(param1:Function) : void
        {
            this._isoMain.setOut(param1);
            return;
        }// end function

        public function setEnd() : void
        {
            this._isoMain.setEnd();
            return;
        }// end function

    }
}
