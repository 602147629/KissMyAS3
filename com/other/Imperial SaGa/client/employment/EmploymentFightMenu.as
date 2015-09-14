package employment
{
    import button.*;
    import flash.display.*;
    import message.*;
    import sound.*;
    import user.*;
    import utility.*;

    public class EmploymentFightMenu extends Object
    {
        private var _phase:int;
        private var _mcBase:MovieClip;
        private var _isoMain:InStayOut;
        private var _playerNumBox:EmploymentPlayerNumBox;
        private var _btnEmployment:ButtonBase;
        private var _btnMultiEmployment:ButtonBase;
        private var _gauge:Gauge;
        private var _curPoint:int;
        private var _targetPoint:int;
        private var _gachaNum:int;
        private var _cbFunc:Function;
        private var _cbEmployment:Function;
        private var _cbGoTradingPost:Function;
        private var _cbGoRetire:Function;
        private var _bBtnEnable:Boolean;
        private static const _MULTI_MAX:int = 10;
        private static const _MULTI_MIN:int = 2;
        private static const _GACHA_COST:int = 100;
        private static const _PHASE_OPEN:int = 0;
        private static const _PHASE_INPUT_WAIT:int = 1;
        private static const _PHASE_BUSY:int = 2;
        private static const _PHASE_CLOSE:int = 3;

        public function EmploymentFightMenu(param1:MovieClip, param2:Function, param3:Function, param4:Function)
        {
            this._cbFunc = null;
            this._cbEmployment = param2;
            this._cbGoTradingPost = param3;
            this._cbGoRetire = param4;
            this._mcBase = param1;
            this._isoMain = new InStayOut(this._mcBase);
            this._gauge = new Gauge(this._mcBase.FameGaugeSet.barMc, 100, 0);
            this._curPoint = 0;
            this._targetPoint = 0;
            this._gachaNum = 0;
            this._btnEmployment = ButtonManager.getInstance().addButton(this._mcBase.call1BtnMc, this.cbEmploymentButton);
            this._btnEmployment.setId(1);
            this._btnEmployment.setDisable(true);
            this._btnEmployment.enterSeId = SoundId.SE_DECIDE;
            TextControl.setIdText(this._mcBase.call1BtnMc.textMc.textDt, MessageId.EMPLOYMENT_NORMAL_EMPLOY_BUTTON);
            TextControl.setText(this._mcBase.call1BtnMc.PriceMc.textDt, TextControl.formatIdText(MessageId.EMPLOYMENT_NORMAL_EMPLOY_COUNT, 1));
            this._btnMultiEmployment = ButtonManager.getInstance().addButton(this._mcBase.call10BtnMc, this.cbEmploymentButton);
            this._btnMultiEmployment.setId(10);
            this._btnMultiEmployment.setDisable(true);
            this._btnMultiEmployment.enterSeId = SoundId.SE_DECIDE;
            TextControl.setIdText(this._mcBase.call10BtnMc.textMc.textDt, MessageId.EMPLOYMENT_NORMAL_EMPLOY_BUTTON);
            this._playerNumBox = new EmploymentPlayerNumBox(this._mcBase.VassalNumMc, this.cbRetireButton);
            this.updateGachaResource(true);
            this._phase = _PHASE_CLOSE;
            return;
        }// end function

        public function get bOpened() : Boolean
        {
            return this._isoMain && this._isoMain.bOpened;
        }// end function

        public function get bStay() : Boolean
        {
            return this._phase == _PHASE_INPUT_WAIT && (this._isoMain && this._isoMain.bAnimetion == false);
        }// end function

        public function get bEnd() : Boolean
        {
            return this._isoMain && this._isoMain.bEnd;
        }// end function

        public function release() : void
        {
            if (this._playerNumBox)
            {
                this._playerNumBox.release();
            }
            this._playerNumBox = null;
            if (this._btnMultiEmployment)
            {
                ButtonManager.getInstance().removeButton(this._btnMultiEmployment);
            }
            this._btnMultiEmployment = null;
            if (this._btnEmployment)
            {
                ButtonManager.getInstance().removeButton(this._btnEmployment);
            }
            this._btnEmployment = null;
            if (this._gauge)
            {
                this._gauge.release();
            }
            this._gauge = null;
            if (this._isoMain)
            {
                this._isoMain.release();
            }
            this._isoMain = null;
            this._cbGoRetire = null;
            this._cbGoTradingPost = null;
            this._cbEmployment = null;
            this._cbFunc = null;
            return;
        }// end function

        private function setPhase(param1:int) : void
        {
            this._phase = param1;
            switch(this._phase)
            {
                case _PHASE_OPEN:
                {
                    this.initPhaseOpen();
                    break;
                }
                case _PHASE_INPUT_WAIT:
                {
                    this.initPhaseInputWait();
                    break;
                }
                case _PHASE_BUSY:
                {
                    this.initPhaseBusy();
                    break;
                }
                case _PHASE_CLOSE:
                {
                    this.initPhaseClose();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function control(param1:Number) : void
        {
            switch(this._phase)
            {
                case _PHASE_INPUT_WAIT:
                {
                    this.controlPhaseInputWait(param1);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function initPhaseOpen() : void
        {
            this.btnEnable(false);
            this._isoMain.setIn(function () : void
            {
                if (_cbFunc != null)
                {
                    _cbFunc();
                }
                _cbFunc = null;
                setPhase(_PHASE_INPUT_WAIT);
                return;
            }// end function
            );
            return;
        }// end function

        private function initPhaseInputWait() : void
        {
            this.btnEnable(true);
            return;
        }// end function

        private function controlPhaseInputWait(param1:Number) : void
        {
            return;
        }// end function

        private function initPhaseBusy() : void
        {
            this.btnEnable(false);
            return;
        }// end function

        private function initPhaseClose() : void
        {
            this.btnEnable(false);
            this._isoMain.setOut(function () : void
            {
                if (_cbFunc != null)
                {
                    _cbFunc();
                }
                _cbFunc = null;
                return;
            }// end function
            );
            return;
        }// end function

        public function open(param1:Function = null) : void
        {
            this._cbFunc = param1;
            this.setPhase(_PHASE_OPEN);
            return;
        }// end function

        public function close(param1:Function = null) : void
        {
            this._cbFunc = param1;
            this.setPhase(_PHASE_CLOSE);
            return;
        }// end function

        public function setBusy(param1:Boolean) : void
        {
            this.setPhase(param1 ? (_PHASE_BUSY) : (_PHASE_INPUT_WAIT));
            return;
        }// end function

        public function allReset() : void
        {
            this.btnEnable(this._bBtnEnable);
            this.updateGachaResource(false);
            return;
        }// end function

        public function updatePlayerNum() : void
        {
            this._playerNumBox.updatePlayerNum();
            return;
        }// end function

        public function btnEnable(param1:Boolean) : void
        {
            this._bBtnEnable = param1;
            this._playerNumBox.setDisable(!this._bBtnEnable);
            this._btnEmployment.setDisable(!this._bBtnEnable);
            if (param1 && this._gachaNum > 1)
            {
                this._btnMultiEmployment.setDisable(false);
            }
            else
            {
                this._btnMultiEmployment.setDisable(true);
            }
            return;
        }// end function

        private function updateGachaResource(param1:Boolean) : void
        {
            var _loc_2:* = 0;
            this._targetPoint = UserDataManager.getInstance().userData.gachaResource;
            if (this._targetPoint > CommonConstant.OWN_ITEM_MAX_EMPLOYMENT)
            {
                this._targetPoint = CommonConstant.OWN_ITEM_MAX_EMPLOYMENT;
            }
            this._curPoint = this._targetPoint;
            this._gachaNum = this._curPoint / _GACHA_COST;
            if (this._curPoint >= CommonConstant.OWN_ITEM_MAX_EMPLOYMENT)
            {
                _loc_2 = 100;
            }
            else
            {
                _loc_2 = 100 * (this._curPoint % _GACHA_COST) / _GACHA_COST;
            }
            if (param1)
            {
                this._gauge.setGauge(_loc_2);
            }
            else
            {
                this._gauge.setTargetGauge(_loc_2);
            }
            TextControl.setText(this._mcBase.FameGaugeSet.UseNumTextMc.textDt, this._gachaNum.toString());
            TextControl.setText(this._mcBase.FameGaugeSet.FameNumSet.NumTextMc.textDt, (this._curPoint % _GACHA_COST).toString());
            TextControl.setText(this._mcBase.FameGaugeSet.FameNumSet.MaxTextMc.textDt, _GACHA_COST.toString());
            if (this._gachaNum <= 0)
            {
                this._btnEmployment.enterSeId = SoundId.SE_GACHA_DISABLE;
            }
            else
            {
                this._btnEmployment.enterSeId = SoundId.SE_DECIDE;
            }
            if (this._gachaNum <= 1)
            {
                this._btnMultiEmployment.enterSeId = SoundId.SE_GACHA_DISABLE;
                this._btnMultiEmployment.setDisable(true);
            }
            else
            {
                this._btnMultiEmployment.enterSeId = SoundId.SE_DECIDE;
                this._btnMultiEmployment.setDisable(!this._bBtnEnable);
            }
            var _loc_3:* = this._gachaNum < _MULTI_MAX ? (this._gachaNum) : (_MULTI_MAX);
            if (_loc_3 < _MULTI_MIN)
            {
                _loc_3 = _MULTI_MIN;
            }
            this._btnMultiEmployment.setId(_loc_3);
            TextControl.setText(this._mcBase.call10BtnMc.PriceMc.textDt, TextControl.formatIdText(MessageId.EMPLOYMENT_NORMAL_EMPLOY_COUNT, _loc_3));
            return;
        }// end function

        private function cbEmploymentButton(param1:int) : void
        {
            var id:* = param1;
            this.setPhase(_PHASE_BUSY);
            var employmentNum:* = id;
            var resourceNum:* = _GACHA_COST * employmentNum;
            var confirmPopup:* = new EmploymentConfirmPopup(EmploymentConfirmPopup.COST_TYPE_GACHA_POINT, TextControl.formatIdText(MessageId.EMPLOYMENT_NORMAL_EMPLOY_MESSAGE, resourceNum.toString(), employmentNum), resourceNum, employmentNum, false, function (param1:int) : void
            {
                switch(param1)
                {
                    case EmploymentConfirmPopup.RESULT_NONE:
                    {
                    }
                    default:
                    {
                        setPhase(_PHASE_INPUT_WAIT);
                        ;
                    }
                    case EmploymentConfirmPopup.RESULT_GOTO_TRADING_POST:
                    {
                        Main.GetProcess().createCrownUpdateWindow();
                        setPhase(_PHASE_INPUT_WAIT);
                        ;
                    }
                    case EmploymentConfirmPopup.RESULT_EMPLOYMENT:
                    {
                        _cbGoTradingPost();
                        ;
                    }
                    case :
                    {
                        if (_cbEmployment != null)
                        {
                            _cbEmployment(id);
                        }
                        ;
                        ;
                    }
                }
                return;
            }// end function
            );
            return;
        }// end function

        private function cbRetireButton(param1:int) : void
        {
            if (this._cbGoRetire != null)
            {
                this._cbGoRetire();
            }
            return;
        }// end function

    }
}
