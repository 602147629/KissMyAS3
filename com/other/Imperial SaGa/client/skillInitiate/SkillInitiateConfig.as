package skillInitiate
{
    import flash.display.*;
    import message.*;
    import player.*;
    import skill.*;
    import user.*;
    import utility.*;

    public class SkillInitiateConfig extends Object
    {
        private const _FRAME_SKILL_UNDECIDE:int = 1;
        private const _FRAME_SKILL_SELECTED:int = 2;
        private var _baseMc:MovieClip;
        private var _siManager:SkillInitiateManager;
        private var _selectedSkillMc:MovieClip;
        private var _selectedProbabilityMc:MovieClip;
        private var _probabilityNumMc:NumericNumberMc;
        private var _probabilityNum2Mc:NumericNumberMc;
        private var _probabilityUpNumMc:NumericNumberMc;

        public function SkillInitiateConfig(param1:MovieClip, param2:SkillInitiateManager)
        {
            this._baseMc = param1.initiateConfMc;
            this._siManager = param2;
            this._selectedSkillMc = this._baseMc.setSkillMc;
            this._selectedProbabilityMc = this._baseMc.setProbabilityMc;
            this._probabilityNumMc = new NumericNumberMc(this._selectedSkillMc.selectSkillMc.probabilityMc.probabilityNumTop1aMc.probabilityNumMc, 0, 0, false);
            this._probabilityNum2Mc = new NumericNumberMc(this._selectedSkillMc.selectSkillMc.probabilityMc.probabilityNumTop1bMc.probabilityNumMc, 0, 0);
            this._probabilityUpNumMc = new NumericNumberMc(this._selectedProbabilityMc.selectProbabilityMc.probabilityNumTopMc.probabilityNumMc, 0, 0, false);
            this.setSelectedSkill(Constant.UNDECIDED);
            return;
        }// end function

        public function release() : void
        {
            if (this._probabilityUpNumMc)
            {
                this._probabilityUpNumMc.release();
            }
            this._probabilityUpNumMc = null;
            if (this._probabilityNum2Mc)
            {
                this._probabilityNum2Mc.release();
            }
            this._probabilityNum2Mc = null;
            if (this._probabilityNumMc)
            {
                this._probabilityNumMc.release();
            }
            this._probabilityNumMc = null;
            return;
        }// end function

        public function setSelectedSkill(param1:int) : void
        {
            this._selectedSkillMc.gotoAndStop(param1 == Constant.UNDECIDED ? (this._FRAME_SKILL_UNDECIDE) : (this._FRAME_SKILL_SELECTED));
            this._selectedProbabilityMc.gotoAndStop(param1 == Constant.UNDECIDED ? (this._FRAME_SKILL_UNDECIDE) : (this._FRAME_SKILL_SELECTED));
            var _loc_2:* = SkillManager.getInstance().getSkillInformation(param1 == Constant.UNDECIDED ? (Constant.EMPTY_ID) : (param1));
            if (_loc_2)
            {
                TextControl.setText(this._selectedSkillMc.selectSkillMc.skillNameMc.textDt, _loc_2.name);
            }
            this._probabilityNumMc.setNum(0);
            return;
        }// end function

        public function updateView(param1:SkillInitiateManager) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = NaN;
            var _loc_2:* = SkillManager.getInstance().getSkillInformation(param1.skillId);
            if (_loc_2 == null)
            {
                this._selectedSkillMc.gotoAndStop(this._FRAME_SKILL_UNDECIDE);
                this._selectedProbabilityMc.gotoAndStop(this._FRAME_SKILL_UNDECIDE);
            }
            else
            {
                this._selectedSkillMc.gotoAndStop(this._FRAME_SKILL_SELECTED);
                this._selectedProbabilityMc.gotoAndStop(this._FRAME_SKILL_SELECTED);
                TextControl.setText(this._selectedSkillMc.selectSkillMc.skillNameMc.textDt, _loc_2.name);
                if (this._siManager.studentId != Constant.EMPTY_ID)
                {
                    _loc_3 = UserDataManager.getInstance().userData.getPlayerPersonal(this._siManager.studentId);
                    this._selectedSkillMc.selectSkillMc.sumiIcon.visible = _loc_3.isHaveSkill(this._siManager.skillId);
                    _loc_4 = Math.round(Math.min(SkillInitiateUtility.getBaseProbability(param1.teacherId, param1.aSupportId) + SkillInitiateUtility.getBonusProbability(param1.bonusId), 100) * 100);
                    this._probabilityNumMc.setNum(int(_loc_4 / 100));
                    this._probabilityNum2Mc.setNum(_loc_4 % 100);
                    TextControl.setText(this._selectedProbabilityMc.selectProbabilityMc.itemNumMc.textDt, SkillInitiateUtility.getItemCost(param1.studentId, param1.bonusId).toString());
                    this._probabilityUpNumMc.setNum(SkillInitiateUtility.getBonusProbability(param1.bonusId));
                    this._selectedSkillMc.selectSkillMc.probabilityMc.upArrowMc.visible = param1.bonusId != Constant.EMPTY_ID;
                }
            }
            return;
        }// end function

    }
}
