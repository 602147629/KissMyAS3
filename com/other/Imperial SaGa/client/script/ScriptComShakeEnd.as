package script
{

    public class ScriptComShakeEnd extends ScriptComBase
    {

        public function ScriptComShakeEnd()
        {
            super(ScriptComConstant.COMMAND_CATEGORY_SET);
            return;
        }// end function

        override public function setXml(param1:XML) : void
        {
            super.setXml(param1);
            return;
        }// end function

        override public function commandInit() : void
        {
            super.commandInit();
            var _loc_1:* = ScriptManager.getInstance().shake;
            if (_loc_1 != null)
            {
                _loc_1.stop();
            }
            _bCommandEnd = true;
            return;
        }// end function

    }
}
