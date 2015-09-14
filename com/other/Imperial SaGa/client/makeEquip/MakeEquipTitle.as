package makeEquip
{
    import button.*;
    import flash.display.*;
    import home.*;
    import message.*;
    import user.*;

    public class MakeEquipTitle extends MakeEquipBase
    {
        private var _bUpgrade:Boolean;

        public function MakeEquipTitle(param1:DisplayObjectContainer)
        {
            this._bUpgrade = false;
            super(param1, "TitleMc", true);
            this.setGrade();
            var _loc_2:* = ButtonManager.getInstance().addButton(_mc.gradeUpBtnMc, this.cbUpgrade);
            TextControl.setIdText(_mc.gradeUpBtnMc.textMc.textDt, MessageId.FACILITY_BUTTON_GRADE_UP);
            _loc_2.enterSeId = ButtonBase.SE_DECIDE_ID;
            _aButton.push(_loc_2);
            setButtonDisable(true);
            return;
        }// end function

        public function get bUpgrade() : Boolean
        {
            return this._bUpgrade;
        }// end function

        public function get btnUpgrade() : ButtonBase
        {
            return _aButton[0];
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
            this.setGrade();
            return;
        }// end function

        override public function close() : void
        {
            super.close();
            this._bUpgrade = false;
            setButtonDisable(true);
            return;
        }// end function

        private function setButtonEnable() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in _aButton)
            {
                
                _loc_1.setDisable(false);
            }
            return;
        }// end function

        override protected function cbMainIn() : void
        {
            super.cbMainIn();
            this.setButtonEnable();
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
            var _loc_1:* = UserDataManager.getInstance().userData.getInstitutionInfo(CommonConstant.FACILITY_ID_MAKE_EQUIP);
            _mc.taitleGradeRankMc.gotoAndStop((_loc_1.grade + 1));
            return;
        }// end function

    }
}
