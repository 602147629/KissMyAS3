package script
{

    public class ScriptComGoto extends ScriptComBase
    {
        private var _name:String;

        public function ScriptComGoto()
        {
            super(ScriptComConstant.COMMAND_CATEGORY_SET);
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
            ScriptManager.getInstance().gotoLabel(this._name);
            _bCommandEnd = true;
            return;
        }// end function

    }
}
