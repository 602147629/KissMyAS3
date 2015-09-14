package script
{
    import utility.*;

    public class ScriptComNarrationMessage extends ScriptComBase
    {
        private var _name:String;
        private var _message:String;
        private var _bEnd:Boolean;

        public function ScriptComNarrationMessage()
        {
            super(ScriptComConstant.COMMAND_CATEGORY_DISP);
            return;
        }// end function

        override public function setXml(param1:XML) : void
        {
            super.setXml(param1);
            this._name = param1.name;
            this._message = StringTools.xmlLineToStringLine(param1.message);
            this._bEnd = parseInt(param1.bEnd) == 1;
            return;
        }// end function

        override public function commandInit() : void
        {
            super.commandInit();
            var _loc_1:* = ScriptManager.getInstance().getNarration(this._name);
            if (_loc_1 == null)
            {
                Assert.print("指定ナレーションが作成されていません");
            }
            _loc_1.setMessage(this._message, this._bEnd, this.cbWindowClick);
            return;
        }// end function

        override public function commandSkip() : int
        {
            ScriptManager.getInstance().onNextButtonClick();
            return ScriptComConstant.COMMAND_SKIP_RESULT_FINISH;
        }// end function

        override public function isCommandSkipEnable() : Boolean
        {
            return true;
        }// end function

        private function cbWindowClick() : void
        {
            _bCommandEnd = true;
            return;
        }// end function

    }
}
