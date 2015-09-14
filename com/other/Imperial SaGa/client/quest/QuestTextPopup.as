package quest
{
    import flash.display.*;
    import message.*;
    import resource.*;
    import sound.*;
    import utility.*;

    public class QuestTextPopup extends Object
    {
        private var _mc:MovieClip;
        private var _isoMain:InStayOut;
        private var _cbFunc:Function;
        private var _stayWait:Number;
        private var _bClosed:Boolean;
        private var _playSeId:int;
        public static const TEXT_COLOR_WHITE:int = 0;
        public static const TEXT_COLOR_BLUE:int = 1;
        public static const TEXT_COLOR_RED:int = 2;
        public static const _TEXT_WAIT:Number = 2;

        public function QuestTextPopup(param1:DisplayObjectContainer)
        {
            this._mc = ResourceManager.getInstance().createMovieClip(ResourcePath.QUEST_PATH + QuestMap.getResourceName(), "EventPop_TextEventMc");
            param1.addChild(this._mc);
            this._isoMain = new InStayOut(this._mc);
            this._stayWait = 0;
            return;
        }// end function

        public function get bClosed() : Boolean
        {
            return this._bClosed;
        }// end function

        public function setPlaySeId(param1:int) : void
        {
            this._playSeId = param1;
            return;
        }// end function

        public function release() : void
        {
            if (this._mc.parent)
            {
                this._mc.parent.removeChild(this._mc);
            }
            this._mc = null;
            this._isoMain.release();
            return;
        }// end function

        public function control(param1:Number) : void
        {
            if (this._stayWait > 0)
            {
                this._stayWait = this._stayWait - param1;
                if (this._stayWait <= 0)
                {
                    this._isoMain.setOut(this.cbTextOut);
                }
            }
            return;
        }// end function

        public function setInText(param1:String, param2:Function = null, param3:int = 0) : void
        {
            TextControl.setText(this._mc.textEventMc.texrMc.textDt, param1);
            this._cbFunc = param2;
            this._bClosed = false;
            switch(param3)
            {
                case TEXT_COLOR_WHITE:
                {
                    this._mc.textEventMc.gotoAndStop("textColor1");
                    break;
                }
                case TEXT_COLOR_BLUE:
                {
                    this._mc.textEventMc.gotoAndStop("textColor2");
                    break;
                }
                case TEXT_COLOR_RED:
                {
                    this._mc.textEventMc.gotoAndStop("textColor3");
                    break;
                }
                default:
                {
                    break;
                }
            }
            this._isoMain.setIn(this.cbTextIn);
            this._playSeId = SoundId.SE_CAPTION1;
            return;
        }// end function

        public function setInIdText(param1:int, param2:Function = null, param3:int = 0) : void
        {
            this.setInText(MessageManager.getInstance().getMessage(param1), param2, param3);
            return;
        }// end function

        private function cbTextIn() : void
        {
            this._stayWait = _TEXT_WAIT;
            SoundManager.getInstance().playSe(this._playSeId);
            return;
        }// end function

        private function cbTextOut() : void
        {
            this._bClosed = true;
            if (this._cbFunc != null)
            {
                this._cbFunc();
            }
            return;
        }// end function

        public static function getSoundId() : int
        {
            return SoundId.SE_CAPTION1;
        }// end function

    }
}
