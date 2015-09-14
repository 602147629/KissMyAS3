package skillInitiate
{
    import button.*;
    import flash.display.*;
    import message.*;
    import skill.*;
    import utility.*;

    public class SISelectSkillButton extends Object
    {
        private var _baseMc:MovieClip;
        private var _button:ButtonBase;
        private var _teacherNumMc:NumericNumberMc;
        private var _selectedMc:MovieClip;

        public function SISelectSkillButton(param1:MovieClip, param2:MovieClip, param3:Function)
        {
            this._baseMc = param1;
            this._button = ButtonManager.getInstance().addButton(this._baseMc, param3);
            this._button.enterSeId = ButtonBase.SE_DECIDE_ID;
            this._teacherNumMc = new NumericNumberMc(this._baseMc.skillOwnerCountMc.skillOwnerNumMc, 0, 0, false);
            this._selectedMc = param2;
            this.setSkill();
            TextControl.setIdText(this._baseMc.skillOwnerCountMc.textMc.textDt, MessageId.SKILL_INITIATE_INITIATABLE);
            return;
        }// end function

        public function release() : void
        {
            if (this._button)
            {
                ButtonManager.getInstance().removeButton(this._button);
            }
            if (this._teacherNumMc)
            {
                this._teacherNumMc.release();
            }
            return;
        }// end function

        public function setSkill(param1:InitiateSkillData = null) : void
        {
            var _loc_3:* = null;
            if (param1 == null)
            {
                param1 = new InitiateSkillData(Constant.UNDECIDED, 0, false);
            }
            this._button.setId(param1.skillId);
            this._button.setDisable(param1.skillId == Constant.UNDECIDED);
            this._baseMc.visible = param1.skillId != Constant.UNDECIDED;
            var _loc_2:* = SkillManager.getInstance().getSkillInformation(param1.skillId);
            if (_loc_2)
            {
                if (this._baseMc.attributeTypeMc != null)
                {
                    _loc_3 = SkillManager.getInstance().getMagicTypeLabel(_loc_2.skillType);
                    this._baseMc.attributeTypeMc.gotoAndStop(_loc_3);
                }
                TextControl.setText(this._baseMc.skillNameMc.textDt, _loc_2.name);
                this._baseMc.sumiIcon.visible = param1.isHave;
            }
            this._teacherNumMc.setNum(param1.teacherNum);
            return;
        }// end function

        public function setSkillId(param1:int, param2:int) : void
        {
            var _loc_4:* = null;
            this._button.setId(param1);
            this._button.setDisable(param1 == Constant.UNDECIDED);
            this._baseMc.visible = param1 != Constant.UNDECIDED;
            var _loc_3:* = SkillManager.getInstance().getSkillInformation(param1);
            if (_loc_3)
            {
                if (this._baseMc.attributeTypeMc != null)
                {
                    _loc_4 = SkillManager.getInstance().getMagicTypeLabel(_loc_3.skillType);
                    this._baseMc.attributeTypeMc.gotoAndStop(_loc_4);
                }
                TextControl.setText(this._baseMc.skillNameMc.textDt, _loc_3.name);
            }
            this._teacherNumMc.setNum(param2);
            return;
        }// end function

        public function setButtonEnable(param1:Boolean) : void
        {
            this._button.setDisableFlag(!param1 || this._button.id == Constant.UNDECIDED);
            return;
        }// end function

        public function setShowSelectedMc(param1:Boolean) : void
        {
            this._selectedMc.visible = param1;
            return;
        }// end function

    }
}
