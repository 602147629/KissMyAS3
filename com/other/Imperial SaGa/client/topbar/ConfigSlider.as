package topbar
{
    import button.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import input.*;
    import utility.*;

    public class ConfigSlider extends Object
    {
        private var _baseMc:MovieClip;
        private var _markerMc:MovieClip;
        private var _numeric:NumericNumberMc;
        private var _volume:Number;
        private var _aButton:Array;
        private var _type:int;
        private var _min:Number;
        private var _max:Number;
        private var _inputDrag:InputDrag;
        private var _bMute:Boolean;
        private static const VOLUME_UP:int = 1;
        private static const VOLUME_DOWN:int = 2;
        private static const VOLUME_MOVE:int = 2;

        public function ConfigSlider(param1:MovieClip, param2:Number, param3:int)
        {
            this._baseMc = param1;
            this._markerMc = this._baseMc.suradaOnOffMc.surada;
            this._type = param3;
            this._min = param1.suradaOnOffMc.suradaNull1.x;
            this._max = param1.suradaOnOffMc.suradaNull2.x;
            this._markerMc.x = this._max;
            this._numeric = new NumericNumberMc(this._markerMc.suradaBalloonMc, param2 * 100, 0, false);
            this._aButton = [];
            var _loc_4:* = ButtonManager.getInstance().addPushButton(this._baseMc.suradaOnOffMc.volUpBtnMc, VOLUME_UP);
            ButtonManager.getInstance().addPushButton(this._baseMc.suradaOnOffMc.volUpBtnMc, VOLUME_UP).enterSeId = ButtonBase.SE_CURSOR_ID;
            this._aButton.push(_loc_4);
            _loc_4 = ButtonManager.getInstance().addPushButton(this._baseMc.suradaOnOffMc.volDownBtnMc, VOLUME_DOWN);
            _loc_4.enterSeId = ButtonBase.SE_CURSOR_ID;
            this._aButton.push(_loc_4);
            this.setVolume(param2);
            this._inputDrag = new InputDrag(this, this._markerMc, null, this.cbMove, null);
            InputManager.getInstance().addDrag(this._inputDrag);
            this._inputDrag.setInputGroup(InputManager.INPUT_GROUP_CONFIG);
            InputManager.getInstance().addMouseCallback(this, null, this.cbClick);
            InputManager.getInstance().setInputGroupMouseCallback(this, InputManager.INPUT_GROUP_CONFIG);
            return;
        }// end function

        public function release() : void
        {
            var _loc_1:* = null;
            InputManager.getInstance().delMouseCallback(this);
            if (this._inputDrag)
            {
                InputManager.getInstance().delDrag(this._inputDrag);
                this._inputDrag.release();
                this._inputDrag = null;
            }
            for each (_loc_1 in this._aButton)
            {
                
                ButtonManager.getInstance().removeButton(_loc_1);
            }
            this._aButton = [];
            if (this._numeric)
            {
                this._numeric.release();
            }
            this._numeric = null;
            this._baseMc = null;
            this._markerMc = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            var _loc_3:* = null;
            if (this._numeric)
            {
                this._numeric.control(param1);
            }
            var _loc_2:* = Constant.UNDECIDED;
            for each (_loc_3 in this._aButton)
            {
                
                if (_loc_3.bPush)
                {
                    _loc_2 = _loc_3.id;
                    break;
                }
            }
            if (_loc_2 != Constant.UNDECIDED)
            {
                if (_loc_2 == VOLUME_UP)
                {
                    this.scrollMovePoint(new Point(this._markerMc.x + VOLUME_MOVE, this._markerMc.y));
                }
                if (_loc_2 == VOLUME_DOWN)
                {
                    this.scrollMovePoint(new Point(this._markerMc.x - VOLUME_MOVE, this._markerMc.y));
                }
            }
            return;
        }// end function

        public function setVolume(param1:Number) : void
        {
            this._volume = param1;
            this._numeric.setNum(this._volume * 100);
            var _loc_2:* = (this._max - this._min) * this._volume + this._min;
            if (_loc_2 < this._min)
            {
                _loc_2 = this._min;
            }
            if (_loc_2 > this._max)
            {
                _loc_2 = this._max;
            }
            this._markerMc.x = _loc_2;
            return;
        }// end function

        public function scrollMovePoint(param1:Point) : void
        {
            var _loc_2:* = (param1.x - this._min) / (this._max - this._min);
            this.setVolume(_loc_2);
            if (this._type == ConfigWindow.MARKER_TYPE_BGM)
            {
                Main.GetApplicationData().userConfigData.bgmVolume = _loc_2 * 100;
            }
            if (this._type == ConfigWindow.MARKER_TYPE_SE)
            {
                Main.GetApplicationData().userConfigData.seVolume = _loc_2 * 100;
            }
            return;
        }// end function

        public function bMuteMarker(param1:Boolean) : void
        {
            var _loc_2:* = null;
            this._bMute = param1;
            for each (_loc_2 in this._aButton)
            {
                
                _loc_2.setDisable(param1 == true);
            }
            if (this._inputDrag)
            {
                this._inputDrag.enable(param1 == false);
            }
            if (param1)
            {
                this._baseMc.gotoAndStop("off");
            }
            else
            {
                this._baseMc.gotoAndStop("on");
            }
            return;
        }// end function

        private function cbClick(event:MouseEvent) : void
        {
            if (this._bMute)
            {
                return;
            }
            var _loc_2:* = this._markerMc.parent.globalToLocal(new Point(event.stageX, event.stageY));
            var _loc_3:* = this._baseMc.suradaOnOffMc.volUpBtnMc.getRect(this._markerMc.parent);
            if (this._min <= _loc_2.x && _loc_2.x <= this._max && _loc_3.top <= _loc_2.y && _loc_2.y <= _loc_3.bottom)
            {
                _loc_2.y = this._markerMc.y;
                this.scrollMovePoint(_loc_2);
            }
            return;
        }// end function

        private function cbMove(event:MouseEvent) : void
        {
            if (this._bMute)
            {
                return;
            }
            var _loc_2:* = this._markerMc.parent.globalToLocal(new Point(event.stageX, event.stageY));
            if (_loc_2.x > this._max)
            {
                _loc_2.x = this._max;
            }
            if (_loc_2.x < this._min)
            {
                _loc_2.x = this._min;
            }
            _loc_2.y = this._markerMc.y;
            this.scrollMovePoint(_loc_2);
            return;
        }// end function

    }
}
