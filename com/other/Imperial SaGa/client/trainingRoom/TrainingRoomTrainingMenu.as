package trainingRoom
{
    import button.*;
    import flash.display.*;
    import message.*;
    import player.*;
    import utility.*;

    public class TrainingRoomTrainingMenu extends Object
    {
        private var _phase:int;
        private var _mcBase:MovieClip;
        private var _isoMain:InStayOut;
        private var _btnReset:ButtonBase;
        private var _btnDecide:ButtonBase;
        private var _btnTimeSelect:ButtonBase;
        private var _cbClose:Function;
        private var _cbDecide:Function;
        private var _cbReset:Function;
        private var _cbSelect:Function;
        private var _traineePesonal:PlayerPersonal;
        private var _selectSkillNum:int;
        private var _bBtnEnable:Boolean;
        private var _bDecideBtnEnable:Boolean;
        private static const _PHASE_OPEN_WAIT:int = 0;
        private static const _PHASE_OPEN:int = 1;
        private static const _PHASE_MAIN:int = 2;
        private static const _PHASE_CLOSE:int = 3;

        public function TrainingRoomTrainingMenu(param1:MovieClip, param2:Function, param3:Function, param4:Function)
        {
            this._mcBase = param1;
            this._isoMain = new InStayOut(this._mcBase);
            this._btnReset = ButtonManager.getInstance().addButton(this._mcBase.resetBtnMc, this.cbResetButton);
            this._btnReset.enterSeId = ButtonBase.SE_CANCEL_ID;
            TextControl.setIdText(this._mcBase.resetBtnMc.textMc.textDt, MessageId.TRAINING_ROOM_BUTTON_RESET);
            this._btnDecide = ButtonManager.getInstance().addButton(this._mcBase.decisionBtnMc, this.cbDecideButton);
            this._btnDecide.enterSeId = ButtonBase.SE_DECIDE_ID;
            TextControl.setIdText(this._mcBase.decisionBtnMc.textMc.textDt, MessageId.COMMON_BUTTON_DECIDE);
            this._btnTimeSelect = ButtonManager.getInstance().addButton(this._mcBase.trainingConfMc.selectBtn2Mc, this.cbTimeSelectButton);
            TextControl.setIdText(this._mcBase.trainingConfMc.selectBtn2Mc.textMc.textDt, MessageId.COMMON_BUTTON_CHANGE);
            this._mcBase.trainingConfMc.changeBtn2Mc.visible = false;
            this._cbClose = null;
            this._cbDecide = param2;
            this._cbReset = param3;
            this._cbSelect = param4;
            this._traineePesonal = null;
            this._selectSkillNum = Constant.UNDECIDED;
            this._bBtnEnable = true;
            this._bDecideBtnEnable = true;
            this.reset();
            this.setPhase(_PHASE_OPEN_WAIT);
            return;
        }// end function

        public function get selectSkillNum() : int
        {
            return this._selectSkillNum;
        }// end function

        public function get bOpenWait() : Boolean
        {
            return this._phase == _PHASE_OPEN_WAIT;
        }// end function

        public function get bClosing() : Boolean
        {
            return this._phase == _PHASE_CLOSE;
        }// end function

        public function get bClose() : Boolean
        {
            return this._phase == _PHASE_CLOSE && (this._isoMain == null || this._isoMain.bClosed);
        }// end function

        public function release() : void
        {
            ButtonManager.getInstance().removeButton(this._btnReset);
            this._btnReset = null;
            ButtonManager.getInstance().removeButton(this._btnDecide);
            this._btnDecide = null;
            ButtonManager.getInstance().removeButton(this._btnTimeSelect);
            this._btnTimeSelect = null;
            if (this._isoMain)
            {
                this._isoMain.release();
            }
            this._isoMain = null;
            if (this._mcBase && this._mcBase.parent)
            {
                this._mcBase.parent.removeChild(this._mcBase);
            }
            this._mcBase = null;
            return;
        }// end function

        private function setPhase(param1:int) : void
        {
            this._phase = param1;
            switch(this._phase)
            {
                case _PHASE_OPEN_WAIT:
                {
                    this.initPhaseOpenWait();
                    break;
                }
                case _PHASE_OPEN:
                {
                    this.initPhaseOpen();
                    break;
                }
                case _PHASE_MAIN:
                {
                    this.initPhaseMain();
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
                case _PHASE_MAIN:
                {
                    this.controlPhaseMain(param1);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function initPhaseOpenWait() : void
        {
            this.btnEnable(false);
            return;
        }// end function

        private function initPhaseOpen() : void
        {
            this.btnEnable(false);
            this._isoMain.setIn(function () : void
            {
                setPhase(_PHASE_MAIN);
                return;
            }// end function
            );
            return;
        }// end function

        private function initPhaseMain() : void
        {
            this.btnEnable(true);
            return;
        }// end function

        private function controlPhaseMain(param1:Number) : void
        {
            return;
        }// end function

        private function initPhasePopup() : void
        {
            this.btnEnable(false);
            return;
        }// end function

        private function initPhaseClose() : void
        {
            this.btnEnable(false);
            this._isoMain.setOut(function () : void
            {
                if (_cbClose != null)
                {
                    _cbClose();
                }
                _cbClose = null;
                setPhase(_PHASE_OPEN_WAIT);
                return;
            }// end function
            );
            return;
        }// end function

        public function open() : void
        {
            this.setPhase(_PHASE_OPEN);
            return;
        }// end function

        public function close(param1:Function = null) : void
        {
            this._cbClose = param1;
            this.setPhase(_PHASE_CLOSE);
            return;
        }// end function

        public function btnEnable(param1:Boolean) : void
        {
            this._bBtnEnable = param1;
            this._btnReset.setDisable(!this._bBtnEnable);
            this._btnDecide.setDisable(!this._bDecideBtnEnable || !this._bBtnEnable);
            this._btnTimeSelect.setDisable(!this._bBtnEnable);
            return;
        }// end function

        public function setEnableDecideButton(param1:Boolean) : void
        {
            this._bDecideBtnEnable = param1;
            this._btnDecide.setDisable(!this._bDecideBtnEnable || !this._bBtnEnable);
            return;
        }// end function

        public function setTraineePersonal(param1:PlayerPersonal) : void
        {
            this._traineePesonal = param1;
            return;
        }// end function

        public function setSelectSkillNum(param1:int) : void
        {
            this._selectSkillNum = param1;
            TextControl.setText(this._mcBase.trainingConfMc.timeSelectMc.selectTextMc.textDt, TrainingRoomTable.getTrainingTimeText(this._traineePesonal, this._selectSkillNum));
            return;
        }// end function

        public function reset() : void
        {
            this._selectSkillNum = Constant.UNDECIDED;
            TextControl.setIdText(this._mcBase.trainingConfMc.timeSelectMc.selectTextMc.textDt, MessageId.TRAINING_ROOM_TRAINING_MENU_EMPTY_TIME);
            return;
        }// end function

        private function cbDecideButton(param1:int) : void
        {
            if (this._cbDecide != null)
            {
                this._cbDecide();
            }
            return;
        }// end function

        private function cbResetButton(param1:int) : void
        {
            this.reset();
            if (this._cbReset != null)
            {
                this._cbReset();
            }
            return;
        }// end function

        private function cbTimeSelectButton(param1:int) : void
        {
            if (this._cbSelect != null)
            {
                this._cbSelect();
            }
            return;
        }// end function

    }
}
