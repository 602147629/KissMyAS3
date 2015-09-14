package script
{
    import utility.*;

    public class ScriptComNarrationClose extends ScriptComBase
    {
        private var _name:String;

        public function ScriptComNarrationClose()
        {
            super(ScriptComConstant.COMMAND_CATEGORY_DISP);
            return;
        }// end function

        override public function setXml(param1:XML) : void
        {
            super.setXml(param1);
            this._name = param1.name;
            return;
        }// end function

        override public function commandInit() : void
        {
            super.commandInit();
            var _loc_1:* = ScriptManager.getInstance().getNarration(this._name);
            if (_loc_1 == null)
            {
                Assert.print("指定ナレーションウィンドウが作成されていません");
            }
            _loc_1.setOut(this.cbOut);
            return;
        }// end function

        override public function commandSkip() : int
        {
            var _loc_1:* = ScriptManager.getInstance().getNarration(this._name);
            if (_loc_1)
            {
                _loc_1.setEnd();
            }
            this.cbOut();
            return ScriptComConstant.COMMAND_SKIP_RESULT_FINISH;
        }// end function

        override public function isCommandSkipEnable() : Boolean
        {
            return true;
        }// end function

        override public function commandControl(param1:Number) : void
        {
            return;
        }// end function

        private function cbOut() : void
        {
            _bCommandEnd = true;
            return;
        }// end function

    }
}
