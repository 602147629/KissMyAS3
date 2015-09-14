package script
{

    public class ScriptComBase extends Object
    {
        private var _category:int;
        protected var _no:int;
        protected var _bCommandEnd:Boolean;

        public function ScriptComBase(param1:int)
        {
            this._category = param1;
            this._bCommandEnd = false;
            return;
        }// end function

        public function get category() : int
        {
            return this._category;
        }// end function

        public function get no() : int
        {
            return this._no;
        }// end function

        public function get bCommandEnd() : Boolean
        {
            return this._bCommandEnd;
        }// end function

        public function setXml(param1:XML) : void
        {
            this._no = parseInt(param1.@no);
            return;
        }// end function

        public function copy(param1:ScriptComBase) : void
        {
            this._no = param1.no;
            return;
        }// end function

        public function commandInit() : void
        {
            this._bCommandEnd = false;
            if (this._category == ScriptComConstant.COMMAND_CATEGORY_DISP)
            {
                ScriptManager.getInstance().commandSkipCtrlStart();
            }
            return;
        }// end function

        public function commandSkip() : int
        {
            return ScriptComConstant.COMMAND_SKIP_RESULT_DONT;
        }// end function

        public function isCommandSkipEnable() : Boolean
        {
            return false;
        }// end function

        public function commandControl(param1:Number) : void
        {
            return;
        }// end function

    }
}
