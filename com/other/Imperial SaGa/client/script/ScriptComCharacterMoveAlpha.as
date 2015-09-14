package script
{
    import flash.display.*;
    import flash.geom.*;
    import utility.*;

    public class ScriptComCharacterMoveAlpha extends ScriptComBase
    {
        private var _name:String;
        private var _targetPos:Point;
        private var _basePos:Point;
        private var _targetAlpha:Number;
        private var _baseAlpha:Number;
        private var _useTime:Number;
        private var _time:Number;

        public function ScriptComCharacterMoveAlpha()
        {
            super(ScriptComConstant.COMMAND_CATEGORY_SET);
            return;
        }// end function

        override public function setXml(param1:XML) : void
        {
            super.setXml(param1);
            this._name = param1.name;
            this._targetPos = new Point(param1.pos.@x, param1.pos.@y);
            this._basePos = new Point();
            this._targetAlpha = Number(param1.alpha);
            this._baseAlpha = 0;
            this._useTime = param1.useTime;
            this._time = 0;
            return;
        }// end function

        override public function commandInit() : void
        {
            super.commandInit();
            var _loc_1:* = ScriptManager.getInstance().getCharacter(this._name);
            if (_loc_1 == null)
            {
                Assert.print("キャラ【" + this._name + "】が作成されていません");
            }
            this._basePos = new Point(_loc_1.mc.x, _loc_1.mc.y);
            this._baseAlpha = _loc_1.alpha;
            this._time = 0;
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
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            var _loc_2:* = ScriptManager.getInstance().getCharacter(this._name);
            var _loc_3:* = _loc_2.mc;
            this._time = this._time + param1;
            if (this._time >= this._useTime)
            {
                _loc_3.x = this._targetPos.x;
                _loc_3.y = this._targetPos.y;
                _loc_2.alpha = this._targetAlpha;
                _loc_2.setVisible(this._targetAlpha > 0);
                _bCommandEnd = true;
            }
            else if (this._useTime > 0)
            {
                _loc_4 = this._time / this._useTime;
                _loc_3.x = this._basePos.x + (this._targetPos.x - this._basePos.x) * _loc_4;
                _loc_3.y = this._basePos.y + (this._targetPos.y - this._basePos.y) * _loc_4;
                _loc_5 = (this._targetAlpha - this._baseAlpha) * (this._time / this._useTime) + this._baseAlpha;
                if (_loc_5 > 1)
                {
                    _loc_5 = 1;
                }
                if (_loc_5 < 0)
                {
                    _loc_5 = 0;
                }
                _loc_2.alpha = _loc_5;
                _loc_2.setVisible(_loc_5 > 0);
            }
            return;
        }// end function

    }
}
