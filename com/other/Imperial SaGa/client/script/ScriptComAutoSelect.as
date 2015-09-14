package script
{
    import flash.display.*;
    import flash.geom.*;
    import utility.*;

    public class ScriptComAutoSelect extends ScriptComBase
    {
        private var _aChoice:Array;
        private var _pos:Point;

        public function ScriptComAutoSelect()
        {
            super(ScriptComConstant.COMMAND_CATEGORY_DISP);
            this._aChoice = new Array();
            this._pos = new Point();
            return;
        }// end function

        override public function setXml(param1:XML) : void
        {
            var _loc_3:* = null;
            super.setXml(param1);
            this._pos = new Point(param1.pos.@x, param1.pos.@y);
            var _loc_2:* = 0;
            for each (param1 in param1.ChoiceList.children())
            {
                
                _loc_3 = new ScriptSelectChoice();
                _loc_3.setParam(param1.message, param1.label, _loc_2);
                this._aChoice.push(_loc_3);
                _loc_2++;
            }
            return;
        }// end function

        override public function commandInit() : void
        {
            super.commandInit();
            var _loc_1:* = ScriptManager.getInstance().getBalloonLayer();
            if (_loc_1 == null)
            {
                Assert.print("表示スプライトが有りません");
            }
            var _loc_2:* = ScriptManager.getInstance().createAutoSelect();
            _loc_2.setParam(this._aChoice.concat(), this._pos);
            _loc_1.addChild(_loc_2.mc);
            return;
        }// end function

        override public function commandSkip() : int
        {
            var _loc_1:* = ScriptManager.getInstance().getAutoSelect();
            _loc_1.setStay();
            _bCommandEnd = true;
            return ScriptComConstant.COMMAND_SKIP_RESULT_FINISH;
        }// end function

        override public function isCommandSkipEnable() : Boolean
        {
            return true;
        }// end function

        override public function commandControl(param1:Number) : void
        {
            var _loc_2:* = ScriptManager.getInstance().getAutoSelect();
            if (_loc_2.bOpen)
            {
                _bCommandEnd = true;
            }
            return;
        }// end function

    }
}
