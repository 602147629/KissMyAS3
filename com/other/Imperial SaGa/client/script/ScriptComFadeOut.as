package script
{

    public class ScriptComFadeOut extends ScriptComBase
    {
        private var _waitTime:Number;
        private var _color:uint;

        public function ScriptComFadeOut()
        {
            super(ScriptComConstant.COMMAND_CATEGORY_DISP);
            this._waitTime = 0;
            return;
        }// end function

        override public function setXml(param1:XML) : void
        {
            super.setXml(param1);
            this._waitTime = Number(param1.waitTime);
            this._color = uint(param1.color);
            return;
        }// end function

        override public function commandInit() : void
        {
            super.commandInit();
            var _loc_1:* = ScriptManager.getInstance().getFade();
            _loc_1.setParamFadeOut(this._waitTime, this._color);
            return;
        }// end function

        override public function commandSkip() : int
        {
            var _loc_1:* = ScriptManager.getInstance().getFade();
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
            var _loc_2:* = ScriptManager.getInstance().getFade();
            if (_loc_2 != null && _loc_2.bFadeEnd)
            {
                _bCommandEnd = true;
            }
            return;
        }// end function

    }
}
