package subdualPoint
{
    import button.*;
    import flash.display.*;
    import message.*;
    import resource.*;
    import utility.*;

    public class SubdualPointBar extends Object
    {
        private var _cbRewardBtn:Function;
        private var _mc:MovieClip;
        private var _isoMain:InStayOut;
        private var _pointBox:SubdualPointBox;
        private var _btnReward:ButtonBase;
        private var _btnEnable:Boolean;
        private var _data:SubdualPointData;

        public function SubdualPointBar(param1:DisplayObjectContainer, param2:Function)
        {
            this._cbRewardBtn = param2;
            this._mc = ResourceManager.getInstance().createMovieClip(ResourcePath.QUEST_PATH + "UI_QuestSelect.swf", "QuestSubjugationPoint");
            param1.addChild(this._mc);
            this._isoMain = new InStayOut(this._mc);
            this._pointBox = new SubdualPointBox(this._mc.pointBox);
            this._btnReward = ButtonManager.getInstance().addButton(this._mc.pointBox.rewardBtn, this.cbRewardButtonClick);
            this._btnReward.enterSeId = ButtonBase.SE_DECIDE_ID;
            this._btnReward.setDisable(true);
            TextControl.setIdText(this._mc.pointBox.rewardBtn.textMc.textDt, MessageId.EVENT_QUEST_DESTRUCTION_REWARD_BUTTON);
            this._btnEnable = false;
            this._data = null;
            this.updatePoint();
            return;
        }// end function

        public function bOpen() : Boolean
        {
            return this._isoMain.bOpened;
        }// end function

        public function bClose() : Boolean
        {
            return this._isoMain.bClosed;
        }// end function

        public function release() : void
        {
            if (this._btnReward)
            {
                ButtonManager.getInstance().removeButton(this._btnReward);
            }
            this._btnReward = null;
            if (this._pointBox)
            {
                this._pointBox.release();
            }
            this._pointBox = null;
            if (this._isoMain)
            {
                this._isoMain.release();
            }
            this._isoMain = null;
            if (this._mc && this._mc.parent)
            {
                this._mc.parent.removeChild(this._mc);
            }
            this._mc = null;
            this._cbRewardBtn = null;
            return;
        }// end function

        public function setData(param1:SubdualPointData) : void
        {
            this._data = param1;
            this.updatePoint();
            this.setBtnEnable(this._btnEnable);
            return;
        }// end function

        public function setIn() : void
        {
            if (this._data && this._data.bEnable)
            {
                if (this._isoMain.bOpened == false && this._isoMain.bAnimetionOpen == false)
                {
                    this._isoMain.setIn();
                }
            }
            return;
        }// end function

        public function setOut() : void
        {
            if (this._data && this._data.bEnable)
            {
                if (this._isoMain.bClosed == false && this._isoMain.bAnimetionClose == false)
                {
                    this._isoMain.setOut();
                }
            }
            return;
        }// end function

        public function setBtnEnable(param1:Boolean) : void
        {
            this._btnEnable = param1;
            param1 = param1 && this._data != null && this._data.bEnable;
            this._btnReward.setDisable(!param1);
            return;
        }// end function

        private function updatePoint() : void
        {
            var _loc_1:* = this._data ? (this._data.individualPoint) : (0);
            var _loc_2:* = this._data ? (this._data.wholePoint) : (0);
            this._pointBox.setPoint(_loc_1, _loc_2);
            return;
        }// end function

        private function cbRewardButtonClick(param1:int) : void
        {
            if (this._cbRewardBtn != null)
            {
                this._cbRewardBtn();
            }
            return;
        }// end function

    }
}
