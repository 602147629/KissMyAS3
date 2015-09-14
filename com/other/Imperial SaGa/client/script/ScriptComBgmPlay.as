package script
{

    public class ScriptComBgmPlay extends ScriptComBase
    {
        private var _id:int;

        public function ScriptComBgmPlay()
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
            var _loc_1:* = null;
            super.commandInit();
            if (ScriptManager.getInstance().isCommandPlayPhase())
            {
                _loc_1 = ScriptManager.getInstance().getSoundBgm(this._id);
                _loc_1.play();
            }
            else
            {
                ScriptManager.getInstance().setSkipBgmId(this._id);
            }
            _bCommandEnd = true;
            return;
        }// end function

    }
}
