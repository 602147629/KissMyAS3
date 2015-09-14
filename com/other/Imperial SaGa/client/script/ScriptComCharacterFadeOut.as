package script
{
    import utility.*;

    public class ScriptComCharacterFadeOut extends ScriptComBase
    {
        private var _name:String;
        private var _targetAlpha:Number;
        private var _baseAlpha:Number;
        private var _useTime:Number;
        private var _time:Number;

        public function ScriptComCharacterFadeOut()
        {
            super(ScriptComConstant.COMMAND_CATEGORY_DISP);
            this._name = "";
            return;
        }// end function

        override public function setXml(param1:XML) : void
        {
            super.setXml(param1);
            this._name = param1.name;
            this._targetAlpha = 0;
            this._baseAlpha = 1;
            this._useTime = param1.useTime;
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
            var _loc_3:* = NaN;
            var _loc_2:* = ScriptManager.getInstance().getCharacter(this._name);
            this._time = this._time + param1;
            if (this._time >= this._useTime)
            {
                _loc_2.alpha = this._targetAlpha;
                _loc_2.setVisible(this._targetAlpha > 0);
                _bCommandEnd = true;
            }
            else if (this._useTime > 0)
            {
                _loc_3 = (this._targetAlpha - this._baseAlpha) * (this._time / this._useTime) + this._baseAlpha;
                if (_loc_3 > 1)
                {
                    _loc_3 = 1;
                }
                if (_loc_3 < 0)
                {
                    _loc_3 = 0;
                }
                _loc_2.alpha = _loc_3;
                _loc_2.setVisible(_loc_3 > 0);
            }
            return;
        }// end function

    }
}
