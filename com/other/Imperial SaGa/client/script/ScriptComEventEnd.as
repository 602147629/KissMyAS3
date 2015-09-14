package script
{
    import utility.*;

    public class ScriptComEventEnd extends ScriptComBase
    {

        public function ScriptComEventEnd()
        {
            super(ScriptComConstant.COMMAND_CATEGORY_DISP);
            return;
        }// end function

        override public function commandInit() : void
        {
            super.commandInit();
            var _loc_1:* = ScriptManager.getInstance().isoEvent;
            _loc_1.setOut(this.cbOut);
            return;
        }// end function

        override public function commandSkip() : int
        {
            var _loc_1:* = ScriptManager.getInstance().isoEvent;
            _loc_1.setEnd();
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
            return;
        }// end function

    }
}
