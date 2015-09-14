package script
{

    public class ScriptComWait extends ScriptComBase
    {
        private var _time:Number;
        private var _waitTime:Number;

        public function ScriptComWait()
        {
            super(ScriptComConstant.COMMAND_CATEGORY_WAIT);
            return;
        }// end function

        override public function setXml(param1:XML) : void
        {
            super.setXml(param1);
            this._time = 0;
            this._waitTime = param1.waitTime;
            return;
        }// end function

        override public function commandSkip() : int
        {
            this._time = this._waitTime;
            this.commandControl(0);
            return ScriptComConstant.COMMAND_SKIP_RESULT_FINISH;
        }// end function

        override public function isCommandSkipEnable() : Boolean
        {
            return true;
        }// end function

        override public function commandControl(param1:Number) : void
        {
            this._time = this._time + param1;
            if (this._time >= this._waitTime)
            {
                _bCommandEnd = true;
            }
            return;
        }// end function

    }
}
