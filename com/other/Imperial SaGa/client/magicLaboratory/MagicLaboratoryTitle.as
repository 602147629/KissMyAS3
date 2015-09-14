package magicLaboratory
{
    import button.*;
    import flash.display.*;
    import home.*;
    import user.*;

    public class MagicLaboratoryTitle extends MagicDevelopBase
    {
        private var _bUpgrade:Boolean;
        private var _btnUpgrade:ButtonBase;

        public function MagicLaboratoryTitle(param1:MovieClip)
        {
            super(param1, true);
            var _loc_2:* = ButtonManager.getInstance().addButton(_mc.gradeUpBtnMc, this.cbUpgrade);
            _loc_2.enterSeId = ButtonBase.SE_DECIDE_ID;
            _aButton.push(_loc_2);
            this.setGrade();
            return;
        }// end function

        public function get bUpgrade() : Boolean
        {
            return this._bUpgrade;
        }// end function

        public function get bOpened() : Boolean
        {
            return _isoMain.bOpened;
        }// end function

        public function get bClosed() : Boolean
        {
            return _isoMain.bClosed;
        }// end function

        override public function open() : void
        {
            super.open();
            this.setButtonEnable();
            this.setGrade();
            return;
        }// end function

        override public function close() : void
        {
            super.close();
            this._bUpgrade = false;
            setButtonDisable();
            return;
        }// end function

        public function titleEnable() : void
        {
            this.setButtonEnable();
            this.setGrade();
            return;
        }// end function

        public function titleDisable() : void
        {
            this._bUpgrade = false;
            setButtonDisable();
            return;
        }// end function

        override public function release() : void
        {
            super.release();
            return;
        }// end function

        private function cbUpgrade(param1:int) : void
        {
            this._bUpgrade = true;
            return;
        }// end function

        public function setGrade() : void
        {
            var _loc_3:* = null;
            var _loc_1:* = UserDataManager.getInstance().userData;
            var _loc_2:* = 0;
            for each (_loc_3 in _loc_1.aInstitution)
            {
                
                if (_loc_3.id == CommonConstant.FACILITY_ID_MAGIC_DEVELOP)
                {
                    _loc_2 = _loc_3.grade;
                    break;
                }
            }
            _mc.taitleGradeRankMc.gotoAndStop((_loc_2 + 1));
            return;
        }// end function

        protected function setButtonEnable() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in _aButton)
            {
                
                _loc_1.setDisable(false);
            }
            return;
        }// end function

    }
}
