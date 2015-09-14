package magicLaboratory
{
    import button.*;
    import flash.display.*;
    import home.*;
    import skill.*;
    import user.*;

    public class MLearnSkillSelectButton extends Object
    {
        private var _baseMc:MovieClip;
        private var _selectedMc:MovieClip;
        private var _button:ButtonBase;
        private var _magicLearnPlate:MagicLearnPlate;
        private var _callback:Function;

        public function MLearnSkillSelectButton(param1:MovieClip, param2:MovieClip, param3:Function)
        {
            this._baseMc = param1;
            this._selectedMc = param2;
            this._button = ButtonManager.getInstance().addButton(this._baseMc, this.cbSelected);
            this._button.enterSeId = ButtonBase.SE_DECIDE_ID;
            this._magicLearnPlate = new MagicLearnPlate(this._baseMc, this._baseMc.skillNameMc, this._baseMc.learningTimeDisplayMc, this._baseMc.dsNull);
            this._callback = param3;
            this._selectedMc.visible = false;
            return;
        }// end function

        public function get baseMc() : MovieClip
        {
            return this._baseMc;
        }// end function

        public function get skillId() : int
        {
            return this._button.id;
        }// end function

        public function release() : void
        {
            if (this._magicLearnPlate)
            {
                this._magicLearnPlate.release();
            }
            this._magicLearnPlate = null;
            if (this._button)
            {
                ButtonManager.getInstance().removeButton(this._button);
            }
            this._callback = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            this._magicLearnPlate.control(param1);
            return;
        }// end function

        public function setSkillId(param1:int) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = 0;
            this._button.setId(param1);
            var _loc_2:* = param1 > 0;
            var _loc_3:* = "";
            if (_loc_2)
            {
                _loc_4 = SkillManager.getInstance().getSkillInformation(param1);
                this._magicLearnPlate.setSkillName(_loc_4.name);
                _loc_5 = SkillManager.getInstance().getMagicTypeLabel(_loc_4.skillType);
                this._baseMc.attributeTypeMc.gotoAndStop(_loc_5);
                _loc_6 = UserDataManager.getInstance().userData;
                _loc_7 = _loc_6.getInstitutionInfo(CommonConstant.FACILITY_ID_MAGIC_DEVELOP);
                if (_loc_7 != null)
                {
                    _loc_8 = MagicLearnUtility.getLearnSecond(_loc_4);
                    this._magicLearnPlate.setLearningTime(_loc_8);
                }
                this._magicLearnPlate.setResourceNum(MagicLearnUtility.getLearnResourceNum(_loc_4));
            }
            this._magicLearnPlate.setEnable(_loc_2);
            this._button.setDisable(!_loc_2);
            return;
        }// end function

        public function setSelect(param1:int) : void
        {
            this._selectedMc.visible = param1 == this._button.id;
            return;
        }// end function

        public function setDisable(param1:Boolean) : void
        {
            this._button.setDisableFlag(param1 || this._button.id == Constant.EMPTY_ID);
            return;
        }// end function

        private function cbSelected(param1:int) : void
        {
            if (this._callback != null)
            {
                this._callback(param1);
            }
            return;
        }// end function

        public function checkMouseOn() : Boolean
        {
            if (this._button.id != Constant.EMPTY_ID)
            {
                return ButtonManager.getInstance().checkMouseOnEnableButton(this._button);
            }
            return false;
        }// end function

    }
}
