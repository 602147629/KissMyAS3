package battle
{
    import flash.display.*;
    import flash.geom.*;
    import message.*;
    import resource.*;

    public class BattleMessageCharacter extends BattleMessageBase
    {
        private const _SIDE_PLAYER:String = "blue";
        private const _SIDE_ENEMY:String = "red";
        private var _questUniqueId:uint;
        private var _bTiemCountMode:Boolean;
        private var _timeCount:Number;
        private var _msg:String;

        public function BattleMessageCharacter(param1:DisplayObjectContainer, param2:Point, param3:uint, param4:String)
        {
            this._questUniqueId = param3;
            var _loc_5:* = ResourceManager.getInstance().createMovieClip(ResourcePath.BATTLE_PATH + "UI_BattleMain.swf", "CharaTopSkillWindowMc");
            super(_loc_5);
            _aMessageColumn = ["1Calum", "2Calum", "3Calum", "4Calum", "5Calum", "6Calum", "7Calum", "8Calum", "9Calum", "10Calum", "11Calum", "12Calum", "13Calum", "14Calum", "15Calum", "16Calum"];
            _mc.x = param2.x;
            _mc.y = param2.y;
            param1.addChild(_mc);
            this.setMessage(this._SIDE_PLAYER, param4);
            _isoMain.setIn();
            this._bTiemCountMode = false;
            this._timeCount = 0;
            return;
        }// end function

        public function get questUniqueId() : uint
        {
            return this._questUniqueId;
        }// end function

        public function getMcHitArea() : MovieClip
        {
            return _mc.skillWindowsMc.skillWindowColorMc;
        }// end function

        private function setMessage(param1:String, param2:String) : void
        {
            this._msg = param2;
            _mc.skillWindowsMc.gotoAndStop(param1);
            TextControl.setText(_mc.skillWindowsMc.textMc.textDt, this._msg);
            setMessageColumn(_mc.skillWindowsMc.skillWindowColorMc, this._msg.length);
            return;
        }// end function

        override public function release() : void
        {
            super.release();
            if (_mc)
            {
                if (_mc.parent)
                {
                    _mc.parent.removeChild(_mc);
                }
            }
            _mc = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            if (this._bTiemCountMode == false)
            {
                return;
            }
            this._timeCount = this._timeCount - param1;
            if (this._timeCount <= 0)
            {
                _isoMain.setOut();
                this._bTiemCountMode = false;
            }
            return;
        }// end function

        public function setTimeClose(param1:Number) : void
        {
            this._bTiemCountMode = true;
            this._timeCount = param1;
            return;
        }// end function

        public function setEnemySide() : void
        {
            this.setMessage(this._SIDE_ENEMY, this._msg);
            return;
        }// end function

    }
}
