package quest
{
    import flash.display.*;
    import message.*;
    import resource.*;
    import sound.*;
    import utility.*;

    public class QuestGossipBalloon extends Object
    {
        private var _mc:MovieClip;
        private var _isoMain:InStayOut;
        private var _time:Number;

        public function QuestGossipBalloon(param1:DisplayObjectContainer, param2:String, param3:Number, param4:Number, param5:Number)
        {
            this._mc = ResourceManager.getInstance().createMovieClip(ResourcePath.QUEST_PATH + "UI_QuestMap.swf", "fukiMove");
            TextControl.setText(this._mc.fukiTopMc.textMc.textDt, param2);
            param1.addChild(this._mc);
            this._isoMain = new InStayOut(this._mc);
            this._isoMain.setIn();
            this._mc.x = param3;
            this._mc.y = param4;
            this._time = param5;
            SoundManager.getInstance().playSe(SoundId.SE_BALLOON);
            return;
        }// end function

        public function isEnd() : Boolean
        {
            return this._isoMain.bClosed;
        }// end function

        public function release() : void
        {
            this._isoMain.release();
            this._isoMain = null;
            if (this._mc.parent)
            {
                this._mc.parent.removeChild(this._mc);
            }
            this._mc = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            if (this._time > 0)
            {
                this._time = this._time - param1;
                if (this._time <= 0)
                {
                    this._isoMain.setOut();
                }
            }
            return;
        }// end function

    }
}
