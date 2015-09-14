package script
{

    public class ScriptComBackgroundFadeOut extends ScriptComBase
    {
        private var _name:String;
        private var _useTime:Number;
        private var _time:Number;

        public function ScriptComBackgroundFadeOut()
        {
            super(ScriptComConstant.COMMAND_CATEGORY_DISP);
            this._name = "";
            return;
        }// end function

        override public function setXml(param1:XML) : void
        {
            super.setXml(param1);
            this._name = param1.name;
            this._useTime = param1.useTime;
            return;
        }// end function

        override public function commandInit() : void
        {
            super.commandInit();
            this._time = 0;
            return;
        }// end function

        override public function commandSkip() : int
        {
            this._time = this._useTime;
            this.commandControl(0);
            return ScriptComConstant.COMMAND_SKIP_RESULT_FINISH;
        }// end function

        override public function isCommandSkipEnable() : Boolean
        {
            return true;
        }// end function

        override public function commandControl(param1:Number) : void
        {
            var _loc_3:* = NaN;
            var _loc_2:* = ScriptManager.getInstance().getBackground(this._name);
            this._time = this._time + param1;
            if (this._useTime > 0)
            {
                _loc_3 = 1 - this._time / this._useTime;
                if (_loc_3 < 0)
                {
                    _loc_3 = 0;
                }
                _loc_2.alpha = _loc_3;
            }
            if (this._time >= this._useTime)
            {
                _loc_2.setVisible(false);
                _bCommandEnd = true;
            }
            return;
        }// end function

    }
}
