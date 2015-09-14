package script
{

    public class ScriptComShakeLoop extends ScriptComBase
    {
        private var _width:int;
        private var _height:int;
        private var shake:ScriptParamShake;

        public function ScriptComShakeLoop()
        {
            super(ScriptComConstant.COMMAND_CATEGORY_SET);
            return;
        }// end function

        override public function setXml(param1:XML) : void
        {
            super.setXml(param1);
            this._width = int(param1.width);
            this._height = int(param1.height);
            return;
        }// end function

        override public function commandInit() : void
        {
            super.commandInit();
            this.shake = ScriptManager.getInstance().shake;
            if (this.shake == null)
            {
                this.shake = new ScriptParamShake();
                ScriptManager.getInstance().shake = this.shake;
            }
            this.shake.setParam(this._width, this._height);
            _bCommandEnd = true;
            return;
        }// end function

    }
}
