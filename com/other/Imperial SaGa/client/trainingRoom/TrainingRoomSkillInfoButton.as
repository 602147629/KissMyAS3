package trainingRoom
{
    import asset.*;
    import button.*;
    import flash.display.*;
    import input.*;
    import message.*;
    import player.*;
    import skill.*;
    import utility.*;

    public class TrainingRoomSkillInfoButton extends Object
    {
        private var _mc:MovieClip;
        private var _balloonAmbitNull:MovieClip;
        private var _ambitOffs:int;
        private var _bDisable:Boolean;
        private var _ownSkillData:OwnSkillData;
        private var _powerBtn:ButtonBase;
        private var _hitBtn:ButtonBase;
        private var _assetIcon:AssetIcon;

        public function TrainingRoomSkillInfoButton(param1:MovieClip, param2:MovieClip, param3:int, param4:int, param5:Function, param6:Function)
        {
            this._mc = param1;
            this._balloonAmbitNull = param2;
            this._ambitOffs = param3;
            this._bDisable = false;
            this._ownSkillData = null;
            if (this._mc.dsNull)
            {
                this._assetIcon = new AssetIcon(this._mc.dsNull, AssetId.ASSET_TRAINING);
            }
            if (this._mc.PowerBtn)
            {
                this._powerBtn = new ButtonBase(this._mc.PowerBtn, param5);
                this._powerBtn.setId(param4);
                this._powerBtn.enterSeId = ButtonBase.SE_DECIDE_ID;
                ButtonManager.getInstance().addButtonBase(this._powerBtn);
                TextControl.setIdText(this._mc.PowerBtn.textMc.textDt, MessageId.TRAINING_ROOM_KUMITE_POWER_REINFORCE);
            }
            if (this._mc.HitBtn)
            {
                this._hitBtn = new ButtonBase(this._mc.HitBtn, param6);
                this._hitBtn.setId(param4);
                this._hitBtn.enterSeId = ButtonBase.SE_DECIDE_ID;
                ButtonManager.getInstance().addButtonBase(this._hitBtn);
                TextControl.setIdText(this._mc.HitBtn.textMc.textDt, MessageId.TRAINING_ROOM_KUMITE_HIT_REINFORCE);
            }
            return;
        }// end function

        public function get balloonAmbitNull() : MovieClip
        {
            return this._balloonAmbitNull;
        }// end function

        public function get ambitOffs() : int
        {
            return this._ambitOffs;
        }// end function

        public function get balloonNull() : MovieClip
        {
            return this._mc.BalloonNull;
        }// end function

        public function get ownSkillData() : OwnSkillData
        {
            return this._ownSkillData;
        }// end function

        public function release() : void
        {
            if (this._hitBtn)
            {
                ButtonManager.getInstance().removeButton(this._hitBtn);
            }
            this._hitBtn = null;
            if (this._powerBtn)
            {
                ButtonManager.getInstance().removeButton(this._powerBtn);
            }
            this._powerBtn = null;
            if (this._assetIcon)
            {
                this._assetIcon.release();
            }
            this._assetIcon = null;
            this._ownSkillData = null;
            this._balloonAmbitNull = null;
            this._mc = null;
            return;
        }// end function

        public function getMoveClip() : MovieClip
        {
            return this._mc;
        }// end function

        public function setDisable(param1:Boolean) : void
        {
            this._bDisable = param1;
            if (this._powerBtn)
            {
                this._powerBtn.setDisable(param1);
            }
            if (this._hitBtn)
            {
                this._hitBtn.setDisable(param1);
            }
            return;
        }// end function

        public function setKumiteSkillData(param1:OwnSkillData) : void
        {
            this._ownSkillData = param1;
            var _loc_2:* = this._ownSkillData.skillInfo;
            var _loc_3:* = this._mc.skillTextMc;
            TextControl.setText(_loc_3.skillNameMc.textDt, _loc_2.name);
            var _loc_4:* = TrainingRoomTable.getKumiteTimeSec(this._ownSkillData);
            TextControl.setIdText(_loc_3.TimeNum.textDt1, MessageId.TRAINING_ROOM_KUMITE_TIME);
            TextControl.setText(_loc_3.TimeNum.textDt2, StringTools.timeTextSec322(_loc_4));
            var _loc_5:* = TrainingRoomTable.getKumiteResourceNum(this._ownSkillData);
            TextControl.setIdText(_loc_3.CostNum.textDt1, MessageId.QUEST_SELECT_ITEM_NUM);
            TextControl.setText(_loc_3.CostNum.textDt2, _loc_5.toString());
            return;
        }// end function

        public function setTrainingSkillData(param1:OwnSkillData) : void
        {
            this._ownSkillData = param1;
            var _loc_2:* = this._ownSkillData.skillInfo;
            TextControl.setText(this._mc.textMc.textDt, _loc_2.name);
            return;
        }// end function

        public function isHitTest() : Boolean
        {
            return !this._bDisable && this._mc.visible && InputManager.getInstance().isHitTest(this._mc);
        }// end function

    }
}
