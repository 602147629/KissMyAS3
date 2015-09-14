package quest
{
    import flash.display.*;
    import message.*;
    import resource.*;
    import utility.*;

    public class QuestTextInformation extends Object
    {
        private var _mc:MovieClip;
        private var _isoMain:InStayOut;
        private var _stayWait:Number;
        private var _cbEndFunc:Function;
        private var _bClosed:Boolean;
        private static const _STAY_WAIT_TIME:Number = 1;

        public function QuestTextInformation(param1:DisplayObjectContainer)
        {
            this._mc = ResourceManager.getInstance().createMovieClip(ResourcePath.QUEST_PATH + QuestMap.getResourceName(), "EventPop_GetEventMc");
            this._stayWait = 0;
            param1.addChild(this._mc);
            this._isoMain = new InStayOut(this._mc);
            return;
        }// end function

        public function get bClosed() : Boolean
        {
            return this._bClosed;
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
                    this._isoMain.setOut(this.cbOut);
                }
            }
            return;
        }// end function

        public function setMessage(param1:int, param2:Function) : void
        {
            TextControl.setIdText(this._mc.texrMc.textDt, param1);
            this._bClosed = false;
            this._cbEndFunc = param2;
            this._isoMain.setIn(this.cbIn);
            return;
        }// end function

        private function cbIn() : void
        {
            this._stayWait = _STAY_WAIT_TIME;
            return;
        }// end function

        private function cbOut() : void
        {
            this._bClosed = true;
            if (this._cbEndFunc != null)
            {
                this._cbEndFunc();
            }
            return;
        }// end function

    }
}
