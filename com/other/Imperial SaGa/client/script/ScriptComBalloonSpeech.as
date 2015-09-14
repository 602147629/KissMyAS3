package script
{
    import utility.*;

    public class ScriptComBalloonSpeech extends ScriptComBase
    {
        private var _name:String;
        private var _message:String;
        private var _bEnd:Boolean;

        public function ScriptComBalloonSpeech()
        {
            super(ScriptComConstant.COMMAND_CATEGORY_DISP);
            this._name = "";
            this._message = "";
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
            var _loc_1:* = ScriptManager.getInstance().getBalloon(this._name);
            if (_loc_1 == null)
            {
                Assert.print("フキダシ【" + this._name + "】が作成されていません");
            }
            this._message = ScriptChangeKeyword.changeKeyword(ScriptConstant.SCRIPT_COMMAND_NOW_EMPEROR, this._message);
            _loc_1.setSpeech(this._message, this._bEnd, this.cbBalloonClick);
            ScriptManager.getInstance().setBalloonDarkout(this._name);
            if (_loc_1.aCharacterName.length > 0)
            {
                ScriptManager.getInstance().setDarkoutCharacter(_loc_1.aCharacterName);
            }
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

        private function cbBalloonClick() : void
        {
            _bCommandEnd = true;
            return;
        }// end function

    }
}
