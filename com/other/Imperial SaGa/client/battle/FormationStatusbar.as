package battle
{
    import button.*;
    import flash.display.*;
    import formationSkill.*;
    import message.*;
    import utility.*;

    public class FormationStatusbar extends Object
    {
        private var _btnFormationAttack:ButtonBase;
        private var _baseMc:MovieClip;
        private var _buttonBase:ButtonBase;
        private var _bOpen:Boolean;
        private var _cbFunc:Function;
        private var _cbFormationAttack:Function;
        private var _openTime:Number;
        private var _isoUi:InStayOut;
        private var _phase:int;
        public static const PHASE_HIDE:int = 1;
        public static const PHASE_OPEN:int = 2;
        public static const PHASE_SHOW:int = 10;
        public static const PHASE_CLOSE:int = 99;

        public function FormationStatusbar(param1:MovieClip, param2:Function = null, param3:Function = null)
        {
            this._baseMc = param1;
            this._isoUi = new InStayOut(this._baseMc);
            this._cbFunc = param3;
            this._cbFormationAttack = param2;
            this.setStatus();
            return;
        }// end function

        public function get btnFormationAttack() : ButtonBase
        {
            return this._btnFormationAttack;
        }// end function

        public function release() : void
        {
            if (this._buttonBase)
            {
                ButtonManager.getInstance().removeButton(this._buttonBase);
                this._buttonBase.release();
            }
            this._buttonBase = null;
            if (this._btnFormationAttack)
            {
                ButtonManager.getInstance().removeButton(this._btnFormationAttack);
            }
            this._btnFormationAttack = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            switch(this._phase)
            {
                case PHASE_OPEN:
                {
                    this.controlOpen(param1);
                    break;
                }
                case PHASE_SHOW:
                {
                    this.controlShow(param1);
                    break;
                }
                case PHASE_CLOSE:
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

        public function setDisableChangeButton(param1:Boolean) : void
        {
            this._buttonBase.setDisable(param1);
            return;
        }// end function

        public function setDisableAttackButton(param1:Boolean) : void
        {
            if (this._btnFormationAttack)
            {
                this._btnFormationAttack.setDisable(param1);
            }
            return;
        }// end function

        public function setEnableFormationSkillBlank(param1:Boolean) : void
        {
            var _loc_2:* = this._baseMc.formationAttackbtnMc.fSkillBtnBlinkMc;
            _loc_2.visible = BuildSwitch.SW_FORMATION_SKILL && param1;
            return;
        }// end function

        public function updateFormationSkill(param1:FormationSkillInformation) : Boolean
        {
            var _loc_3:* = null;
            var _loc_2:* = false;
            if (BuildSwitch.SW_FORMATION_SKILL && param1 != null)
            {
                if (param1.memberMinNum == param1.memberMaxNum)
                {
                    _loc_3 = String("SP：" + param1.skillPoint.toString() + "ｘ" + param1.memberNum.toString());
                }
                else
                {
                    _loc_3 = String("SP：" + param1.skillPoint.toString() + "ｘ" + param1.memberMinNum.toString() + "～" + param1.memberMaxNum.toString());
                }
                TextControl.setText(this._baseMc.formationAttackbtnMc.skillTextMc.textDt, param1.skillName);
                TextControl.setText(this._baseMc.formationAttackbtnMc.skillSpTextMc.textDt, _loc_3);
            }
            else
            {
                TextControl.setIdText(this._baseMc.formationAttackbtnMc.skillTextMc.textDt, MessageId.FORMATION_FORMATION_NO_SKILL);
                TextControl.setText(this._baseMc.formationAttackbtnMc.skillSpTextMc.textDt, "");
            }
            return _loc_2;
        }// end function

        public function updateFormation(param1:int) : void
        {
            this._baseMc.formationChangeBtnMc.formationMiniMc.formationsMc.gotoAndStop("formation" + param1);
            return;
        }// end function

        public function checkFormationStatusbar() : Boolean
        {
            return this._isoUi.bAnimetion;
        }// end function

        public function isOpend() : Boolean
        {
            return this._phase == PHASE_SHOW;
        }// end function

        public function isAnimetionOpen() : Boolean
        {
            return this._phase == PHASE_OPEN;
        }// end function

        public function isClose() : Boolean
        {
            return this._phase == PHASE_CLOSE || this._phase == PHASE_HIDE;
        }// end function

        private function setPhase(param1:int) : void
        {
            if (param1 != this._phase)
            {
                this._phase = param1;
                switch(this._phase)
                {
                    case PHASE_OPEN:
                    {
                        this.phaseOpen();
                        break;
                    }
                    case PHASE_SHOW:
                    {
                        break;
                    }
                    case PHASE_CLOSE:
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

        private function phaseOpen() : void
        {
            return;
        }// end function

        private function controlOpen(param1:Number) : void
        {
            if (this._isoUi.bOpened == false && this._isoUi.bAnimetionOpen == false)
            {
                if (this._openTime <= 0)
                {
                    this._isoUi.setIn(this.cbOpen);
                }
                else
                {
                    this._openTime = this._openTime - param1;
                }
            }
            return;
        }// end function

        private function cbOpen() : void
        {
            this.setPhase(PHASE_SHOW);
            return;
        }// end function

        private function phaseShow() : void
        {
            return;
        }// end function

        private function controlShow(param1:Number) : void
        {
            return;
        }// end function

        private function phaseClose() : void
        {
            this._isoUi.setOut(this.cbClose);
            return;
        }// end function

        private function controlClose() : void
        {
            return;
        }// end function

        private function cbClose() : void
        {
            this.setPhase(PHASE_HIDE);
            return;
        }// end function

        public function openWindow(param1:Number = 0) : void
        {
            if (this._isoUi.bOpened == false && this._isoUi.bAnimetionOpen == false)
            {
                this._openTime = param1;
                this.setPhase(PHASE_OPEN);
            }
            return;
        }// end function

        public function closeWindow() : void
        {
            if (this._isoUi.bClosed == false && this._isoUi.bAnimetionClose == false)
            {
                this.setPhase(PHASE_CLOSE);
            }
            return;
        }// end function

        private function setStatus() : void
        {
            TextControl.setIdText(this._baseMc.formationAttackbtnMc.formationSkillTextMc.textDt, MessageId.COMMON_FORMATION_SKILL);
            this._buttonBase = ButtonManager.getInstance().addButton(this._baseMc.formationChangeBtnMc, this._cbFunc);
            this._buttonBase.enterSeId = ButtonBase.SE_DECIDE_ID;
            if (BuildSwitch.SW_FORMATION_SKILL)
            {
                this._btnFormationAttack = ButtonManager.getInstance().addButton(this._baseMc.formationAttackbtnMc, this._cbFormationAttack);
                this._btnFormationAttack.enterSeId = ButtonBase.SE_DECIDE_ID;
            }
            else
            {
                this._baseMc.formationAttackbtnMc.visible = false;
            }
            return;
        }// end function

    }
}
