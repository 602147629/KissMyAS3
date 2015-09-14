package script
{

    public class ScriptComBgmStop extends ScriptComBase
    {

        public function ScriptComBgmStop()
        {
            super(ScriptComConstant.COMMAND_CATEGORY_SET);
            return;
        }// end function

        override public function commandInit() : void
        {
            super.commandInit();
            ScriptManager.getInstance().setBgmStop();
            _bCommandEnd = true;
            return;
        }// end function

    }
}
