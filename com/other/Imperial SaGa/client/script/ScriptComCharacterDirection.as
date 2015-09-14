package script
{
    import flash.display.*;
    import utility.*;

    public class ScriptComCharacterDirection extends ScriptComBase
    {
        private var _name:String;
        private var _bTurnOver:Boolean;

        public function ScriptComCharacterDirection()
        {
            super(ScriptComConstant.COMMAND_CATEGORY_SET);
            return;
        }// end function

        override public function setXml(param1:XML) : void
        {
            super.setXml(param1);
            this._name = param1.name;
            this._bTurnOver = parseInt(param1.bTurnOver) == 1;
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
            if (this._bTurnOver)
            {
                _loc_2.scaleX = -1;
            }
            else
            {
                _loc_2.scaleX = 1;
            }
            _bCommandEnd = true;
            return;
        }// end function

    }
}
