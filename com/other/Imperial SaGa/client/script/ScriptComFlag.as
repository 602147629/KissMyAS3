package script
{

    public class ScriptComFlag extends ScriptComBase
    {
        private var _id:int;
        private var _value:Boolean;

        public function ScriptComFlag()
        {
            super(ScriptComConstant.COMMAND_CATEGORY_SET);
            return;
        }// end function

        override public function setXml(param1:XML) : void
        {
            super.setXml(param1);
            this._id = parseInt(param1.id);
            this._value = Boolean(parseInt(param1.id.@value));
            return;
        }// end function

        override public function commandInit() : void
        {
            super.commandInit();
            var _loc_1:* = new ScriptParamFlag();
            _loc_1.setParam(this._id, this._value);
            ScriptManager.getInstance().setFlag(_loc_1);
            _bCommandEnd = true;
            return;
        }// end function

    }
}
