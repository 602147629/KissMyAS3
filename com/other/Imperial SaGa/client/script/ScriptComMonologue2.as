package script
{
    import utility.*;

    public class ScriptComMonologue2 extends ScriptComBase
    {
        private var _mes:String;
        private var _monologueId:uint;

        public function ScriptComMonologue2()
        {
            super(ScriptComConstant.COMMAND_CATEGORY_DISP);
            this._mes = null;
            return;
        }// end function

        override public function setXml(param1:XML) : void
        {
            super.setXml(param1);
            this._mes = StringTools.xmlLineToStringLine(param1.message);
            return;
        }// end function

        override public function commandInit() : void
        {
            super.commandInit();
            this._monologueId = ScriptManager.getInstance().addMonologue2(this._mes, ScriptParamMonologue2.DEFAULT_STAY_TIME);
            return;
        }// end function

        override public function commandSkip() : int
        {
            ScriptManager.getInstance().deleteMonologue2(this._monologueId);
            _bCommandEnd = true;
            return ScriptComConstant.COMMAND_SKIP_RESULT_FINISH;
        }// end function

        override public function isCommandSkipEnable() : Boolean
        {
            return true;
        }// end function

        override public function commandControl(param1:Number) : void
        {
            if (ScriptManager.getInstance().isAliveMonologue2(this._monologueId) == false)
            {
                _bCommandEnd = true;
            }
            return;
        }// end function

    }
}
