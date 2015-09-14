package quest
{
    import flash.display.*;
    import flash.geom.*;
    import item.*;
    import message.*;
    import player.*;
    import resource.*;
    import sound.*;

    public class QuestResultRewardRecord extends Object
    {
        private var _mcReward:MovieClip;
        private var _bitmapItem:Bitmap;
        private var _playerDisplay:PlayerDisplay;
        private var _rewardData:QuestRemunerationData;
        public static const LABEL_STOP:String = "stop";
        public static const LABEL_IN:String = "in";
        public static const LABEL_STAY:String = "stay";

        public function QuestResultRewardRecord(param1:MovieClip)
        {
            this._mcReward = param1;
            return;
        }// end function

        public function get mcReward() : MovieClip
        {
            return this._mcReward;
        }// end function

        public function get bitmapItem() : Bitmap
        {
            return this._bitmapItem;
        }// end function

        public function get playerDisplay() : PlayerDisplay
        {
            return this._playerDisplay;
        }// end function

        public function get currentLabel() : String
        {
            return this._mcReward.currentLabel;
        }// end function

        public function get rewardData() : QuestRemunerationData
        {
            return this._rewardData;
        }// end function

        public function release() : void
        {
            this.clear();
            this._mcReward = null;
            return;
        }// end function

        public function clear() : void
        {
            this._mcReward.gotoAndStop(LABEL_STOP);
            if (this._playerDisplay != null)
            {
                this._playerDisplay.release();
                this._playerDisplay = null;
            }
            if (this._bitmapItem && this._bitmapItem.parent)
            {
                this._bitmapItem.parent.removeChild(this._bitmapItem);
                this._bitmapItem = null;
            }
            this._rewardData = null;
            return;
        }// end function

        public function setVisible(param1:Boolean) : void
        {
            this._mcReward.visible = param1;
            return;
        }// end function

        public function setIn() : void
        {
            this._mcReward.gotoAndPlay(LABEL_IN);
            SoundManager.getInstance().playSe(SoundId.SE_REV_RESULT_REWARD);
            return;
        }// end function

        public function setStay() : void
        {
            this._mcReward.gotoAndStop(LABEL_STAY);
            return;
        }// end function

        public function setReward(param1:QuestRemunerationData) : void
        {
            this.clear();
            this._rewardData = param1;
            if (param1.categoryId == CommonConstant.ITEM_KIND_WARRIOR)
            {
                this.setCard(param1);
                this.setCardHidden();
            }
            else
            {
                this.setItem(param1);
            }
            return;
        }// end function

        private function setItem(param1:QuestRemunerationData) : void
        {
            var _loc_2:* = ItemManager.getInstance().getItemPng(param1.categoryId, param1.itemId);
            var _loc_3:* = ItemManager.getInstance().getItemName(param1.categoryId, param1.itemId);
            _loc_2 = ItemManager.getInstance().getItemPng(param1.categoryId, param1.itemId);
            _loc_3 = ItemManager.getInstance().getItemName(param1.categoryId, param1.itemId);
            var _loc_4:* = ResourceManager.getInstance().createBitmap(_loc_2);
            ResourceManager.getInstance().createBitmap(_loc_2).smoothing = true;
            _loc_4.x = _loc_4.x - _loc_4.width / 2;
            _loc_4.y = _loc_4.y - _loc_4.height / 2;
            this._mcReward.itemNull.addChild(_loc_4);
            this._bitmapItem = _loc_4;
            if (param1.categoryId == CommonConstant.ITEM_KIND_CROWN)
            {
                _loc_3 = String(param1.num + _loc_3);
                this._mcReward.numTextMc.visible = false;
            }
            else
            {
                this._mcReward.numTextMc.visible = true;
                TextControl.setText(this._mcReward.numTextMc.textDt, param1.num.toString());
            }
            TextControl.setText(this._mcReward.itemTextMc.textDt, _loc_3);
            return;
        }// end function

        private function setCard(param1:QuestRemunerationData) : void
        {
            var _loc_2:* = new PlayerDisplay(this._mcReward.charaNull, param1.itemId, 0);
            _loc_2.setAnimation(PlayerDisplay.LABEL_SIDE_STOP);
            this._playerDisplay = _loc_2;
            this._mcReward.numTextMc.visible = false;
            return;
        }// end function

        public function setCardHidden() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            if (this._playerDisplay)
            {
                _loc_1 = this._playerDisplay.mc.transform.colorTransform;
                _loc_1.blueMultiplier = 0;
                _loc_1.greenMultiplier = 0;
                _loc_1.redMultiplier = 0;
                this._playerDisplay.mc.transform.colorTransform = _loc_1;
                _loc_2 = MessageManager.getInstance().getMessage(MessageId.QUEST_RESULT_ITEM_RIDDLE);
                TextControl.setText(this._mcReward.itemTextMc.textDt, _loc_2);
            }
            return;
        }// end function

        public function setCardNotHidden() : void
        {
            var _loc_1:* = null;
            if (this._playerDisplay)
            {
                _loc_1 = this._playerDisplay.mc.transform.colorTransform;
                _loc_1.blueMultiplier = 1;
                _loc_1.greenMultiplier = 1;
                _loc_1.redMultiplier = 1;
                this._playerDisplay.mc.transform.colorTransform = _loc_1;
                TextControl.setText(this._mcReward.itemTextMc.textDt, this._playerDisplay.info.name);
            }
            return;
        }// end function

    }
}
