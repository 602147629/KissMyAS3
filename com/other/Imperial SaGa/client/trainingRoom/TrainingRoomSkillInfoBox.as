package trainingRoom
{
    import flash.display.*;
    import message.*;
    import player.*;
    import skill.*;

    public class TrainingRoomSkillInfoBox extends Object
    {
        private var _mcBase:MovieClip;

        public function TrainingRoomSkillInfoBox(param1:MovieClip)
        {
            this._mcBase = param1;
            return;
        }// end function

        public function setSkillData(param1:OwnSkillData) : void
        {
            var _loc_2:* = param1.skillInfo;
            var _loc_3:* = param1.powerTotal - _loc_2.power;
            var _loc_4:* = param1.hitTotalShowVal - _loc_2.hitShowVal;
            var _loc_5:* = param1.spTotal - _loc_2.sp;
            TextControl.setText(this._mcBase.skillNameMc.textDt, _loc_2.name);
            TextControl.setText(this._mcBase.skillParam1Mc.textDt, TextControl.formatIdText(MessageId.COMMON_SKILL_STATUS_VALUE_TEXT, MessageManager.getInstance().getMessage(MessageId.COMMON_SKILL_STATUS_POWER), param1.powerTotal));
            TextControl.setText(this._mcBase.skillParam2Mc.textDt, TextControl.formatIdText(MessageId.COMMON_SKILL_STATUS_VALUE_TEXT, MessageManager.getInstance().getMessage(MessageId.COMMON_SKILL_STATUS_HIT), TextControl.createHitValText(param1.hitTotal)));
            TextControl.setText(this._mcBase.skillParam3Mc.textDt, TextControl.formatIdText(MessageId.COMMON_SKILL_STATUS_VALUE_TEXT, MessageManager.getInstance().getMessage(MessageId.COMMON_SKILL_STATUS_SP), param1.spTotal));
            TextControl.setBonusText(this._mcBase.revisionNum1Mc, _loc_3 != 0, _loc_3);
            TextControl.setBonusText(this._mcBase.revisionNum2Mc, _loc_4 != 0, _loc_4);
            TextControl.setReverseBonusText(this._mcBase.revisionNum3Mc, _loc_5 != 0, _loc_5);
            return;
        }// end function

    }
}
