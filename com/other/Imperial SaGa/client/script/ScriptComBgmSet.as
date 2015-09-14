package script
{

    public class ScriptComBgmSet extends ScriptComBase
    {
        private var _id:int;

        public function ScriptComBgmSet()
        {
            super(ScriptComConstant.COMMAND_CATEGORY_SET);
            return;
        }// end function

        override public function setXml(param1:XML) : void
        {
            super.setXml(param1);
            this._id = param1.id;
            return;
        }// end function

        override public function commandInit() : void
        {
            super.commandInit();
            var _loc_1:* = new ScriptParamBgm();
            _loc_1.setParam(this._id);
            ScriptManager.getInstance().addSoundBgm(_loc_1);
            _bCommandEnd = true;
            return;
        }// end function

    }
}
