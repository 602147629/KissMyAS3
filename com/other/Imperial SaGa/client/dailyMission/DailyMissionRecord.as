package dailyMission
{
    import button.*;
    import flash.display.*;
    import flash.geom.*;
    import message.*;
    import utility.*;

    public class DailyMissionRecord extends Object
    {
        private var _mc:MovieClip;
        private var _data:DailyMissionData;
        private var _cbGetEnd:Function;
        private var _gauge:Gauge;
        private var _btn:ButtonBase;

        public function DailyMissionRecord(param1:MovieClip, param2:DailyMissionData, param3:Function)
        {
            this._mc = param1;
            this._data = param2;
            this._cbGetEnd = param3;
            this._gauge = null;
            this._btn = null;
            this.setup();
            return;
        }// end function

        public function get mc() : MovieClip
        {
            return this._mc;
        }// end function

        public function get data() : DailyMissionData
        {
            return this._data;
        }// end function

        public function release() : void
        {
            if (this._btn)
            {
                ButtonManager.getInstance().removeButton(this._btn);
            }
            this._btn = null;
            if (this._gauge)
            {
                this._gauge.release();
            }
            this._gauge = null;
            if (this._mc && this._mc.parent)
            {
                this._mc.parent.removeChild(this._mc);
            }
            this._mc = null;
            this._cbGetEnd = null;
            this._data = null;
            return;
        }// end function

        public function updateBtnEnable(param1:Boolean, param2:Number, param3:Number) : void
        {
            if (this._btn)
            {
                if (this.checkButtonPosition(param2, param3))
                {
                    this._btn.setDisable(!param1 || !this._data.bAchieved);
                }
                else
                {
                    this._btn.setDisable(true);
                }
            }
            return;
        }// end function

        private function checkButtonPosition(param1:Number, param2:Number) : Boolean
        {
            var _loc_3:* = new Point(this._mc.getEndBtn.x, this._mc.getEndBtn.y);
            _loc_3 = this._mc.localToGlobal(_loc_3);
            var _loc_4:* = _loc_3.y;
            var _loc_5:* = _loc_3.y + this._mc.getEndBtn.height;
            if (_loc_3.y + this._mc.getEndBtn.height < param1 || param2 < _loc_4)
            {
                return false;
            }
            return true;
        }// end function

        private function setup() : void
        {
            this._mc.gotoAndStop("Group" + this._data.type);
            TextControl.setText(this._mc.nameText.textDt, this._data.missionName);
            TextControl.setText(this._mc.contentText.textDt, this._data.rewardText);
            if (this._data.bAchieved || this._data.bGet)
            {
                TextControl.setIdText(this._mc.progressNumText.textDt, MessageId.DAILY_MISSION_MISSION_PROGRESS_02);
            }
            else
            {
                TextControl.setText(this._mc.progressNumText.textDt, TextControl.formatIdText(MessageId.DAILY_MISSION_MISSION_PROGRESS_01, this._data.progressNum, this._data.progressMax));
            }
            this._gauge = new Gauge(this._mc.gaugeMc, 100, this._data.progressRate);
            TextControl.setIdText(this._mc.rankText.textDt, MessageId.DAILY_MISSION_RANK);
            this._mc.rankMc.gotoAndStop(this.getRankLabel(this._data.rank));
            this._btn = ButtonManager.getInstance().addButton(this._mc.getEndBtn, this.cbGetEndBtn);
            TextControl.setIdText(this._mc.getEndBtn.textMc.textDt, this._data.bGet ? (MessageId.DAILY_MISSION_GET_REWARD_BUTTON_ACHIEVED) : (MessageId.DAILY_MISSION_GET_REWARD_BUTTON));
            this._mc.getEnd.visible = this._data.bGet;
            return;
        }// end function

        private function getRankLabel(param1:int) : String
        {
            return "lv" + param1.toString();
        }// end function

        private function cbGetEndBtn(param1:int) : void
        {
            if (this._cbGetEnd != null)
            {
                this._cbGetEnd(this._data);
            }
            return;
        }// end function

    }
}
