package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import lovefox.socket.*;
    import lovefox.unit.*;

    public class JewelCompound extends Window
    {
        private var slot:CloneSlot;
        private var slot1:CloneSlot;
        private var slotlab:TextField;
        private var slot1lab:TextField;
        private var titled:Label;
        private var titles:Label;
        private var titlem:Label;
        private var titlej:Label;
        private var pdnum:NumericStepper;
        private var _itemId:int;
        private var _num:int;
        private var costMonArr:Array;

        public function JewelCompound(param1:DisplayObjectContainer = null)
        {
            this.costMonArr = [166, 283, 481, 818, 1391, 2366, 4023, 6838];
            super(param1);
            this.initpanel();
            return;
        }// end function

        private function initpanel()
        {
            resize(240, 280);
            this.slot = new CloneSlot(0, 32);
            this.addChild(this.slot);
            this.slot.x = 155;
            this.slot.y = 90;
            this.slot.addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
            this.slot.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
            this.slot1 = new CloneSlot(0, 32);
            this.addChild(this.slot1);
            this.slot1.x = 50;
            this.slot1.y = 90;
            this.slot1.addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
            this.slot1.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
            this.slotlab = Config.getSimpleTextField();
            this.slot1lab = Config.getSimpleTextField();
            this.slotlab.multiline = true;
            this.slot1lab.multiline = true;
            this.slotlab.x = 15;
            this.slot1lab.x = 120;
            this.slotlab.y = 125;
            this.slot1lab.y = 125;
            this.slotlab.width = 100;
            this.slot1lab.width = 100;
            this.slotlab.autoSize = TextFieldAutoSize.CENTER;
            this.slot1lab.autoSize = TextFieldAutoSize.CENTER;
            this.addChild(this.slotlab);
            this.addChild(this.slot1lab);
            this.titled = new Label(this, 45, 50, Config.language("JewelCompound", 2));
            this.titled.html = true;
            this.titlem = new Label(this, 45, 210);
            this.titlej = new Label(this, 45, 165);
            this.titlej.html = true;
            var _loc_1:* = new Label(this, 100, 105, Config.language("JewelCompound", 11));
            var _loc_2:* = new PushButton(this, 100, 240, Config.language("JewelCompound", 6), this.sendcompound);
            _loc_2.width = 40;
            return;
        }// end function

        public function getjewelId(param1:int, param2:int)
        {
            this.title = Config.language("JewelCompound", 1);
            this._itemId = param1;
            this._num = 4;
            var _loc_3:* = Config.ui._charUI.getItemAmount(param1);
            if (_loc_3 >= 4)
            {
                this.titled.text = Config.language("JewelCompound", 7, _loc_3);
            }
            else
            {
                this.titled.text = Config.language("JewelCompound", 12, _loc_3);
            }
            this.titlem.text = Config.language("JewelCompound", 9, this.costMonArr[(param2 - 1)]);
            this.titlej.text = Config.language("JewelCompound", 10);
            if (this.slot1.item != null)
            {
                this.slot1.item.destroy();
            }
            var _loc_4:* = Item.newItem(Config._itemMap[param1], 0, 0, UNIT_TYPE_ENUM.TYPEID_ITEMCLONE, 0);
            Item.newItem(Config._itemMap[param1], 0, 0, UNIT_TYPE_ENUM.TYPEID_ITEMCLONE, 0).display();
            this.slot1.item = _loc_4;
            this.slot1.item.amount = this._num;
            var _loc_5:* = param1 + 1;
            if (this.slot.item != null)
            {
                this.slot.item.destroy();
            }
            var _loc_6:* = Item.newItem(Config._itemMap[_loc_5], 0, 0, UNIT_TYPE_ENUM.TYPEID_ITEMCLONE, 0);
            Item.newItem(Config._itemMap[_loc_5], 0, 0, UNIT_TYPE_ENUM.TYPEID_ITEMCLONE, 0).display();
            this.slot.item = _loc_6;
            this.slot1lab.text = this.slot.item._itemData.name;
            this.slotlab.text = this.slot1.item._itemData.name;
            Config.ui._charUI.addEventListener("itemchange", Config.create(this.jewelcount, param1));
            return;
        }// end function

        public function getfragmentId(param1:int, param2:int)
        {
            this.title = Config.language("JewelCompound", 14);
            this._itemId = param1;
            this._num = 10;
            var _loc_3:* = Config.ui._charUI.getItemAmount(param1);
            if (_loc_3 >= 10)
            {
                this.titled.text = Config.language("JewelCompound", 15, _loc_3);
            }
            else
            {
                this.titled.text = Config.language("JewelCompound", 16, _loc_3);
            }
            this.titlem.text = "";
            this.titlej.text = Config.language("JewelCompound", 17);
            if (this.slot1.item != null)
            {
                this.slot1.item.destroy();
            }
            var _loc_4:* = Item.newItem(Config._itemMap[param1], 0, 0, UNIT_TYPE_ENUM.TYPEID_ITEMCLONE, 0);
            Item.newItem(Config._itemMap[param1], 0, 0, UNIT_TYPE_ENUM.TYPEID_ITEMCLONE, 0).display();
            this.slot1.item = _loc_4;
            this.slot1.item.amount = this._num;
            var _loc_5:* = Config._itemMap[param1].functionKey;
            if (this.slot.item != null)
            {
                this.slot.item.destroy();
            }
            var _loc_6:* = Item.newItem(Config._itemMap[_loc_5], 0, 0, UNIT_TYPE_ENUM.TYPEID_ITEMCLONE, 0);
            Item.newItem(Config._itemMap[_loc_5], 0, 0, UNIT_TYPE_ENUM.TYPEID_ITEMCLONE, 0).display();
            this.slot.item = _loc_6;
            var _loc_7:* = "";
            var _loc_8:* = "";
            _loc_7 = this.slot.item._itemData.name;
            _loc_8 = _loc_7.substr(0, 4);
            _loc_8 = _loc_8 + "\n";
            _loc_8 = _loc_8 + _loc_7.substr(4, _loc_7.length);
            this.slot1lab.htmlText = "<p align=\'center\'>" + _loc_8 + "</p>";
            _loc_7 = this.slot1.item._itemData.name;
            _loc_8 = _loc_7.substr(0, 6);
            _loc_8 = _loc_8 + "\n";
            _loc_8 = _loc_8 + _loc_7.substr(6, _loc_7.length);
            this.slotlab.htmlText = "<p align=\'center\'>" + _loc_8 + "</p>";
            Config.ui._charUI.addEventListener("itemchange", Config.create(this.jewelcount, param1));
            return;
        }// end function

        private function sendcompound(event:MouseEvent)
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.CMSG_STONE_UPGRADE);
            _loc_2.add32(this._itemId);
            _loc_2.add8(this._num);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function jewelcount(param1, param2)
        {
            var _loc_3:* = 0;
            _loc_3 = Config.ui._charUI.getItemAmount(param2);
            if (_loc_3 >= 4)
            {
                this.titled.text = Config.language("JewelCompound", 7, _loc_3);
            }
            else
            {
                this.titled.text = Config.language("JewelCompound", 12, _loc_3);
            }
            return;
        }// end function

        private function handleSlotOver(event:MouseEvent) : void
        {
            var _loc_2:* = event.currentTarget;
            if (_loc_2.item != null)
            {
                Holder.showInfo(_loc_2.item.outputInfo(), new Rectangle(_loc_2.x + this.x, _loc_2.y + this.y, _loc_2._size, _loc_2._size), false, 0, 200);
            }
            return;
        }// end function

        private function handleSlotOut(event:MouseEvent) : void
        {
            Holder.closeInfo();
            return;
        }// end function

        public function backjc()
        {
            Config.message(Config.language("JewelCompound", 13));
            var _loc_1:* = this.slot1.releaseParticle(500);
            this.slot.receiveParticle(_loc_1);
            return;
        }// end function

    }
}
