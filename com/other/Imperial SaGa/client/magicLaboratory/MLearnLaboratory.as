package magicLaboratory
{
    import button.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import input.*;
    import player.*;
    import sound.*;
    import status.*;

    public class MLearnLaboratory extends Object
    {
        private const _PHASE_OPEN:int = 1;
        private const _PHASE_WAIT:int = 10;
        private const _PHASE_CLOSE:int = 99;
        private var _baseMc:MovieClip;
        private var _aCharaView:Array;
        private var _phase:int;
        private var _simpleStatus:PlayerSimpleStatus;
        private var _targetIndex:int;
        private var _overIndex:int;
        private var _mouseOverPlayer:PlayerDisplay;
        private var _bSimpleStatusEnable:Boolean;
        private static const _SIMPLE_STATUS_DISPLAY_POSITION_X:int = 773;
        private static const _SIMPLE_STATUS_DISPLAY_POSITION_Y_MIN:int = 220;
        private static const _SIMPLE_STATUS_DISPLAY_POSITION_Y_MAX:int = 340;

        public function MLearnLaboratory(param1:MovieClip)
        {
            this._baseMc = param1;
            this._baseMc.gotoAndStop("lv" + MagicLearnUtility.getLearnCount());
            this.createCharaPoint();
            this._simpleStatus = new PlayerSimpleStatus(this._baseMc.parent, PlayerSimpleStatus.LABEL_MAIN, null, null, false);
            this._simpleStatus.hide();
            this._targetIndex = Constant.UNDECIDED;
            this._overIndex = Constant.UNDECIDED;
            this._mouseOverPlayer = null;
            this._bSimpleStatusEnable = true;
            InputManager.getInstance().addMouseCallback(this, this.cbMouseMove);
            return;
        }// end function

        public function get aCharaView() : Array
        {
            return this._aCharaView.concat();
        }// end function

        private function createCharaPoint() : void
        {
            var _loc_3:* = null;
            this._aCharaView = [];
            var _loc_1:* = [{baseMc:this._baseMc.learningFlameMc1, charaMc:this._baseMc.learningCharaMc1}, {baseMc:this._baseMc.learningFlameMc2, charaMc:this._baseMc.learningCharaMc2}, {baseMc:this._baseMc.learningFlameMc3, charaMc:this._baseMc.learningCharaMc3}, {baseMc:this._baseMc.learningFlameMc4, charaMc:this._baseMc.learningCharaMc4}];
            var _loc_2:* = 0;
            while (_loc_2 < MagicLearnUtility.getLearnCount() && _loc_2 < _loc_1.length)
            {
                
                _loc_3 = new MLearningCharacterView(_loc_1[_loc_2].baseMc, _loc_1[_loc_2].charaMc, _loc_2, MagicLabolatoryManager.getInstance().getLearningData(_loc_2));
                this._aCharaView.push(_loc_3);
                _loc_2++;
            }
            return;
        }// end function

        public function release() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aCharaView)
            {
                
                _loc_1.release();
            }
            if (this._simpleStatus)
            {
                this._simpleStatus.release();
            }
            this._simpleStatus = null;
            this._mouseOverPlayer = null;
            InputManager.getInstance().delMouseCallback(this);
            return;
        }// end function

        public function control(param1:Number) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aCharaView)
            {
                
                _loc_2.control(param1);
            }
            return;
        }// end function

        private function setPhase(param1:int) : void
        {
            if (param1 != this._phase)
            {
                this._phase = param1;
                switch(this._phase)
                {
                    case this._PHASE_OPEN:
                    {
                        this.phaseOpen();
                        break;
                    }
                    case this._PHASE_WAIT:
                    {
                        this.phaseWait();
                        break;
                    }
                    case this._PHASE_CLOSE:
                    {
                        this.phaseClose();
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

        public function setButtonEnable(param1:Boolean) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aCharaView)
            {
                
                _loc_2.setButtonEnable(param1);
            }
            this.setSimpleStatusEnable(param1);
            return;
        }// end function

        private function phaseOpen() : void
        {
            return;
        }// end function

        private function controlOpen() : void
        {
            return;
        }// end function

        private function phaseWait() : void
        {
            return;
        }// end function

        private function controlWait(param1:Number) : void
        {
            return;
        }// end function

        private function phaseClose() : void
        {
            return;
        }// end function

        private function controlClose() : void
        {
            return;
        }// end function

        public function showSimpleStatus(param1:int) : void
        {
            this._targetIndex = param1;
            this.updateSimpleStatus();
            return;
        }// end function

        public function hideSimpleStatus() : void
        {
            this._targetIndex = Constant.UNDECIDED;
            this.updateSimpleStatus();
            return;
        }// end function

        private function setSimpleStatusEnable(param1:Boolean) : void
        {
            if (this._bSimpleStatusEnable != param1)
            {
                this._bSimpleStatusEnable = param1;
                if (!param1)
                {
                    this._overIndex = Constant.UNDECIDED;
                    if (this._mouseOverPlayer)
                    {
                        this._mouseOverPlayer.setSelect(false);
                    }
                    this._mouseOverPlayer = null;
                }
                this.updateSimpleStatus();
            }
            return;
        }// end function

        private function cbMouseMove(event:MouseEvent) : void
        {
            var _loc_3:* = null;
            var _loc_5:* = null;
            if (!this._bSimpleStatusEnable || this._targetIndex != Constant.UNDECIDED)
            {
                return;
            }
            var _loc_2:* = Constant.UNDECIDED;
            var _loc_4:* = 0;
            while (_loc_4 < this._aCharaView.length)
            {
                
                _loc_5 = this._aCharaView[_loc_4];
                _loc_3 = _loc_5.getPlayerDisplay();
                if (_loc_3.uniqueId != Constant.EMPTY_ID && _loc_3.isHitTest2())
                {
                    _loc_2 = _loc_4;
                    break;
                }
                _loc_4++;
            }
            if (this._overIndex != _loc_2)
            {
                this._overIndex = _loc_2;
                if (this._mouseOverPlayer)
                {
                    this._mouseOverPlayer.setSelect(false);
                }
                if (this._overIndex != Constant.UNDECIDED)
                {
                    SoundManager.getInstance().playSe(ButtonBase.SE_SELECT_ID);
                    this._mouseOverPlayer = _loc_3;
                    this._mouseOverPlayer.setSelect(true);
                }
                else
                {
                    this._mouseOverPlayer = null;
                }
                this.updateSimpleStatus();
            }
            return;
        }// end function

        private function updateSimpleStatus() : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_1:* = this._targetIndex;
            if (_loc_1 == Constant.UNDECIDED)
            {
                _loc_1 = this._overIndex;
            }
            var _loc_2:* = this._aCharaView[_loc_1];
            if (_loc_2)
            {
                _loc_3 = _loc_2.getPlayerPersonal();
                if (_loc_3)
                {
                    _loc_4 = _loc_2.getPlayerCenterPosition();
                    _loc_4.x = _SIMPLE_STATUS_DISPLAY_POSITION_X;
                    _loc_4.y = Math.min(Math.max(_loc_4.y, _SIMPLE_STATUS_DISPLAY_POSITION_Y_MIN), _SIMPLE_STATUS_DISPLAY_POSITION_Y_MAX);
                    this._simpleStatus.setStatus(_loc_3.clone());
                    this._simpleStatus.setPosition(_loc_4);
                    this._simpleStatus.show();
                    _loc_5 = _loc_2.getPlayerCenterPosition();
                    this._simpleStatus.setArrowTargetPosition(_loc_5);
                }
                else
                {
                    this._simpleStatus.hide();
                }
            }
            else
            {
                this._simpleStatus.hide();
            }
            return;
        }// end function

    }
}
