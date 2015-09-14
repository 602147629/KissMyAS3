package script
{
    import flash.display.*;
    import flash.geom.*;
    import utility.*;

    public class ScriptComCharacterDisplay extends ScriptComBase
    {
        private var _name:String;
        private var _pos:Point;
        private var _bTurnOver:Boolean;

        public function ScriptComCharacterDisplay()
        {
            super(ScriptComConstant.COMMAND_CATEGORY_DISP);
            this._name = "";
            this._pos = new Point();
            return;
        }// end function

        override public function setXml(param1:XML) : void
        {
            super.setXml(param1);
            this._name = param1.name;
            this._pos = new Point(param1.pos.@x, param1.pos.@y);
            this._bTurnOver = parseInt(param1.bTurnOver) == 1;
            return;
        }// end function

        override public function commandInit() : void
        {
            super.commandInit();
            var _loc_1:* = ScriptManager.getInstance().getLayerCharacter();
            if (_loc_1 == null)
            {
                Assert.print("指定したレイヤーが見つかりません");
            }
            var _loc_2:* = ScriptManager.getInstance().getCharacter(this._name);
            if (_loc_2 == null)
            {
                Assert.print("キャラ【" + this._name + "】が作成されていません");
            }
            var _loc_3:* = _loc_2.mc;
            if (_loc_3.parent == null || _loc_1 != _loc_3.parent)
            {
                _loc_1.addChild(_loc_3);
            }
            else
            {
                ScriptManager.getInstance().topPriority(_loc_1, _loc_3);
            }
            _loc_3.x = this._pos.x;
            _loc_3.y = this._pos.y;
            if (this._bTurnOver)
            {
                _loc_3.scaleX = -1;
            }
            else
            {
                _loc_3.scaleX = 1;
            }
            _bCommandEnd = true;
            return;
        }// end function

    }
}
