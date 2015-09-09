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

    public class BagPanel extends Window
    {
        public var _slotStartIndex:int = 1;
        public var _slotNumber:int = 108;
        public var _bagActiveNumber:int = 72;
        private var _page:Object = 0;
        private var _gridWidth:Object = 9;
        private var _gridHeight:Object = 4;
        private var _gridMatrix:Array;
        private var _itemListArr:Array;
        private var levelSort:int = 0;
        private var _pageButton:ButtonBar;
        private var money1text:Label;
        private var money2text:Label;
        private var money3text:Label;
        private var money4text:Label;
        private var flagsplit:Boolean;
        private var _splitUI:ItemSplit;
        private var _splitPB:PushButton;
        private var _repairPB:PushButton;
        private var _findSellPB:PushButton;
        private var _allRepairPB:PushButton;
        private var _moneyBtn:PushButton;
        private var _toSeeBtn:PushButton;
        private var sellBtn:PushButton;
        private var madeBtn:PushButton;
        private var recycleslotnumber:uint;
        public var isdrop:String = "";
        private var _slotRollOver:Boolean = false;
        private var _wingslotnumber:Object;
        private var _wingslotlevel:Object;
        private var menubar:ButtonBar;
        private var typeaRb:RadioButton;
        private var typebRb:RadioButton;
        private var typecRb:RadioButton;
        private var typedRb:RadioButton;
        private var bagNumLabel:Label;
        public var tempbtn:PushButton;
        private var enableArr:Array;
        private var yeBtn:Bitmap;
        private var tempallbtn:PushButton;
        private var _bagwareflag:Boolean;
        private var _godopen:int = 0;
        private var numb:int;

        public function BagPanel(param1:DisplayObjectContainer)
        {
            this._gridMatrix = [];
            this._itemListArr = [];
            this.enableArr = [];
            super(param1);
            this.title = Config.language("BagPanel", 1);
            resize(350, 310);
            this.initsocket();
            this.initDraw();
            return;
        }// end function

        override public function switchOpen() : void
        {
            this.showBagRoll();
            this.menubar.selectpage = 0;
            this.selectPage(null, 0);
            super.switchOpen();
            return;
        }// end function

        private function initsocket() : void
        {
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.SMSG_OPEN_BOX, this.openboxflag);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_GIFTBOX_OPEN_RESULT, this.openkeybox);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_WAREHOUSE_FLAG, this.bagwareflag);
            Config.ui._charUI.addEventListener("itemchange", this.showBagRoll);
            return;
        }// end function

        public function BagCount(param1:int)
        {
            if (param1 == 1)
            {
                this._bagActiveNumber = 108;
            }
            else
            {
                this._bagActiveNumber = 72;
            }
            Config.ui._blackmarket.setBagActiveNumber();
            Config.ui._easyShop.setBagActiveNumber();
            trace("_bagActiveNumber", this._bagActiveNumber);
            this.showBagRoll();
            this.selectType(this.menubar.selectpage);
            return;
        }// end function

        private function showBagRoll(event:Event = null) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = this._slotStartIndex;
            while (_loc_3 < this._bagActiveNumber + this._slotStartIndex)
            {
                
                if (Config.ui._charUI._slotArray[_loc_3].item != null)
                {
                    _loc_2 = _loc_2 + 1;
                }
                _loc_3 = _loc_3 + 1;
            }
            this.bagremainNum = this._bagActiveNumber - _loc_2;
            this.bagNumLabel.text = Config.language("BagPanel", 2) + _loc_2 + "/" + this._bagActiveNumber;
            if (this.menubar.selectpage > 0)
            {
                this.selectPage(null, this.menubar.selectpage);
            }
            if (_loc_2 < this._bagActiveNumber)
            {
                Config.ui._systemUI.bagpictrue(false);
            }
            else
            {
                Config.ui._systemUI.bagpictrue(true);
            }
            return;
        }// end function

        public function set bagremainNum(param1:int)
        {
            this.numb = param1;
            return;
        }// end function

        public function get bagremainNum() : int
        {
            return this.numb;
        }// end function

        private function changePage(param1, param2)
        {
            var _loc_3:* = undefined;
            var _loc_4:* = 0;
            var _loc_5:* = undefined;
            if (param2 < int(this._bagActiveNumber / 36))
            {
                if (Holder.item != null)
                {
                    _loc_3 = param2 * this._gridWidth * this._gridHeight + this._slotStartIndex;
                    while (_loc_3 < (param2 + 1) * this._gridWidth * this._gridHeight + this._slotStartIndex)
                    {
                        
                        if (Config.ui._charUI._slotArray[_loc_3].item == null)
                        {
                            Config.ui._charUI._holderBuff = Config.ui._charUI._slotArray[_loc_3].item;
                            if (Holder.item._position >= 1 && Holder.item._position < this._slotNumber)
                            {
                                _loc_4 = int(Holder.item._position / (this._gridWidth * this._gridHeight));
                                this._pageButton.selectpage = _loc_4;
                                this._page = _loc_4;
                            }
                            else
                            {
                                this._page = param2;
                            }
                            this.showItem();
                            Config.ui._charUI.swapItem(Holder.item, _loc_3);
                            return;
                        }
                        _loc_3 = _loc_3 + 1;
                    }
                }
                this._page = param2;
                this.showItem();
            }
            else
            {
                this._pageButton.selectpage = this._page;
                _loc_5 = Config.ui._charUI.findThirdBag();
                if (_loc_5 == null)
                {
                    AlertUI.alert(Config.language("BagPanel", 3), Config.language("BagPanel", 4), [Config.language("BagPanel", 5)]);
                }
                else
                {
                    AlertUI.alert(Config.language("BagPanel", 6), Config.language("BagPanel", 7), [Config.language("BagPanel", 8), Config.language("BagPanel", 9)], [Config.ui._charUI.openThirdBag]);
                }
            }
            return;
        }// end function

        private function initDraw()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_9:* = null;
            this.menubar = new ButtonBar(this, 7, 25, 344, -4);
            this.menubar.addTab(Config.language("BagPanel", 10), Config.create(this.selectPage, 0), 57);
            this.menubar.addTab(Config.language("BagPanel", 11), Config.create(this.selectPage, 1), 46);
            this.menubar.addTab(Config.language("BagPanel", 12), Config.create(this.selectPage, 2), 46);
            this.menubar.addTab(Config.language("BagPanel", 13), Config.create(this.selectPage, 3), 46);
            this.menubar.addTab(Config.language("BagPanel", 15), Config.create(this.selectPage, 4), 46);
            this.menubar.addTab(Config.language("BagPanel", 16), Config.create(this.selectPage, 5), 46);
            this.menubar.addTab(Config.language("BagPanel", 17), Config.create(this.selectPage, 6), 46);
            this.typedRb = new RadioButton(this, 280, 53, Config.language("BagPanel", 18), false, Config.create(this.levelSortFuc, 0));
            this.typedRb.group = "levelSort";
            this.typeaRb = new RadioButton(this, 40, 53, Config.language("BagPanel", 19), false, Config.create(this.levelSortFuc, 1));
            this.typeaRb.group = "levelSort";
            this.typebRb = new RadioButton(this, 120, 53, Config.language("BagPanel", 20), false, Config.create(this.levelSortFuc, 2));
            this.typebRb.group = "levelSort";
            this.typecRb = new RadioButton(this, 200, 53, Config.language("BagPanel", 21), false, Config.create(this.levelSortFuc, 3));
            this.typecRb.group = "levelSort";
            this._pageButton = new ButtonBar(this, 10, 220, 90, 15);
            this._pageButton.lineFlag = false;
            this.bagNumLabel = new Label(this, 230, 220, Config.language("BagPanel", 22) + this._bagActiveNumber);
            _loc_1 = this._slotStartIndex;
            while (_loc_1 < this._slotStartIndex + this._slotNumber)
            {
                
                Config.ui._charUI._slotArray[_loc_1] = new InvSlot(_loc_1, 32);
                Config.ui._charUI._slotArray[_loc_1].addEventListener("sglClick", this.handleSlotClick);
                Config.ui._charUI._slotArray[_loc_1].addEventListener("drag", this.handleSlotClick);
                Config.ui._charUI._slotArray[_loc_1].addEventListener("dblClick", this.handleSlotDoubleClick);
                Config.ui._charUI._slotArray[_loc_1].addEventListener("up", this.handleSlotUp);
                Config.ui._charUI._slotArray[_loc_1].addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
                Config.ui._charUI._slotArray[_loc_1].addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
                _loc_1 = _loc_1 + 1;
            }
            this.selectType();
            _loc_4 = new Panel(this, 4, 245);
            _loc_4.color = 13545363;
            _loc_4.shadow = 0;
            _loc_4.width = 340;
            _loc_4.height = 60;
            _loc_4 = new Panel(this, 10, 280);
            _loc_4.color = 7689037;
            _loc_4.shadow = 0;
            _loc_4.width = 100;
            _loc_4.height = 22;
            if (Config._lanVersion == LanVersion.QQ_ZH_CN)
            {
            }
            else
            {
                _loc_4 = new Panel(this, 240, 280);
                _loc_4.color = 7689037;
                _loc_4.shadow = 0;
                _loc_4.width = 100;
                _loc_4.height = 22;
            }
            _loc_4 = new Panel(this, 125, 280);
            _loc_4.color = 7689037;
            _loc_4.shadow = 0;
            _loc_4.width = 100;
            _loc_4.height = 22;
            this.money3text = new Label(null, 65, 250);
            this.money3text.textColor = 16767082;
            this.money4text = new Label(this, 25, 280);
            this.money4text.textColor = 16767082;
            this.money4text.tip = Config.language("BagPanel", 24);
            this.money1text = new Label(this, 255, 280);
            this.money1text.textColor = 16767082;
            this.money1text.tip = Config.language("BagPanel", 25);
            this.money2text = new Label(this, 140, 280);
            this.money2text.textColor = 16767082;
            this.money2text.tip = Config.language("BagPanel", 26);
            var _loc_6:* = new Sprite();
            _loc_5 = new Bitmap(BitmapLoader.pick(String(Config.findUI("bagui").money2.dir)));
            this.addChild(_loc_6);
            _loc_6.x = 12;
            _loc_6.y = 283;
            _loc_6.addChild(_loc_5);
            _loc_6.addEventListener(MouseEvent.ROLL_OVER, Config.create(this.showMoneyTip, 2));
            _loc_6.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
            var _loc_7:* = new Sprite();
            this.addChild(_loc_7);
            _loc_5 = new Bitmap(BitmapLoader.pick(String(Config.findUI("bagui").money4.dir)));
            _loc_7.x = 242;
            _loc_7.y = 283;
            _loc_7.addChild(_loc_5);
            _loc_7.addEventListener(MouseEvent.ROLL_OVER, Config.create(this.showMoneyTip, 4));
            _loc_7.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
            var _loc_8:* = new Sprite();
            this.addChild(_loc_8);
            _loc_5 = new Bitmap(BitmapLoader.pick(String(Config.findUI("bagui").money3.dir)));
            _loc_8.x = 127;
            _loc_8.y = 283;
            _loc_8.addChild(_loc_5);
            _loc_8.addEventListener(MouseEvent.ROLL_OVER, Config.create(this.showMoneyTip, 3));
            _loc_8.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
            if (Config._lanVersion == LanVersion.QQ_ZH_CN)
            {
                this.removeChild(this.money1text);
                this.removeChild(_loc_7);
                _loc_9 = new Sprite();
                this.addChild(_loc_9);
                _loc_9.buttonMode = true;
                _loc_9.addEventListener(MouseEvent.CLICK, this.openQQPay);
                _loc_9.addEventListener(MouseEvent.ROLL_OVER, this.overQQBtn);
                _loc_9.addEventListener(MouseEvent.ROLL_OUT, this.outQQBtn);
                this.yeBtn = new Bitmap();
                _loc_9.addChild(this.yeBtn);
                _loc_9.x = 230;
                _loc_9.y = 275;
            }
            this._splitPB = new PushButton(this, 61, 250, Config.language("BagPanel", 27), this.splitefuc);
            this._splitPB.mode = PushButton.CHECK_MODE;
            this._splitPB.width = 44;
            this.tempbtn = new PushButton(this, 7, 250, Config.language("BagPanel", 28), this.handleSort);
            this.tempbtn.width = 54;
            this.madeBtn = new PushButton(this, 105, 250, Config.language("BagPanel", 55), this.madeFuc);
            this.madeBtn.width = 44;
            this.sellBtn = new PushButton(this, 162, 250, Config.language("BagPanel", 59), this.sellallpanel);
            this.sellBtn.width = 60;
            this._moneyBtn = new PushButton(this, 281, 250, Config.language("BagPanel", 30), Config.ui._shopmail.getbtnurl);
            this._moneyBtn.width = 60;
            this._repairPB = new PushButton(this, 222, 250, Config.language("BagPanel", 31), this.handleSwitchMix);
            this._repairPB.width = 59;
            addEventListener(MouseEvent.MOUSE_WHEEL, this.handleMouseWheel);
            this.tempallbtn = new PushButton(this, 150, 220, "", this.openbagware);
            this.tempallbtn.setTable("table18", "table31");
            this.tempallbtn.width = 60;
            this.tempallbtn.height = 20;
            return;
        }// end function

        private function handleMouseWheel(param1)
        {
            var _loc_2:* = Math.ceil(this._itemListArr.length / (this._gridWidth * this._gridHeight));
            if (param1.delta < 0)
            {
                if (this._page < (_loc_2 - 1))
                {
                    var _loc_3:* = this;
                    var _loc_4:* = this._page + 1;
                    _loc_3._page = _loc_4;
                    this._pageButton.selectpage = this._page;
                    this.showItem();
                }
            }
            else if (this._page > 0)
            {
                var _loc_3:* = this;
                var _loc_4:* = this._page - 1;
                _loc_3._page = _loc_4;
                this._pageButton.selectpage = this._page;
                this.showItem();
            }
            return;
        }// end function

        public function handleSort(param1)
        {
            var _loc_2:* = null;
            if (this.tempbtn.enabled)
            {
                if (!Config.ui._stallUI._opening)
                {
                    trace("handleSort");
                    AlertUI.close();
                    _loc_2 = new DataSet();
                    _loc_2.addHead(CONST_ENUM.CMSG_ITEM_ARRANGE);
                    _loc_2.add8(1);
                    ClientSocket.send(_loc_2);
                }
            }
            return;
        }// end function

        public function backArrange() : void
        {
            this.selectType(this.menubar.selectpage);
            if (Config.ui._easyShop._opening)
            {
                Config.ui._easyShop.resettotalmoney();
            }
            return;
        }// end function

        private function handledestroy(event:MouseEvent)
        {
            this.isdrop = "";
            if (Holder.item != null)
            {
                if (Holder.item._drawer == Config.ui._charUI._slotArray)
                {
                    this.drop(Holder.item);
                    Holder.item.backToSlot();
                    Holder.item = null;
                }
            }
            else
            {
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
            return;
        }// end function

        private function sureappraisal(param1, param2)
        {
            Config.ui._charUI.useItem(param2);
            return;
        }// end function

        private function splitefuc(event:MouseEvent) : void
        {
            this.flagsplit = false;
            if (Holder.item != null)
            {
                if (Holder.item._drawer == Config.ui._charUI._slotArray)
                {
                    this.split(Holder.item);
                    Holder.item.backToSlot();
                    Holder.item = null;
                }
            }
            else
            {
                Holder.item = null;
                Holder.other = null;
                if (Config.getMouseState() == "split")
                {
                    Config.setMouseState("", true);
                    this._splitPB.selected = false;
                }
                else
                {
                    Config.setMouseState("split", true);
                    this._splitPB.selected = true;
                }
            }
            return;
        }// end function

        public function sell(param1:Item)
        {
            if (int(param1._itemData.destroyable) == 1 || int(param1._itemData.destroyable) == 3)
            {
                Config.message(Config.language("BagPanel", 37));
                if (int(param1._itemData.type) == 7)
                {
                    AlertUI.alert(Config.language("BagPanel", 38), Config.language("BagPanel", 39), [Config.language("BagPanel", 32)]);
                }
                return;
            }
            if (param1._position == 1013)
            {
                Config.message(Config.language("BagPanel", 40));
                return;
            }
            if (int(param1._itemData.nameColor) == 0 || int(param1._itemData.nameColor) == 1)
            {
                Config.ui._easyShop.selloneitem(param1);
            }
            else
            {
                AlertUI.alert(Config.language("BagPanel", 38), Config.language("BagPanel", 41), [Config.language("BagPanel", 34), Config.language("BagPanel", 35)], [Config.ui._easyShop.selloneitem], param1);
            }
            return;
        }// end function

        private function subSell(param1)
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_SELL_ITEM);
            _loc_2.add32(Npc._npcId);
            _loc_2.add16(param1._position);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        public function drop(param1:Item) : void
        {
            var _loc_2:* = 0;
            if (this.isdrop == "sel" && Config.getMouseState() == "drop")
            {
                Config.ui._stallUI.openSellitem(param1);
            }
            else
            {
                if (int(param1._itemData.destroyable) == 1 || int(param1._itemData.destroyable) == 3)
                {
                    Config.message(Config.language("BagPanel", 37));
                    return;
                }
                if (param1._position == 1013)
                {
                    Config.message(Config.language("BagPanel", 40));
                    return;
                }
                _loc_2 = 0;
                if (int(param1.amount) == 0)
                {
                    _loc_2 = 1;
                }
                else
                {
                    _loc_2 = int(param1.amount);
                }
                Config.ui._charUI.addproductbitmap(param1._position);
                AlertUI.alert(Config.language("BagPanel", 57, param1._itemData.name), Config.language("BagPanel", 58, param1._itemData.name, int(param1._itemData.goldValue) * _loc_2), [Config.language("BagPanel", 34), Config.language("BagPanel", 35)], [Config.ui._easyShop.selloneitem], param1);
            }
            Config.setMouseState("", true);
            return;
        }// end function

        private function sellallpanel(param1)
        {
            Config.ui._easyShop.switchOpen();
            return;
        }// end function

        private function subDrop(param1)
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.CMSG_ITEM_DESTROY);
            _loc_2.add16(param1._position);
            if (param1._position >= 120)
            {
                _loc_2.add32(Config.ui._bagware.npcid);
            }
            else
            {
                _loc_2.add32(0);
            }
            ClientSocket.send(_loc_2);
            return;
        }// end function

        public function wing(param1:Item)
        {
            if (int(param1._itemData.type) == 4 && int(param1._itemData.subType) == 13)
            {
                Config.setMouseState("", true);
                AlertUI.alert(Config.language("BagPanel", 38), Config.language("BagPanel", 47), [Config.language("BagPanel", 34), Config.language("BagPanel", 35)], [this.doWing], param1);
            }
            return;
        }// end function

        public function doWing(param1:Item)
        {
            return;
        }// end function

        public function recycle(param1:Item)
        {
            return;
        }// end function

        public function recyclequip(param1:Item)
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.CMSG_RECYCLE_ITEM);
            _loc_2.add16(param1._position);
            _loc_2.add16(this.recycleslotnumber);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        public function split(param1:Item)
        {
            if (param1._itemData.baseID == 93001 && this.flagsplit)
            {
                Config.setMouseState("", true);
            }
            else if (param1.amount > 1 && this.flagsplit == false)
            {
                Config.ui._numericUI.openUI(Config.language("BagPanel", 48) + param1._itemData.name, 1, (param1.amount - 1), this.doSplit, param1, Config.ui.mouseX, Config.ui.mouseY, param1._itemData.id);
                Config.setMouseState("", true);
            }
            else if (this.flagsplit)
            {
                Config.message(Config.language("BagPanel", 49));
            }
            else
            {
                Config.message(Config.language("BagPanel", 50));
            }
            return;
        }// end function

        public function doSplit(param1, param2)
        {
            var _loc_3:* = new DataSet();
            _loc_3.addHead(CONST_ENUM.CMSG_ITEM_SPLIT);
            _loc_3.add16(param2._position);
            _loc_3.add32(param1);
            ClientSocket.send(_loc_3);
            return;
        }// end function

        private function clickSlot(param1)
        {
            var _loc_2:* = null;
            if (Holder.item == null)
            {
                if (param1.item != null)
                {
                    if (Config.getMouseState() == "wing")
                    {
                        this.wing(param1.item);
                        param1.item.backToSlot();
                        Config.setMouseState("", true);
                        return;
                    }
                    if (Config.getMouseState() == "recycle")
                    {
                        this.recycle(param1.item);
                        param1.item.backToSlot();
                        Config.setMouseState("", true);
                        return;
                    }
                    if (Config.getMouseState() == "split")
                    {
                        this._splitPB.selected = false;
                        this.split(param1.item);
                        param1.item.backToSlot();
                        Config.setMouseState("", true);
                        return;
                    }
                    if (Config.getMouseState() == "sell")
                    {
                        if (param1.item != null)
                        {
                            param1.item.backToSlot();
                            this.sell(param1.item);
                        }
                        return;
                    }
                    else
                    {
                        if (Config.getMouseState() == "drop")
                        {
                            this.drop(param1.item);
                            param1.item.backToSlot();
                            Config.setMouseState("", true);
                            return;
                        }
                        if (Config.getMouseState() == "use")
                        {
                            if (int(param1.item._itemData.type) == 18)
                            {
                                if (param1.item._itemData.addEffect.length == 0)
                                {
                                    AlertUI.alert(Config.language("BagPanel", 32), Config.language("BagPanel", 33), [Config.language("BagPanel", 34), Config.language("BagPanel", 35)], [Config.create(this.sureappraisal, param1.item)]);
                                }
                                else
                                {
                                    Config.ui._producepanel.putBook(param1);
                                }
                            }
                            else
                            {
                                Config.message(Config.language("BagPanel", 51));
                            }
                            Config.setMouseState("", true);
                            return;
                        }
                    }
                }
                if (param1.item != null)
                {
                    Holder.item = param1.item;
                }
            }
            else if (Holder.item._drawer == Config.ui._shopUI._slotArray || Holder.item._drawer == Config.ui._shopUI._buybackSlotArray)
            {
                Config.ui._shopUI.buy(Holder.item);
            }
            else if (Holder.item._drawer == Config.ui._dealUI._selfSlotArray)
            {
                if (param1.item == null)
                {
                    Config.ui._charUI.unlockfromid(Holder.item._id);
                    _loc_2 = new DataSet();
                    _loc_2.addHead(CONST_ENUM.CMSG_TRADE_REMOVEITEM);
                    _loc_2.add16(Holder.item._position);
                    ClientSocket.send(_loc_2);
                }
            }
            else if (Holder.item._drawer == Config.ui._charUI._slotArray)
            {
                if (Holder.item == param1.item)
                {
                    param1.item = Holder.item;
                    Holder.item = null;
                    this.refreshMouseSlot();
                }
                else if (param1.item != null && Holder.item._itemData.baseID == param1.item._itemData.baseID && Holder.item._itemData.maxSum > 1)
                {
                    Config.ui._charUI._holderBuff = param1.item;
                    _loc_2 = new DataSet();
                    _loc_2.addHead(CONST_ENUM.CMSG_ITEM_STACK);
                    _loc_2.add16(Holder.item._position);
                    _loc_2.add16(param1._id);
                    _loc_2.add32(0);
                    ClientSocket.send(_loc_2);
                }
                else
                {
                    Config.ui._charUI._holderBuff = param1.item;
                    Config.ui._charUI.swapItem(Holder.item, param1._id);
                }
            }
            return;
        }// end function

        private function handleSlotUp(param1)
        {
            var _loc_2:* = param1.currentTarget;
            if (Holder.item != null)
            {
                this.clickSlot(_loc_2);
            }
            return;
        }// end function

        private function handleSlotClick(param1)
        {
            var _loc_2:* = param1.currentTarget;
            this.clickSlot(_loc_2);
            return;
        }// end function

        private function handleSlotDoubleClick(param1)
        {
            var _loc_3:* = undefined;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = undefined;
            var _loc_2:* = param1.currentTarget;
            if (_loc_2.item != null)
            {
                if (Config.getMouseState() != "")
                {
                    return;
                }
                _loc_3 = int(_loc_2.item._itemData.baseID);
                if (_loc_3 == 93001)
                {
                    this.recycleslotnumber = _loc_2.item._position;
                    this.flagsplit = true;
                    Config.setMouseState("recycle", true);
                }
                else if (_loc_3 == 95389)
                {
                    if (!AlertUI._ui._opening)
                    {
                        AlertUI.alert(Config.language("BagPanel", 32), Config.language("BagPanel", 60), [Config.language("BagPanel", 34), Config.language("BagPanel", 35)], [Config.create(this.sureappraisal, _loc_2.item)]);
                    }
                }
                else if (_loc_3 == 95390)
                {
                    _loc_4 = Config.ui._charUI.getItemAmount(896101);
                    if (_loc_4 > 0)
                    {
                        if (!AlertUI._ui._opening)
                        {
                            AlertUI.alert(Config.language("BagPanel", 32), Config.language("BagPanel", 61), [Config.language("BagPanel", 34), Config.language("BagPanel", 35)], [Config.create(this.sureappraisal, _loc_2.item)]);
                        }
                    }
                    else if (Config._lanVersion == LanVersion.QQ_ZH_CN)
                    {
                        Config.message(Config.language("BagPanel", 69));
                    }
                    else if (!AlertUI._ui._opening)
                    {
                        AlertUI.alert(Config.language("BagPanel", 32), Config.language("BagPanel", 62), [Config.language("BagPanel", 34), Config.language("BagPanel", 35)], [Config.create(this.buykey, 896101)]);
                    }
                }
                else if (_loc_3 == 95407)
                {
                    _loc_4 = Config.ui._charUI.getItemAmount(95341);
                    if (_loc_4 > 0)
                    {
                        if (!AlertUI._ui._opening)
                        {
                            AlertUI.alert(Config.language("BagPanel", 32), Config.language("BagPanel", 74), [Config.language("BagPanel", 34), Config.language("BagPanel", 35)], [Config.create(this.sureappraisal, _loc_2.item)]);
                        }
                    }
                    else if (!AlertUI._ui._opening)
                    {
                        AlertUI.alert(Config.language("BagPanel", 32), Config.language("BagPanel", 75), [Config.language("BagPanel", 34), Config.language("BagPanel", 35)], [Config.create(this.buykey, 95341)]);
                    }
                }
                else if (_loc_3 == 898004 || _loc_3 == 898005)
                {
                    if (this.godopen == 0)
                    {
                        AlertUI.alert(Config.language("BagPanel", 32), Config.language("BagPanel", 86), [Config.language("BagPanel", 34)]);
                    }
                    else
                    {
                        Config.ui._godmade.open();
                    }
                }
                else if (_loc_3 == 94502)
                {
                    if (Config.ui._gangs.gildid == 0)
                    {
                        Config.message(Config.language("GildPanel", 38));
                        return;
                    }
                    Config.ui._gangs.gildSourcePanel();
                }
                else if (_loc_3 == 95739)
                {
                    AlertUI.alert(Config.language("BagPanel", 6), Config.language("BagPanel", 85), [Config.language("BagPanel", 34), Config.language("BagPanel", 35)], [this.usebagwareitem], _loc_2.item);
                }
                else if (_loc_3 == 898013)
                {
                    Config.ui._randompetegg.open();
                }
                else if (int(_loc_2.item._itemData.type) == 18)
                {
                    if (_loc_2.item._itemData.addEffect.length == 0)
                    {
                        AlertUI.alert(Config.language("BagPanel", 32), Config.language("BagPanel", 33), [Config.language("BagPanel", 34), Config.language("BagPanel", 35)], [Config.create(this.sureappraisal, _loc_2.item)]);
                    }
                    else
                    {
                        Config.ui._producepanel.putBook(_loc_2);
                    }
                }
                else if (int(_loc_2.item._itemData.type) == 3 && int(_loc_2.item._itemData.quality) < 7)
                {
                    Config.ui._jewelCompound.open();
                    if (int(_loc_2.item._itemData.subType) == 3)
                    {
                        Config.ui._jewelCompound.getfragmentId(int(_loc_2.item._itemData.baseID), int(_loc_2.item._itemData.quality));
                    }
                    else
                    {
                        Config.ui._jewelCompound.getjewelId(int(_loc_2.item._itemData.baseID), int(_loc_2.item._itemData.quality));
                    }
                }
                else if (int(_loc_2.item._itemData.type) == 20)
                {
                    Config.ui._suitFit.open();
                    Config.ui._suitFit.getSuitname(_loc_2.item);
                }
                else if (int(_loc_2.item._itemData.type) == 8 && int(_loc_2.item._itemData.subType) == 52)
                {
                    if (Config.ui._shopmail.vipLv == 0)
                    {
                        Config.ui._charUI.useItem(_loc_2.item);
                    }
                    else if (Config.ui._shopmail.vipLv == int(_loc_2.item._itemData.relatedId))
                    {
                        _loc_5 = Config.language("BagPanel", 71, int(int(_loc_2.item._itemData.timeLimit) / 24));
                        _loc_6 = Config.language("BagPanel", 72, int(_loc_2.item._itemData.timeLimit) % 24);
                        if (int(_loc_2.item._itemData.timeLimit) % 24 > 0)
                        {
                            _loc_5 = _loc_5 + _loc_6;
                        }
                        if (!AlertUI._ui._opening)
                        {
                            AlertUI.alert(Config.language("BagPanel", 32), Config.language("BagPanel", 73, _loc_2.item._itemData.relatedId, _loc_5), [Config.language("BagPanel", 34), Config.language("BagPanel", 35)], [Config.create(this.vipalert, _loc_2.item)]);
                        }
                    }
                }
                else
                {
                    Config.ui._charUI.useItem(_loc_2.item);
                }
            }
            return;
        }// end function

        private function vipalert(event:MouseEvent, param2:Item)
        {
            Config.ui._charUI.useItem(param2);
            return;
        }// end function

        private function openkeybox(event:SocketEvent)
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            var _loc_4:* = _loc_2.readUnsignedInt();
            if (Config._lanVersion == LanVersion.QQ_ZH_CN)
            {
                Config.message(Config.language("BagPanel", 70, Config._itemMap[_loc_4].name));
            }
            else
            {
                AlertUI.alert(Config.language("BagPanel", 32), Config.language("BagPanel", 63, Config._itemMap[_loc_4].name), [Config.language("BagPanel", 34), Config.language("BagPanel", 35)], [Config.create(this.buykey, _loc_4)]);
            }
            return;
        }// end function

        private function buykey(event:MouseEvent, param2:uint)
        {
            Config.ui._shopmail.sendbuy(param2, 1, 0);
            return;
        }// end function

        public function refreshMouseSlot()
        {
            var _loc_3:* = undefined;
            var _loc_1:* = Math.floor((mouseX - 11) / 37);
            var _loc_2:* = Math.floor((mouseY - 70) / 37);
            if (this._gridMatrix[_loc_1] != null)
            {
                _loc_3 = this._gridMatrix[_loc_1][_loc_2];
                if (_loc_3 != null && _opening && _loc_3.item != null && _loc_3.hitTestPoint(Config.stage.mouseX, Config.stage.mouseY, true))
                {
                    this.showSlotInfo(_loc_3);
                    return;
                }
            }
            Holder.closeInfo();
            return;
        }// end function

        public function showSlotInfo(param1)
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (param1.item != null && this._slotRollOver)
            {
                if (param1.parent == null)
                {
                    return;
                }
                Holder.showInfo(param1.item.outputInfo(), new Rectangle(param1.x + param1.parent.x, param1.y + param1.parent.y, param1._size, param1._size), false, 0, 250, param1.item.star);
                _loc_2 = param1.item;
                if ((_loc_2._itemData.reqJob == Player.job || _loc_2._itemData.reqJob == 0) && _loc_2._itemData.reqLevel <= Player.level)
                {
                    if (_loc_2._itemData.type == 4)
                    {
                        if (_loc_2._itemData.subType < 7)
                        {
                            _loc_3 = Config.ui._charUI._slotArray[_loc_2._itemData.subType + 1000].item;
                            if (_loc_3 != null)
                            {
                                Holder.showTwinInfo(_loc_3.outputInfo() + "\n\n<font color=\'#cc0000\'>" + Config.language("BagPanel", 52) + "</font>", new Rectangle(param1.x + param1.parent.x, param1.y + param1.parent.y, param1._size, param1._size), false, 250, _loc_3.star);
                            }
                        }
                        else if (_loc_2._itemData.subType == 7)
                        {
                            if (Config.ui._charUI._slotArray[_loc_2._itemData.subType + 1000].item == null)
                            {
                            }
                            else if (Config.ui._charUI._slotArray[_loc_2._itemData.subType + 1001].item == null)
                            {
                            }
                            else
                            {
                                _loc_3 = Config.ui._charUI._slotArray[_loc_2._itemData.subType + 1000].item;
                                if (_loc_3 != null)
                                {
                                    Holder.showTwinInfo(_loc_3.outputInfo() + "\n\n<font color=\'#cc0000\'>" + Config.language("BagPanel", 52) + "</font>", new Rectangle(param1.x + param1.parent.x, param1.y + param1.parent.y, param1._size, param1._size), false, 250, _loc_3.star);
                                }
                            }
                        }
                        else if (_loc_2._itemData.subType > 7)
                        {
                            _loc_3 = Config.ui._charUI._slotArray[_loc_2._itemData.subType + 1001].item;
                            if (_loc_3 != null)
                            {
                                Holder.showTwinInfo(_loc_3.outputInfo() + "\n\n<font color=\'#cc0000\'>" + Config.language("BagPanel", 52) + "</font>", new Rectangle(param1.x + param1.parent.x, param1.y + param1.parent.y, param1._size, param1._size), false, 250, _loc_3.star);
                            }
                        }
                    }
                    else if (_loc_2._itemData.type == 10 && _loc_2._itemData.subType == 12)
                    {
                        _loc_3 = Config.ui._charUI._slotArray[1013].item;
                        if (_loc_3 != null)
                        {
                            Holder.showTwinInfo(_loc_3.outputInfo() + "\n\n<font color=\'#cc0000\'>" + Config.language("BagPanel", 52) + "</font>", new Rectangle(param1.x + param1.parent.x, param1.y + param1.parent.y, param1._size, param1._size), false, 250, _loc_3.star);
                        }
                    }
                }
                if (int(_loc_2._itemData.suitID) > 0 && int(_loc_2._itemData.type) != 20)
                {
                    _loc_4 = param1.parent.localToGlobal(new Point(param1.x, param1.y));
                    Holder.showRightInfo(param1.item.outfitInfo(1), new Rectangle(_loc_4.x, _loc_4.y, param1._size, param1._size));
                }
            }
            return;
        }// end function

        private function handleSlotOver(param1)
        {
            this._slotRollOver = true;
            var _loc_2:* = param1.currentTarget;
            this.showSlotInfo(_loc_2);
            return;
        }// end function

        private function handleSlotOut(param1)
        {
            this._slotRollOver = false;
            Holder.closeInfo();
            return;
        }// end function

        private function handleSwitchMix(param1)
        {
            if (Config.map._type == 0)
            {
                this._repairPB.removeEventListener(MouseEvent.CLICK, this.handleSwitchMix);
                this._repairPB.enabled = false;
                this._repairPB.buttonMode = false;
                Config.ui._stallUI.switchOpen();
            }
            else
            {
                Config.message(Config.language("BagPanel", 53));
            }
            return;
        }// end function

        public function addhandleSwitchMix()
        {
            this._repairPB.addEventListener(MouseEvent.CLICK, this.handleSwitchMix);
            this._repairPB.enabled = true;
            this._repairPB.buttonMode = true;
            return;
        }// end function

        public function getMinEmptySlot()
        {
            var _loc_1:* = undefined;
            _loc_1 = this._slotStartIndex;
            while (_loc_1 < this._slotStartIndex + this._bagActiveNumber)
            {
                
                if (!Config.ui._charUI._slotArray[_loc_1]._locked && Config.ui._charUI._slotArray[_loc_1].item == null)
                {
                    return Config.ui._charUI._slotArray[_loc_1];
                }
                _loc_1 = _loc_1 + 1;
            }
            return null;
        }// end function

        public function listenPlayer(param1)
        {
            param1.removeEventListener("update", this.handlePlayerUpdate);
            param1.addEventListener("update", this.handlePlayerUpdate);
            return;
        }// end function

        public function removeListenPlayer(param1)
        {
            param1.removeEventListener("update", this.handlePlayerUpdate);
            return;
        }// end function

        private function handlePlayerUpdate(event:UnitEvent)
        {
            var _loc_2:* = [16775920, 8190976, 16776960, 16766720];
            if (event.param == "money1")
            {
                if (event.value >= 0 && event.value < 1000)
                {
                    this.money1text.textColor = _loc_2[0];
                }
                else if (event.value >= 1000 && event.value < 1000000)
                {
                    this.money1text.textColor = _loc_2[1];
                }
                else if (event.value >= 1000000 && event.value < 1000000000)
                {
                    this.money1text.textColor = _loc_2[2];
                }
                else if (event.value >= 1000000000)
                {
                    this.money1text.textColor = _loc_2[3];
                }
                this.money1text.text = Config.coinShow(event.value);
                this.money1text.x = 340 - this.money1text.width;
            }
            if (event.param == "money3")
            {
                if (event.value >= 0 && event.value < 1000)
                {
                    this.money3text.textColor = _loc_2[0];
                }
                else if (event.value >= 1000 && event.value < 1000000)
                {
                    this.money3text.textColor = _loc_2[1];
                }
                else if (event.value >= 1000000 && event.value < 1000000000)
                {
                    this.money3text.textColor = _loc_2[2];
                }
                else if (event.value >= 1000000000)
                {
                    this.money3text.textColor = _loc_2[3];
                }
                this.money3text.text = Config.coinShow(event.value);
                this.money3text.x = 110 - this.money3text.width;
            }
            if (event.param == "money4")
            {
                if (event.value >= 0 && event.value < 1000)
                {
                    this.money4text.textColor = _loc_2[0];
                }
                else if (event.value >= 1000 && event.value < 1000000)
                {
                    this.money4text.textColor = _loc_2[1];
                }
                else if (event.value >= 1000000 && event.value < 1000000000)
                {
                    this.money4text.textColor = _loc_2[2];
                }
                else if (event.value >= 1000000000)
                {
                    this.money4text.textColor = _loc_2[3];
                }
                this.money4text.text = Config.coinShow(event.value);
                this.money4text.x = 110 - this.money4text.width;
            }
            if (event.param == "money2")
            {
                if (event.value >= 0 && event.value < 1000)
                {
                    this.money2text.textColor = _loc_2[0];
                }
                else if (event.value >= 1000 && event.value < 1000000)
                {
                    this.money2text.textColor = _loc_2[1];
                }
                else if (event.value >= 1000000 && event.value < 1000000000)
                {
                    this.money2text.textColor = _loc_2[2];
                }
                else if (event.value >= 1000000000)
                {
                    this.money2text.textColor = _loc_2[3];
                }
                this.money2text.text = Config.coinShow(event.value);
                this.money2text.x = 225 - this.money2text.width;
            }
            return;
        }// end function

        override public function testGuide()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = null;
            var _loc_5:* = undefined;
            if (GuideUI.testId(8))
            {
                for (_loc_1 in Config.ui._charUI._itemArray)
                {
                    
                    _loc_4 = Config.ui._charUI._itemArray[_loc_1];
                    _loc_3 = _loc_4._itemData;
                    if (_loc_4._position >= this._slotStartIndex && _loc_3.type == 4 && (_loc_3.reqJob == Player.job || _loc_3.reqJob == 0) && _loc_3.reqLevel <= Player.level)
                    {
                        _loc_5 = _loc_4._drawer[_loc_4._position];
                        if (_loc_5._id >= this._slotStartIndex)
                        {
                            this.gotoSlotPage(_loc_5);
                        }
                        GuideUI.doId(8, _loc_5);
                        return;
                    }
                }
            }
            else if (GuideUI.testId(48))
            {
                _loc_5 = Config.ui._charUI.getOneItemSlot(51000);
                if (_loc_5 != null)
                {
                    if (_loc_5._id >= this._slotStartIndex)
                    {
                        this.gotoSlotPage(_loc_5);
                    }
                    GuideUI.doId(48, _loc_5);
                }
            }
            else if (GuideUI.testId(52))
            {
                GuideUI.doId(52, this._repairPB);
            }
            else if (GuideUI.testId(79))
            {
                for (_loc_1 in Config.ui._charUI._itemArray)
                {
                    
                    _loc_4 = Config.ui._charUI._itemArray[_loc_1];
                    _loc_3 = _loc_4._itemData;
                    if (_loc_4._position >= this._slotStartIndex && _loc_3.type == 12 && (_loc_3.reqJob == Player.job || _loc_3.reqJob == 0) && _loc_3.reqLevel <= Player.level)
                    {
                        _loc_5 = _loc_4._drawer[_loc_4._position];
                        if (_loc_5._id >= this._slotStartIndex)
                        {
                            this.gotoSlotPage(_loc_5);
                        }
                        GuideUI.doId(79, _loc_5);
                        return;
                    }
                }
            }
            else if (GuideUI.testId(86))
            {
                _loc_5 = Config.ui._charUI.getOneItemSlot(23000);
                trace("GuideUI.testId(86)", _loc_5);
                if (_loc_5 != null)
                {
                    if (_loc_5._id >= this._slotStartIndex)
                    {
                        this.gotoSlotPage(_loc_5);
                    }
                    GuideUI.doId(86, _loc_5);
                }
            }
            else if (GuideUI.testId(89))
            {
                _loc_5 = Config.ui._charUI.getOneItemSlot(24000);
                if (_loc_5 != null)
                {
                    if (_loc_5._id >= this._slotStartIndex)
                    {
                        this.gotoSlotPage(_loc_5);
                    }
                    GuideUI.doId(89, _loc_5);
                }
            }
            else if (GuideUI.testId(152))
            {
                _loc_5 = Config.ui._charUI.getOneItemSlot(95391);
                if (_loc_5 != null)
                {
                    if (_loc_5._id >= this._slotStartIndex)
                    {
                        this.gotoSlotPage(_loc_5);
                    }
                    GuideUI.doId(152, _loc_5);
                }
            }
            else if (GuideUI.testId(168))
            {
                if (Player.job == 1)
                {
                    _loc_5 = Config.ui._charUI.getOneItemSlot(31002);
                }
                else if (Player.job == 4)
                {
                    _loc_5 = Config.ui._charUI.getOneItemSlot(32002);
                }
                else if (Player.job == 10)
                {
                    _loc_5 = Config.ui._charUI.getOneItemSlot(33002);
                }
                if (_loc_5 != null)
                {
                    if (_loc_5._id >= this._slotStartIndex)
                    {
                        this.gotoSlotPage(_loc_5);
                    }
                    GuideUI.doId(168, _loc_5);
                }
            }
            else if (GuideUI.testId(174))
            {
                if (Player.job == 1)
                {
                    _loc_5 = Config.ui._charUI.getOneItemSlot(31003);
                }
                else if (Player.job == 4)
                {
                    _loc_5 = Config.ui._charUI.getOneItemSlot(32003);
                }
                else if (Player.job == 10)
                {
                    _loc_5 = Config.ui._charUI.getOneItemSlot(33003);
                }
                if (_loc_5 != null)
                {
                    if (_loc_5._id >= this._slotStartIndex)
                    {
                        this.gotoSlotPage(_loc_5);
                    }
                    GuideUI.doId(174, _loc_5);
                }
            }
            else if (GuideUI.testId(178))
            {
                if (Player.job == 1)
                {
                    _loc_5 = Config.ui._charUI.getOneItemSlot(31004);
                }
                else if (Player.job == 4)
                {
                    _loc_5 = Config.ui._charUI.getOneItemSlot(32004);
                }
                else if (Player.job == 10)
                {
                    _loc_5 = Config.ui._charUI.getOneItemSlot(33004);
                }
                if (_loc_5 != null)
                {
                    if (_loc_5._id >= this._slotStartIndex)
                    {
                        this.gotoSlotPage(_loc_5);
                    }
                    GuideUI.doId(178, _loc_5);
                }
            }
            else if (GuideUI.testId(204))
            {
                _loc_5 = Config.ui._charUI.getOneItemSlot(10111);
                if (_loc_5 != null)
                {
                    if (_loc_5._id >= this._slotStartIndex)
                    {
                        this.gotoSlotPage(_loc_5);
                    }
                    GuideUI.doId(204, _loc_5);
                }
            }
            else if (GuideUI.testId(208))
            {
                for (_loc_1 in Config.ui._charUI._itemArray)
                {
                    
                    _loc_4 = Config.ui._charUI._itemArray[_loc_1];
                    _loc_3 = _loc_4._itemData;
                    if (_loc_4._position >= this._slotStartIndex && _loc_3.type == 10 && _loc_3.subType == 2)
                    {
                        _loc_5 = _loc_4._drawer[_loc_4._position];
                        if (_loc_5._id >= this._slotStartIndex)
                        {
                            this.gotoSlotPage(_loc_5);
                        }
                        GuideUI.doId(208, _loc_5);
                        return;
                    }
                }
            }
            else if (GuideUI.testId(214))
            {
                for (_loc_1 in Config.ui._charUI._itemArray)
                {
                    
                    _loc_4 = Config.ui._charUI._itemArray[_loc_1];
                    _loc_3 = _loc_4._itemData;
                    if (_loc_4._position >= this._slotStartIndex && _loc_3.type == 10 && _loc_3.subType == 5)
                    {
                        _loc_5 = _loc_4._drawer[_loc_4._position];
                        if (_loc_5._id >= this._slotStartIndex)
                        {
                            this.gotoSlotPage(_loc_5);
                        }
                        GuideUI.doId(214, _loc_5);
                        return;
                    }
                }
            }
            else if (GuideUI.testId(220))
            {
                GuideUI.doId(220, Config.ui._petPanel.soulPanel);
            }
            else if (GuideUI.testId(229))
            {
                _loc_5 = Config.ui._charUI.getOneItemSlot(10100);
                if (_loc_5 != null)
                {
                    if (_loc_5._id >= this._slotStartIndex)
                    {
                        this.gotoSlotPage(_loc_5);
                    }
                    GuideUI.doId(229, _loc_5);
                }
            }
            else if (GuideUI.testId(201))
            {
                _loc_5 = Config.ui._charUI.getOneItemSlot(95306);
                if (_loc_5 != null)
                {
                    if (_loc_5._id >= this._slotStartIndex)
                    {
                        this.gotoSlotPage(_loc_5);
                    }
                    GuideUI.doId(201, _loc_5);
                }
            }
            else if (GuideUI.testId(194) && !GuideUI.testOverId(195))
            {
                _loc_5 = Config.ui._charUI.getOneItemSlot(95307);
                if (_loc_5 == null)
                {
                    _loc_5 = Config.ui._charUI.getOneItemSlot(95306);
                    if (_loc_5 != null)
                    {
                        if (_loc_5._id >= this._slotStartIndex)
                        {
                            this.gotoSlotPage(_loc_5);
                        }
                        GuideUI.doId(194, _loc_5);
                        return;
                    }
                }
                else
                {
                    if (_loc_5._id >= this._slotStartIndex)
                    {
                        this.gotoSlotPage(_loc_5);
                    }
                    GuideUI.testDoId(195, _loc_5);
                }
            }
            else if (GuideUI.testId(195))
            {
                _loc_5 = Config.ui._charUI.getOneItemSlot(95307);
                if (_loc_5 != null)
                {
                    if (_loc_5._id >= this._slotStartIndex)
                    {
                        this.gotoSlotPage(_loc_5);
                    }
                    GuideUI.doId(195, _loc_5);
                }
            }
            else if (GuideUI.testId(235))
            {
                _loc_5 = Config.ui._charUI.getOneItemSlot(95105);
                if (_loc_5 != null)
                {
                    if (_loc_5._id >= this._slotStartIndex)
                    {
                        this.gotoSlotPage(_loc_5);
                    }
                    GuideUI.doId(235, _loc_5);
                }
            }
            else if (GuideUI.testId(245))
            {
                _loc_5 = Config.ui._charUI.getOneItemSlot(970003);
                if (_loc_5 != null)
                {
                    if (_loc_5._id >= this._slotStartIndex)
                    {
                        this.gotoSlotPage(_loc_5);
                    }
                    GuideUI.doId(245, _loc_5);
                }
            }
            else if (AutoDrug.canBuy && GuideUI.testId(44))
            {
                for (_loc_1 in Config.ui._charUI._itemArray)
                {
                    
                    _loc_4 = Config.ui._charUI._itemArray[_loc_1];
                    _loc_3 = _loc_4._itemData;
                    if (_loc_3.id == 66001 || _loc_3.id == 66002 || _loc_3.id == 66003)
                    {
                        _loc_5 = _loc_4._drawer[_loc_4._position];
                        if (_loc_5._id >= this._slotStartIndex)
                        {
                            this.gotoSlotPage(_loc_5);
                        }
                        GuideUI.doId(44, _loc_5);
                        return;
                    }
                }
            }
            else if (AutoDrug.canBuy && GuideUI.testId(45))
            {
                for (_loc_1 in Config.ui._charUI._itemArray)
                {
                    
                    _loc_4 = Config.ui._charUI._itemArray[_loc_1];
                    _loc_3 = _loc_4._itemData;
                    if (_loc_3.id == 66501 || _loc_3.id == 66502 || _loc_3.id == 66503)
                    {
                        _loc_5 = _loc_4._drawer[_loc_4._position];
                        if (_loc_5._id >= this._slotStartIndex)
                        {
                            this.gotoSlotPage(_loc_5);
                        }
                        GuideUI.doId(45, _loc_5);
                        return;
                    }
                }
            }
            else if (GuideUI.testId(243))
            {
                for (_loc_1 in Config.ui._charUI._itemArray)
                {
                    
                    _loc_4 = Config.ui._charUI._itemArray[_loc_1];
                    _loc_3 = _loc_4._itemData;
                    if (_loc_3.id == 980001 || _loc_3.id == 980002 || _loc_3.id == 980003)
                    {
                        _loc_5 = _loc_4._drawer[_loc_4._position];
                        if (_loc_5._id >= this._slotStartIndex)
                        {
                            this.gotoSlotPage(_loc_5);
                        }
                        GuideUI.doId(243, _loc_5);
                        return;
                    }
                }
            }
            else if (GuideUI.testId(247))
            {
                GuideUI.doId(247, this.madeBtn);
            }
            else if (GuideUI.testId(162))
            {
                for (_loc_1 in Config.ui._charUI._itemArray)
                {
                    
                    _loc_4 = Config.ui._charUI._itemArray[_loc_1];
                    _loc_3 = _loc_4._itemData;
                    if (_loc_3.id == 95407)
                    {
                        _loc_5 = _loc_4._drawer[_loc_4._position];
                        if (_loc_5._id >= this._slotStartIndex)
                        {
                            this.gotoSlotPage(_loc_5);
                        }
                        GuideUI.doId(162, _loc_5);
                        return;
                    }
                }
            }
            return;
        }// end function

        public function gotoSlotPage(param1)
        {
            var _loc_2:* = undefined;
            if (param1 != null)
            {
                _loc_2 = int((param1._id - this._slotStartIndex) / (this._gridWidth * this._gridHeight));
                this._pageButton.selectpage = _loc_2;
                if (_loc_2 > 2)
                {
                    _loc_2 = 0;
                }
                this.changePage(null, _loc_2);
            }
            return;
        }// end function

        override public function close()
        {
            super.close();
            Config.setMouseState("", true);
            this._splitPB.selected = false;
            return;
        }// end function

        public function bagfull() : Boolean
        {
            var _loc_1:* = true;
            var _loc_2:* = this._slotStartIndex;
            while (_loc_2 <= this._bagActiveNumber)
            {
                
                if (Config.ui._charUI._slotArray[_loc_2].item == null)
                {
                    _loc_1 = false;
                    break;
                }
                _loc_2 = _loc_2 + 1;
            }
            return _loc_1;
        }// end function

        public function clearBag()
        {
            var _loc_2:* = undefined;
            var _loc_1:* = true;
            _loc_2 = this._slotStartIndex;
            while (_loc_2 <= this._bagActiveNumber)
            {
                
                if (Config.ui._charUI._slotArray[_loc_2].item != null)
                {
                    if (Holder.item == Config.ui._charUI._slotArray[_loc_2].item)
                    {
                        Holder.item = null;
                    }
                    Config.ui._charUI._slotArray[_loc_2].item.destroy();
                    Config.ui._charUI._slotArray[_loc_2].item = null;
                }
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        private function openboxflag(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readByte();
            switch(_loc_3)
            {
                case 0:
                {
                    break;
                }
                case 1:
                {
                    Config.message(Config.language("BagPanel", 64));
                    break;
                }
                case 25:
                {
                    Config.message(Config.language("BagPanel", 65));
                    break;
                }
                case 73:
                {
                    Config.message(Config.language("BagPanel", 66));
                    break;
                }
                case 79:
                {
                    Config.message(Config.language("BagPanel", 67));
                    break;
                }
                case 76:
                {
                    Config.message(Config.language("BagPanel", 68));
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function selectPage(event:MouseEvent = null, param2:uint = 0) : void
        {
            this._page = 0;
            this.levelSort = 0;
            this.selectType(param2);
            this.typeaRb.selected = false;
            this.typebRb.selected = false;
            this.typecRb.selected = false;
            this.typedRb.selected = true;
            this.menubar.selectpage = param2;
            return;
        }// end function

        private function selectType(param1:uint = 0) : void
        {
            var _loc_2:* = undefined;
            this.typeaRb.visible = true;
            this.typebRb.visible = true;
            this.typecRb.visible = true;
            this.typedRb.visible = true;
            this._itemListArr = [];
            switch(param1)
            {
                case 0:
                {
                    _loc_2 = this._slotStartIndex;
                    while (_loc_2 < this._slotStartIndex + this._bagActiveNumber)
                    {
                        
                        this._itemListArr.push(Config.ui._charUI._slotArray[_loc_2]);
                        _loc_2 = _loc_2 + 1;
                    }
                    this.typeaRb.visible = false;
                    this.typebRb.visible = false;
                    this.typecRb.visible = false;
                    this.typedRb.visible = false;
                    break;
                }
                case 1:
                {
                    _loc_2 = this._slotStartIndex;
                    while (_loc_2 < this._slotStartIndex + this._bagActiveNumber)
                    {
                        
                        if (Config.ui._charUI._slotArray[_loc_2].item != null)
                        {
                            if (Config.ui._charUI._slotArray[_loc_2].item._itemData.type == 20 || Config.ui._charUI._slotArray[_loc_2].item._itemData.type == 4 || Config.ui._charUI._slotArray[_loc_2].item._itemData.type == 8 && Config.ui._charUI._slotArray[_loc_2].item._itemData.subType == 7)
                            {
                                this._itemListArr.push(Config.ui._charUI._slotArray[_loc_2]);
                            }
                        }
                        _loc_2 = _loc_2 + 1;
                    }
                    break;
                }
                case 2:
                {
                    _loc_2 = this._slotStartIndex;
                    while (_loc_2 < this._slotStartIndex + this._bagActiveNumber)
                    {
                        
                        if (Config.ui._charUI._slotArray[_loc_2].item != null)
                        {
                            if (Config.ui._charUI._slotArray[_loc_2].item._itemData.type == 2 && (Config.ui._charUI._slotArray[_loc_2].item._itemData.subType == 1 || Config.ui._charUI._slotArray[_loc_2].item._itemData.subType == 5))
                            {
                                this._itemListArr.push(Config.ui._charUI._slotArray[_loc_2]);
                            }
                        }
                        _loc_2 = _loc_2 + 1;
                    }
                    break;
                }
                case 3:
                {
                    _loc_2 = this._slotStartIndex;
                    while (_loc_2 < this._slotStartIndex + this._bagActiveNumber)
                    {
                        
                        if (Config.ui._charUI._slotArray[_loc_2].item != null)
                        {
                            if (Config.ui._charUI._slotArray[_loc_2].item._itemData.type == 19)
                            {
                                this._itemListArr.push(Config.ui._charUI._slotArray[_loc_2]);
                            }
                        }
                        _loc_2 = _loc_2 + 1;
                    }
                    break;
                }
                case 4:
                {
                    _loc_2 = this._slotStartIndex;
                    while (_loc_2 < this._slotStartIndex + this._bagActiveNumber)
                    {
                        
                        if (Config.ui._charUI._slotArray[_loc_2].item != null)
                        {
                            if (Config.ui._charUI._slotArray[_loc_2].item._itemData.type == 10)
                            {
                                this._itemListArr.push(Config.ui._charUI._slotArray[_loc_2]);
                            }
                        }
                        _loc_2 = _loc_2 + 1;
                    }
                    break;
                }
                case 5:
                {
                    _loc_2 = this._slotStartIndex;
                    while (_loc_2 < this._slotStartIndex + this._bagActiveNumber)
                    {
                        
                        if (Config.ui._charUI._slotArray[_loc_2].item != null)
                        {
                            if (Config.ui._charUI._slotArray[_loc_2].item._itemData.type == 1)
                            {
                                this._itemListArr.push(Config.ui._charUI._slotArray[_loc_2]);
                            }
                        }
                        _loc_2 = _loc_2 + 1;
                    }
                    break;
                }
                case 6:
                {
                    _loc_2 = this._slotStartIndex;
                    while (_loc_2 < this._slotStartIndex + this._bagActiveNumber)
                    {
                        
                        if (Config.ui._charUI._slotArray[_loc_2].item != null)
                        {
                            if (!(Config.ui._charUI._slotArray[_loc_2].item._itemData.type == 4 || Config.ui._charUI._slotArray[_loc_2].item._itemData.type == 20 || Config.ui._charUI._slotArray[_loc_2].item._itemData.type == 8 && Config.ui._charUI._slotArray[_loc_2].item._itemData.subType == 7))
                            {
                                if (!(Config.ui._charUI._slotArray[_loc_2].item._itemData.type == 2 && (Config.ui._charUI._slotArray[_loc_2].item._itemData.subType == 1 || Config.ui._charUI._slotArray[_loc_2].item._itemData.subType == 5)))
                                {
                                    if (Config.ui._charUI._slotArray[_loc_2].item._itemData.type != 19)
                                    {
                                        if (Config.ui._charUI._slotArray[_loc_2].item._itemData.type != 18)
                                        {
                                            if (Config.ui._charUI._slotArray[_loc_2].item._itemData.type != 10)
                                            {
                                                if (Config.ui._charUI._slotArray[_loc_2].item._itemData.type != 1)
                                                {
                                                    this._itemListArr.push(Config.ui._charUI._slotArray[_loc_2]);
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        _loc_2 = _loc_2 + 1;
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (param1 > 0)
            {
                _loc_2 = this._slotStartIndex;
                while (_loc_2 < this._slotStartIndex + this._bagActiveNumber)
                {
                    
                    if (Config.ui._charUI._slotArray[_loc_2].item == null)
                    {
                        this._itemListArr.push(Config.ui._charUI._slotArray[_loc_2]);
                    }
                    _loc_2 = _loc_2 + 1;
                }
            }
            this.selectLevel();
            return;
        }// end function

        private function selectLevel() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
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
                _loc_1++;
            }
            this._gridMatrix = [];
            if (this.levelSort == 1)
            {
                _loc_1 = this._itemListArr.length - 1;
                while (_loc_1 >= 0)
                {
                    
                    if (this._itemListArr[_loc_1].item != null)
                    {
                        if (this._itemListArr[_loc_1].item._itemData.reqLevel > 49)
                        {
                            this._itemListArr.splice(_loc_1, 1);
                        }
                    }
                    _loc_1 = _loc_1 - 1;
                }
            }
            else if (this.levelSort == 2)
            {
                _loc_1 = this._itemListArr.length - 1;
                while (_loc_1 >= 0)
                {
                    
                    if (this._itemListArr[_loc_1].item != null)
                    {
                        if (this._itemListArr[_loc_1].item._itemData.reqLevel < 50 || this._itemListArr[_loc_1].item._itemData.reqLevel >= 60)
                        {
                            this._itemListArr.splice(_loc_1, 1);
                        }
                    }
                    _loc_1 = _loc_1 - 1;
                }
            }
            else if (this.levelSort == 3)
            {
                _loc_1 = this._itemListArr.length - 1;
                while (_loc_1 >= 0)
                {
                    
                    if (this._itemListArr[_loc_1].item != null)
                    {
                        if (this._itemListArr[_loc_1].item._itemData.reqLevel < 60)
                        {
                            this._itemListArr.splice(_loc_1, 1);
                        }
                    }
                    _loc_1 = _loc_1 - 1;
                }
            }
            this._pageButton.clearBar();
            _loc_1 = 0;
            while (_loc_1 < Math.ceil(this._bagActiveNumber / (this._gridWidth * this._gridHeight)))
            {
                
                this._pageButton.addTab(String((_loc_1 + 1)), Config.create(this.changePage, _loc_1), 40);
                _loc_1++;
            }
            if (this.menubar.selectpage == 0 && this._bagActiveNumber < this._slotNumber)
            {
                this._pageButton.addTab(String(3) + Config.language("BagPanel", 54), Config.create(this.changePage, 3), 60);
            }
            this._pageButton.selectpage = this._page;
            this.showItem();
            return;
        }// end function

        public function showItem() : void
        {
            var _loc_1:* = undefined;
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = null;
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
            var _loc_6:* = 0;
            _loc_3 = 0;
            _loc_2 = _loc_6;
            _loc_1 = _loc_6;
            _loc_4 = this._page * this._gridWidth * this._gridHeight;
            _loc_3 = _loc_4;
            while (_loc_3 < this._bagActiveNumber + _loc_4)
            {
                
                if (_loc_3 < this._itemListArr.length)
                {
                    this._gridMatrix[_loc_1][_loc_2] = this._itemListArr[_loc_3];
                }
                else
                {
                    _loc_5 = new InvSlot(_loc_1, 32);
                    _loc_5.lock();
                    this._gridMatrix[_loc_1][_loc_2] = _loc_5;
                }
                this._gridMatrix[_loc_1][_loc_2].x = _loc_1 * 37 + 11;
                this._gridMatrix[_loc_1][_loc_2].y = _loc_2 * 37 + 70;
                addChild(this._gridMatrix[_loc_1][_loc_2]);
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
            }
            return;
        }// end function

        private function levelSortFuc(event:MouseEvent, param2:int) : void
        {
            this.levelSort = param2;
            this.selectType(this.menubar.selectpage);
            return;
        }// end function

        public function findItem(param1:int) : Item
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            while (_loc_3 < Config.ui._charUI._itemArray.length)
            {
                
                if (param1 == Config.ui._charUI._itemArray[_loc_3].id)
                {
                    _loc_2 = Config.ui._charUI._itemArray[_loc_3];
                    break;
                }
                _loc_3 = _loc_3 + 1;
            }
            return _loc_2;
        }// end function

        public function findItemBybaseId(param1:int) : Item
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            while (_loc_3 < Config.ui._charUI._itemArray.length)
            {
                
                if (param1 == Config.ui._charUI._itemArray[_loc_3]._itemData.id)
                {
                    _loc_2 = Config.ui._charUI._itemArray[_loc_3];
                    break;
                }
                _loc_3 = _loc_3 + 1;
            }
            return _loc_2;
        }// end function

        public function handleFull()
        {
            GuideUI.testDoId(206);
            return;
        }// end function

        public function sellFuc(event:MouseEvent = null) : void
        {
            if (Holder.item != null)
            {
                if (Holder.item._drawer == Config.ui._charUI._slotArray)
                {
                    this.sell(Holder.item);
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
                    this.sellBtn.selected = false;
                }
                else
                {
                    Config.setMouseState("sell", true);
                    this.sellBtn.selected = true;
                }
            }
            return;
        }// end function

        private function madeFuc(event:MouseEvent) : void
        {
            Config.ui._equiomadepanel.switchOpen();
            return;
        }// end function

        public function setEnable(param1:int, param2:int) : void
        {
            return;
        }// end function

        public function cancelEnable() : void
        {
            return;
        }// end function

        public function showMoneyTip(event:MouseEvent, param2:int) : void
        {
            var _loc_3:* = "";
            if (param2 == 2)
            {
                _loc_3 = Config.language("BagPanel", 24);
            }
            else if (param2 == 3)
            {
                _loc_3 = Config.language("BagPanel", 26);
            }
            else if (param2 == 4)
            {
                _loc_3 = Config.language("BagPanel", 25);
            }
            var _loc_4:* = event.currentTarget;
            var _loc_5:* = event.currentTarget.parent.localToGlobal(new Point(_loc_4.x, _loc_4.y));
            Holder.showInfo(_loc_3, new Rectangle(_loc_5.x, _loc_5.y, 20, 20), false, 0);
            return;
        }// end function

        private function overQQBtn(event:Event) : void
        {
            event.target.filters = [Style.GREENLIGHT];
            return;
        }// end function

        private function outQQBtn(event:Event) : void
        {
            event.target.filters = [];
            return;
        }// end function

        private function openQQPay(event:MouseEvent) : void
        {
            Config.ui._shopmail.openvipPay();
            return;
        }// end function

        public function setYeVip() : void
        {
            if (Config._QQInfo.is_yellow_vip)
            {
                this.yeBtn.bitmapData = Config.findsysUI("headui/qq1", 110, 34);
            }
            else
            {
                this.yeBtn.bitmapData = Config.findsysUI("headui/qq2", 114, 34);
            }
            return;
        }// end function

        private function bagwareflag(event:SocketEvent)
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readByte();
            var _loc_4:* = "";
            this._bagwareflag = false;
            if (_loc_3 == 0)
            {
                _loc_4 = Config.language("BagPanel", 77);
            }
            else
            {
                this._bagwareflag = true;
                _loc_4 = Config.language("BagPanel", 78);
            }
            this.tempallbtn.label = _loc_4;
            this.tempallbtn.textColor = Style.GOLD_FONT;
            return;
        }// end function

        private function openbagware(param1)
        {
            if (this._bagwareflag)
            {
                Config.ui._bagware.switchOpen();
            }
            else if (Config.ui._charUI.getItemAmount(95739) > 0)
            {
                AlertUI.alert(Config.language("BagPanel", 6), Config.language("BagPanel", 79), [Config.language("BagPanel", 34), Config.language("BagPanel", 35)], [this.senduse]);
            }
            else
            {
                AlertUI.alert(Config.language("BagPanel", 80), Config.language("BagPanel", 76), [Config.language("BagPanel", 5)]);
            }
            return;
        }// end function

        private function senduse(param1)
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (!this._bagwareflag)
            {
                _loc_2 = Config.ui._charUI.getOneItem(95739);
                if (_loc_2 != null)
                {
                    _loc_3 = new DataSet();
                    _loc_3.addHead(CONST_ENUM.CMSG_ITEM_USE);
                    _loc_3.add16(_loc_2._position);
                    ClientSocket.send(_loc_3);
                }
                else
                {
                    AlertUI.alert(Config.language("BagPanel", 81), Config.language("BagPanel", 82), [Config.language("BagPanel", 5)]);
                }
            }
            else
            {
                AlertUI.alert(Config.language("BagPanel", 83), Config.language("BagPanel", 84), [Config.language("BagPanel", 5)]);
            }
            return;
        }// end function

        private function usebagwareitem(param1:Item)
        {
            var _loc_2:* = null;
            AlertUI.close();
            if (!this._bagwareflag)
            {
                _loc_2 = new DataSet();
                _loc_2.addHead(CONST_ENUM.CMSG_ITEM_USE);
                _loc_2.add16(param1._position);
                ClientSocket.send(_loc_2);
            }
            else
            {
                AlertUI.alert(Config.language("BagPanel", 83), Config.language("BagPanel", 84), [Config.language("BagPanel", 5)]);
            }
            return;
        }// end function

        public function set godopen(param1:int) : void
        {
            this._godopen = param1;
            return;
        }// end function

        public function get godopen() : int
        {
            return this._godopen;
        }// end function

    }
}
