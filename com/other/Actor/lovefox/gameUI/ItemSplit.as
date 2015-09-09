package lovefox.gameUI
{
    import flash.events.*;
    import flash.utils.*;
    import lovefox.component.*;
    import lovefox.gui.*;
    import lovefox.socket.*;
    import lovefox.unit.*;

    public class ItemSplit extends Window
    {
        private var splititem:Item;
        private var splitobj:Object;

        public function ItemSplit(param1)
        {
            super(param1);
            resize(200, 130);
            this.splitobj = new Object();
            this.initDraw();
            this.initpanel();
            return;
        }// end function

        private function initDraw() : void
        {
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.SMSG_ITEM_SPLIT, this.splitback);
            return;
        }// end function

        private function initpanel() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_4:* = null;
            _loc_1 = new LabelUI();
            this.addChild(_loc_1);
            _loc_1.text = Config.language("ItemSplit", 1);
            _loc_1.x = 10;
            _loc_1.y = 6;
            _loc_2 = new LabelUI();
            this.addChild(_loc_2);
            _loc_2.x = 50;
            _loc_2.y = 30;
            _loc_2.text = Config.language("ItemSplit", 2);
            this.splitobj.itemname = _loc_2;
            var _loc_3:* = new GButton(Config.findUI("general").button4);
            this.addChild(_loc_3);
            _loc_3.label = "＋";
            _loc_3.x = 30;
            _loc_3.y = 60;
            this.splitobj.addbtn = _loc_3;
            _loc_3.addEventListener(MouseEvent.CLICK, this.addnum);
            _loc_4 = new GButton(Config.findUI("general").button4);
            this.addChild(_loc_4);
            _loc_4.label = "－";
            _loc_4.x = 140;
            _loc_4.y = 60;
            this.splitobj.delbtn = _loc_4;
            _loc_4.addEventListener(MouseEvent.CLICK, this.delnum);
            var _loc_5:* = CustomTextInput.create(50, 20, 70, 60, "1", this);
            CustomTextInput.create(50, 20, 70, 60, "1", this).restricts("0-9");
            _loc_5.maxChars = 3;
            this.splitobj.numinput = _loc_5;
            var _loc_6:* = new GButton(Config.findUI("general").button5);
            new GButton(Config.findUI("general").button5).x = 20;
            _loc_6.y = 90;
            _loc_6.label = Config.language("ItemSplit", 3);
            _loc_6.addEventListener(MouseEvent.CLICK, this.sendsplit);
            this.addChild(_loc_6);
            var _loc_7:* = new GButton(Config.findUI("general").button5);
            new GButton(Config.findUI("general").button5).x = 110;
            _loc_7.y = 90;
            _loc_7.label = Config.language("ItemSplit", 4);
            _loc_7.addEventListener(MouseEvent.CLICK, this.cancelsplit);
            this.addChild(_loc_7);
            return;
        }// end function

        public function spitem(param1:Item) : void
        {
            this.splititem = param1;
            this.splitobj.numinput.text = "1";
            this.splitobj.itemname.text = this.splititem._itemData.name + "(" + this.splititem.amount + ")";
            return;
        }// end function

        private function sendsplit(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            if (this.splitobj.numinput.text == "")
            {
                Config.message(Config.language("ItemSplit", 5));
            }
            else if (int(this.splitobj.numinput.text) >= 1 && int(this.splitobj.numinput.text) <= this.splititem.amount)
            {
                _loc_2 = new DataSet();
                _loc_2.addHead(CONST_ENUM.CMSG_ITEM_SPLIT);
                _loc_2.add16(this.splititem._position);
                _loc_2.add32(int(this.splitobj.numinput.text));
                ClientSocket.send(_loc_2);
            }
            else
            {
                Config.message(Config.language("ItemSplit", 6));
            }
            return;
        }// end function

        private function cancelsplit(event:MouseEvent) : void
        {
            super.close();
            return;
        }// end function

        private function splitback(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readByte();
            if (_loc_3 == 0)
            {
                Config.message(Config.language("ItemSplit", 7));
                super.close();
            }
            else
            {
                Config.message(Config.language("ItemSplit", 8));
            }
            return;
        }// end function

        private function addnum(event:MouseEvent) : void
        {
            if (int(this.splitobj.numinput.text) < this.splititem.amount)
            {
                this.splitobj.numinput.text = int(this.splitobj.numinput.text) + 1;
            }
            else
            {
                this.splitobj.numinput.text = this.splititem.amount;
            }
            return;
        }// end function

        private function delnum(event:MouseEvent) : void
        {
            if (int(this.splitobj.numinput.text) > 1)
            {
                this.splitobj.numinput.text = int(this.splitobj.numinput.text) - 1;
            }
            else
            {
                this.splitobj.numinput.text = 1;
            }
            return;
        }// end function

    }
}
