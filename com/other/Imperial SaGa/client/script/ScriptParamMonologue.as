package script
{
    import flash.display.*;
    import message.*;
    import resource.*;
    import utility.*;

    public class ScriptParamMonologue extends ScriptParamBase
    {
        private var _mc:MovieClip;
        private var _isoMain:InStayOut;
        private var _waitTime:Number;
        private var _cbEnd:Function;
        private var _bWait:Boolean;
        private var _bEnd:Boolean;

        public function ScriptParamMonologue()
        {
            this._waitTime = 0;
            this._bEnd = false;
            return;
        }// end function

        override public function release() : void
        {
            super.release();
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
            this._cbEnd = null;
            return;
        }// end function

        public function setParam(param1:String, param2:Number, param3:Function) : void
        {
            this._mc = ResourceManager.getInstance().createMovieClip(ScriptManager.getResourcePath(), "EventMonologueMc");
            this._isoMain = new InStayOut(this._mc);
            TextControl.setText(this._mc.textMc.textDt, param1);
            this._waitTime = param2;
            this._cbEnd = param3;
            return;
        }// end function

        public function play(param1:DisplayObjectContainer) : void
        {
            param1.addChild(this._mc);
            this._isoMain.setIn(this.cbIn);
            return;
        }// end function

        public function control(param1:Number) : void
        {
            if (this._bWait)
            {
                this._waitTime = this._waitTime - param1;
                if (this._waitTime <= 0)
                {
                    this._bWait = false;
                    this._isoMain.setOut(this._cbEnd);
                }
            }
            return;
        }// end function

        private function cbIn() : void
        {
            this._bWait = true;
            return;
        }// end function

    }
}
