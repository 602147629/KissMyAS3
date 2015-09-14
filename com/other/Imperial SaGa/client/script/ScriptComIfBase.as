package script
{

    public class ScriptComIfBase extends ScriptComBase
    {

        public function ScriptComIfBase()
        {
            super(ScriptComConstant.COMMAND_CATEGORY_SET);
            return;
        }// end function

        override public function commandInit() : void
        {
            super.commandInit();
            this.gotoLabel(this.checkLabel());
            return;
        }// end function

        protected function gotoLabel(param1:String) : void
        {
            if (param1 && param1 != "")
            {
                ScriptManager.getInstance().gotoLabel(param1);
            }
            _bCommandEnd = true;
            return;
        }// end function

        protected function checkLabel() : String
        {
            return "";
        }// end function

    }
}
