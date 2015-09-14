package script
{
    import flash.geom.*;

    public class ScriptComBackgroundScroll extends ScriptComBase
    {
        private var _name:String;
        private var _direction:int;
        private var _useTime:Number;
        private var _max:Number;
        private var _vec:Point;
        private var _startPos:Point;
        private var _endPos:Point;
        private var _time:Number;
        private static const DERECTION_TOP:int = 1;
        private static const DERECTION_BOTTOM:int = 2;
        private static const DERECTION_LEFT:int = 3;
        private static const DERECTION_RIGHT:int = 4;

        public function ScriptComBackgroundScroll()
        {
            super(ScriptComConstant.COMMAND_CATEGORY_DISP);
            return;
        }// end function

        override public function setXml(param1:XML) : void
        {
            super.setXml(param1);
            this._name = param1.name;
            this._direction = param1.direction;
            this._useTime = param1.useTime;
            this._max = param1.max;
            return;
        }// end function

        override public function commandInit() : void
        {
            super.commandInit();
            var _loc_1:* = ScriptManager.getInstance().getBackground(this._name);
            this._startPos = new Point(_loc_1.bmp.x, _loc_1.bmp.y);
            this._endPos = new Point(_loc_1.bmp.x, _loc_1.bmp.y);
            this._time = 0;
            switch(this._direction)
            {
                case DERECTION_TOP:
                {
                    this._endPos.y = this._endPos.y - this._max;
                    break;
                }
                case DERECTION_LEFT:
                {
                    this._endPos.x = this._endPos.x - this._max;
                    break;
                }
                case DERECTION_BOTTOM:
                {
                    this._endPos.y = this._endPos.y + this._max;
                    break;
                }
                case DERECTION_RIGHT:
                {
                    this._endPos.x = this._endPos.x + this._max;
                    break;
                }
                default:
                {
                    break;
                }
            }
            this._vec = new Point(this._endPos.x - this._startPos.x, this._endPos.y - this._startPos.y);
            return;
        }// end function

        override public function commandSkip() : int
        {
            this._time = this._useTime;
            this.commandControl(0);
            return ScriptComConstant.COMMAND_SKIP_RESULT_FINISH;
        }// end function

        override public function isCommandSkipEnable() : Boolean
        {
            return true;
        }// end function

        override public function commandControl(param1:Number) : void
        {
            var _loc_3:* = NaN;
            this._time = this._time + param1;
            var _loc_2:* = ScriptManager.getInstance().getBackground(this._name);
            if (_loc_2 != null && _bCommandEnd == false)
            {
                _loc_3 = this._time / this._useTime;
                _loc_2.bmp.x = this._startPos.x + this._vec.x * _loc_3;
                _loc_2.bmp.y = this._startPos.y + this._vec.y * _loc_3;
                if (this._time >= this._useTime)
                {
                    _loc_2.bmp.x = this._endPos.x;
                    _loc_2.bmp.y = this._endPos.y;
                    _bCommandEnd = true;
                }
            }
            return;
        }// end function

    }
}
