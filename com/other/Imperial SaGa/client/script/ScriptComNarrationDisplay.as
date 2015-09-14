package script
{
    import flash.display.*;
    import utility.*;

    public class ScriptComNarrationDisplay extends ScriptComBase
    {
        private var _name:String;

        public function ScriptComNarrationDisplay()
        {
            super(ScriptComConstant.COMMAND_CATEGORY_DISP);
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
            var _loc_1:* = ScriptManager.getInstance().getNarrationLayer();
            if (_loc_1 == null)
            {
                Assert.print("表示スプライトが有りません");
            }
            var _loc_2:* = ScriptManager.getInstance().getNarration(this._name);
            if (_loc_2 == null)
            {
                Assert.print("指定ナレーションウィンドウが作成されていません");
            }
            if (_loc_2.mc.parent == null)
            {
                _loc_1.addChild(_loc_2.mc);
            }
            _loc_2.setIn(this.cbIn, this.cbClick);
            return;
        }// end function

        override public function commandSkip() : int
        {
            var _loc_1:* = ScriptManager.getInstance().getNarration(this._name);
            if (_loc_1)
            {
                _loc_1.setStay();
            }
            this.cbClick();
            return ScriptComConstant.COMMAND_SKIP_RESULT_FINISH;
        }// end function

        override public function isCommandSkipEnable() : Boolean
        {
            return true;
        }// end function

        private function cbIn() : void
        {
            return;
        }// end function

        private function cbClick() : void
        {
            _bCommandEnd = true;
            return;
        }// end function

    }
}
