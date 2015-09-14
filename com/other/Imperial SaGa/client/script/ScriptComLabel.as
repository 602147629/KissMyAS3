package script
{

    public class ScriptComLabel extends ScriptComBase
    {
        private var _name:String;

        public function ScriptComLabel()
        {
            super(ScriptComConstant.COMMAND_CATEGORY_SET);
            return;
        }// end function

        public function get name() : String
        {
            return this._name;
        }// end function

        override public function commandInit() : void
        {
            super.commandInit();
            _bCommandEnd = true;
            return;
        }// end function

        override public function setXml(param1:XML) : void
        {
            super.setXml(param1);
            this._name = param1.name;
            return;
        }// end function

    }
}
