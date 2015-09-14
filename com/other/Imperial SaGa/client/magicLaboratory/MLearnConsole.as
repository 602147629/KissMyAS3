package magicLaboratory
{
    import button.*;
    import develop.*;
    import flash.display.*;
    import message.*;
    import skill.*;
    import utility.*;

    public class MLearnConsole extends Object
    {
        private const _PHASE_OPEN:int = 1;
        private const _PHASE_UNSET_SKILL:int = 10;
        private const _PHASE_SET_SKILL:int = 20;
        private const _PHASE_CLOSE:int = 99;
        private const _BUTTON_ID_DECISITON:int = 0;
        private const _BUTTON_ID_RESET:int = 1;
        private const _BUTTON_ID_SELECT:int = 2;
        private var _baseMc:MovieClip;
        private var _isoBase:InStayOut;
        private var _aButton:Array;
        private var _phase:int;
        private var _magicLearnPlate:MagicLearnPlate;
        private var _selectSekillId:int;
        private var _bLearnStart:Boolean;
        private var _bReset:Boolean;
        private var _bOpenSkillSelect:Boolean;

        public function MLearnConsole(param1:MovieClip)
        {
            this._baseMc = param1;
            this._isoBase = new InStayOut(this._baseMc);
            this._aButton = [];
            this._aButton.push(ButtonManager.getInstance().addButton(this._baseMc.decisionBtnMc, this.cbDecision));
            this._aButton.push(ButtonManager.getInstance().addButton(this._baseMc.resetBtnMc, this.cbReset));
            this._aButton.push(ButtonManager.getInstance().addButton(this._baseMc.labolatroyConfMc.selectBtnMc, this.cbSelect));
            this.setEnableButton(false);
            TextControl.setIdText(this._baseMc.decisionBtnMc.textMc.textDt, MessageId.MAGIC_LEARN_BUTTON_START);
            TextControl.setIdText(this._baseMc.resetBtnMc.textMc.textDt, MessageId.MAGIC_LEARN_BUTTON_RESET);
            TextControl.setIdText(this._baseMc.labolatroyConfMc.selectBtnMc.textMc.textDt, MessageId.MAGIC_LEARN_BUTTON_SELECT);
            var _loc_2:* = this._baseMc.labolatroyConfMc.setSkillMc.selectMagicMc;
            this._magicLearnPlate = new MagicLearnPlate(_loc_2, _loc_2.skillNameMc, _loc_2.learningTimeDisplayMc);
            this.setSkill(Constant.EMPTY_ID);
            return;
        }// end function

        public function get bEnd() : Boolean
        {
            return this._isoBase.bEnd;
        }// end function

        public function get bClosed() : Boolean
        {
            return this._isoBase.bClosed;
        }// end function

        public function get bLearnStart() : Boolean
        {
            return this._bLearnStart;
        }// end function

        public function get bReset() : Boolean
        {
            return this._bReset;
        }// end function

        public function get bOpenSkillSelect() : Boolean
        {
            return this._bOpenSkillSelect;
        }// end function

        public function release() : void
        {
            var _loc_1:* = null;
            if (this._isoBase)
            {
                this._isoBase.release();
            }
            if (this._magicLearnPlate)
            {
                this._magicLearnPlate.release();
            }
            this._magicLearnPlate = null;
            for each (_loc_1 in this._aButton)
            {
                
                ButtonManager.getInstance().removeArray(_loc_1);
            }
            this._aButton = [];
            return;
        }// end function

        public function control(param1:Number) : void
        {
            if (this._magicLearnPlate)
            {
                this._magicLearnPlate.control(param1);
            }
            switch(this._phase)
            {
                case this._PHASE_OPEN:
                {
                    this.controlOpen();
                    break;
                }
                case this._PHASE_UNSET_SKILL:
                {
                    this.controlUnsetSkill();
                    break;
                }
                case this._PHASE_SET_SKILL:
                {
                    this.controlSetSkill();
                    break;
                }
                case this._PHASE_CLOSE:
                {
                    this.controlClose();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function setPhase(param1:int) : void
        {
            this._phase = param1;
            switch(this._phase)
            {
                case this._PHASE_OPEN:
                {
                    this.phaseOpen();
                    break;
                }
                case this._PHASE_UNSET_SKILL:
                {
                    this.phaseUnsetSkill();
                    break;
                }
                case this._PHASE_SET_SKILL:
                {
                    this.phaseSetSkill();
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
            return;
        }// end function

        public function openList() : void
        {
            this._bLearnStart = false;
            this._bReset = false;
            this._bOpenSkillSelect = false;
            this.setSkill(Constant.EMPTY_ID);
            this.setPhase(this._PHASE_OPEN);
            return;
        }// end function

        public function closeList() : void
        {
            if (this._isoBase.bOpened)
            {
                this.setPhase(this._PHASE_CLOSE);
            }
            return;
        }// end function

        public function setSkill(param1:int) : void
        {
            this._selectSekillId = param1;
            if (param1 <= Constant.EMPTY_ID)
            {
                this.setPhase(this._PHASE_UNSET_SKILL);
            }
            else
            {
                this.setPhase(this._PHASE_SET_SKILL);
            }
            return;
        }// end function

        public function checkOpenSkillList() : void
        {
            this._bOpenSkillSelect = false;
            return;
        }// end function

        private function phaseOpen() : void
        {
            this._isoBase.setIn(this.cbIn);
            return;
        }// end function

        private function cbIn() : void
        {
            return;
        }// end function

        private function controlOpen() : void
        {
            if (this._isoBase.bOpened)
            {
                this.setPhase(this._PHASE_UNSET_SKILL);
            }
            return;
        }// end function

        private function phaseUnsetSkill() : void
        {
            this._baseMc.labolatroyConfMc.setSkillMc.gotoAndStop("empty");
            this.setEnableButton(true);
            return;
        }// end function

        private function controlUnsetSkill() : void
        {
            return;
        }// end function

        private function phaseSetSkill() : void
        {
            this._baseMc.labolatroyConfMc.setSkillMc.gotoAndStop("select");
            this.setEnableButton(true);
            var _loc_1:* = SkillManager.getInstance().getSkillInformation(this._selectSekillId);
            this._magicLearnPlate.setSkillName(_loc_1.name);
            this._magicLearnPlate.setLearningTime(MagicLearnUtility.getLearnSecond(_loc_1));
            return;
        }// end function

        private function controlSetSkill() : void
        {
            return;
        }// end function

        private function phaseClose() : void
        {
            this.setEnableButton(false);
            this._isoBase.setOut();
            return;
        }// end function

        private function controlClose() : void
        {
            return;
        }// end function

        private function cbDecision(param1:int) : void
        {
            DebugLog.print("console:: decision" + (this._selectSekillId != Constant.EMPTY_ID));
            if (this._selectSekillId != Constant.EMPTY_ID)
            {
                this._bLearnStart = true;
            }
            return;
        }// end function

        private function cbReset(param1:int) : void
        {
            this._bReset = true;
            this.closeList();
            return;
        }// end function

        private function cbSelect(param1:int) : void
        {
            DebugLog.print("console:: select");
            this._bOpenSkillSelect = true;
            return;
        }// end function

        private function setEnableButton(param1:Boolean) : void
        {
            param1 = false;
            this._aButton[this._BUTTON_ID_DECISITON].setDisable(!param1 || this._baseMc.labolatroyConfMc.setSkillMc.currentLabel == "empty");
            this._aButton[this._BUTTON_ID_RESET].setDisable(!param1);
            this._aButton[this._BUTTON_ID_SELECT].setDisable(!param1);
            return;
        }// end function

    }
}
