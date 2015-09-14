package trainingRoom
{
    import asset.*;
    import button.*;
    import flash.display.*;
    import message.*;
    import player.*;
    import resource.*;
    import utility.*;

    public class TrainingRoomKumiteMenu extends Object
    {
        private var _phase:int;
        private var _mcBase:MovieClip;
        private var _isoMain:InStayOut;
        private var _btnReset:ButtonBase;
        private var _btnDecide:ButtonBase;
        private var _btnSkillSelect:ButtonBase;
        private var _btnParamSelect:ButtonBase;
        private var _numericTrainingTime:NumericNumberTimeMc;
        private var _cbClose:Function;
        private var _cbDecide:Function;
        private var _cbReset:Function;
        private var _cbSelect:Function;
        private var _skillInfoBox:TrainingRoomSkillInfoBox;
        private var _itemIcon:Bitmap;
        private var _traineePesonal:PlayerPersonal;
        private var _selectSkillData:OwnSkillData;
        private var _selectParam:int;
        private var _bBtnEnable:Boolean;
        private var _bDecideBtnEnable:Boolean;
        private var _bFixed:Boolean;
        private static const _PHASE_OPEN_WAIT:int = 0;
        private static const _PHASE_OPEN:int = 1;
        private static const _PHASE_MAIN:int = 2;
        private static const _PHASE_CLOSE:int = 3;

        public function TrainingRoomKumiteMenu(param1:MovieClip, param2:Function, param3:Function, param4:Function)
        {
            this._mcBase = param1;
            this._isoMain = new InStayOut(this._mcBase);
            this._btnSkillSelect = ButtonManager.getInstance().addButton(this._mcBase.trainingConfMc.selectBtn1Mc, this.cbSkillSelectButton);
            TextControl.setIdText(this._mcBase.trainingConfMc.selectBtn1Mc.textMc.textDt, MessageId.COMMON_BUTTON_CHANGE);
            this._mcBase.trainingConfMc.changeBtn1Mc.visible = false;
            this._btnParamSelect = ButtonManager.getInstance().addButton(this._mcBase.trainingConfMc.selectBtn2Mc, this.cbParamSelectButton);
            TextControl.setIdText(this._mcBase.trainingConfMc.selectBtn2Mc.textMc.textDt, MessageId.COMMON_BUTTON_CHANGE);
            this._mcBase.trainingConfMc.changeBtn2Mc.visible = false;
            this._mcBase.trainingConfMc.selectBtn1Mc.visible = false;
            this._mcBase.trainingConfMc.selectBtn2Mc.visible = false;
            this._numericTrainingTime = new NumericNumberTimeMc(this._mcBase.trainingConfMc.timeMc, 0, 1);
            this._skillInfoBox = new TrainingRoomSkillInfoBox(this._mcBase.trainingConfMc.skillSelectMc.skillTextMc);
            this._itemIcon = ResourceManager.getInstance().createBitmap(AssetListManager.getInstance().getAssetPng(AssetId.ASSET_TRAINING));
            this._itemIcon.smoothing = true;
            this._mcBase.trainingConfMc.dsNull.addChild(this._itemIcon);
            this._cbClose = null;
            this._cbDecide = param2;
            this._cbReset = param3;
            this._cbSelect = param4;
            this._traineePesonal = null;
            this._selectSkillData = null;
            this._selectParam = Constant.UNDECIDED;
            this._bBtnEnable = true;
            this._bDecideBtnEnable = true;
            this._bFixed = true;
            this.reset();
            this.setPhase(_PHASE_OPEN_WAIT);
            return;
        }// end function

        public function get selectSkillData() : OwnSkillData
        {
            return this._selectSkillData;
        }// end function

        public function get selectParam() : int
        {
            return this._selectParam;
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
            ButtonManager.getInstance().removeButton(this._btnSkillSelect);
            this._btnSkillSelect = null;
            ButtonManager.getInstance().removeButton(this._btnParamSelect);
            this._btnParamSelect = null;
            if (this._itemIcon)
            {
                if (this._itemIcon.parent)
                {
                    this._itemIcon.parent.removeChild(this._itemIcon);
                }
                this._itemIcon = null;
            }
            if (this._numericTrainingTime)
            {
                this._numericTrainingTime.release();
            }
            this._numericTrainingTime = null;
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
            this._btnSkillSelect.setDisable(this._bFixed || !this._bBtnEnable);
            this._btnParamSelect.setDisable(this._bFixed || !this._bBtnEnable);
            return;
        }// end function

        public function setEnableDecideButton(param1:Boolean) : void
        {
            this._bDecideBtnEnable = param1;
            return;
        }// end function

        public function setFix(param1:Boolean) : void
        {
            this._bFixed = param1;
            return;
        }// end function

        public function setTraineePersonal(param1:PlayerPersonal) : void
        {
            this._traineePesonal = param1;
            return;
        }// end function

        public function setSelectSkill(param1:OwnSkillData) : void
        {
            this._selectSkillData = param1;
            this.updateMenu();
            return;
        }// end function

        public function setSelectParam(param1:int) : void
        {
            this._selectParam = param1;
            this.updateMenu();
            return;
        }// end function

        public function reset() : void
        {
            this._selectSkillData = null;
            this._selectParam = Constant.UNDECIDED;
            this.updateMenu();
            return;
        }// end function

        private function updateMenu() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            if (this._selectSkillData)
            {
                _loc_1 = TrainingRoomTable.getKumiteTimeSec(this._selectSkillData);
                _loc_2 = _loc_1 % 60;
                _loc_3 = _loc_1 / 60 % 60;
                _loc_4 = _loc_1 / 60 / 60;
                _loc_5 = _loc_4 * 10000 + _loc_3 * 100 + _loc_2;
                this._numericTrainingTime.setNum(_loc_5);
                _loc_6 = TrainingRoomTable.getKumiteResourceNum(this._selectSkillData);
                TextControl.setText(this._mcBase.trainingConfMc.ItemNum.textDt, _loc_6.toString());
                this._mcBase.trainingConfMc.skillSelectMc.gotoAndStop("skill");
                this._skillInfoBox.setSkillData(this._selectSkillData);
            }
            else
            {
                this._numericTrainingTime.setNum(0);
                TextControl.setText(this._mcBase.trainingConfMc.ItemNum.textDt, "0");
                this._mcBase.trainingConfMc.skillSelectMc.gotoAndStop("select");
                TextControl.setIdText(this._mcBase.trainingConfMc.skillSelectMc.selectTextMc.textDt, MessageId.TRAINING_ROOM_KUMITE_MENU_EMPTY_SKILL);
            }
            if (this._selectParam != Constant.UNDECIDED)
            {
                TextControl.setText(this._mcBase.trainingConfMc.pramSelectMc.selectTextMc.textDt, TrainingRoomTable.getParamReinforceText(this._selectParam));
            }
            else
            {
                TextControl.setIdText(this._mcBase.trainingConfMc.pramSelectMc.selectTextMc.textDt, MessageId.TRAINING_ROOM_KUMITE_MENU_EMPTY_PARAM);
            }
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

        private function cbSkillSelectButton(param1:int) : void
        {
            if (this._cbSelect != null)
            {
                this._cbSelect(TrainingRoomSelecter.SELECTER_TYPE_SKILL);
            }
            return;
        }// end function

        private function cbParamSelectButton(param1:int) : void
        {
            if (this._cbSelect != null)
            {
                this._cbSelect(TrainingRoomSelecter.SELECTER_TYPE_PARAM);
            }
            return;
        }// end function

    }
}
