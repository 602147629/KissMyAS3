package script
{
    import flash.geom.*;
    import utility.*;

    public class ScriptComMonologue3 extends ScriptComBase
    {
        private var _waitTime:Number;
        private var _mes:String;
        private var _pos:Point;
        private var _monologueId:uint;

        public function ScriptComMonologue3()
        {
            super(ScriptComConstant.COMMAND_CATEGORY_DISP);
            this._waitTime = 0;
            this._mes = null;
            this._pos = new Point();
            return;
        }// end function

        override public function setXml(param1:XML) : void
        {
            super.setXml(param1);
            this._waitTime = Number(param1.waitTime);
            this._mes = StringTools.xmlLineToStringLine(param1.message);
            this._pos = new Point(param1.pos.@x, param1.pos.@y);
            return;
        }// end function

        override public function commandInit() : void
        {
            super.commandInit();
            this._monologueId = ScriptManager.getInstance().addMonologue2(this._mes, this._waitTime, this._pos.x, this._pos.y, false);
            return;
        }// end function

        override public function commandSkip() : int
        {
            ScriptManager.getInstance().deleteMonologue2(this._monologueId);
            _bCommandEnd = true;
            return ScriptComConstant.COMMAND_SKIP_RESULT_FINISH;
        }// end function

        override public function isCommandSkipEnable() : Boolean
        {
            return true;
        }// end function

        override public function commandControl(param1:Number) : void
        {
            if (ScriptManager.getInstance().isAliveMonologue2(this._monologueId) == false)
            {
                _bCommandEnd = true;
            }
            return;
        }// end function

    }
}
