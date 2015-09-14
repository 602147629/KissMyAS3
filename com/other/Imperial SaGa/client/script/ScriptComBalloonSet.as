package script
{
    import flash.geom.*;
    import utility.*;

    public class ScriptComBalloonSet extends ScriptComBase
    {
        private var _name:String;
        private var _title:String;
        private var _type:int;
        private var _pos:Point;

        public function ScriptComBalloonSet()
        {
            super(ScriptComConstant.COMMAND_CATEGORY_SET);
            this._name = "";
            this._pos = new Point();
            this._title = "";
            return;
        }// end function

        override public function setXml(param1:XML) : void
        {
            super.setXml(param1);
            this._name = param1.name;
            this._type = param1.type;
            this._pos = new Point(param1.pos.@x, param1.pos.@y);
            this._title = param1.title;
            return;
        }// end function

        override public function commandInit() : void
        {
            var _loc_1:* = null;
            super.commandInit();
            _loc_1 = ScriptManager.getInstance().getBalloon(this._name);
            if (_loc_1 != null)
            {
                Assert.print("すでにフキダシ【" + this._name + "】は作成されています");
            }
            var _loc_2:* = "";
            _loc_2 = ScriptChangeKeyword.changeKeyword(ScriptConstant.SCRIPT_COMMAND_NOW_EMPEROR, this._title);
            _loc_1 = new ScriptParamBalloon();
            _loc_1.setParam(this._name, this._type, this._pos, _loc_2);
            ScriptManager.getInstance().addBalloon(_loc_1);
            _bCommandEnd = true;
            return;
        }// end function

    }
}
