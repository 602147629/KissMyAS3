package script
{
    import flash.display.*;
    import utility.*;

    public class ScriptParamShake extends ScriptParamBase
    {
        private var _shake:Shake;

        public function ScriptParamShake()
        {
            return;
        }// end function

        override public function release() : void
        {
            if (this._shake != null)
            {
                this._shake.release();
            }
            return;
        }// end function

        private function shakeRelease() : void
        {
            if (this._shake != null)
            {
                this._shake.release();
                this._shake = null;
            }
            return;
        }// end function

        public function setParam(param1:int, param2:int) : void
        {
            this.shakeRelease();
            var _loc_3:* = ScriptManager.getInstance().getLayerScreen();
            this._shake = new Shake(_loc_3, param1, param2);
            return;
        }// end function

        public function control(param1:Number) : void
        {
            if (this._shake == null)
            {
                return;
            }
            this._shake.control(param1);
            return;
        }// end function

        public function stop() : void
        {
            this.shakeRelease();
            return;
        }// end function

    }
}
