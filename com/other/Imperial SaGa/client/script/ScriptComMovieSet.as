package script
{

    public class ScriptComMovieSet extends ScriptComBase
    {
        private var _name:String;
        private var _fileName:String;

        public function ScriptComMovieSet()
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
            this._fileName = param1.fileName;
            return;
        }// end function

        override public function commandInit() : void
        {
            super.commandInit();
            var _loc_1:* = new ScriptParamMovie();
            _loc_1.setParam(this._name, this._fileName);
            ScriptManager.getInstance().addMovie(_loc_1);
            _bCommandEnd = true;
            return;
        }// end function

    }
}
