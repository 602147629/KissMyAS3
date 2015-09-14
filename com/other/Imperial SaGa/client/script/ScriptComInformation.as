package script
{

    public class ScriptComInformation extends ScriptComBase
    {
        private var _mes:String;
        private var _informationId:uint;

        public function ScriptComInformation()
        {
            super(ScriptComConstant.COMMAND_CATEGORY_DISP);
            this._mes = null;
            return;
        }// end function

        override public function setXml(param1:XML) : void
        {
            super.setXml(param1);
            this._mes = String(param1.message).toString();
            return;
        }// end function

        override public function commandInit() : void
        {
            super.commandInit();
            this._informationId = ScriptManager.getInstance().addInformation(this._mes);
            return;
        }// end function

        override public function commandSkip() : int
        {
            ScriptManager.getInstance().deleteInformation(this._informationId);
            _bCommandEnd = true;
            return ScriptComConstant.COMMAND_SKIP_RESULT_FINISH;
        }// end function

        override public function isCommandSkipEnable() : Boolean
        {
            return true;
        }// end function

        override public function commandControl(param1:Number) : void
        {
            if (ScriptManager.getInstance().isAliveInformation(this._informationId) == false)
            {
                _bCommandEnd = true;
            }
            return;
        }// end function

    }
}
