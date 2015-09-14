package script
{

    public class ScriptComFadeOutAlpha extends ScriptComBase
    {
        private var _waitTime:Number;
        private var _color:uint;
        private var _alpha:Number;

        public function ScriptComFadeOutAlpha()
        {
            super(ScriptComConstant.COMMAND_CATEGORY_DISP);
            return;
        }// end function

        override public function setXml(param1:XML) : void
        {
            super.setXml(param1);
            this._waitTime = Number(param1.waitTime);
            this._color = uint(param1.color);
            this._alpha = Number(param1.alpha);
            return;
        }// end function

        override public function commandInit() : void
        {
            super.commandInit();
            var _loc_1:* = ScriptManager.getInstance().getFadeAlpha();
            _loc_1.setParamFadeOut(this._waitTime, this._color, this._alpha);
            return;
        }// end function

        override public function commandSkip() : int
        {
            var _loc_1:* = ScriptManager.getInstance().getFadeAlpha();
            if (_loc_1 != null && !_loc_1.bFadeEnd)
            {
                _loc_1.setEndFadeOut();
            }
            _bCommandEnd = true;
            return ScriptComConstant.COMMAND_SKIP_RESULT_FINISH;
        }// end function

        override public function isCommandSkipEnable() : Boolean
        {
            return true;
        }// end function

        override public function commandControl(param1:Number) : void
        {
            var _loc_2:* = ScriptManager.getInstance().getFadeAlpha();
            if (_loc_2 != null && _loc_2.bFadeEnd)
            {
                _bCommandEnd = true;
            }
            return;
        }// end function

    }
}
