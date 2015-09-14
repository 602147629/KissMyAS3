package script
{
    import utility.*;

    public class ScriptComNarrationSetMessageSpeed extends ScriptComBase
    {
        private var _name:String;
        private var _speed:int;

        public function ScriptComNarrationSetMessageSpeed()
        {
            super(ScriptComConstant.COMMAND_CATEGORY_SET);
            return;
        }// end function

        override public function setXml(param1:XML) : void
        {
            super.setXml(param1);
            this._name = param1.name;
            this._speed = param1.speed;
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
            _loc_1.setMessageSpeed(this._speed);
            _bCommandEnd = true;
            return;
        }// end function

    }
}
