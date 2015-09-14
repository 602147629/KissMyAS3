package home
{
    import button.*;
    import dailyMission.*;
    import flash.display.*;

    public class HomeDailyMissionIcon extends Object
    {
        private var _baseMc:MovieClip;
        private var _completeIcon:MovieClip;
        private var _finisheMarkMc:MovieClip;
        private var _cbMissionBtn:Function;
        private var _dailyMissionBtn:ButtonBase;
        private var _bVisible:Boolean;
        private var _bEnable:Boolean;

        public function HomeDailyMissionIcon(param1:MovieClip, param2:MovieClip, param3:Function, param4:Boolean)
        {
            this._baseMc = param1;
            this._completeIcon = this._baseMc.completeIcon;
            this._completeIcon.visible = false;
            this._finisheMarkMc = param2;
            this._finisheMarkMc.visible = false;
            this._dailyMissionBtn = ButtonManager.getInstance().addButton(this._baseMc, param3);
            this._dailyMissionBtn.enterSeId = ButtonBase.SE_DECIDE_ID;
            this._dailyMissionBtn.setDisableFlag(true);
            this._bVisible = param4;
            this._bEnable = false;
            this.setVisible(this._bVisible);
            return;
        }// end function

        public function release() : void
        {
            if (this._dailyMissionBtn)
            {
                ButtonManager.getInstance().removeButton(this._dailyMissionBtn);
            }
            this._dailyMissionBtn = null;
            this._finisheMarkMc = null;
            this._completeIcon = null;
            this._baseMc = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            if (this._bVisible)
            {
                this.update();
            }
            return;
        }// end function

        public function update() : void
        {
            if (DailyMissionManager.getInstance().checkResetTime())
            {
                DailyMissionManager.getInstance().reset();
            }
            if (DailyMissionManager.getInstance().bAllGet)
            {
                this._completeIcon.visible = this._bVisible;
                this._finisheMarkMc.visible = false;
            }
            else if (DailyMissionManager.getInstance().bAnyClear)
            {
                this._completeIcon.visible = false;
                this._finisheMarkMc.visible = this._bVisible;
            }
            else
            {
                this._completeIcon.visible = false;
                this._finisheMarkMc.visible = false;
            }
            return;
        }// end function

        public function setVisible(param1:Boolean) : void
        {
            this._bVisible = param1;
            this._baseMc.visible = param1;
            this.updateBtnEnable();
            this.update();
            return;
        }// end function

        public function setEnable(param1:Boolean) : void
        {
            this._bEnable = param1;
            this.updateBtnEnable();
            return;
        }// end function

        private function updateBtnEnable() : void
        {
            var _loc_1:* = this._bEnable && this._bVisible;
            this._dailyMissionBtn.setDisableFlag(!_loc_1);
            return;
        }// end function

    }
}
