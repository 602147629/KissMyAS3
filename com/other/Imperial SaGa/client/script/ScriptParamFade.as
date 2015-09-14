package script
{
    import flash.display.*;
    import utility.*;

    public class ScriptParamFade extends ScriptParamBase
    {
        private var _fade:Fade;
        private var _waitTime:Number;

        public function ScriptParamFade()
        {
            this._fade = null;
            this._waitTime = 0;
            return;
        }// end function

        public function get bFadeEnd() : Boolean
        {
            return this._fade.isFadeEnd();
        }// end function

        override public function release() : void
        {
            if (this._fade != null)
            {
                this._fade.release();
            }
            this._fade = null;
            return;
        }// end function

        public function setParamFadeIn(param1:Number, param2:uint) : void
        {
            var _loc_3:* = null;
            this._waitTime = param1;
            if (this._fade == null)
            {
                _loc_3 = ScriptManager.getInstance().getFadeLayer();
                this._fade = new Fade(_loc_3);
            }
            this._fade.setColor(param2);
            this._fade.setFadeIn(this._waitTime);
            return;
        }// end function

        public function setParamFadeOut(param1:Number, param2:uint) : void
        {
            var _loc_3:* = null;
            this._waitTime = param1;
            if (this._fade == null)
            {
                _loc_3 = ScriptManager.getInstance().getFadeLayer();
                this._fade = new Fade(_loc_3);
            }
            this._fade.setColor(param2);
            this._fade.setFadeOut(this._waitTime);
            return;
        }// end function

        public function setEndFadeIn() : void
        {
            if (this._fade == null)
            {
                return;
            }
            this._fade.setFadeIn(0);
            this._fade.control(0);
            return;
        }// end function

        public function setEndFadeOut() : void
        {
            if (this._fade == null)
            {
                return;
            }
            this._fade.setFadeOut(0);
            this._fade.control(0);
            return;
        }// end function

        public function control(param1:Number) : void
        {
            if (this._fade == null)
            {
                return;
            }
            this._fade.control(param1);
            return;
        }// end function

    }
}
