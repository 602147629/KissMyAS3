package script
{
    import flash.display.*;
    import utility.*;

    public class ScriptComBackgroundDisplay extends ScriptComBase
    {
        private var _name:String;

        public function ScriptComBackgroundDisplay()
        {
            super(ScriptComConstant.COMMAND_CATEGORY_DISP);
            this._name = "";
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
            var _loc_1:* = ScriptManager.getInstance().getBackground(this._name);
            if (_loc_1 == null)
            {
                Assert.print("背景【" + this._name + "】が作成されていません");
            }
            var _loc_2:* = ScriptManager.getInstance().getLayerBg();
            _loc_2.removeChildren();
            _loc_2.addChild(_loc_1.bmp);
            _bCommandEnd = true;
            return;
        }// end function

    }
}
