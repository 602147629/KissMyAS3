package script
{
    import utility.*;

    public class ScriptComCharacterAlpha extends ScriptComBase
    {
        private var _name:String;
        private var _alpha:Number;

        public function ScriptComCharacterAlpha()
        {
            super(ScriptComConstant.COMMAND_CATEGORY_SET);
            this._name = "";
            this._alpha = 1;
            return;
        }// end function

        override public function setXml(param1:XML) : void
        {
            super.setXml(param1);
            this._name = param1.name;
            this._alpha = Number(param1.alpha);
            return;
        }// end function

        override public function commandInit() : void
        {
            super.commandInit();
            var _loc_1:* = ScriptManager.getInstance().getCharacter(this._name);
            if (_loc_1 == null)
            {
                Assert.print("キャラ【" + this._name + "】が作成されていません");
            }
            _loc_1.alpha = this._alpha;
            _bCommandEnd = true;
            return;
        }// end function

    }
}
