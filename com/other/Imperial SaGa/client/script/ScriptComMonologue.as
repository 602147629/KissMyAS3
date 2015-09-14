package script
{
    import utility.*;

    public class ScriptComMonologue extends ScriptComBase
    {
        private var _waitTime:Number;
        private var _message:String;

        public function ScriptComMonologue()
        {
            super(ScriptComConstant.COMMAND_CATEGORY_DISP);
            this._message = "";
            return;
        }// end function

        override public function setXml(param1:XML) : void
        {
            super.setXml(param1);
            this._message = StringTools.xmlLineToStringLine(param1.message);
            this._waitTime = Number(param1.waitTime);
            return;
        }// end function

        override public function commandInit() : void
        {
            super.commandInit();
            var _loc_1:* = new ScriptParamMonologue();
            _loc_1.setParam(this._message, this._waitTime, this.cbOut);
            ScriptManager.getInstance().addMonologue(_loc_1);
            _loc_1.play(ScriptManager.getInstance().getMonologueLayer());
            return;
        }// end function

        override public function commandSkip() : int
        {
            this.cbOut();
            return ScriptComConstant.COMMAND_SKIP_RESULT_FINISH;
        }// end function

        override public function isCommandSkipEnable() : Boolean
        {
            return true;
        }// end function

        private function cbOut() : void
        {
            _bCommandEnd = true;
            ScriptManager.getInstance().removeMonologue();
            return;
        }// end function

    }
}
