package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;
    import lovefox.socket.*;
    import lovefox.unit.*;

    public class StallUI extends Window
    {
        private var _slotStartIndex:Object = 1;
        private var _slotNumber:Object = 10;
        private var _slotArray:Array;
        private var _gridWidth:Object = 2;
        private var _gridHeight:Object = 5;
        private var _gridMatrix:Array;
        private var _slotlabArray:Array;
        private var _slotlabArrayPrice:Object;
        private var _sellPanel:Panel;
        private var _sellAmountNS:InputText;
        private var _sellPriceNS:InputText;
        private var _sellPriceMUI:MoneyUI;
        private var _sellConfirmPB:PushButton;
        private var _sellConselPB:PushButton;
        private var _sellTempItem:Item;
        public var _sellTempSlot:CloneSlot;
        private var _doorPb:PushButton;
        public var _doorOpening:Boolean = false;
        private var _moneyUI:MoneyUI;
        private var _inputext:InputText;
        private var _sellholderitem:PushButton;
        private var _max:uint;
        private var _stallpanel:Panel;
        private var _stalltitleText:TextField;
        private var _stateBar:StateBar;
        private var _flag:Boolean;
        private var _cookieStall:Array;

        public function StallUI(param1)
        {
            this._slotArray = [];
            this._gridMatrix = [];
            this._slotlabArray = [];
            this._slotlabArrayPrice = [];
            this._cookieStall = [];
            super(param1);
            resize(400, 360);
            title = Config.language("StallUI", 1);
            this.initDraw();
            return;
        }// end function

        override public function open(event:MouseEvent = null)
        {
            GuideUI.testDoId(53);
            super.open();
            Config.player.removeEventListener("move", this.handlePlayerMove);
            Config.player.addEventListener("move", this.handlePlayerMove);
            return;
        }// end function

        override public function close()
        {
            var _loc_1:* = undefined;
            if (Config.getMouseState() != "")
            {
                Config.setMouseState("", true);
            }
            if (!this._flag)
            {
                _loc_1 = this._slotStartIndex;
                while (_loc_1 < this._slotStartIndex + this._slotNumber)
                {
                    
                    if (this._slotArray[_loc_1].item != null)
                    {
                        this._flag = true;
                        AlertUI.alert(Config.language("StallUI", 2), Config.language("StallUI", 3), [Config.language("StallUI", 4), Config.language("StallUI", 5)], [this.closestore, this.closecansel]);
                        return;
                    }
                    _loc_1 = _loc_1 + 1;
                }
                this.closestore();
            }
            return;
        }// end function

        private function closecansel(param1)
        {
            this._flag = false;
            return;
        }// end function

        private function closestore(param1 = null)
        {
            var _loc_3:* = null;
            Config.player.removeEventListener("move", this.handlePlayerMove);
            this._flag = false;
            this.handleSellConsel();
            var _loc_2:* = this._slotStartIndex;
            while (_loc_2 < this._slotStartIndex + this._slotNumber)
            {
                
                if (this._slotArray[_loc_2].item != null)
                {
                    this._slotArray[_loc_2].item._drawer[this._slotArray[_loc_2].item._position].unlock();
                    this._slotArray[_loc_2].item = null;
                    this._slotlabArray[_loc_2].text = "";
                    this._slotlabArrayPrice[_loc_2] = 0;
                }
                this._slotArray[_loc_2].unlock();
                _loc_2++;
            }
            if (this._doorOpening)
            {
                this._doorPb.label = Config.language("StallUI", 6);
                Config.player.resting = false;
                this._doorOpening = false;
                Config.player.lock = false;
                _loc_3 = new DataSet();
                _loc_3.addHead(CONST_ENUM.CMSG_CLOSE_BOOTH);
                ClientSocket.send(_loc_3);
            }
            super.close();
            Config.ui._bagUI.addhandleSwitchMix();
            Config.player.removeEventListener("move", this.handlePlayerMove);
            return;
        }// end function

        public function initDraw()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = null;
            _loc_1 = this._slotStartIndex;
            while (_loc_1 < this._slotStartIndex + this._slotNumber)
            {
                
                this._slotArray[_loc_1] = new CloneSlot(_loc_1, 32);
                this._slotArray[_loc_1].addEventListener("sglClick", this.handleSlotClick);
                this._slotArray[_loc_1].addEventListener("dblClick", this.handleSlotDoubleClick);
                this._slotArray[_loc_1].addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
                this._slotArray[_loc_1].addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
                _loc_1 = _loc_1 + 1;
            }
            this.arrange();
            this._moneyUI = new MoneyUI(this, 30, 205);
            this._moneyUI.visible = false;
            this._inputext = new InputText(this, 128, 30, "", this.inputmaxChar);
            this._inputext.width = 168;
            this._inputext.height = 20;
            _loc_4 = new Label(this, 70, 30, Config.language("StallUI", 7));
            this._sellPanel = new Panel(null, 60, 170);
            this._sellPanel.width = 200;
            this._sellPanel.height = 135;
            this._sellPanel.color = Style.WINDOW;
            this._sellPanel.border = 2;
            _loc_4 = new Label(this._sellPanel, 30, 15, Config.language("StallUI", 8));
            _loc_4 = new Label(this._sellPanel, 15, 40, Config.language("StallUI", 9));
            _loc_4 = new Label(this._sellPanel, 15, 70, Config.language("StallUI", 10));
            this._sellAmountNS = new InputText(this._sellPanel, 71, 40, "", this.inputAmount);
            this._sellAmountNS.height = 20;
            this._sellAmountNS.restrict = "0-9";
            this._sellPriceNS = new InputText(this._sellPanel, 71, 70, "", this.inputPrice);
            this._sellPriceNS.height = 20;
            this._sellPriceNS.restrict = "0-9";
            this._sellConfirmPB = new PushButton(this._sellPanel, 27, 100, Config.language("StallUI", 11), this.handleSellConfirm);
            this._sellConfirmPB.width = 69;
            this._sellConselPB = new PushButton(this._sellPanel, 104, 100, Config.language("StallUI", 12), this.handleSellConsel);
            this._sellConselPB.width = 69;
            this._doorPb = new PushButton(this, 180, 320, Config.language("StallUI", 6), this.handleDoorClick);
            this._sellholderitem = new PushButton(this, 40, 320, Config.language("StallUI", 13), this.sellitemClick);
            this._sellholderitem.width = 40;
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.SMSG_OPEN_BOOTH, this.handleBoothSet);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.SMSG_CLOSE_BOOTH, this.handleBoothCancel);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.SMSG_BOOTH_ITEM_UPDATE, this.handleBoothUpdate);
            return;
        }// end function

        private function inputmaxChar(param1)
        {
            var _loc_2:* = 24;
            var _loc_3:* = 0;
            while (_loc_3 < this._inputext.text.length)
            {
                
                if (this._inputext.text.charCodeAt(_loc_3) > 255)
                {
                    _loc_2 = _loc_2 - 1;
                }
                _loc_3++;
            }
            this._inputext.maxChars = int(_loc_2);
            return;
        }// end function

        private function inputAmount(param1)
        {
            if (parseInt(this._sellAmountNS.text) > this._max)
            {
                this._sellAmountNS.text = this._max.toString();
            }
            else if (parseInt(this._sellAmountNS.text) < 1 || this._sellAmountNS.text == null || this._sellAmountNS.text == "")
            {
                this._sellAmountNS.text = "1";
            }
            else
            {
                this._sellAmountNS.text = parseInt(this._sellAmountNS.text).toString();
            }
            return;
        }// end function

        private function inputPrice(param1)
        {
            if (parseInt(this._sellPriceNS.text) > 100000000)
            {
                this._sellPriceNS.text = "100000000";
            }
            else if (parseInt(this._sellPriceNS.text) < 1 || this._sellPriceNS.text == null || this._sellPriceNS.text == "")
            {
                this._sellPriceNS.text = "1";
            }
            else
            {
                this._sellPriceNS.text = parseInt(this._sellPriceNS.text).toString();
            }
            return;
        }// end function

        private function handleBoothUpdate(event:SocketEvent)
        {
            var _loc_2:* = undefined;
            var _loc_10:* = undefined;
            var _loc_11:* = undefined;
            var _loc_12:* = undefined;
            var _loc_3:* = event.data;
            var _loc_4:* = _loc_3.readByte();
            var _loc_5:* = _loc_3.readUnsignedShort();
            var _loc_6:* = _loc_3.readUnsignedInt();
            _loc_2 = _loc_3.readUnsignedShort();
            var _loc_7:* = _loc_3.readUTFBytes(_loc_2);
            _loc_2 = _loc_3.readUnsignedShort();
            var _loc_8:* = _loc_3.readUTFBytes(_loc_2);
            if (Config.ui._charUI._slotArray[_loc_5].item != null)
            {
                this._slotArray[_loc_4].item = Config.ui._charUI._slotArray[_loc_5].item;
                this._slotArray[_loc_4].item.data.boothPrice = this._slotlabArrayPrice[_loc_4];
                Config.ui._charUI._slotArray[_loc_5].lock();
            }
            Config.message(Config.language("StallUI", 14, _loc_8, _loc_6));
            var _loc_9:* = Config.doingCookie;
            if (Config.doingCookie != null && _loc_9.act == "hangStall")
            {
                _loc_12 = [];
                for (_loc_10 in _loc_9.stallData)
                {
                    
                    _loc_11 = Config.ui._charUI._slotArray[_loc_9.stallData[_loc_10].pos].item;
                    if (_loc_11 != null)
                    {
                        trace("位置:", _loc_9.stallData[_loc_10].pos, "价格:", _loc_11.data.boothPrice);
                        _loc_12.push(_loc_9.stallData[_loc_10]);
                    }
                }
                this._cookieStall = _loc_12;
                Config.doingCookie = {act:"hangStall", stallData:this._cookieStall, ad:_loc_9.ad};
            }
            _loc_10 = 1;
            while (_loc_10 < 11)
            {
                
                if (this._slotArray[_loc_10].item == null)
                {
                    this._slotlabArray[_loc_10].text = "";
                    this._slotlabArrayPrice[_loc_10] = 0;
                }
                _loc_10 = _loc_10 + 1;
            }
            return;
        }// end function

        private function handleBoothCancel(param1)
        {
            var _loc_4:* = undefined;
            var _loc_5:* = null;
            var _loc_2:* = param1.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            if (_loc_3 == Player._playerId)
            {
                Config.doingCookie = null;
                this._doorPb.label = Config.language("StallUI", 6);
                this._doorOpening = false;
                Config.player.lock = false;
                this._inputext.selectable = true;
                this._inputext.tf.type = TextFieldType.INPUT;
                if (Config._switchEnglish)
                {
                    this._inputext.tf.restrict = "^一-龥";
                }
                this._moneyUI.value = 0;
                this._sellholderitem.enabled = true;
                this._sellholderitem.buttonMode = true;
                _loc_5 = Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_PLAYER, _loc_3);
                if (_loc_5.boothing != false)
                {
                    _loc_5.boothing = false;
                }
                _loc_4 = this._slotStartIndex;
                while (_loc_4 < this._slotStartIndex + this._slotNumber)
                {
                    
                    this._slotArray[_loc_4].unlock();
                    _loc_4 = _loc_4 + 1;
                }
            }
            else
            {
                _loc_5 = Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_PLAYER, _loc_3);
                if (_loc_5.boothing != false)
                {
                    _loc_5.boothing = false;
                }
                if (Config.ui._boothUI.owner == _loc_3)
                {
                    Config.ui._boothUI.close();
                }
            }
            return;
        }// end function

        public function backerrbooth(param1:int)
        {
            if (param1 == 532)
            {
                this._inputext.selectable = true;
                this._inputext.tf.type = TextFieldType.INPUT;
                if (Config._switchEnglish)
                {
                    this._inputext.tf.restrict = "^一-龥";
                }
            }
            return;
        }// end function

        private function handleBoothSet(event:SocketEvent)
        {
            var _loc_3:* = undefined;
            var _loc_4:* = null;
            var _loc_2:* = event.data;
            var _loc_5:* = _loc_2.readUnsignedInt();
            var _loc_6:* = _loc_2.readUnsignedShort();
            var _loc_7:* = _loc_2.readUTFBytes(_loc_6);
            if (_loc_5 == Player._playerId)
            {
                Config.doingCookie = {act:"hangStall", stallData:this._cookieStall, ad:_loc_7};
                this._doorPb.label = Config.language("StallUI", 17);
                this._doorOpening = true;
                this._sellholderitem.enabled = false;
                this._sellholderitem.buttonMode = false;
                Config.player.lock = true;
                this._inputext.enabled = false;
                this._inputext.selectable = false;
                this._inputext.tf.type = TextFieldType.DYNAMIC;
                Config.ui._bagUI.close();
                _loc_3 = this._slotStartIndex;
                while (_loc_3 < this._slotStartIndex + this._slotNumber)
                {
                    
                    this._slotArray[_loc_3].lock();
                    _loc_3 = _loc_3 + 1;
                }
                _loc_4 = Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_PLAYER, _loc_5);
                _loc_4.boothAd = _loc_7;
                if (_loc_4.boothing != true)
                {
                    _loc_4.boothing = true;
                }
            }
            else
            {
                _loc_4 = Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_PLAYER, _loc_5);
                _loc_4.boothAd = _loc_7;
                if (_loc_4.boothing != true)
                {
                    _loc_4.boothing = true;
                }
            }
            return;
        }// end function

        private function handleDoorClick(param1)
        {
            if (this._sellPanel.parent == this)
            {
                removeChild(this._sellPanel);
            }
            this.stalling = !this.stalling;
            return;
        }// end function

        public function setStall(param1, param2)
        {
            var _loc_3:* = undefined;
            var _loc_4:* = null;
            this._cookieStall = param2;
            this._inputext.text = param1;
            _loc_3 = 0;
            while (_loc_3 < this._cookieStall.length)
            {
                
                _loc_4 = Config.ui._charUI._slotArray[this._cookieStall[_loc_3].pos].item;
                if (_loc_4 == null)
                {
                    return;
                }
                _loc_3 = _loc_3 + 1;
            }
            Config.player.lock = false;
            var _loc_5:* = new DataSet();
            new DataSet().addHead(CONST_ENUM.CMSG_OPEN_BOOTH);
            _loc_5.addUTF(param1);
            _loc_5.add8(this._cookieStall.length);
            _loc_3 = 0;
            while (_loc_3 < this._cookieStall.length)
            {
                
                _loc_4 = Config.ui._charUI._slotArray[this._cookieStall[_loc_3].pos].item;
                _loc_4.data.boothPrice = this._cookieStall[_loc_3].price;
                this._slotArray[this._cookieStall[_loc_3].stallPos].item = _loc_4;
                this._slotlabArrayPrice[this._cookieStall[_loc_3].stallPos] = this._cookieStall[_loc_3].price;
                if (this._cookieStall[_loc_3].price < 10000)
                {
                    this._slotlabArray[this._cookieStall[_loc_3].stallPos].text = _loc_4._itemData.name + Config.language("StallUI", 18) + Config.coinShow(this._cookieStall[_loc_3].price);
                }
                else if (this._cookieStall[_loc_3].price < 1000000)
                {
                    this._slotlabArray[this._cookieStall[_loc_3].stallPos].text = _loc_4._itemData.name + Config.language("StallUI", 18) + "<font color=\'#0000ff\'>" + Config.coinShow(this._cookieStall[_loc_3].price) + "</font>";
                }
                else if (this._cookieStall[_loc_3].price < 100000000)
                {
                    this._slotlabArray[this._cookieStall[_loc_3].stallPos].text = _loc_4._itemData.name + Config.language("StallUI", 18) + "<font color=\'#399765\'>" + Config.coinShow(this._cookieStall[_loc_3].price) + "</font>";
                }
                else
                {
                    this._slotlabArray[this._cookieStall[_loc_3].stallPos].text = _loc_4._itemData.name + Config.language("StallUI", 18) + "<font color=\'#ff3333\'>" + Config.coinShow(this._cookieStall[_loc_3].price) + "</font>";
                }
                _loc_5.add16(this._cookieStall[_loc_3].pos);
                _loc_5.add8(this._cookieStall[_loc_3].stallPos);
                _loc_5.add32(this._cookieStall[_loc_3].price);
                _loc_3 = _loc_3 + 1;
            }
            ClientSocket.send(_loc_5);
            this.open();
            return;
        }// end function

        private function set stalling(param1)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = null;
            if (param1 && !this._doorOpening)
            {
                _loc_3 = [];
                _loc_2 = this._slotStartIndex;
                while (_loc_2 < this._slotStartIndex + this._slotNumber)
                {
                    
                    if (this._slotArray[_loc_2].item != null)
                    {
                        _loc_3.push({item:this._slotArray[_loc_2].item, boothPrice:this._slotArray[_loc_2].item.data.boothPrice, stallPos:_loc_2});
                    }
                    _loc_2 = _loc_2 + 1;
                }
                if (_loc_3.length > 0)
                {
                    if (this._inputext.text == "" || this._inputext.text == null)
                    {
                        this._inputext.text = Config.player.name + Config.language("StallUI", 19);
                    }
                    this._cookieStall = [];
                    Config.player.lock = false;
                    _loc_4 = new DataSet();
                    _loc_4.addHead(CONST_ENUM.CMSG_OPEN_BOOTH);
                    _loc_4.addUTF(this._inputext.text);
                    _loc_4.add8(_loc_3.length);
                    _loc_2 = 0;
                    while (_loc_2 < _loc_3.length)
                    {
                        
                        this._cookieStall.push({pos:_loc_3[_loc_2].item._position, price:_loc_3[_loc_2].boothPrice, stallPos:_loc_3[_loc_2].stallPos});
                        _loc_4.add16(_loc_3[_loc_2].item._position);
                        _loc_4.add8(_loc_3[_loc_2].stallPos);
                        _loc_4.add32(_loc_3[_loc_2].boothPrice);
                        _loc_2 = _loc_2 + 1;
                    }
                    ClientSocket.send(_loc_4);
                }
            }
            else if (this._doorOpening)
            {
                _loc_4 = new DataSet();
                _loc_4.addHead(CONST_ENUM.CMSG_CLOSE_BOOTH);
                ClientSocket.send(_loc_4);
                this._inputext.selectable = true;
                this._inputext.tf.type = TextFieldType.INPUT;
                if (Config._switchEnglish)
                {
                    this._inputext.tf.restrict = "^一-龥";
                }
            }
            return;
        }// end function

        private function get stalling()
        {
            return this._doorOpening;
        }// end function

        public function checkStall(param1, param2 = null)
        {
            var _loc_3:* = undefined;
            var _loc_4:* = false;
            if (param2 == null)
            {
                param1.slot.unlock();
            }
            _loc_3 = this._slotStartIndex;
            while (_loc_3 < this._slotStartIndex + this._slotNumber)
            {
                
                if (this._slotArray[_loc_3] != param2 && this._slotArray[_loc_3].item == param1)
                {
                    this._slotArray[_loc_3].item = null;
                }
                _loc_3 = _loc_3 + 1;
            }
            return _loc_4;
        }// end function

        private function openSell(param1:Item, param2:CloneSlot)
        {
            GuideUI.testDoId(54);
            if (this._sellPanel.parent != this)
            {
                addChild(this._sellPanel);
            }
            else if (this._sellTempItem != null)
            {
                this._sellTempItem.slot.unlock();
            }
            Config.ui._charUI._slotArray[param1._position].lock();
            this._max = param1.amount;
            this._sellAmountNS.text = param1.amount.toString();
            this._sellPriceNS.text = param1._itemData.goldValue.toString();
            if (param1.data.boothPrice != null)
            {
                this._sellPriceNS.text = param1.data.boothPrice.toString();
            }
            else
            {
                this._sellPriceNS.text = "1";
            }
            this._sellTempItem = param1;
            this._sellTempSlot = param2;
            return;
        }// end function

        private function handleSellConfirm(param1)
        {
            GuideUI.testDoId(55, this._doorPb);
            if (this._sellPanel.parent == this)
            {
                removeChild(this._sellPanel);
            }
            this._sellTempItem.data.boothPrice = parseInt(this._sellPriceNS.text);
            if (parseInt(this._sellAmountNS.text) == this._sellTempItem.amount)
            {
                this.subSellConfirm(this._sellTempItem, this._sellTempSlot);
            }
            else
            {
                Config.ui._charUI.removeEventListener("itemchange", this.handleItemAmountChange);
                Config.ui._charUI.addEventListener("itemchange", this.handleItemAmountChange);
                Config.ui._bagUI.doSplit(this._sellTempItem.amount - parseInt(this._sellAmountNS.text), this._sellTempItem);
            }
            return;
        }// end function

        private function handleItemAmountChange(param1)
        {
            Config.ui._charUI.removeEventListener("itemchange", this.handleItemAmountChange);
            this._sellTempItem = Config.ui._bagUI.findItem(this._sellTempItem.id);
            if (this._sellTempItem != null)
            {
                this._sellTempItem.data.boothPrice = parseInt(this._sellPriceNS.text);
                this.subSellConfirm(this._sellTempItem, this._sellTempSlot);
            }
            return;
        }// end function

        private function subSellConfirm(param1:Item, param2:CloneSlot)
        {
            trace("subSellConfirm");
            if (param2.item != null)
            {
                param2.item._drawer[param2.item._position].unlock();
            }
            param2.item = param1;
            var _loc_3:* = 1;
            while (_loc_3 < 11)
            {
                
                if (this._slotArray[_loc_3] == param2)
                {
                    this._slotlabArrayPrice[_loc_3] = param2.item.data.boothPrice;
                    if (param2.item.data.boothPrice < 10000)
                    {
                        this._slotlabArray[_loc_3].text = param1._itemData.name + Config.language("StallUI", 18) + Config.coinShow(param2.item.data.boothPrice);
                    }
                    else if (param2.item.data.boothPrice < 1000000)
                    {
                        this._slotlabArray[_loc_3].text = param1._itemData.name + Config.language("StallUI", 18) + "<font color=\'#0000ff\'>" + Config.coinShow(param2.item.data.boothPrice) + "</font>";
                    }
                    else if (param2.item.data.boothPrice < 100000000)
                    {
                        this._slotlabArray[_loc_3].text = param1._itemData.name + Config.language("StallUI", 18) + "<font color=\'#399765\'>" + Config.coinShow(param2.item.data.boothPrice) + "</font>";
                    }
                    else
                    {
                        this._slotlabArray[_loc_3].text = param1._itemData.name + Config.language("StallUI", 18) + "<font color=\'#ff3333\'>" + Config.coinShow(param2.item.data.boothPrice) + "</font>";
                    }
                }
                if (this._slotArray[_loc_3].item == null)
                {
                    this._slotlabArray[_loc_3].text = "";
                    this._slotlabArrayPrice[_loc_3] = 0;
                }
                _loc_3 = _loc_3 + 1;
            }
            param1._drawer[param1._position].lock();
            this.checkStall(param1, param2);
            return;
        }// end function

        private function clickSlot(param1)
        {
            if (Holder.item == null && param1.item != null)
            {
                this.openSell(param1.item, param1);
            }
            else if (Holder.item._drawer == Config.ui._charUI._slotArray)
            {
                if (Config.ui._charUI.getPosite(int(Holder.item._position)) == 3)
                {
                    Config.message(Config.language("StallUI", 20));
                }
                else if (Config.ui._charUI.getPosite(int(Holder.item._position)) == 2)
                {
                    Config.message(Config.language("StallUI", 21));
                }
                else if (Holder.item._itemData.binding == 1)
                {
                    Config.message(Config.language("StallUI", 22));
                }
                else
                {
                    Holder.item._drawer[Holder.item._position].item = Holder.item;
                    this.openSell(Holder.item, param1);
                    Holder.item = null;
                }
            }
            return;
        }// end function

        private function handleSellConsel(event:MouseEvent = null)
        {
            var _loc_2:* = undefined;
            if (this._sellPanel.parent == this)
            {
                if (this._sellTempItem != null)
                {
                    _loc_2 = 1;
                    while (_loc_2 < 11)
                    {
                        
                        if (this._slotArray[_loc_2].item == this._sellTempItem)
                        {
                            this._slotArray[_loc_2].item._drawer[this._slotArray[_loc_2].item._position].unlock();
                            this._slotArray[_loc_2].item.data.boothPrice = null;
                            this._slotArray[_loc_2].item = null;
                            this._slotlabArray[_loc_2].text = "";
                            this._slotlabArrayPrice[_loc_2] = 0;
                        }
                        _loc_2 = _loc_2 + 1;
                    }
                    this._sellTempItem.slot.unlock();
                }
                removeChild(this._sellPanel);
                this._sellTempItem = null;
            }
            return;
        }// end function

        private function handleSlotUp(param1)
        {
            var _loc_2:* = param1.currentTarget;
            if (Holder.item != null && _loc_2.item == null)
            {
                this.clickSlot(_loc_2);
            }
            return;
        }// end function

        private function handleSlotClick(param1)
        {
            var _loc_2:* = param1.currentTarget;
            if (Holder.item != null && _loc_2.item == null)
            {
                this.clickSlot(_loc_2);
            }
            else if (Holder.item == null && _loc_2.item != null)
            {
                this.clickSlot(_loc_2);
            }
            return;
        }// end function

        private function handleSlotDoubleClick(param1)
        {
            var _loc_3:* = undefined;
            var _loc_2:* = param1.currentTarget;
            if (_loc_2.item != null && Holder.item == null)
            {
                Config.ui._charUI.itemunlock(_loc_2.item._position);
                _loc_2.item = null;
                _loc_3 = 1;
                while (_loc_3 < 11)
                {
                    
                    if (this._slotArray[_loc_3] == _loc_2)
                    {
                        this._slotlabArray[_loc_3].text = "";
                        this._slotlabArrayPrice[_loc_3] = 0;
                        break;
                    }
                    _loc_3 = _loc_3 + 1;
                }
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
                this._slotlabArrayPrice[_loc_5] = 0;
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

        public function getMinEmptySlot()
        {
            var _loc_1:* = undefined;
            _loc_1 = this._slotStartIndex;
            while (_loc_1 < this._slotStartIndex + this._slotNumber)
            {
                
                if ([_loc_1].item == null)
                {
                    return [_loc_1];
                }
                _loc_1 = _loc_1 + 1;
            }
            return null;
        }// end function

        public function listenPlayer(param1)
        {
            param1.addEventListener("update", this.handlePlayerUpdate);
            return;
        }// end function

        private function handlePlayerUpdate(event:UnitEvent)
        {
            if (event.param == "money4")
            {
                this.money4 = event.value;
            }
            return;
        }// end function

        private function set money4(param1) : void
        {
            this._moneyUI.value = param1;
            return;
        }// end function

        private function get money4() : int
        {
            return this._moneyUI.value;
        }// end function

        private function sellitemClick(param1)
        {
            if (!this._doorOpening)
            {
                if (Holder.item != null)
                {
                    if (Holder.item._drawer == Config.ui._charUI._slotArray)
                    {
                        if (Config.ui._charUI.getPosite(int(Holder.item._position)) == 3)
                        {
                            Config.message(Config.language("StallUI", 20));
                        }
                        else if (Config.ui._charUI.getPosite(int(Holder.item._position)) == 2)
                        {
                            Config.message(Config.language("StallUI", 21));
                        }
                        else if (Holder.item._itemData.binding == 1)
                        {
                            Config.message(Config.language("StallUI", 22));
                        }
                        else
                        {
                            Holder.item.backToSlot();
                            this.openSellitem(Holder.item);
                        }
                    }
                }
                else
                {
                    Config.ui._bagUI.isdrop = "sel";
                    Holder.item = null;
                    Holder.other = null;
                    if (Config.getMouseState() == "drop")
                    {
                        Config.setMouseState("", true);
                    }
                    else
                    {
                        Config.setMouseState("drop", true);
                    }
                }
            }
            return;
        }// end function

        public function openSellitem(param1:Item)
        {
            var _loc_2:* = 0;
            var _loc_3:* = undefined;
            trace(param1._position, "item._position");
            if (Config.ui._charUI.getPosite(int(param1._position)) == 3)
            {
                Config.message(Config.language("StallUI", 20));
            }
            else if (Config.ui._charUI.getPosite(int(param1._position)) == 2)
            {
                Config.message(Config.language("StallUI", 21));
            }
            else if (param1._itemData.binding == 1)
            {
                Config.message(Config.language("StallUI", 22));
            }
            else
            {
                _loc_2 = 1;
                while (_loc_2 < 11)
                {
                    
                    if (this._slotArray[_loc_2].item == null)
                    {
                        _loc_3 = this._slotArray[_loc_2];
                        this.openSell(param1, _loc_3);
                        Holder.item = null;
                        break;
                    }
                    else if (_loc_2 == 10 && this._slotArray[_loc_2].item != null)
                    {
                        Config.message(Config.language("StallUI", 23));
                    }
                    _loc_2++;
                }
            }
            return;
        }// end function

        private function handlePlayerMove(param1)
        {
            if (Config.getMouseState() != "")
            {
                Config.setMouseState("", true);
            }
            return;
        }// end function

    }
}
