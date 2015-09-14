package script
{
    import sound.*;

    public class ScriptComSePlay extends ScriptComBase
    {
        private var _id:int;
        private var _bPlayEnd:Boolean;

        public function ScriptComSePlay()
        {
            super(ScriptComConstant.COMMAND_CATEGORY_SET);
            return;
        }// end function

        override public function setXml(param1:XML) : void
        {
            super.setXml(param1);
            this._id = param1.id;
            this._bPlayEnd = parseInt(param1.bPlayEnd) == 1;
            return;
        }// end function

        override public function commandInit() : void
        {
            super.commandInit();
            if (this._bPlayEnd == false)
            {
                if (ScriptManager.getInstance().isCommandPlayPhase())
                {
                    SoundManager.getInstance().playSe(this._id);
                }
                _bCommandEnd = true;
            }
            else if (ScriptManager.getInstance().isCommandPlayPhase())
            {
                SoundManager.getInstance().playSeCallBack(this._id, this.cbPlayEnd);
            }
            return;
        }// end function

        override public function commandSkip() : int
        {
            this.cbPlayEnd();
            return ScriptComConstant.COMMAND_SKIP_RESULT_FINISH;
        }// end function

        override public function isCommandSkipEnable() : Boolean
        {
            return true;
        }// end function

        private function cbPlayEnd() : void
        {
            _bCommandEnd = true;
            return;
        }// end function

    }
}
