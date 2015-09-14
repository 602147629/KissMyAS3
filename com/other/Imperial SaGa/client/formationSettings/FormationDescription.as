package formationSettings
{
    import flash.display.*;
    import formation.*;
    import formationSkill.*;
    import message.*;

    public class FormationDescription extends Object
    {
        private var _baseInfoMc:MovieClip;
        private var _baseSkillInfoMc:MovieClip;
        private var _formationHeaderMc:MovieClip;
        private var _formationNameMc:MovieClip;
        private var _formationDescMc:MovieClip;
        private var _formationSkillHeaderMc:MovieClip;
        private var _formationSkillNameMc:MovieClip;
        private var _formationSkillSpMc:MovieClip;
        private var _formationSkillDescMc:MovieClip;

        public function FormationDescription(param1:MovieClip, param2:MovieClip)
        {
            this._baseInfoMc = param1;
            this._baseSkillInfoMc = param2;
            this._formationHeaderMc = this._baseInfoMc.formationTitleMc;
            this._formationNameMc = this._baseInfoMc.formationNameMc;
            this._formationDescMc = this._baseInfoMc.formationInfoTextMc;
            this._formationSkillHeaderMc = this._baseSkillInfoMc.formationSkillTitleMc;
            this._formationSkillNameMc = this._baseSkillInfoMc.formationSkillNameMc;
            this._formationSkillSpMc = this._baseSkillInfoMc.formationSkillSpNumMc;
            this._formationSkillDescMc = this._baseSkillInfoMc.formationSkillInfoTextMc;
            this._baseSkillInfoMc.visible = BuildSwitch.SW_FORMATION_SKILL;
            return;
        }// end function

        public function release() : void
        {
            return;
        }// end function

        public function setDescription(param1:int) : void
        {
            var _loc_2:* = FormationManager.getInstance().getFormationInformation(param1);
            var _loc_3:* = FormationManager.getInstance().getFormationSkillInformation(_loc_2.formationSkillId);
            TextControl.setIdText(this._formationHeaderMc.textDt, MessageId.COMMON_FORMATION);
            if (BuildSwitch.SW_FORMATION_SKILL)
            {
                TextControl.setIdText(this._formationSkillHeaderMc.textDt, MessageId.COMMON_FORMATION_SKILL);
            }
            TextControl.setText(this._formationNameMc.textDt, _loc_2.name);
            TextControl.setText(this._formationDescMc.textDt, _loc_2.explanation);
            if (BuildSwitch.SW_FORMATION_SKILL && _loc_3)
            {
                TextControl.setText(this._formationSkillNameMc.textDt, _loc_3.skillName);
                TextControl.setText(this._formationSkillDescMc.textDt, _loc_3.explanation);
                if (_loc_3.memberMaxNum == _loc_3.memberMinNum)
                {
                    TextControl.setText(this._formationSkillSpMc.textDt, TextControl.formatIdText(MessageId.FORMATION_FORMATION_SKILL_SP, _loc_3.skillPoint, _loc_3.memberNum));
                }
                else
                {
                    TextControl.setText(this._formationSkillSpMc.textDt, TextControl.formatIdText(MessageId.FORMATION_FORMATION_SKILL_SP, _loc_3.skillPoint, _loc_3.memberMinNum + "～" + _loc_3.memberMaxNum));
                }
            }
            else
            {
                TextControl.setIdText(this._formationSkillNameMc.textDt, MessageId.COMMON_EMPTY);
                TextControl.setText(this._formationSkillSpMc.textDt, "");
                TextControl.setText(this._formationSkillDescMc.textDt, "");
            }
            return;
        }// end function

    }
}
