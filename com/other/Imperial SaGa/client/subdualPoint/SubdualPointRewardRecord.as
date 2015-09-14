package subdualPoint
{
    import button.*;
    import flash.display.*;
    import item.*;
    import message.*;
    import resource.*;

    public class SubdualPointRewardRecord extends Object
    {
        private var _mc:MovieClip;
        private var _btn:RewardRecordButton;
        private var _bButtonEnable:Boolean;
        private var _bitmapItem:Bitmap;
        private var _data:SubdualPointRewardData;

        public function SubdualPointRewardRecord(param1:int, param2:MovieClip, param3:Function, param4:Function)
        {
            this._mc = param2;
            this._btn = new RewardRecordButton(this._mc, param3, param4);
            this._btn.setId(param1);
            ButtonManager.getInstance().addButtonBase(this._btn);
            this._btn.setDisable(true);
            this._bButtonEnable = false;
            this._bitmapItem = null;
            this._data = null;
            return;
        }// end function

        public function get balloonAmbitNull() : MovieClip
        {
            return this._mc.BalloonAmbitNull;
        }// end function

        public function get balloonNull() : MovieClip
        {
            return this._mc.BalloonNull;
        }// end function

        public function get data() : SubdualPointRewardData
        {
            return this._data;
        }// end function

        public function release() : void
        {
            this._data = null;
            if (this._bitmapItem && this._bitmapItem.parent)
            {
                this._bitmapItem.parent.removeChild(this._bitmapItem);
            }
            this._bitmapItem = null;
            if (this._btn)
            {
                ButtonManager.getInstance().removeArray(this._btn);
                this._btn.release();
            }
            this._btn = null;
            this._mc = null;
            return;
        }// end function

        public function setButtonEnable(param1:Boolean) : void
        {
            this._bButtonEnable = param1;
            this._btn.setDisable(!param1 || this._data == null);
            return;
        }// end function

        public function setRewardData(param1:SubdualPointRewardData) : void
        {
            if (this._bitmapItem && this._bitmapItem.parent)
            {
                this._bitmapItem.parent.removeChild(this._bitmapItem);
            }
            this._bitmapItem = null;
            this._data = param1;
            if (this._data)
            {
                this._mc.visible = true;
                this.setup();
            }
            else
            {
                this._mc.visible = false;
            }
            this.setButtonEnable(this._bButtonEnable);
            return;
        }// end function

        private function setup() : void
        {
            this.setupBitmap(ItemManager.getInstance().getItemPng(this._data.category, this._data.itemId));
            TextControl.setText(this._mc.infoText.textDt, TextControl.formatIdText(MessageId.EVENT_QUEST_DESTRUCTION_CONDITION_POINT, this._data.point));
            TextControl.setIdText(this._mc.pointNum.textDt, MessageId.EVENT_QUEST_DESTRUCTION_CONDITION);
            var _loc_1:* = ItemManager.getInstance().getItemName(this._data.category, this._data.itemId);
            if (this._data.category == CommonConstant.ITEM_KIND_CROWN)
            {
                _loc_1 = String(this._data.num + _loc_1);
                this._mc.numMc.visible = false;
            }
            else if (this._data.num <= 1)
            {
                this._mc.numMc.visible = false;
            }
            else
            {
                this._mc.numMc.visible = true;
                TextControl.setText(this._mc.numMc.textDt, MessageManager.getInstance().getMessage(MessageId.QUEST_GET_TREASURE_CROSS) + this._data.num.toString());
            }
            TextControl.setText(this._mc.itemNameMc.textDt, _loc_1);
            this._mc.getEnd.visible = this._data.bGet;
            this._btn.setLabelChangeEnable(!this._data.bGet);
            return;
        }// end function

        private function setupBitmap(param1:String) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = ResourceManager.getInstance().createBitmap(param1);
            if (_loc_2)
            {
                _loc_2.smoothing = true;
                _loc_2.x = _loc_2.x - _loc_2.width / 2;
                _loc_2.y = _loc_2.y - _loc_2.height / 2;
                _loc_3 = this._mc.itemNull as MovieClip;
                if (_loc_3.numChildren > 0)
                {
                    _loc_3.removeChildren(0, (_loc_3.numChildren - 1));
                }
                _loc_3.addChild(_loc_2);
                this._bitmapItem = _loc_2;
            }
            return;
        }// end function

    }
}

import button.*;

import flash.display.*;

import item.*;

import message.*;

import resource.*;

class RewardRecordButton extends ButtonNotClick
{
    private var _bChangeLabel:Boolean;

    function RewardRecordButton(param1:MovieClip, param2:Function = null, param3:Function = null)
    {
        super(param1, param2, param3);
        this._bChangeLabel = true;
        return;
    }// end function

    public function setLabelChangeEnable(param1:Boolean) : void
    {
        this._bChangeLabel = param1;
        return;
    }// end function

    override protected function labelChange(param1:String) : void
    {
        if (_mc)
        {
            if (this._bChangeLabel)
            {
                _mc.gotoAndStop(param1);
            }
            else
            {
                _mc.gotoAndStop(_LABEL_MOUSE_OUT);
            }
        }
        return;
    }// end function

}

