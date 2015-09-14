package dailyMission
{
    import flash.display.*;
    import flash.geom.*;
    import message.*;
    import resource.*;
    import utility.*;

    public class DailyMissionList extends Object
    {
        private var _mcBase:MovieClip;
        private var _cbGetEndBtn:Function;
        private var _spr:Sprite;
        private var _bBtnEnable:Boolean;
        private var _scrollBar:ScrollBar;
        private var _scrollPos:int;
        private var aRecord:Array;
        private static const DISPLAY_NUM:int = 4;

        public function DailyMissionList(param1:MovieClip, param2:Function)
        {
            this._mcBase = param1;
            this._cbGetEndBtn = param2;
            this._spr = new Sprite();
            this._mcBase.listNull1.addChild(this._spr);
            TextControl.setIdText(this._mcBase.timeLimitTextMc.infoTextMc.textDt, MessageId.DAILY_MISSION_TIME_LIMIT);
            TextControl.setIdText(this._mcBase.totalNumTextMc.infoTextMc.textDt, MessageId.DAILY_MISSION_MISSION_NUM);
            this._bBtnEnable = false;
            this._scrollBar = new ScrollBar(this._mcBase.scrollBerTopMc, this.cbScroll);
            this._scrollBar.open();
            this._scrollPos = 0;
            this.aRecord = [];
            this.updateMission();
            return;
        }// end function

        public function release() : void
        {
            this.clearRecord();
            this.aRecord = null;
            if (this._scrollBar)
            {
                this._scrollBar.release();
            }
            this._scrollBar = null;
            if (this._spr && this._spr.parent)
            {
                this._spr.parent.removeChild(this._spr);
            }
            this._spr = null;
            this._cbGetEndBtn = null;
            this._mcBase = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            this._scrollBar.control();
            this.updateTime();
            return;
        }// end function

        public function setButtonEnable(param1:Boolean) : void
        {
            this._bBtnEnable = param1;
            this.updateBtnEnable();
            return;
        }// end function

        private function updateBtnEnable() : void
        {
            var _loc_1:* = this._bBtnEnable;
            this._scrollBar.setEnable(_loc_1);
            this.updateMissionButton();
            return;
        }// end function

        private function updateTime() : void
        {
            var _loc_1:* = DailyMissionManager.getInstance().getRemainTime();
            TextControl.setText(this._mcBase.timeLimitTextMc.numTextMc.textDt, StringTools.timeTextSec(_loc_1));
            return;
        }// end function

        private function clearRecord() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this.aRecord)
            {
                
                _loc_1.release();
            }
            this.aRecord = [];
            return;
        }// end function

        public function updateMission() : void
        {
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            this.clearRecord();
            var _loc_1:* = 0;
            var _loc_2:* = this._mcBase.listNull1.y - this._mcBase.listNull0.y;
            var _loc_3:* = 0;
            var _loc_4:* = DailyMissionManager.getInstance().aMissionData;
            var _loc_5:* = 0;
            while (_loc_5 < _loc_4.length)
            {
                
                _loc_7 = _loc_4[_loc_5];
                if (_loc_7.bAchieved || _loc_7.bGet)
                {
                    _loc_3++;
                }
                _loc_8 = ResourceManager.getInstance().createMovieClip(ResourcePath.HOME_PATH + "UI_DailyMission.swf", "missionList");
                if (_loc_8)
                {
                    this._spr.addChild(_loc_8);
                    _loc_8.y = _loc_1;
                    _loc_1 = _loc_1 + _loc_2;
                    _loc_9 = new DailyMissionRecord(_loc_8, _loc_7, this.cbGetEnd);
                    this.aRecord.push(_loc_9);
                }
                _loc_5++;
            }
            var _loc_6:* = (this.aRecord.length - DISPLAY_NUM) * _loc_2;
            if ((this.aRecord.length - DISPLAY_NUM) * _loc_2 < 0)
            {
                _loc_6 = 0;
            }
            this._scrollBar.setMaxScroll(_loc_6);
            this.updateScroll();
            this.updateTime();
            TextControl.setText(this._mcBase.totalNumTextMc.numTextMc.textDt, TextControl.formatIdText(MessageId.DAILY_MISSION_MISSION_NUM_PROGRESS, _loc_3, _loc_4.length));
            return;
        }// end function

        private function updateScroll() : void
        {
            this._scrollPos = this._scrollBar.curScroll;
            this._spr.y = -this._scrollPos;
            this.updateMissionButton();
            return;
        }// end function

        private function updateMissionButton() : void
        {
            var _loc_6:* = null;
            var _loc_1:* = this._bBtnEnable;
            var _loc_2:* = this._mcBase.listNull1.y - this._mcBase.listNull0.y;
            var _loc_3:* = this._mcBase.listNull1.localToGlobal(new Point());
            var _loc_4:* = _loc_3.y;
            var _loc_5:* = _loc_3.y + _loc_2 * DISPLAY_NUM;
            for each (_loc_6 in this.aRecord)
            {
                
                _loc_6.updateBtnEnable(_loc_1, _loc_4, _loc_5);
            }
            return;
        }// end function

        private function cbScroll() : void
        {
            if (this._scrollPos != this._scrollBar.curScroll)
            {
                this.updateScroll();
            }
            return;
        }// end function

        private function cbGetEnd(param1:DailyMissionData) : void
        {
            if (this._cbGetEndBtn != null)
            {
                this._cbGetEndBtn(param1);
            }
            return;
        }// end function

    }
}
