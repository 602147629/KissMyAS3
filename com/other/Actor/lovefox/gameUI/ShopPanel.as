package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;
    import lovefox.component.*;
    import lovefox.socket.*;
    import lovefox.unit.*;

    public class ShopPanel extends Window
    {
        private var _mcanvas:CanvasUI;
        private var page:int = 1;
        private var allpage:int = 1;
        private var pagenum:int = 100;
        private var itemarr:Array;
        public var _slotArray:Array;
        public var _buybackSlotArray:Array;
        private var _limitinitarr:Array;
        private var _limitxtarr:Array;
        private var _limitlaberArr:Array;
        private var _dblClickTimer:Object;
        private var _preClickPt:Object;
        private var _preClickTime:Object;
        private var _preClickSlot:Object;
        private var pagelabel:Label;
        private var scorecon:Shape;
        private var scoreText:Label;
        private var _panelBuff:Array;
        private var _panelCurr:Array;
        private var _panelCurr1:Array;
        private var _panelCurr2:Array;
        private var _panelItemArr:Array;
        private var _panelItemIndex:int = 0;
        private var _yhigh:int = 0;
        public var btntop:ButtonBar;
        private var _itemPos:Object;

        public function ShopPanel(param1)
        {
            this._buybackSlotArray = new Array();
            this._limitxtarr = [];
            this._panelBuff = [];
            this._panelCurr = [];
            this._panelCurr1 = [];
            this._panelCurr2 = [];
            this._itemPos = {};
            super(param1);
            this.initpanel();
            this.initsocket();
            return;
        }// end function

        private function initpanel() : void
        {
            var _loc_1:* = null;
            resize(530, 320);
            this.title = Config.language("ShopPanel", 1);
            _loc_1 = new Shape();
            this.addChild(_loc_1);
            _loc_1.x = 5;
            _loc_1.y = 280;
            _loc_1.graphics.beginFill(13545363);
            _loc_1.graphics.drawRoundRect(0, 0, 520, 35, 1);
            _loc_1.graphics.endFill();
            this._mcanvas = new CanvasUI(this, 10, 55, 510, 215);
            this._mcanvas.addEventListener(MouseEvent.CLICK, this.sellformbag);
            this.itemarr = new Array();
            var _loc_2:* = new PushButton(this, 440, 285, Config.language("ShopPanel", 2), this.itemsellfuc);
            _loc_2.width = 60;
            this.scorecon = new Shape();
            this.scorecon.graphics.beginFill(16777215, 0.4);
            this.scorecon.graphics.drawRoundRect(110, 285, 150, 25, 5);
            this.scorecon.graphics.endFill();
            this.scoreText = new Label(this, 120, 290);
            this.btntop = new ButtonBar(this, 18, 30, 510);
            this.btntop.addTab(Config.language("ShopPanel", 22), this.selectitemtype);
            this.btntop.addTab(Config.language("ShopPanel", 23), this.selectitemtype);
            this.btntop.selectpage = 0;
            return;
        }// end function

        private function initsocket() : void
        {
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.SMSG_ITEM_BUYBACK_LIST, this.handleBuybackList);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.SMSG_ITEM_SELL, this.handleError);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_DAILYLIMIT_INFO, this.limitcountinit);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_DAILYLIMIT_UPDATE, this.limitcountupdat);
            return;
        }// end function

        override public function open(event:MouseEvent = null)
        {
            if (this.parent != null)
            {
                this.close();
            }
            this.btntop.selectpage = 0;
            this.getitemlist1(0);
            super.open();
            return;
        }// end function

        override public function close()
        {
            super.close();
            this._mcanvas.removeAllChildren();
            if (Config.getMouseState() != "")
            {
                Config.setMouseState("", true);
            }
            if (this.scorecon != null)
            {
                if (this.scorecon.parent != null)
                {
                    this.removeChild(this.scorecon);
                }
            }
            if (this.scoreText != null)
            {
                if (this.scoreText.parent != null)
                {
                    this.removeChild(this.scoreText);
                }
            }
            return;
        }// end function

        public function getitemlist222(param1:int)
        {
            this.getitemlist1(param1);
            super.open();
            return;
        }// end function

        public function getitemlist(param1:int)
        {
            this.btntop.selectpage = 0;
            this.getitemlist1(param1);
            super.open();
            return;
        }// end function

        private function getitemlist1(param1:int) : void
        {
            var _loc_3:* = undefined;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = undefined;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            Config.player.removeEventListener("update", this.updatemoney);
            Config.player.addEventListener("update", this.updatemoney);
            this.itemarr = [];
            this._limitlaberArr = [];
            var _loc_2:* = 0;
            if (param1 != 0)
            {
                _loc_2 = param1;
            }
            else
            {
                _loc_2 = Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_NPC, Npc._npcId)._data.id;
            }
            if (this.scorecon != null)
            {
                if (this.scorecon.parent != null)
                {
                    this.removeChild(this.scorecon);
                }
            }
            if (this.scoreText != null)
            {
                if (this.scoreText.parent != null)
                {
                    this.removeChild(this.scoreText);
                }
            }
            this.addChild(this.scorecon);
            this.addChild(this.scoreText);
            if (_loc_2 == 30015)
            {
                if (this.btntop != null)
                {
                    this.btntop.visible = false;
                }
                this._yhigh = 0;
                _loc_2 = int(Config._npcMap[_loc_2].shopId);
                this.title = Config.language("ShopPanel", 7);
                this.scoreText.text = Config.language("ShopPanel", 8) + Config.coinShow(Config.player.honor);
            }
            else if (_loc_2 == 20050)
            {
                this._limitinitarr = [];
                this._yhigh = 20;
                this.btntop.visible = true;
                this.title = Config.language("ShopPanel", 18);
                this.scoreText.text = Config.language("ShopPanel", 17) + Config.coinShow(Config.player.gildCoin);
            }
            for (_loc_3 in Config._buy)
            {
                
                if (_loc_2 == int(Config._buy[_loc_3].shopsid) && int(Config._buy[_loc_3].type) == this.btntop.selectpage)
                {
                    _loc_4 = int(Config._buy[_loc_3].itemId);
                    _loc_5 = Item.newItem(Config._itemMap[_loc_4], 0, 0, UNIT_TYPE_ENUM.TYPEID_ITEMCLONE, 0);
                    _loc_5.sortId = Config._buy[_loc_3].buyIteminit;
                    _loc_6 = Config._buy[_loc_3].buyType;
                    _loc_7 = Config._buy[_loc_3].buyValue;
                    _loc_5._itemData.itemId = _loc_4;
                    if (_loc_7 != 0)
                    {
                        _loc_5._itemData.priceType = _loc_6;
                        _loc_5._itemData.goldValue = _loc_7;
                        _loc_5._itemData.guidsplv = int(Config._buy[_loc_3].guildShopLevel);
                    }
                    _loc_5._itemData.todaymax = 0;
                    if (_loc_2 == 20050)
                    {
                        _loc_5._itemData.guidtodaynum = int(Config._buy[_loc_3].limitNumber);
                        _loc_5._itemData.todaymax = int(Config._buy[_loc_3].limitNumber);
                        if (int(Config._buy[_loc_3].limitNumber) == 0)
                        {
                            _loc_5._itemData.guidtodaynum = -1;
                            _loc_5._itemData.todaymax = 999;
                        }
                        this._limitinitarr.push({baseId:_loc_4, _limitCount:int(_loc_5._itemData.guidtodaynum)});
                        _loc_8 = 0;
                        while (_loc_8 < this._limitxtarr.length)
                        {
                            
                            if (this._limitxtarr[_loc_8].iteid == _loc_4)
                            {
                                if (int(Config._buy[_loc_3].limitNumber) > 0)
                                {
                                    _loc_5._itemData.guidtodaynum = int(Config._buy[_loc_3].limitNumber) - this._limitxtarr[_loc_8].todaynum;
                                }
                            }
                            _loc_8 = _loc_8 + 1;
                        }
                    }
                    this.itemarr.push(_loc_5);
                }
            }
            this.itemarr.sortOn("sortId", Array.NUMERIC);
            this.showitemlist(1);
            return;
        }// end function

        private function getPanel()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            if (this._panelBuff.length > 0)
            {
                _loc_1 = this._panelBuff.shift();
                this._mcanvas.addChildUI(_loc_1.itemcontainer);
                return _loc_1;
            }
            _loc_2 = new Sprite();
            this._mcanvas.addChildUI(_loc_2);
            _loc_2.graphics.beginFill(16777215, 0.4);
            _loc_2.graphics.drawRoundRect(0, 0, 245, 50 + this._yhigh, 5);
            _loc_2.graphics.endFill();
            _loc_3 = new Label(_loc_2, 50, 5);
            _loc_4 = new CloneSlot(0, 30);
            this._slotArray.push(_loc_4);
            _loc_2.addChild(_loc_4);
            _loc_4.x = 10;
            _loc_4.y = 10;
            _loc_4.addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
            _loc_4.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
            _loc_5 = new Label(_loc_2, 50, 25);
            _loc_5.html = true;
            _loc_6 = new Label(_loc_2, 40, 50);
            _loc_6.html = true;
            _loc_7 = new PushButton(_loc_2, 185, 25, Config.language("ShopPanel", 10), this.buyitemfuc);
            _loc_7.width = 50;
            return {itemcontainer:_loc_2, itemlabel:_loc_3, icon:_loc_4, _goldCoinText:_loc_5, buybtn:_loc_7, _limitext:_loc_6};
        }// end function

        private function showitemlist(param1:int = 1) : void
        {
            if (this._yhigh == 0)
            {
                this._panelBuff = this._panelBuff.concat(this._panelCurr);
                this._panelCurr = [];
            }
            if (this._yhigh == 20)
            {
                if (this.btntop.selectpage == 1)
                {
                    this._panelBuff = this._panelBuff.concat(this._panelCurr1);
                    this._panelCurr1 = [];
                }
                else
                {
                    this._panelBuff = this._panelBuff.concat(this._panelCurr2);
                    this._panelCurr2 = [];
                }
            }
            this._mcanvas.removeAllChildren();
            this._slotArray = new Array();
            var _loc_2:* = this.itemarr.length;
            this._panelItemIndex = 0;
            var _loc_3:* = Math.min(this._panelBuff.length + 10, _loc_2);
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                this.showOne(_loc_4);
                this._panelItemIndex = _loc_4;
                _loc_4 = _loc_4 + 1;
            }
            this._panelItemIndex = _loc_3;
            while (this._panelItemIndex < _loc_2)
            {
                
                this.showLoop();
            }
            return;
        }// end function

        private function showLoop(param1 = null)
        {
            var _loc_2:* = this.itemarr.length;
            var _loc_3:* = this._panelItemIndex;
            while (_loc_3 < Math.min(this._panelItemIndex + 4, _loc_2))
            {
                
                this.showOne(_loc_3);
                _loc_3 = _loc_3 + 1;
            }
            this._panelItemIndex = Math.min(this._panelItemIndex + 4, _loc_2);
            return;
        }// end function

        private function showOne(param1)
        {
            var _loc_2:* = this.getPanel();
            if (this._yhigh == 0)
            {
                this._panelCurr.push(_loc_2);
            }
            if (this._yhigh == 20)
            {
                if (this.btntop.selectpage == 1)
                {
                    this._panelCurr1.push(_loc_2);
                }
                else
                {
                    this._panelCurr2.push(_loc_2);
                }
            }
            var _loc_3:* = _loc_2.itemcontainer;
            if (param1 % 2 == 0)
            {
                _loc_3.x = 5;
                _loc_3.y = int(param1 / 2) * (55 + this._yhigh);
            }
            else
            {
                _loc_3.x = 255;
                _loc_3.y = int((param1 - 1) / 2) * (55 + this._yhigh);
            }
            this._itemPos[this.itemarr[param1]._itemData.id] = _loc_3.y;
            var _loc_4:* = _loc_2.itemlabel;
            var _loc_5:* = _loc_2.icon;
            this.itemarr[param1].display();
            _loc_5.item = this.itemarr[param1];
            _loc_5.item._drawer = this._slotArray;
            var _loc_6:* = _loc_2.buybtn;
            _loc_4.text = this.itemarr[param1]._itemData.name;
            var _loc_7:* = _loc_2._goldCoinText;
            var _loc_8:* = _loc_2._limitext;
            if (Number(this.itemarr[param1]._itemData.priceType) == 3)
            {
                _loc_7.text = Config.language("ShopPanel", 11) + Config.coinShow(this.itemarr[param1]._itemData.goldValue);
            }
            else if (Number(this.itemarr[param1]._itemData.priceType) == 5)
            {
                _loc_7.text = Config.language("ShopPanel", 9) + Config.coinShow(this.itemarr[param1]._itemData.goldValue);
            }
            else if (Number(this.itemarr[param1]._itemData.priceType) == 10)
            {
                _loc_5.unlock();
                _loc_6.enabled = true;
                _loc_8.text = "";
                _loc_7.text = Config.language("ShopPanel", 8) + Config.coinShow(this.itemarr[param1]._itemData.goldValue);
            }
            else if (Number(this.itemarr[param1]._itemData.priceType) == 12)
            {
                if (this.itemarr[param1]._itemData.guidsplv > int(Config.ui._gangs.gildShopLevel))
                {
                    _loc_5.lock();
                    _loc_6.enabled = false;
                    _loc_7.text = "<font color=\'#ad1b2e\'>" + Config.language("ShopPanel", 19, this.itemarr[param1]._itemData.guidsplv) + "</font>";
                }
                else
                {
                    _loc_5.unlock();
                    _loc_6.enabled = true;
                    _loc_7.text = Config.language("ShopPanel", 17) + Config.coinShow(this.itemarr[param1]._itemData.goldValue);
                }
                if (int(this.itemarr[param1]._itemData.guidtodaynum) < 0)
                {
                    _loc_8.text = Config.language("ShopPanel", 21);
                }
                else if (int(this.itemarr[param1]._itemData.guidtodaynum) == 0)
                {
                    _loc_5.lock();
                    _loc_6.enabled = false;
                    _loc_8.text = "<font color=\'#ad1b2e\'>" + Config.language("ShopPanel", 20, 0) + "</font>";
                }
                else
                {
                    _loc_8.text = Config.language("ShopPanel", 20, this.itemarr[param1]._itemData.guidtodaynum);
                }
            }
            else
            {
                _loc_7.text = Config.language("ShopPanel", 12) + Config.coinShow(this.itemarr[param1]._itemData.goldValue);
            }
            this._limitlaberArr.push({_basid:int(this.itemarr[param1]._itemData.itemId), _limitext:_loc_8, buybtn:_loc_6, icon:_loc_5});
            _loc_6.data = this.itemarr[param1];
            return;
        }// end function

        private function selectitemtype(event:MouseEvent)
        {
            this.getitemlist1(20050);
            return;
        }// end function

        private function handleSlotOver(param1)
        {
            var _loc_3:* = null;
            var _loc_2:* = param1.currentTarget;
            if (_loc_2.item != null)
            {
                _loc_3 = _loc_2.parent.localToGlobal(new Point(_loc_2.x, _loc_2.y));
                Holder.showInfo(_loc_2.item.outputInfo(true), new Rectangle(_loc_3.x, _loc_3.y, _loc_2._size, _loc_2._size));
            }
            return;
        }// end function

        private function handleSlotOut(param1)
        {
            Holder.closeInfo();
            return;
        }// end function

        private function handleBuybackList(param1)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            _loc_3 = 1;
            while (_loc_3 < this._buybackSlotArray.length)
            {
                
                _loc_6 = this._buybackSlotArray[_loc_3].item;
                this._buybackSlotArray[_loc_3].item = null;
                if (_loc_6 != null)
                {
                    _loc_6.destroy();
                }
                _loc_3 = _loc_3 + 1;
            }
            var _loc_7:* = param1.data;
            var _loc_8:* = param1.data.readByte();
            if (param1.data.readByte() != 0)
            {
                return;
            }
            var _loc_9:* = _loc_7.readUnsignedShort();
            _loc_3 = 0;
            while (_loc_3 < _loc_9)
            {
                
                _loc_4 = _loc_7.readUnsignedInt();
                _loc_5 = _loc_7.readUnsignedShort();
                _loc_2 = Item.createItemByBytes(_loc_7, _loc_4);
                _loc_2.display();
                _loc_2._drawer = this._buybackSlotArray;
                this._buybackSlotArray[_loc_5].item = _loc_2;
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

        private function handleError(param1)
        {
            var _loc_2:* = param1.data.readByte();
            trace("失败" + _loc_2);
            return;
        }// end function

        public function buy(param1:Item)
        {
            var _loc_2:* = undefined;
            if (Config.player.money3 >= param1._itemData.goldValue)
            {
                if (param1._itemData.maxSum > 1 && param1._drawer == this._slotArray)
                {
                    Config.ui._numericUI.openUI(Config.language("ShopPanel", 10) + param1._itemData.name, 1, Math.min(100, Math.floor(Config.player.money3 / param1._itemData.goldValue)), this.handleBuy, param1, Config.ui.mouseX, Config.ui.mouseY);
                }
                else
                {
                    this.handleBuy(1, param1);
                }
            }
            else
            {
                Config.message(Config.language("ShopPanel", 13));
            }
            return;
        }// end function

        private function handleBuy(param1, param2)
        {
            var _loc_3:* = undefined;
            if (param2._drawer == this._slotArray)
            {
                _loc_3 = new DataSet();
                _loc_3.addHead(CONST_ENUM.C2G_BUY_ITEM_FROM_EASYSHOP);
                _loc_3.add8(3);
                _loc_3.add32(param2._id);
                _loc_3.add32(param1);
                ClientSocket.send(_loc_3);
            }
            else if (param2._drawer == this._buybackSlotArray)
            {
                _loc_3 = new DataSet();
                _loc_3.addHead(CONST_ENUM.CMSG_ITEM_BUYBACK);
                _loc_3.add32(Npc._npcId);
                _loc_3.add32(param2._id);
                ClientSocket.send(_loc_3);
            }
            return;
        }// end function

        private function buyitemfuc(event:MouseEvent) : void
        {
            if (Config.getMouseState() == "sell")
            {
                Config.setMouseState("", true);
            }
            var _loc_2:* = event.currentTarget.data;
            var _loc_3:* = new Object();
            _loc_3.item = _loc_2;
            _loc_3.id = int(_loc_2._data.id);
            _loc_3.goldcoin = _loc_2._itemData.goldValue;
            _loc_3.moneyflag = _loc_2._itemData.priceType;
            _loc_3.todaymax = _loc_2._itemData.todaymax;
            Config.ui._shopbuy.initdata(_loc_3);
            Config.ui._shopbuy.x = this.x + 230;
            Config.ui._shopbuy.y = this.y;
            Config.ui._shopbuy.open();
            return;
        }// end function

        private function checkbuy(param1) : void
        {
            if (Config.player.money3 >= param1.coin)
            {
                this.sendbuy(param1.id, 1);
            }
            else
            {
                Config.message(Config.language("ShopPanel", 14));
            }
            return;
        }// end function

        public function sendbuy(param1:int, param2:int) : void
        {
            var _loc_3:* = new DataSet();
            _loc_3.addHead(CONST_ENUM.C2G_BUY_ITEM_FROM_EASYSHOP);
            _loc_3.add8(3);
            _loc_3.add32(param1);
            _loc_3.add32(param2);
            ClientSocket.send(_loc_3);
            return;
        }// end function

        public function sendbuygilditem(param1:int, param2:int)
        {
            var _loc_3:* = new DataSet();
            _loc_3.addHead(CONST_ENUM.C2G_GUILDSHOP_BUY);
            _loc_3.add32(param1);
            _loc_3.add32(param2);
            ClientSocket.send(_loc_3);
            return;
        }// end function

        private function limitcountinit(event:SocketEvent)
        {
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedShort();
            this._limitxtarr = [];
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = _loc_2.readByte();
                _loc_6 = _loc_2.readUnsignedInt();
                _loc_7 = _loc_2.readUnsignedInt();
                if (_loc_5 == 1)
                {
                    this._limitxtarr.push({iteid:_loc_6, todaynum:_loc_7});
                }
                else if (_loc_5 == 6)
                {
                    Config.ui._moraUI.time = _loc_7;
                }
                else if (_loc_5 == 12)
                {
                    Config.ui._interBigwar.time = _loc_7;
                }
                else if (_loc_5 == 13)
                {
                    Config.ui._interPkPanel.gettimes = _loc_7;
                }
                else if (_loc_5 == 16)
                {
                    Config.ui._activePanel.jionnumber = _loc_7;
                }
                _loc_4++;
            }
            return;
        }// end function

        private function limitcountupdat(event:SocketEvent)
        {
            var _loc_6:* = false;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readByte();
            var _loc_4:* = _loc_2.readUnsignedInt();
            var _loc_5:* = _loc_2.readUnsignedInt();
            if (_loc_3 == 1)
            {
                _loc_6 = false;
                _loc_7 = 0;
                while (_loc_7 < this._limitxtarr.length)
                {
                    
                    if (this._limitxtarr[_loc_7].iteid == _loc_4)
                    {
                        this._limitxtarr[_loc_7].todaynum = _loc_5;
                        _loc_6 = true;
                        break;
                    }
                    _loc_7++;
                }
                if (!_loc_6)
                {
                    this._limitxtarr.push({iteid:_loc_4, todaynum:_loc_5});
                }
                _loc_8 = 0;
                while (_loc_8 < this._limitlaberArr.length)
                {
                    
                    if (this._limitlaberArr[_loc_8]._basid == _loc_4)
                    {
                        _loc_9 = 0;
                        while (_loc_9 < this._limitinitarr.length)
                        {
                            
                            if (this._limitinitarr[_loc_9].baseId == _loc_4)
                            {
                                if (this._limitinitarr[_loc_9]._limitCount - _loc_5 <= 0)
                                {
                                    this._limitlaberArr[_loc_8].icon.lock();
                                    this._limitlaberArr[_loc_8].buybtn.enabled = false;
                                    if (this._limitlaberArr[_loc_8]._limitext != null)
                                    {
                                        this._limitlaberArr[_loc_8]._limitext.text = "<font color=\'#ad1b2e\'>" + Config.language("ShopPanel", 20, 0) + "</font>";
                                    }
                                }
                                else if (this._limitlaberArr[_loc_8]._limitext != null)
                                {
                                    this._limitlaberArr[_loc_8]._limitext.text = Config.language("ShopPanel", 20, this._limitinitarr[_loc_9]._limitCount - _loc_5);
                                }
                            }
                            _loc_9++;
                        }
                    }
                    _loc_8++;
                }
            }
            else if (_loc_3 == 6)
            {
                Config.ui._moraUI.time = _loc_5;
            }
            else if (_loc_3 == 12)
            {
                Config.ui._interBigwar.time = _loc_5;
            }
            else if (_loc_3 == 13)
            {
                Config.ui._interPkPanel.gettimes = _loc_5;
            }
            else if (_loc_3 == 16)
            {
                Config.ui._activePanel.jionnumber = _loc_5;
            }
            return;
        }// end function

        private function itemsellfuc(event:MouseEvent) : void
        {
            if (Holder.item != null)
            {
                if (Holder.item._drawer == Config.ui._charUI._slotArray)
                {
                    Config.ui._bagUI.sell(Holder.item);
                    Holder.item.backToSlot();
                    Holder.item = null;
                }
            }
            else
            {
                Holder.item = null;
                Holder.other = null;
                if (Config.getMouseState() == "sell")
                {
                    Config.setMouseState("", true);
                }
                else
                {
                    Config.setMouseState("sell", true);
                }
            }
            return;
        }// end function

        private function handleSlotDoubleClick(param1)
        {
            var _loc_2:* = param1.currentTarget;
            if (_loc_2.item != null)
            {
                this.buy(_loc_2.item);
            }
            return;
        }// end function

        private function sellformbag(event:MouseEvent) : void
        {
            if (Holder.item != null)
            {
                if (Holder.item._drawer == Config.ui._charUI._slotArray)
                {
                    Config.ui._bagUI.sell(Holder.item);
                }
            }
            return;
        }// end function

        private function updatemoney(event:UnitEvent) : void
        {
            if (event.param == "instanceSore")
            {
                this.scoreText.text = Config.language("ShopPanel", 9) + Config.coinShow(Config.player.instanceSore);
            }
            if (event.param == "honor")
            {
                this.scoreText.text = Config.language("ShopPanel", 8) + Config.coinShow(Config.player.honor);
            }
            if (event.param == "gildcoin")
            {
                this.scoreText.text = Config.language("ShopPanel", 17) + Config.coinShow(Config.player.gildCoin);
            }
            return;
        }// end function

        public function scrollToItem(param1:int)
        {
            if (this._itemPos[param1] != null)
            {
                this._mcanvas.verticalScrollPosition = this._mcanvas.backPosition(this._itemPos[param1] + (50 + this._yhigh) / 2 - this._mcanvas.height / 2);
            }
            return;
        }// end function

        public function arrange()
        {
            return;
        }// end function

    }
}
