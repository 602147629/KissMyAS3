package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import lovefox.component.*;
    import lovefox.socket.*;
    import lovefox.unit.*;

    public class BoothUI extends Window
    {
        private var _slotStartIndex:Object = 1;
        private var _slotNumber:Object = 10;
        private var _slotArray:Array;
        private var _gridWidth:Object = 2;
        private var _gridHeight:Object = 5;
        private var _gridMatrix:Array;
        private var _owner:Object;
        private var _preBuyItem:Object;
        private var _slotlabArray:Array;
        private var Purchasepanel:Window;
        private var laberprice:Label;
        private var labertatolprice:Label;
        public var _boothAd:Object = "";
        public var _name:Object = "";
        private var _buyAmountNS:InputText;
        private var _num:int = 1;
        private var _addnum:PushButton;
        private var _minusnum:PushButton;
        private var mouselistenerflag:Boolean;
        private var _amt:int;
        private var _pri:int;
        private var _titletempCL:ClickLabel;
        private var _titletempLB:Label;

        public function BoothUI(param1)
        {
            this._slotArray = [];
            this._gridMatrix = [];
            this._slotlabArray = [];
            super(param1);
            resize(400, 360);
            this.initDraw();
            return;
        }// end function

        public function initDraw()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            _loc_1 = this._slotStartIndex;
            while (_loc_1 < this._slotStartIndex + this._slotNumber)
            {
                
                this._slotArray[_loc_1] = new CloneSlot(_loc_1, 32);
                this._slotArray[_loc_1].addEventListener("dblClick", this.handleSlotDoubleClick);
                this._slotArray[_loc_1].addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
                this._slotArray[_loc_1].addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
                _loc_1 = _loc_1 + 1;
            }
            this.arrange();
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.SMSG_BOOTH_ITEM_LIST, this.handleBoothList);
            var _loc_4:* = new Label(this, 140, 320, Config.language("BoothUI", 1));
            this._titletempCL = new ClickLabel(this, 0, 30, "", this.clickname, true);
            this._titletempCL.clickColor([26367, 6837142]);
            this._titletempLB = new Label(this, 0, 30, Config.language("BoothUI", 2));
            return;
        }// end function

        override public function open(event:MouseEvent = null)
        {
            Config.player.stop(false, true);
            this._titletempCL.text = this._name;
            this._titletempLB.text = Config.language("BoothUI", 2);
            this._titletempLB.x = (_width - this._titletempCL.width - this._titletempLB.width) / 2;
            this._titletempCL.x = (_width - this._titletempCL.width - this._titletempLB.width) / 2 + this._titletempLB.width;
            this.title = this._boothAd;
            super.open();
            Config.player.removeEventListener("move", this.handlePlayerMove);
            Config.player.addEventListener("move", this.handlePlayerMove);
            return;
        }// end function

        private function handlePlayerMove(param1)
        {
            Config.player.removeEventListener("move", this.handlePlayerMove);
            this.close();
            return;
        }// end function

        private function clickname(param1)
        {
            var _loc_2:* = new Array();
            var _loc_3:* = [Config.language("BlackMarket", 85), Config.language("BlackMarket", 83), Config.language("BlackMarket", 84)];
            _loc_2 = _loc_3;
            DropDown.dropDown(_loc_2, Config.create(this.handleDropDownClick, this._name));
            return;
        }// end function

        private function handleDropDownClick(param1:int, param2:Object) : void
        {
            switch(param1)
            {
                case 0:
                {
                    Config.ui._chatUI.whisperTo(this._name);
                    break;
                }
                case 1:
                {
                    Config.ui._mailpanel.sendmailshow(null, this._name);
                    Config.ui._mailpanel.open();
                    break;
                }
                case 2:
                {
                    Config.ui._friendUI.addFriend(this._name);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function backerrboothtrade(param1:int)
        {
            var _loc_2:* = undefined;
            if (param1 == 0)
            {
                if (this._preBuyItem != null)
                {
                    if (this.Purchasepanel != null)
                    {
                        this.Purchasepanel.close();
                        if (this.mouselistenerflag)
                        {
                            this.mouselistenerflag = false;
                            this._addnum.removeEventListener(MouseEvent.CLICK, Config.create(this.handleAddMouseDown, this._amt, this._pri));
                            this._minusnum.removeEventListener(MouseEvent.CLICK, Config.create(this.handleMinusMouseDown, this._pri));
                        }
                    }
                    this.owner = this._owner;
                }
            }
            else if (param1 == 507)
            {
                _loc_2 = 1;
                while (_loc_2 < 11)
                {
                    
                    if (this._slotArray[_loc_2].item == null)
                    {
                        this._slotlabArray[_loc_2].text = "";
                    }
                    _loc_2 = _loc_2 + 1;
                }
            }
            return;
        }// end function

        private function handleBoothList(event:SocketEvent)
        {
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_7:* = null;
            var _loc_2:* = event.data;
            _loc_3 = 1;
            while (_loc_3 < 11)
            {
                
                if (this._slotArray[_loc_3].item != null)
                {
                    this._slotArray[_loc_3].item = null;
                }
                this._slotlabArray[_loc_3].text = "";
                _loc_3 = _loc_3 + 1;
            }
            var _loc_8:* = _loc_2.readUnsignedInt();
            var _loc_9:* = _loc_2.readByte();
            _loc_3 = 0;
            while (_loc_3 < _loc_9)
            {
                
                _loc_5 = _loc_2.readUnsignedInt();
                _loc_4 = _loc_2.readUnsignedShort();
                _loc_7 = Item.createItemByBytes(_loc_2, _loc_5);
                _loc_7.display();
                _loc_7._drawer = this._slotArray;
                _loc_6 = _loc_2.readByte();
                _loc_7.data.boothPrice = _loc_2.readUnsignedInt();
                _loc_7.data._position = _loc_6;
                this._slotArray[_loc_6].item = _loc_7;
                if (this._slotArray[_loc_6].item.data.boothPrice < 10000)
                {
                    this._slotlabArray[_loc_6].text = this._slotArray[_loc_6].item._itemData.name + "\n" + Config.language("BoothUI", 3) + Config.coinShow(this._slotArray[_loc_6].item.data.boothPrice);
                }
                else if (this._slotArray[_loc_6].item.data.boothPrice < 1000000)
                {
                    this._slotlabArray[_loc_6].text = this._slotArray[_loc_6].item._itemData.name + "\n" + Config.language("BoothUI", 3) + "<font color=\'#0000ff\'>" + Config.coinShow(this._slotArray[_loc_6].item.data.boothPrice) + "</font>";
                }
                else if (this._slotArray[_loc_6].item.data.boothPrice < 100000000)
                {
                    this._slotlabArray[_loc_6].text = this._slotArray[_loc_6].item._itemData.name + "\n" + Config.language("BoothUI", 3) + "<font color=\'#399765\'>" + Config.coinShow(this._slotArray[_loc_6].item.data.boothPrice) + "</font>";
                }
                else
                {
                    this._slotlabArray[_loc_6].text = this._slotArray[_loc_6].item._itemData.name + "\n" + Config.language("BoothUI", 3) + "<font color=\'#ff3333\'>" + Config.coinShow(this._slotArray[_loc_6].item.data.boothPrice) + "</font>";
                }
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

        public function set owner(param1)
        {
            this._owner = param1;
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.CMSG_BOOTH_ITEM_LIST);
            _loc_2.add32(this._owner);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        public function get owner()
        {
            return this._owner;
        }// end function

        override public function close()
        {
            var _loc_1:* = undefined;
            Config.player.removeEventListener("move", this.handlePlayerMove);
            super.close();
            _loc_1 = 1;
            while (_loc_1 < 11)
            {
                
                if (this._slotArray[_loc_1].item != null)
                {
                    this._slotArray[_loc_1].item = null;
                    this._slotlabArray[_loc_1].text = "";
                }
                _loc_1 = _loc_1 + 1;
            }
            if (this.Purchasepanel != null)
            {
                this.Purchasepanel.close();
                if (this.mouselistenerflag)
                {
                    this.mouselistenerflag = false;
                    this._addnum.removeEventListener(MouseEvent.CLICK, Config.create(this.handleAddMouseDown, this._amt, this._pri));
                    this._minusnum.removeEventListener(MouseEvent.CLICK, Config.create(this.handleMinusMouseDown, this._pri));
                }
            }
            if (this.mouselistenerflag)
            {
                this.mouselistenerflag = false;
                this._addnum.removeEventListener(MouseEvent.CLICK, Config.create(this.handleAddMouseDown, this._amt, this._pri));
                this._minusnum.removeEventListener(MouseEvent.CLICK, Config.create(this.handleMinusMouseDown, this._pri));
            }
            return;
        }// end function

        private function buy(event:MouseEvent, param2:Item)
        {
            this.handleBuy(param2);
            return;
        }// end function

        private function handleBuy(param1)
        {
            var _loc_2:* = undefined;
            this._preBuyItem = param1;
            if (param1._drawer == this._slotArray)
            {
                if (this._num >= 1)
                {
                    _loc_2 = new DataSet();
                    _loc_2.addHead(CONST_ENUM.CMSG_BOOTH_TRADE);
                    _loc_2.add32(this._owner);
                    _loc_2.add8(param1.data._position);
                    _loc_2.add16(this._num);
                    ClientSocket.send(_loc_2);
                }
                else
                {
                    Config.message(Config.language("BoothUI", 4));
                }
            }
            return;
        }// end function

        private function clickSlot(param1)
        {
            var _loc_6:* = null;
            if (this.Purchasepanel != null)
            {
                this.Purchasepanel.close();
                if (this.mouselistenerflag)
                {
                    this.mouselistenerflag = false;
                    this._addnum.removeEventListener(MouseEvent.CLICK, Config.create(this.handleAddMouseDown, this._amt, this._pri));
                    this._minusnum.removeEventListener(MouseEvent.CLICK, Config.create(this.handleMinusMouseDown, this._pri));
                }
            }
            if (this.x > 210)
            {
                this.Purchasepanel = new Window(this.container, this.x - 210, this.y + 50);
            }
            else
            {
                this.Purchasepanel = new Window(this.container, this.x + 410, this.y + 50);
            }
            var _loc_2:* = new PushButton(this.Purchasepanel, 50, 110, Config.language("BoothUI", 5), Config.create(this.buy, param1.item));
            var _loc_3:* = new PushButton(this.Purchasepanel, 110, 110, Config.language("BoothUI", 6), this.consel);
            _loc_2.enabled = true;
            _loc_2.width = 40;
            _loc_3.width = 40;
            this.Purchasepanel.title = Config.language("BoothUI", 7);
            this.Purchasepanel.resize(200, 150);
            var _loc_4:* = new CloneSlot(1, 32);
            new CloneSlot(1, 32).x = 30;
            _loc_4.y = 50;
            this.Purchasepanel.addChild(_loc_4);
            _loc_4.item = param1.item;
            _loc_4.addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
            _loc_4.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
            var _loc_5:* = _loc_4.item.amount;
            this._num = 1;
            if (_loc_4.item.amount == 1)
            {
                _loc_6 = new Label(this.Purchasepanel, 70, 40, Config.language("BoothUI", 8) + param1.item.data.boothPrice);
                _loc_6.html = true;
            }
            else
            {
                this.mouselistenerflag = true;
                this.laberprice = new Label(this.Purchasepanel, 80, 30, Config.language("BoothUI", 9) + param1.item.data.boothPrice);
                this._buyAmountNS = new InputText(this.Purchasepanel, 70, 55, "1", Config.create(this.inputAmount, _loc_5, param1.item.data.boothPrice));
                this._buyAmountNS.width = 60;
                this._buyAmountNS.restrict = "0-9";
                this._addnum = new PushButton(this.Purchasepanel, 160, 55, "+");
                this._addnum.addEventListener(MouseEvent.CLICK, Config.create(this.handleAddMouseDown, _loc_5, param1.item.data.boothPrice));
                this._addnum.width = 28;
                this._minusnum = new PushButton(this.Purchasepanel, 135, 55, "-");
                this._minusnum.addEventListener(MouseEvent.CLICK, Config.create(this.handleMinusMouseDown, param1.item.data.boothPrice));
                this._minusnum.width = 28;
                this.labertatolprice = new Label(this.Purchasepanel, 70, 85, Config.language("BoothUI", 10) + param1.item.data.boothPrice + Config.language("BoothUI", 11));
            }
            this.Purchasepanel.open();
            return;
        }// end function

        private function consel(param1)
        {
            if (this.Purchasepanel != null)
            {
                this.Purchasepanel.close();
                if (this.mouselistenerflag)
                {
                    this.mouselistenerflag = false;
                    this._addnum.removeEventListener(MouseEvent.CLICK, Config.create(this.handleAddMouseDown, this._amt, this._pri));
                    this._minusnum.removeEventListener(MouseEvent.CLICK, Config.create(this.handleMinusMouseDown, this._pri));
                }
            }
            return;
        }// end function

        private function inputAmount(param1, param2, param3)
        {
            if (parseInt(this._buyAmountNS.text) > param2)
            {
                if (Config.player.money4 >= param3 * param2)
                {
                    this._buyAmountNS.text = param2.toString();
                }
                else
                {
                    this._buyAmountNS.text = int(Config.player.money4 / param3).toString();
                }
            }
            else if (parseInt(this._buyAmountNS.text) < 1 || this._buyAmountNS.text == null || this._buyAmountNS.text == "")
            {
                if (Config.player.money4 >= param3)
                {
                    this._buyAmountNS.text = "1";
                }
                else
                {
                    this._buyAmountNS.text = "0";
                }
            }
            else
            {
                this._buyAmountNS.text = parseInt(this._buyAmountNS.text).toString();
                if (parseInt(this._buyAmountNS.text) > int(Config.player.money4 / param3))
                {
                    this._buyAmountNS.text = int(Config.player.money4 / param3).toString();
                }
            }
            this._num = parseInt(this._buyAmountNS.text);
            this.labertatolprice.text = Config.language("BoothUI", 10) + this._num * param3 + Config.language("BoothUI", 11);
            return;
        }// end function

        private function handleAddMouseDown(event:MouseEvent, param2, param3)
        {
            if (parseInt(this._buyAmountNS.text) >= param2)
            {
                if (Config.player.money4 >= param3 * param2)
                {
                    this._buyAmountNS.text = param2.toString();
                    Config.message(Config.language("BoothUI", 12));
                }
                else
                {
                    this._buyAmountNS.text = int(Config.player.money4 / param3).toString();
                    Config.message(Config.language("BoothUI", 13));
                }
            }
            else
            {
                this._buyAmountNS.text = ((parseInt(this._buyAmountNS.text) + 1)).toString();
                if (parseInt(this._buyAmountNS.text) > int(Config.player.money4 / param3))
                {
                    this._buyAmountNS.text = int(Config.player.money4 / param3).toString();
                    Config.message(Config.language("BoothUI", 13));
                }
            }
            this._num = parseInt(this._buyAmountNS.text);
            this.labertatolprice.text = Config.language("BoothUI", 10) + this._num * param3 + Config.language("BoothUI", 11);
            return;
        }// end function

        private function handleMinusMouseDown(event:MouseEvent, param2)
        {
            if (parseInt(this._buyAmountNS.text) <= 1)
            {
                if (Config.player.money4 >= param2)
                {
                    this._buyAmountNS.text = "1";
                }
                else
                {
                    this._buyAmountNS.text = "0";
                }
            }
            else if (Config.player.money4 < param2)
            {
                this._buyAmountNS.text = "0";
            }
            else
            {
                this._buyAmountNS.text = ((parseInt(this._buyAmountNS.text) - 1)).toString();
            }
            this._num = parseInt(this._buyAmountNS.text);
            this.labertatolprice.text = Config.language("BoothUI", 10) + this._num * param2 + Config.language("BoothUI", 11);
            return;
        }// end function

        private function handleSlotClick(param1)
        {
            var _loc_2:* = param1.currentTarget;
            if (_loc_2.item != null)
            {
                this.clickSlot(_loc_2);
            }
            return;
        }// end function

        private function handleSlotDoubleClick(param1)
        {
            var _loc_2:* = param1.currentTarget;
            if (_loc_2.item != null)
            {
                this.clickSlot(_loc_2);
            }
            return;
        }// end function

        private function handleSlotOver(param1)
        {
            var _loc_2:* = param1.currentTarget;
            if (_loc_2.item != null)
            {
                Holder.showInfo(_loc_2.item.outputInfo(), new Rectangle(_loc_2.x + _loc_2.parent.x, _loc_2.y + _loc_2.parent.y, _loc_2._size, _loc_2._size), false, 0, 250, _loc_2.item.star);
            }
            return;
        }// end function

        private function handleSlotOut(param1)
        {
            Holder.closeInfo();
            return;
        }// end function

        public function arrange()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = null;
            var _loc_7:* = null;
            _loc_1 = 0;
            while (_loc_1 < this._gridWidth)
            {
                
                _loc_2 = 0;
                while (_loc_2 < this._gridHeight)
                {
                    
                    if (this._gridMatrix[_loc_1] != null)
                    {
                        if (this._gridMatrix[_loc_1][_loc_2] != null)
                        {
                            removeChild(this._gridMatrix[_loc_1][_loc_2]);
                        }
                    }
                    _loc_2 = _loc_2 + 1;
                }
                _loc_1 = _loc_1 + 1;
            }
            this._gridMatrix = [];
            _loc_1 = 0;
            while (_loc_1 < this._gridWidth)
            {
                
                this._gridMatrix[_loc_1] = [];
                _loc_1 = _loc_1 + 1;
            }
            var _loc_8:* = 0;
            _loc_5 = 0;
            _loc_3 = _loc_8;
            _loc_2 = _loc_8;
            _loc_1 = _loc_8;
            _loc_4 = this._slotStartIndex;
            _loc_3 = _loc_4;
            _loc_5 = 1;
            while (_loc_3 < this._slotStartIndex + this._slotNumber)
            {
                
                _loc_6 = new Sprite();
                _loc_6.graphics.beginFill(16777215, 0.4);
                _loc_6.graphics.drawRect(_loc_1 * 185 + 15, _loc_2 * 50 + 62, 180, 48);
                _loc_6.graphics.endFill();
                this.addChild(_loc_6);
                _loc_7 = new Label(this, _loc_1 * 185 + 60, _loc_2 * 50 + 68);
                _loc_7.html = true;
                this._slotlabArray[_loc_5] = _loc_7;
                this._gridMatrix[_loc_1][_loc_2] = this._slotArray[_loc_3];
                this._gridMatrix[_loc_1][_loc_2].x = _loc_1 * 185 + 23;
                this._gridMatrix[_loc_1][_loc_2].y = _loc_2 * 50 + 70;
                this.addChild(this._gridMatrix[_loc_1][_loc_2]);
                if (_loc_1 < (this._gridWidth - 1))
                {
                    _loc_1 = _loc_1 + 1;
                }
                else
                {
                    _loc_1 = 0;
                    _loc_2 = _loc_2 + 1;
                    if (_loc_2 >= this._gridHeight)
                    {
                        break;
                    }
                }
                _loc_3 = _loc_3 + 1;
                _loc_5 = _loc_5 + 1;
            }
            return;
        }// end function

    }
}
