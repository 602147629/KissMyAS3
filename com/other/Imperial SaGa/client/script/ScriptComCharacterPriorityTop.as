package script
{
    import flash.display.*;
    import utility.*;

    public class ScriptComCharacterPriorityTop extends ScriptComBase
    {
        private var _name:String;

        public function ScriptComCharacterPriorityTop()
        {
            super(ScriptComConstant.COMMAND_CATEGORY_SET);
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
            var _loc_1:* = ScriptManager.getInstance().getCharacter(this._name);
            if (_loc_1 == null)
            {
                Assert.print("キャラ【" + this._name + "】が作成されていません");
            }
            if (_loc_1.mc.parent == null)
            {
                Assert.print("キャラ【" + this._name + "】がLayerに追加されていません");
            }
            var _loc_2:* = _loc_1.mc.parent;
            ScriptManager.getInstance().topPriority(_loc_2, _loc_1.mc);
            _bCommandEnd = true;
            return;
        }// end function

    }
}
