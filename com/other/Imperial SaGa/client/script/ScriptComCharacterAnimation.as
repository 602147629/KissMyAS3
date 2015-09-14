package script
{
    import flash.display.*;
    import utility.*;

    public class ScriptComCharacterAnimation extends ScriptComBase
    {
        private var _name:String;
        private var _label:String;

        public function ScriptComCharacterAnimation()
        {
            super(ScriptComConstant.COMMAND_CATEGORY_SET);
            this._name = "";
            this._label = "";
            return;
        }// end function

        override public function setXml(param1:XML) : void
        {
            super.setXml(param1);
            this._name = param1.name;
            this._label = param1.label;
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
            var _loc_2:* = _loc_1.mc;
            _loc_2.gotoAndPlay(this._label);
            _bCommandEnd = true;
            return;
        }// end function

    }
}
