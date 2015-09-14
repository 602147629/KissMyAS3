package script
{
    import flash.geom.*;
    import utility.*;

    public class ScriptComNarrationSet extends ScriptComBase
    {
        private var _name:String;
        private var _pos:Point;

        public function ScriptComNarrationSet()
        {
            super(ScriptComConstant.COMMAND_CATEGORY_SET);
            return;
        }// end function

        override public function setXml(param1:XML) : void
        {
            super.setXml(param1);
            this._name = param1.name;
            this._pos = new Point(param1.pos.@x, param1.pos.@y);
            return;
        }// end function

        override public function commandInit() : void
        {
            var _loc_1:* = null;
            super.commandInit();
            _loc_1 = ScriptManager.getInstance().getNarration(this._name);
            if (_loc_1 != null)
            {
                Assert.print("すでに指定したナレーションウィンドウは作成されています");
            }
            _loc_1 = new ScriptParamNarration();
            _loc_1.setParam(this._name, this._pos);
            ScriptManager.getInstance().addNarration(_loc_1);
            _bCommandEnd = true;
            return;
        }// end function

    }
}
