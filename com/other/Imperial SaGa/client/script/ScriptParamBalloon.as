package script
{
    import flash.display.*;
    import flash.geom.*;
    import message.*;
    import resource.*;
    import sound.*;
    import utility.*;

    public class ScriptParamBalloon extends ScriptParamBase
    {
        private var _name:String;
        private var _title:String;
        private var _mes:String;
        private var _mc:MovieClip;
        private var _pos:Point;
        private var _type:int;
        private var _messageSeId:int;
        private var _messageSpeed:int;
        private var _messageWait:Number;
        private var _wait:Number;
        private var _isoMain:InStayOut;
        private var _cbBalloonClick:Function;
        private var _aCharacterName:Array;
        private var _textControl:TextControl;
        private var _bMessageStep:Boolean;
        private static const _LABEL_BALLOON1:String = "balloon1";
        private static const _LABEL_BALLOON2:String = "balloon2";
        private static const _LABEL_BALLOON3:String = "balloon3";
        private static const _LABEL_BALLOON4:String = "balloon4";
        private static const _LABEL_BALLOON5:String = "balloon5";
        private static const _LABEL_BALLOON1_DARKOUT:String = "balloon1_darkout";
        private static const _LABEL_BALLOON2_DARKOUT:String = "balloon2_darkout";
        private static const _LABEL_BALLOON3_DARKOUT:String = "balloon3_darkout";
        private static const _LABEL_BALLOON4_DARKOUT:String = "balloon4_darkout";
        private static const _LABEL_BALLOON5_DARKOUT:String = "balloon5_darkout";

        public function ScriptParamBalloon()
        {
            this._name = "";
            this._title = "";
            this._mes = "";
            this._pos = new Point();
            this._type = 0;
            this._aCharacterName = [];
            this._mc = null;
            this._messageSeId = Constant.UNDECIDED;
            this.setMessageSpeed(ScriptComConstant.MESSAGE_SPEED_NORMAL);
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

        public function get bOpen() : Boolean
        {
            return this._isoMain.bOpened;
        }// end function

        public function get bClose() : Boolean
        {
            return this._isoMain.bClosed;
        }// end function

        public function get aCharacterName() : Array
        {
            return this._aCharacterName.concat();
        }// end function

        public function set aCharacterName(param1:Array) : void
        {
            this._aCharacterName = param1.concat();
            return;
        }// end function

        override public function release() : void
        {
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
            this._aCharacterName = [];
            return;
        }// end function

        public function setParam(param1:String, param2:int, param3:Point, param4:String) : void
        {
            this._name = param1;
            this._title = param4;
            this._pos = param3.clone();
            this._type = param2;
            this._mc = ResourceManager.getInstance().createMovieClip(ScriptManager.getResourcePath(), "EventBalloonMc");
            switch(this._type)
            {
                case ScriptComConstant.BALLOON_TYPE1:
                {
                    this._mc.balloonMc.gotoAndStop(_LABEL_BALLOON1);
                    break;
                }
                case ScriptComConstant.BALLOON_TYPE2:
                {
                    this._mc.balloonMc.gotoAndStop(_LABEL_BALLOON2);
                    break;
                }
                case ScriptComConstant.BALLOON_TYPE3:
                {
                    this._mc.balloonMc.gotoAndStop(_LABEL_BALLOON3);
                    break;
                }
                case ScriptComConstant.BALLOON_TYPE4:
                {
                    this._mc.balloonMc.gotoAndStop(_LABEL_BALLOON4);
                    break;
                }
                case ScriptComConstant.BALLOON_TYPE5:
                {
                    this._mc.balloonMc.gotoAndStop(_LABEL_BALLOON5);
                    break;
                }
                default:
                {
                    break;
                }
            }
            this._isoMain = new InStayOut(this._mc);
            TextControl.setText(this._mc.balloonMc.charaNameMc.textMc.textDt, this._title);
            this._mc.x = this._pos.x;
            this._mc.y = this._pos.y;
            this.setNextIcon(false);
            return;
        }// end function

        public function setSpeech(param1:String, param2:Boolean, param3:Function) : void
        {
            this._mes = param1;
            if (this._messageWait == 0)
            {
                TextControl.setText(this._mc.balloonMc.textMc.textDt, this._mes);
                this._bMessageStep = false;
            }
            else
            {
                this._textControl = new TextControl(this._mc.balloonMc.textMc.textDt);
                this._textControl.startMessage(this._mes);
                this._bMessageStep = true;
            }
            this.setNextIcon(param2);
            if (this._isoMain.bClosed)
            {
                this.param3();
                this._cbBalloonClick = null;
            }
            else
            {
                this._cbBalloonClick = param3;
                ScriptManager.getInstance().openNextButton(this);
            }
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
            if (this._cbBalloonClick != null)
            {
                this._cbBalloonClick();
                this._cbBalloonClick = null;
            }
            return;
        }// end function

        private function setNextIcon(param1:Boolean) : void
        {
            this._mc.balloonMc.pageSkipMc.visible = param1;
            return;
        }// end function

        public function setIn(param1:Function, param2:Function) : void
        {
            this._isoMain.setIn(param1);
            this._cbBalloonClick = param2;
            ScriptManager.getInstance().openNextButton(this);
            return;
        }// end function

        public function setStay() : void
        {
            this._isoMain.setStay();
            this._cbBalloonClick = null;
            ScriptManager.getInstance().openNextButton(this);
            return;
        }// end function

        public function setOut(param1:Function) : void
        {
            this._isoMain.setOut(param1);
            ScriptManager.getInstance().closeNextButton();
            return;
        }// end function

        public function setEnd() : void
        {
            this._isoMain.setEnd();
            ScriptManager.getInstance().closeNextButton();
            return;
        }// end function

        public function setDarkout(param1:Boolean) : void
        {
            var _loc_2:* = "";
            switch(this._type)
            {
                case ScriptComConstant.BALLOON_TYPE1:
                {
                    _loc_2 = param1 ? (_LABEL_BALLOON1_DARKOUT) : (_LABEL_BALLOON1);
                    break;
                }
                case ScriptComConstant.BALLOON_TYPE2:
                {
                    _loc_2 = param1 ? (_LABEL_BALLOON2_DARKOUT) : (_LABEL_BALLOON2);
                    break;
                }
                case ScriptComConstant.BALLOON_TYPE3:
                {
                    _loc_2 = param1 ? (_LABEL_BALLOON3_DARKOUT) : (_LABEL_BALLOON3);
                    break;
                }
                case ScriptComConstant.BALLOON_TYPE4:
                {
                    _loc_2 = param1 ? (_LABEL_BALLOON4_DARKOUT) : (_LABEL_BALLOON4);
                    break;
                }
                case ScriptComConstant.BALLOON_TYPE5:
                {
                    _loc_2 = param1 ? (_LABEL_BALLOON5_DARKOUT) : (_LABEL_BALLOON5);
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (_loc_2 != "" && this._mc.balloonMc.currentLabel != _loc_2)
            {
                this._mc.balloonMc.gotoAndStop(_loc_2);
            }
            return;
        }// end function

    }
}
