package script
{

    public class ScriptComCharacterSet extends ScriptComBase
    {
        private var _name:String;
        private var _fileName:String;

        public function ScriptComCharacterSet()
        {
            super(ScriptComConstant.COMMAND_CATEGORY_SET);
            this._name = "";
            this._fileName = "";
            return;
        }// end function

        public function get name() : String
        {
            return this._name;
        }// end function

        public function get fileName() : String
        {
            return this._fileName;
        }// end function

        override public function setXml(param1:XML) : void
        {
            super.setXml(param1);
            this._name = param1.name;
            if (this._name.indexOf(ScriptConstant.SCRIPT_COMMAND_NOW_EMPEROR) >= 0)
            {
                this._fileName = ScriptChangeKeyword.nowEmperorEventFileName();
            }
            else
            {
                this._fileName = param1.fileName;
            }
            return;
        }// end function

        override public function copy(param1:ScriptComBase) : void
        {
            super.copy(param1);
            var _loc_2:* = param1 as ScriptComCharacterSet;
            this._name = _loc_2.name;
            this._fileName = _loc_2.fileName;
            return;
        }// end function

        override public function commandInit() : void
        {
            super.commandInit();
            var _loc_1:* = new ScriptParamCharacter();
            _loc_1.setParam(this._name, this._fileName);
            ScriptManager.getInstance().addCharacter(_loc_1);
            _bCommandEnd = true;
            return;
        }// end function

    }
}
