package script
{
    import flash.display.*;
    import message.*;
    import resource.*;
    import utility.*;

    public class ScriptInformation extends Object
    {
        private const _STAY_TIME:Number = 2;
        private var _uniquId:uint;
        private var _mc:MovieClip;
        private var _inStayOut:InStayOut;
        private var _bEnd:Boolean;
        private var _waitTime:Number;

        public function ScriptInformation(param1:DisplayObjectContainer)
        {
            this._mc = ResourceManager.getInstance().createMovieClip(ScriptManager.getResourcePath(), "EventPop_GetEventMc");
            param1.addChild(this._mc);
            this._inStayOut = new InStayOut(this._mc);
            this._uniquId = UniqueIdUtil.createUniqueId();
            this._waitTime = 0;
            return;
        }// end function

        public function get uniquId() : int
        {
            return this._uniquId;
        }// end function

        public function get bEnd() : Boolean
        {
            return this._bEnd;
        }// end function

        public function release() : void
        {
            if (this._inStayOut)
            {
                this._inStayOut.release();
            }
            this._inStayOut = null;
            if (this._mc != null && this._mc.parent != null)
            {
                this._mc.parent.removeChild(this._mc);
            }
            this._mc = null;
            return;
        }// end function

        public function setStart(param1:String) : void
        {
            TextControl.setText(this._mc.texrMc.textDt, param1);
            this._waitTime = this._STAY_TIME;
            this._inStayOut.setIn(this.cbStart);
            return;
        }// end function

        private function cbStart() : void
        {
            return;
        }// end function

        private function cbEnd() : void
        {
            this._bEnd = true;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            if (this._inStayOut != null && this._inStayOut.bOpened)
            {
                this._waitTime = this._waitTime - param1;
                if (this._waitTime <= 0)
                {
                    this._inStayOut.setOut(this.cbEnd);
                }
            }
            return;
        }// end function

    }
}
