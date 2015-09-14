package script
{

    public class ScriptComShake extends ScriptComBase
    {
        private var _waitTime:Number;
        private var _time:Number;
        private var _width:int;
        private var _height:int;

        public function ScriptComShake()
        {
            super(ScriptComConstant.COMMAND_CATEGORY_SET);
            this._waitTime = 0;
            this._time = 0;
            return;
        }// end function

        override public function setXml(param1:XML) : void
        {
            super.setXml(param1);
            this._width = int(param1.width);
            this._height = int(param1.height);
            this._waitTime = Number(param1.waitTime);
            return;
        }// end function

        override public function commandInit() : void
        {
            super.commandInit();
            this._time = 0;
            var _loc_1:* = ScriptManager.getInstance().shake;
            if (_loc_1 == null)
            {
                _loc_1 = new ScriptParamShake();
                ScriptManager.getInstance().shake = _loc_1;
            }
            _loc_1.setParam(this._width, this._height);
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
            var _loc_2:* = ScriptManager.getInstance().shake;
            if (_loc_2 != null)
            {
                this._time = this._time + param1;
                if (this._time >= this._waitTime)
                {
                    _loc_2.stop();
                    _bCommandEnd = true;
                }
            }
            return;
        }// end function

    }
}
