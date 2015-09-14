package script
{
    import utility.*;

    public class ScriptComBalloonSetMessageWait extends ScriptComBase
    {
        private var _name:String;
        private var _wait:Number;

        public function ScriptComBalloonSetMessageWait()
        {
            super(ScriptComConstant.COMMAND_CATEGORY_SET);
            this._wait = 0;
            return;
        }// end function

        override public function setXml(param1:XML) : void
        {
            super.setXml(param1);
            this._name = param1.name;
            this._wait = Number(param1.second);
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
            _loc_1.messageWait = this._wait;
            _bCommandEnd = true;
            return;
        }// end function

    }
}
