package script
{
    import utility.*;

    public class ScriptComNarrationSetMessageSe extends ScriptComBase
    {
        private var _name:String;
        private var _seId:int;

        public function ScriptComNarrationSetMessageSe()
        {
            super(ScriptComConstant.COMMAND_CATEGORY_SET);
            this._seId = Constant.UNDECIDED;
            return;
        }// end function

        override public function setXml(param1:XML) : void
        {
            super.setXml(param1);
            this._name = param1.name;
            this._seId = param1.id;
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
            _loc_1.messageSeId = this._seId;
            _bCommandEnd = true;
            return;
        }// end function

    }
}
