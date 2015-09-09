package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import flash.utils.*;
    import lovefox.component.*;
    import lovefox.socket.*;
    import lovefox.unit.*;

    public class BlackMarket extends Window
    {
        private var panel:Sprite;
        private var putpricepanel:Window;
        private var btnbar:ButtonBar;
        private var _slotArray:Array;
        private var _slotMysaleArray:Array;
        private var _slotAllsaleArray:Array;
        private var temppagearr:Array;
        private var _itemnum:uint;
        private var _tabauctionprice:Object;
        private var _tabauctionplayername:Object;
        private var _tabauctiontime:Object;
        private var auctionitemobjarr:Array;
        private var _backmoneypool:uint;
        private var ii:int;
        private var listcanvas:CanvasUI;
        private var itemlistarr:Array;
        private var bakemshoplist:Array;
        private var _allslotArray:Array;
        private var autoaddArr:Array;
        private var manualaddArr:Array;
        private var selsctflag:int = -1;
        private var panelobj:Object;
        private var tlabeprice:TextField;
        private var tlabetime:TextField;
        private var tlabepname:TextField;
        private var tabel:TextField;
        private var _priceput:InputText;
        private var _auctionewprice:int;
        private var flagupdate:Boolean;
        private var iii:int;
        private var pooltable:InputText;
        private var lbinput:InputText;
        private var lb2input:InputText;
        private var pagetotal:int;
        private var pg:int = 1;
        private var nowpg:uint;
        private var _minTimer:Number;
        private var epname:String = "";
        private var minle:int = 0;
        private var maxle:int = 99;
        private var togglebtn:ToggleButtonBarUI;
        private var activtopall:ToggleButtonBarUI;
        private var activtopmy:ToggleButtonBarUI;
        private var allSale:PushButton;
        private var _mcanvasall:CanvasUI;
        private var _mcanvasmy:CanvasUI;
        public var _mcanvas:CanvasUI;
        private var _salePanel:Panel;
        private var taxPercentText:Label;
        private var commissionText:Label;
        private var pagelabel:TextField;
        private var _salePriceNS:InputText;
        private var inputname:InputText;
        private var comboxSale:ComboBox;
        private var sendTime:uint;
        private var itemPos:uint;
        private var _salerNameCL:ClickLabel;
        private var _cloneBagPanel:Panel;
        private var _cloneSlotArray:Array;
        private var _slotStartIndex:int = 0;
        private var _page:Object = 0;
        private var _gridWidth:Object = 6;
        private var _gridHeight:Object = 6;
        private var _gridMatrix:Array;
        private var _cloneLeft:PushButton;
        private var _cloneRight:PushButton;
        private var _clonePageLB:TextField;
        private var day:uint = 86400;
        private var hour:uint = 3600;
        private var fivemin:uint = 300;
        private var muni:uint = 60;
        private var priceOrDate:uint = 0;
        private var orderWay:uint = 1;
        private var _itemToPanelMap:Object;
        private var _itemToBuyBtnMap:Object;
        private var _initArray:Array;
        private var _initArrayIndex:int = 0;
        private var _itemPos:Object;

        public function BlackMarket(param1:DisplayObjectContainer = null)
        {
            this._tabauctionprice = [];
            this._tabauctionplayername = [];
            this._tabauctiontime = [];
            this.auctionitemobjarr = [];
            this._allslotArray = [];
            this._cloneSlotArray = [];
            this._gridMatrix = [];
            this._itemToPanelMap = {};
            this._itemToBuyBtnMap = {};
            this._itemPos = {};
            super(param1);
            trace("initpanel_start", getTimer());
            this.initpanel();
            trace("initpanel_end", getTimer());
            this.initsocket();
            return;
        }// end function

        private function initsocket() : void
        {
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_AUCTION_LIST, this.backauctionitemlist);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_AUCTION_BID, this.backauctionitemerr);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_AUCTION_REBATE, this.backmoneypool);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_ORDER_LIST, this.backsalelist);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_OWN_ORDER_LIST, this.backselflist);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_PEND_ORDER, this.salesuccess);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_BUY_ITEM_FROM_CONSIGNSHOP, this.backsalesuccesss);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_REVOKE_ORDER, this.backcancelsale);
            return;
        }// end function

        private function initpanel() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = null;
            var _loc_8:* = undefined;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = null;
            var _loc_16:* = null;
            resize(500, 390);
            this.title = Config.language("BlackMarket", 1);
            this.btnbar = new ButtonBar(this, 15, 25);
            this.btnbar.addTab(Config.language("BlackMarket", 4), this.panelblack);
            this.btnbar.addTab(Config.language("BlackMarket", 3), this.panela);
            this.btnbar.addTab(Config.language("BlackMarket", 2), this.panelb);
            this.panel = new Sprite();
            this.addChild(this.panel);
            this._mcanvasall = new CanvasUI(null, 120, 110, 370, 243);
            this._slotAllsaleArray = new Array();
            _loc_1 = 0;
            while (_loc_1 < 20)
            {
                
                _loc_11 = new Sprite();
                _loc_12 = new Object();
                this._mcanvasall.addChildUI(_loc_11);
                _loc_11.graphics.beginFill(16777215, 0.4);
                _loc_11.graphics.drawRoundRect(0, 0, 350, 38, 5);
                _loc_11.graphics.endFill();
                _loc_11.x = 8;
                _loc_11.y = _loc_1 * 41;
                _loc_13 = new CloneSlot(0, 32);
                _loc_11.addChild(_loc_13);
                _loc_13.x = 8;
                _loc_13.y = 4;
                _loc_13.addEventListener(MouseEvent.ROLL_OVER, this.auctionhandleSlotOver);
                _loc_13.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
                _loc_14 = Config.getSimpleTextField();
                _loc_14.autoSize = TextFieldAutoSize.RIGHT;
                _loc_14.x = 190;
                _loc_14.y = 10;
                _loc_14.width = 85;
                _loc_11.addChild(_loc_14);
                _loc_15 = new Label(_loc_11, 140, 5, "");
                this._salerNameCL = new ClickLabel(_loc_11, 50, 5, "", null, true);
                this._salerNameCL.clickColor([26367, 6837142]);
                this._salerNameCL.mouseEnabled = true;
                _loc_16 = new PushButton(_loc_11, 295, 10, Config.language("BlackMarket", 9), Config.create(this.buysaleitem, _loc_1));
                _loc_16.width = 50;
                if (_loc_13.item == null)
                {
                    _loc_16.enabled = false;
                }
                _loc_12.saleId = 0;
                _loc_12.price = 0;
                _loc_12.sortTime = 0;
                _loc_12.saleItemPrice = _loc_14;
                _loc_12.saleItemPlayer = "";
                _loc_12._salerNameCL = this._salerNameCL;
                _loc_12.saleItemEnd = _loc_15;
                _loc_12.iconSlotAll = _loc_13;
                _loc_12.buySaleBtn = _loc_16;
                this._slotAllsaleArray.push(_loc_12);
                _loc_1++;
            }
            this._salePanel = new Panel(null, 60, 170);
            this._salePanel.width = 200;
            this._salePanel.height = 175;
            this._salePanel.color = Style.WINDOW;
            this._salePanel.border = 2;
            _loc_2 = new Label(this._salePanel, 30, 15, Config.language("BlackMarket", 10));
            _loc_2 = new Label(this._salePanel, 30, 40, Config.language("BlackMarket", 11));
            _loc_2 = new Label(this._salePanel, 30, 70, Config.language("BlackMarket", 12));
            this.taxPercentText = new Label(this._salePanel, 30, 95, Config.language("BlackMarket", 13));
            this.commissionText = new Label(this._salePanel, 30, 115, Config.language("BlackMarket", 14));
            var _loc_3:* = new PushButton(this._salePanel, 40, 140, Config.language("BlackMarket", 15), this.handleSaleConfirm);
            _loc_3.width = 40;
            var _loc_4:* = new PushButton(this._salePanel, 120, 140, Config.language("BlackMarket", 16), this.handleSaleConsel);
            new PushButton(this._salePanel, 120, 140, Config.language("BlackMarket", 16), this.handleSaleConsel).width = 40;
            this.comboxSale = new ComboBox(this._salePanel, 95, 70, this.getsaletime);
            this.comboxSale.addItem({label:Config.language("BlackMarket", 17), data:0});
            this.comboxSale.addItem({label:Config.language("BlackMarket", 18), data:1});
            this.comboxSale.addItem({label:Config.language("BlackMarket", 19), data:2});
            this.comboxSale.selectedItem = this.comboxSale.itemArray[0];
            this.comboxSale.width = 70;
            this.comboxSale.enabled = true;
            this.comboxSale.editable = false;
            this.sendTime = 1;
            this._salePriceNS = new InputText(this._salePanel, 65, 40, "", this.inputprice);
            this._salePriceNS.height = 20;
            this._salePriceNS.restrict = "0-9";
            var _loc_5:* = [{label:Config.language("BlackMarket", 20), len:80, fuc:"reqLevel"}, {label:Config.language("BlackMarket", 21), len:100, fuc:"nowprice"}, {label:Config.language("BlackMarket", 22), len:90, fuc:"limittime"}, {label:Config.language("BlackMarket", 23), len:60, fuc:"autoaddprice"}, {label:Config.language("BlackMarket", 24), len:60, fuc:"manualaddprice"}, {label:Config.language("BlackMarket", 25), len:102, fuc:"ownerne"}];
            this.togglebtn = new ToggleButtonBarUI(_loc_5);
            var _loc_6:* = [{datafield:"itemname", label:Config.language("BlackMarket", 26), len:50}, {datafield:"playerName", label:Config.language("BlackMarket", 27), len:80}, {datafield:"selltime", label:Config.language("BlackMarket", 28), len:62}, {datafield:"price", label:Config.language("BlackMarket", 29), len:106}, {datafield:"online", label:Config.language("BlackMarket", 30), len:57}];
            this.activtopall = new ToggleButtonBarUI(_loc_6);
            this.activtopall.addEventListener(AccTreeEvent.TOGGLE_SELECT, this.sortallsalelist);
            var _loc_7:* = [{datafield:"itemname", label:Config.language("BlackMarket", 26), len:50}, {datafield:"myiteminfo", label:Config.language("BlackMarket", 31), len:140}, {datafield:"manual", label:Config.language("BlackMarket", 30), len:60}];
            this.activtopmy = new ToggleButtonBarUI(_loc_7);
            this.activtopmy.addEventListener(AccTreeEvent.TOGGLE_SELECT, this.sortmysalelist);
            this.addmysalelist();
            this._cloneBagPanel = new Panel(null, 275, 60);
            this._cloneBagPanel.alpha = 0;
            new Label(this._cloneBagPanel, 0, 0, Config.language("BlackMarket", 5));
            this._slotStartIndex = Config.ui._bagUI._slotStartIndex;
            _loc_8 = this._slotStartIndex;
            while (_loc_8 < this._slotStartIndex + this.bagActiveNumber)
            {
                
                Config.ui._charUI._slotArray[_loc_8].removeEventListener(Event.CHANGE, this.hangleSlotUpdate);
                Config.ui._charUI._slotArray[_loc_8].removeEventListener("lockchange", this.hangleSlotUpdate);
                Config.ui._charUI._slotArray[_loc_8].addEventListener(Event.CHANGE, this.hangleSlotUpdate);
                Config.ui._charUI._slotArray[_loc_8].addEventListener("lockchange", this.hangleSlotUpdate);
                this._cloneSlotArray[_loc_8] = new CloneSlot(_loc_8, 32);
                this._cloneSlotArray[_loc_8].addEventListener(MouseEvent.ROLL_OVER, this.handleCloneSlotOver);
                this._cloneSlotArray[_loc_8].addEventListener(MouseEvent.ROLL_OUT, this.handleCloneSlotOut);
                this._cloneSlotArray[_loc_8].addEventListener("sglClick", this.handleCloneSlotClick);
                this._cloneSlotArray[_loc_8].addEventListener("dblClick", this.handleCloneSlotDoubleClick);
                this._cloneSlotArray[_loc_8].addEventListener("drag", this.handleCloneSlotClick);
                _loc_8 = _loc_8 + 1;
            }
            this.arrange();
            this._cloneLeft = new PushButton(this._cloneBagPanel, 60, 260, "<", this.handleCloneLeft);
            this._cloneLeft.width = 30;
            this._cloneRight = new PushButton(this._cloneBagPanel, 132, 260, ">", this.handleCloneRight);
            this._cloneRight.width = 30;
            var _loc_9:* = Math.ceil(this.bagActiveNumber / (this._gridWidth * this._gridHeight));
            this._clonePageLB = Config.getSimpleTextField();
            this._clonePageLB.defaultTextFormat = new TextFormat(null, 16, Style.WINDOW_FONT, true);
            this._clonePageLB.text = (this._page + 1) + "/" + _loc_9;
            this._clonePageLB.x = 100;
            this._clonePageLB.y = 260;
            this._cloneBagPanel.addChild(this._clonePageLB);
            var _loc_10:* = new PushButton(this._cloneBagPanel, 10, 290, Config.language("BlackMarket", 34), Config.ui._bagUI.handleSort);
            new PushButton(this._cloneBagPanel, 10, 290, Config.language("BlackMarket", 34), Config.ui._bagUI.handleSort).width = 90;
            this.initblackmarket();
            return;
        }// end function

        public function setBagActiveNumber()
        {
            var _loc_2:* = undefined;
            var _loc_1:* = Math.ceil(this.bagActiveNumber / (this._gridWidth * this._gridHeight));
            this._clonePageLB.text = (this._page + 1) + "/" + _loc_1;
            _loc_2 = this._slotStartIndex;
            while (_loc_2 < this._slotStartIndex + this.bagActiveNumber)
            {
                
                if (this._cloneSlotArray[_loc_2] == null)
                {
                    Config.ui._charUI._slotArray[_loc_2].removeEventListener(Event.CHANGE, this.hangleSlotUpdate);
                    Config.ui._charUI._slotArray[_loc_2].removeEventListener("lockchange", this.hangleSlotUpdate);
                    Config.ui._charUI._slotArray[_loc_2].addEventListener(Event.CHANGE, this.hangleSlotUpdate);
                    Config.ui._charUI._slotArray[_loc_2].addEventListener("lockchange", this.hangleSlotUpdate);
                    this._cloneSlotArray[_loc_2] = new CloneSlot(_loc_2, 32);
                    this._cloneSlotArray[_loc_2].addEventListener(MouseEvent.ROLL_OVER, this.handleCloneSlotOver);
                    this._cloneSlotArray[_loc_2].addEventListener(MouseEvent.ROLL_OUT, this.handleCloneSlotOut);
                    this._cloneSlotArray[_loc_2].addEventListener("sglClick", this.handleCloneSlotClick);
                    this._cloneSlotArray[_loc_2].addEventListener("dblClick", this.handleCloneSlotDoubleClick);
                    this._cloneSlotArray[_loc_2].addEventListener("drag", this.handleCloneSlotClick);
                }
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        private function get bagActiveNumber() : int
        {
            return Config.ui._bagUI._bagActiveNumber;
        }// end function

        private function handleCloneSlotOver(param1)
        {
            var _loc_3:* = null;
            var _loc_2:* = param1.currentTarget;
            if (_loc_2.item != null)
            {
                Holder.showInfo(_loc_2.item.outputInfo(), new Rectangle(_loc_2.x + _loc_2.parent.x + _loc_2.parent.parent.x + _loc_2.parent.parent.parent.x, _loc_2.y + _loc_2.parent.y + _loc_2.parent.parent.y + _loc_2.parent.parent.parent.y, _loc_2._size, _loc_2._size), false, 0, 200);
                if (int(_loc_2.item._itemData.suitID) > 0 && int(_loc_2.item._itemData.type) != 18)
                {
                    _loc_3 = _loc_2.parent.localToGlobal(new Point(_loc_2.x, _loc_2.y));
                    Holder.showRightInfo(_loc_2.item.outfitInfo(1), new Rectangle(_loc_3.x, _loc_3.y, _loc_2._size, _loc_2._size));
                }
            }
            return;
        }// end function

        private function handleCloneSlotOut(param1)
        {
            Holder.closeInfo();
            return;
        }// end function

        private function handleCloneLeft(param1)
        {
            var _loc_2:* = Math.ceil(this.bagActiveNumber / (this._gridWidth * this._gridHeight));
            if (this._page > 0)
            {
                var _loc_3:* = this;
                var _loc_4:* = this._page - 1;
                _loc_3._page = _loc_4;
                this._clonePageLB.text = (this._page + 1) + "/" + _loc_2;
                this.arrange();
            }
            return;
        }// end function

        private function handleCloneRight(param1)
        {
            var _loc_2:* = Math.ceil(this.bagActiveNumber / (this._gridWidth * this._gridHeight));
            if (this._page < (_loc_2 - 1))
            {
                var _loc_3:* = this;
                var _loc_4:* = this._page + 1;
                _loc_3._page = _loc_4;
                this._clonePageLB.text = (this._page + 1) + "/" + _loc_2;
                this.arrange();
            }
            return;
        }// end function

        public function hangleSlotUpdate(param1)
        {
            this._cloneSlotArray[param1.target._id].item = param1.target.item;
            if (param1.target._locked)
            {
                this._cloneSlotArray[param1.target._id].lock();
            }
            else
            {
                this._cloneSlotArray[param1.target._id].unlock();
            }
            if (this._cloneSlotArray[param1.target._id].item != null)
            {
                if (this._cloneSlotArray[param1.target._id].item._itemData.binding == 1)
                {
                    this._cloneSlotArray[param1.target._id].lock();
                }
            }
            return;
        }// end function

        private function handleCloneSlotClick(event:MouseEvent)
        {
            var _loc_2:* = event.currentTarget;
            if (Holder.item == null)
            {
                if (_loc_2.item != null)
                {
                    Holder.item = _loc_2.item;
                }
            }
            else
            {
                Config.ui._charUI._slotArray[Holder.item._position].item = Holder.item;
                Holder.item = null;
            }
            return;
        }// end function

        private function handleCloneSlotDoubleClick(event:MouseEvent)
        {
            var _loc_2:* = event.currentTarget;
            if (_loc_2.item != null)
            {
                if (_loc_2.item._drawer == Config.ui._charUI._slotArray)
                {
                    if (Config.ui._charUI.getPosite(_loc_2.item._position) == 1)
                    {
                        if (_loc_2.item._itemData.binding != 1)
                        {
                            this.openSale(_loc_2.item);
                        }
                        else
                        {
                            Config.message(Config.language("BlackMarket", 35));
                        }
                    }
                    else if (Config.ui._charUI.getPosite(_loc_2.item._position) == 2)
                    {
                        Config.message(Config.language("BlackMarket", 36));
                    }
                    else if (Config.ui._charUI.getPosite(_loc_2.item._position) == 3)
                    {
                        Config.message(Config.language("BlackMarket", 37));
                    }
                }
            }
            return;
        }// end function

        public function arrange() : void
        {
            var _loc_1:* = undefined;
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
                            this._cloneBagPanel.removeChild(this._gridMatrix[_loc_1][_loc_2]);
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
            var _loc_5:* = 0;
            _loc_3 = 0;
            _loc_2 = _loc_5;
            _loc_1 = _loc_5;
            _loc_4 = this._page * this._gridWidth * this._gridHeight + this._slotStartIndex;
            _loc_3 = _loc_4;
            while (_loc_3 < this._slotStartIndex + this.bagActiveNumber)
            {
                
                this._gridMatrix[_loc_1][_loc_2] = this._cloneSlotArray[_loc_3];
                this._gridMatrix[_loc_1][_loc_2].x = _loc_1 * 37;
                this._gridMatrix[_loc_1][_loc_2].y = _loc_2 * 37 + 26;
                this._cloneBagPanel.addChild(this._gridMatrix[_loc_1][_loc_2]);
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

        override public function open(event:MouseEvent = null)
        {
            this.finishInitLoop();
            this.panelblack();
            super.open();
            return;
        }// end function

        override public function close()
        {
            this.destroyitem();
            clearInterval(this._minTimer);
            this.btnbar.selectpage = 0;
            this.pg = 1;
            super.close();
            return;
        }// end function

        private function panela(event:MouseEvent = null) : void
        {
            this.initsalepanel();
            this.sendallsale();
            dispatchEvent(new ObEvent("page:1"));
            return;
        }// end function

        private function initsalepanel()
        {
            this.clearpanel();
            this.btnbar.selectpage = 1;
            if (this._salePanel.parent == this)
            {
                removeChild(this._salePanel);
            }
            if (this.selsctflag != -1)
            {
                this.selsctflag = -1;
            }
            var _loc_1:* = "";
            var _loc_2:* = 0;
            this.panelobj = new Object();
            new Label(this.panel, 340, 25, Config.language("BlackMarket", 38) + Config.coinShow(Config.player.money4));
            var _loc_3:* = new InputText(this.panel, 10, 55, Config.language("BlackMarket", 39));
            _loc_3._tf.removeEventListener(FocusEvent.FOCUS_IN, this.judage);
            _loc_3._tf.addEventListener(FocusEvent.FOCUS_IN, this.judage);
            _loc_3.maxChars = 10;
            _loc_3.width = 95;
            this.panelobj.nameinput = _loc_3;
            this.inputname = new InputText(this.panel, 280, 55, Config.language("BlackMarket", 40));
            this.inputname._tf.removeEventListener(FocusEvent.FOCUS_IN, this.judage);
            this.inputname._tf.addEventListener(FocusEvent.FOCUS_IN, this.judage);
            this.inputname.maxChars = 12;
            this.inputname.width = 110;
            this.panelobj.inputname = this.inputname;
            var _loc_4:* = new Label(this.panel, 120, 55, Config.language("BlackMarket", 41));
            this.lbinput = new InputText(this.panel, 175, 55, "0", this.lbinputchange);
            this.lbinput.restrict = "0-9";
            this.lbinput.width = 30;
            this.lbinput.maxChars = 3;
            this.panelobj.minlevel = this.lbinput;
            var _loc_5:* = new Label(this.panel, 210, 55, Config.language("BlackMarket", 103));
            this.lb2input = new InputText(this.panel, 230, 55, "120", this.lb2inputchange);
            this.lb2input.restrict = "0-9";
            this.lb2input.width = 30;
            this.lb2input.maxChars = 3;
            this.panelobj.maxlevel = this.lb2input;
            this.panel.addChild(this.activtopall);
            this.activtopall.x = 125;
            this.activtopall.y = 85;
            this.panel.addChild(this._mcanvasall);
            var _loc_6:* = new PushButton(this.panel, 400, 55, Config.language("BlackMarket", 42), this.sendtzlist);
            new PushButton(this.panel, 400, 55, Config.language("BlackMarket", 42), this.sendtzlist).width = 80;
            var _loc_7:* = new AccordionTree(this.panel, 10, 85, 110, 280);
            var _loc_8:* = new XML();
            _loc_8 = Config._itemIndexType[0].copy();
            var _loc_9:* = new XMLList();
            _loc_9 = _loc_8.itemlist[1].children();
            _loc_7.dataProvider = _loc_8;
            _loc_7.removeEventListener(AccTreeEvent.TREE_SELECT, this.typeselect);
            _loc_7.addEventListener(AccTreeEvent.TREE_SELECT, this.typeselect);
            var _loc_10:* = new PushButton(this.panel, 230, 360, "<", Config.create(this.changepage, 2));
            new PushButton(this.panel, 230, 360, "<", Config.create(this.changepage, 2)).width = 30;
            var _loc_11:* = new PushButton(this.panel, 302, 360, ">", Config.create(this.changepage, 3));
            new PushButton(this.panel, 302, 360, ">", Config.create(this.changepage, 3)).width = 30;
            this.pagelabel = Config.getSimpleTextField();
            this.pagelabel.defaultTextFormat = new TextFormat(null, 16, Style.WINDOW_FONT, true);
            this.pagelabel.text = "1/1";
            this.pagelabel.x = 260;
            this.pagelabel.y = 360;
            this.pagelabel.width = 42;
            this.pagelabel.autoSize = TextFieldAutoSize.CENTER;
            this.panel.addChild(this.pagelabel);
            var _loc_12:* = new PushButton(this.panel, 375, 360, Config.language("BlackMarket", 45), this.panels);
            new PushButton(this.panel, 375, 360, Config.language("BlackMarket", 45), this.panels).setTable("table18", "table31");
            _loc_12.textColor = Style.GOLD_FONT;
            _loc_12.overshow = true;
            _loc_12.width = 100;
            return;
        }// end function

        private function sendallsale()
        {
            var _loc_1:* = new DataSet();
            _loc_1.addHead(CONST_ENUM.C2G_ORDER_LIST);
            _loc_1.add32(0);
            _loc_1.add32(20);
            _loc_1.add32(0);
            _loc_1.add32(0);
            _loc_1.addUTF("");
            _loc_1.add16(0);
            _loc_1.add16(99);
            _loc_1.addUTF("");
            _loc_1.add8(0);
            _loc_1.add8(1);
            ClientSocket.send(_loc_1);
            return;
        }// end function

        public function sendsalename(param1:String) : void
        {
            super.open();
            this.initsalepanel();
            this.inputname.text = param1;
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_ORDER_LIST);
            _loc_2.add32(0);
            _loc_2.add32(20);
            _loc_2.add32(0);
            _loc_2.add32(0);
            _loc_2.addUTF("");
            _loc_2.add16(0);
            _loc_2.add16(99);
            _loc_2.addUTF(param1);
            _loc_2.add8(0);
            _loc_2.add8(1);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function judage(param1) : void
        {
            param1.target.text = "";
            param1.target.removeEventListener(FocusEvent.FOCUS_IN, this.judage);
            return;
        }// end function

        public function panelb(event:MouseEvent = null) : void
        {
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            this.clearpanel();
            if (this._salePanel.parent == this)
            {
                removeChild(this._salePanel);
            }
            this.btnbar.selectpage = 2;
            if (this.selsctflag != -1)
            {
                this.selsctflag = -1;
            }
            clearInterval(this._minTimer);
            this._minTimer = setInterval(this.minTimerfun, 60000);
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_AUCTION_LIST);
            ClientSocket.send(_loc_2);
            this.togglebtn.x = 3;
            this.togglebtn.y = 60;
            this.panel.addChild(this.togglebtn);
            var _loc_3:* = new Shape();
            _loc_3.graphics.lineStyle(0);
            _loc_3.graphics.moveTo(5, 84);
            _loc_3.graphics.lineTo(495, 84);
            this.panel.addChild(_loc_3);
            var _loc_4:* = new Shape();
            new Shape().graphics.lineStyle(0);
            _loc_4.graphics.moveTo(5, 355);
            _loc_4.graphics.lineTo(495, 355);
            this.panel.addChild(_loc_4);
            this._slotArray = new Array();
            this.autoaddArr = new Array();
            this.manualaddArr = new Array();
            var _loc_5:* = 0;
            while (_loc_5 < 6)
            {
                
                _loc_10 = new CloneSlot(0, 32);
                this.panel.addChild(_loc_10);
                _loc_10.x = 27;
                _loc_10.y = 90 + _loc_5 * 40;
                _loc_10.addEventListener(MouseEvent.ROLL_OVER, this.auctionhandleSlotOver);
                _loc_10.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
                this._slotArray.push(_loc_10);
                _loc_11 = new Sprite();
                _loc_11.graphics.lineStyle(0);
                _loc_11.graphics.moveTo(5, 126 + _loc_5 * 40);
                _loc_11.graphics.lineTo(495, 126 + _loc_5 * 40);
                this.panel.addChild(_loc_11);
                _loc_12 = new PushButton(this.panel, 282, 95 + _loc_5 * 40, Config.language("BlackMarket", 6), this.clickautoaddprice);
                _loc_12.name = _loc_5.toString();
                _loc_12.width = 40;
                _loc_12.enabled = false;
                this.autoaddArr[_loc_5] = _loc_12;
                _loc_13 = new PushButton(this.panel, 342, 95 + _loc_5 * 40, Config.language("BlackMarket", 46), this.ckickmanualaddprice);
                _loc_13.name = _loc_5.toString();
                _loc_13.width = 40;
                _loc_13.enabled = false;
                this.manualaddArr[_loc_5] = _loc_13;
                this.tlabeprice = Config.getSimpleTextField();
                this.tlabetime = Config.getSimpleTextField();
                this.tlabepname = Config.getSimpleTextField();
                this.tlabeprice.y = 95 + _loc_5 * 40;
                this.tlabetime.y = 95 + _loc_5 * 40;
                this.tlabepname.y = 95 + _loc_5 * 40;
                this.tlabeprice.x = 80;
                this.tlabetime.x = 180;
                this.tlabepname.x = 390;
                this.tlabeprice.width = 100;
                this.tlabetime.width = 90;
                this.tlabepname.width = 100;
                this.tlabeprice.autoSize = TextFieldAutoSize.CENTER;
                this.tlabetime.autoSize = TextFieldAutoSize.CENTER;
                this.tlabepname.autoSize = TextFieldAutoSize.CENTER;
                this._tabauctionprice[_loc_5] = this.tlabeprice;
                this._tabauctiontime[_loc_5] = this.tlabetime;
                this._tabauctionplayername[_loc_5] = this.tlabepname;
                this.panel.addChild(this.tlabeprice);
                this.panel.addChild(this.tlabetime);
                this.panel.addChild(this.tlabepname);
                _loc_5 = _loc_5 + 1;
            }
            var _loc_6:* = new PushButton(this.panel, 380, 360, Config.language("BlackMarket", 47), this.sendmoneyback);
            new PushButton(this.panel, 380, 360, Config.language("BlackMarket", 47), this.sendmoneyback).width = 60;
            var _loc_7:* = new PushButton(this.panel, 200, 330, "<", Config.create(this.goheadinfo, 2));
            var _loc_8:* = new PushButton(this.panel, 272, 330, ">", Config.create(this.goheadinfo, 3));
            _loc_7.width = 30;
            _loc_8.width = 30;
            this.tabel = Config.getSimpleTextField();
            this.tabel.defaultTextFormat = new TextFormat(null, 16, Style.WINDOW_FONT, true);
            this.tabel.x = 230;
            this.tabel.y = 330;
            this.tabel.width = 42;
            this.tabel.autoSize = TextFieldAutoSize.CENTER;
            this.panel.addChild(this.tabel);
            var _loc_9:* = Config.getSimpleTextField();
            Config.getSimpleTextField().defaultTextFormat = new TextFormat(null, 16, Style.WINDOW_FONT, true);
            _loc_9.text = Config.language("BlackMarket", 48);
            _loc_9.x = 195;
            _loc_9.y = 360;
            this.panel.addChild(_loc_9);
            this.pooltable = new InputText(this.panel, 265, 360, "0");
            this.pooltable._tf.selectable = false;
            dispatchEvent(new ObEvent("page:2"));
            return;
        }// end function

        private function panels(event:MouseEvent)
        {
            this.clearpanel();
            this.panel.addChild(this.activtopmy);
            this.panel.addChild(this._mcanvasmy);
            this.panel.addChild(this._cloneBagPanel);
            this.activtopmy.x = 5;
            this.activtopmy.y = 80;
            var _loc_2:* = new Label(this.panel, 15, 55);
            _loc_2.html = true;
            _loc_2.text = "<b><font SIZE=\'16\'>" + Config.language("BlackMarket", 7) + "</font></b>";
            this.allSale = new PushButton(this._cloneBagPanel, 120, 290, Config.language("BlackMarket", 8), this.panela);
            this.allSale.width = 90;
            var _loc_3:* = new DataSet();
            _loc_3.addHead(CONST_ENUM.C2G_OWN_ORDER_LIST);
            ClientSocket.send(_loc_3);
            return;
        }// end function

        private function backsalelist(event:SocketEvent)
        {
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            var _loc_4:* = _loc_2.readUnsignedInt();
            var _loc_5:* = _loc_2.readUnsignedInt();
            _loc_6 = 0;
            while (_loc_6 < 20)
            {
                
                if (this._slotAllsaleArray[_loc_6].iconSlotAll.item != null)
                {
                    this._slotAllsaleArray[_loc_6]._salerNameCL.removeEventListener(TextEvent.LINK, Config.create(this.clickname, this._slotAllsaleArray[_loc_6]._salerNameCL.text));
                    this._slotAllsaleArray[_loc_6].iconSlotAll.item.destroy();
                    this._slotAllsaleArray[_loc_6].iconSlotAll.item = null;
                    this._slotAllsaleArray[_loc_6].saleItemPrice.text = "";
                    this._slotAllsaleArray[_loc_6].saleItemEnd.text = "";
                    this._slotAllsaleArray[_loc_6]._salerNameCL.text = "";
                    this._slotAllsaleArray[_loc_6].buySaleBtn.enabled = false;
                }
                _loc_6 = _loc_6 + 1;
            }
            _loc_6 = 0;
            while (_loc_6 < _loc_5)
            {
                
                this._slotAllsaleArray[_loc_6].saleId = _loc_2.readUnsignedInt();
                _loc_7 = _loc_2.readUnsignedShort();
                _loc_8 = _loc_2.readUTFBytes(_loc_7);
                _loc_9 = _loc_2.readUnsignedInt();
                _loc_10 = _loc_2.readUnsignedInt();
                _loc_11 = Item.createItemByBytes(_loc_2, this._slotAllsaleArray[_loc_6].saleId, UNIT_TYPE_ENUM.TYPEID_ITEM_SALE);
                if (_loc_10 > 0)
                {
                    if (_loc_10 < this.fivemin)
                    {
                        _loc_12 = Config.language("BlackMarket", 49);
                    }
                    else if (_loc_10 < this.hour)
                    {
                        _loc_12 = int(_loc_10 / this.muni) + Config.language("BlackMarket", 50);
                    }
                    else if (_loc_10 < this.day)
                    {
                        _loc_12 = int(_loc_10 / this.hour) + Config.language("BlackMarket", 51);
                    }
                    else if (_loc_10 >= this.day)
                    {
                        _loc_12 = int(_loc_10 / this.day) + Config.language("BlackMarket", 52);
                    }
                }
                else if (_loc_10 == 0)
                {
                    _loc_12 = Config.language("BlackMarket", 53);
                }
                _loc_11.display();
                this._slotAllsaleArray[_loc_6].iconSlotAll.item = _loc_11;
                this._slotAllsaleArray[_loc_6].price = _loc_9;
                this._slotAllsaleArray[_loc_6]._salerNameCL.text = _loc_8;
                if (Config.player == null || Config.player.name != _loc_8)
                {
                    this._slotAllsaleArray[_loc_6]._salerNameCL.addEventListener(TextEvent.LINK, Config.create(this.clickname, _loc_8));
                    this._slotAllsaleArray[_loc_6]._salerNameCL.clickColor([26367, 6837142]);
                }
                else
                {
                    this._slotAllsaleArray[_loc_6]._salerNameCL.clickColor([Style.WINDOW_FONT, Style.WINDOW_FONT]);
                }
                if (_loc_9 < 10000)
                {
                    this._slotAllsaleArray[_loc_6].saleItemPrice.textColor = 0;
                    this._slotAllsaleArray[_loc_6].saleItemPrice.text = Config.coinShow(_loc_9);
                }
                else if (_loc_9 < 1000000)
                {
                    this._slotAllsaleArray[_loc_6].saleItemPrice.textColor = 255;
                    this._slotAllsaleArray[_loc_6].saleItemPrice.text = Config.coinShow(_loc_9);
                }
                else if (_loc_9 < 100000000)
                {
                    this._slotAllsaleArray[_loc_6].saleItemPrice.textColor = 3774309;
                    this._slotAllsaleArray[_loc_6].saleItemPrice.text = Config.coinShow(_loc_9);
                }
                else
                {
                    this._slotAllsaleArray[_loc_6].saleItemPrice.textColor = 16724787;
                    this._slotAllsaleArray[_loc_6].saleItemPrice.text = Config.coinShow(_loc_9);
                }
                this._slotAllsaleArray[_loc_6].sortTime = _loc_10;
                this._slotAllsaleArray[_loc_6].saleItemEnd.text = _loc_12;
                this._slotAllsaleArray[_loc_6].buySaleBtn.enabled = true;
                _loc_6 = _loc_6 + 1;
            }
            this._mcanvasall.verticalScrollPosition = 0;
            this.pagelabel.text = _loc_4 + "/" + _loc_3;
            this.panelobj.page = _loc_4;
            this.panelobj.allpage = _loc_3;
            return;
        }// end function

        private function addmysalelist()
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            this._slotMysaleArray = new Array();
            this._mcanvasmy = new CanvasUI(null, 5, 105, 265, 265);
            var _loc_1:* = 0;
            while (_loc_1 < 20)
            {
                
                _loc_2 = new Object();
                _loc_3 = new Sprite();
                this._mcanvasmy.addChildUI(_loc_3);
                _loc_3.graphics.beginFill(16777215, 0.4);
                _loc_3.graphics.drawRoundRect(0, 0, 250, 40, 5);
                _loc_3.graphics.endFill();
                _loc_3.x = 5;
                _loc_3.y = _loc_1 * 45;
                _loc_4 = new CloneSlot(0, 32);
                this._mcanvasmy.addEventListener(MouseEvent.MOUSE_UP, this.salehandleSlotClick);
                _loc_4.addEventListener(MouseEvent.ROLL_OVER, this.auctionhandleSlotOver);
                _loc_4.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
                _loc_3.addChild(_loc_4);
                _loc_4.x = 6;
                _loc_4.y = 5;
                _loc_5 = new Label(_loc_3, 70, 5);
                _loc_5.html = true;
                _loc_6 = new PushButton(_loc_3, 195, 10, Config.language("BlackMarket", 55), Config.create(this.cancelsaleitem, _loc_1));
                _loc_6.width = 50;
                if (_loc_4.item == null)
                {
                    _loc_6.enabled = false;
                }
                else
                {
                    _loc_6.enabled = true;
                }
                _loc_2.saleId = 0;
                _loc_2.infoText = _loc_5;
                _loc_2.iconSlot = _loc_4;
                _loc_2.canBtn = _loc_6;
                _loc_2.price = 0;
                this._slotMysaleArray.push(_loc_2);
                _loc_1++;
            }
            return;
        }// end function

        private function buysaleitem(event:MouseEvent, param2:uint)
        {
            var _loc_3:* = null;
            if (this._slotAllsaleArray[param2].buySaleBtn.enabled)
            {
                _loc_3 = new Object();
                _loc_3.item = this._slotAllsaleArray[param2].iconSlotAll.item;
                _loc_3.id = int(this._slotAllsaleArray[param2].iconSlotAll.item._itemData.id);
                _loc_3.saleId = this._slotAllsaleArray[param2].saleId;
                _loc_3.goldcoin = this._slotAllsaleArray[param2].price;
                _loc_3.moneyflag = 6;
                Config.ui._shopbuy.initdata(_loc_3);
                Config.ui._shopbuy.x = this.x + 230;
                Config.ui._shopbuy.y = this.y;
                Config.ui._shopbuy.open();
            }
            return;
        }// end function

        public function sendsalebuy(param1:int, param2:int)
        {
            var _loc_3:* = null;
            if (param2 > 0)
            {
                _loc_3 = new DataSet();
                _loc_3.addHead(CONST_ENUM.C2G_BUY_ITEM_FROM_CONSIGNSHOP);
                _loc_3.add32(param1);
                _loc_3.add16(param2);
                ClientSocket.send(_loc_3);
            }
            else
            {
                Config.message(Config.language("BlackMarket", 56));
            }
            return;
        }// end function

        private function backsalesuccesss(event:SocketEvent)
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            var _loc_4:* = _loc_2.readUnsignedShort();
            this.sendtzlist();
            return;
        }// end function

        private function backselflist(event:SocketEvent)
        {
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readByte();
            _loc_4 = 0;
            while (_loc_4 < 20)
            {
                
                if (this._slotMysaleArray[_loc_4].iconSlot.item != null)
                {
                    this._slotMysaleArray[_loc_4].iconSlot.item.destroy();
                    this._slotMysaleArray[_loc_4].iconSlot.item = null;
                    this._slotMysaleArray[_loc_4].infoText.text = "";
                    this._slotMysaleArray[_loc_4].price = 0;
                    this._slotMysaleArray[_loc_4].canBtn.enabled = false;
                }
                _loc_4 = _loc_4 + 1;
            }
            _loc_4 = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = _loc_2.readUnsignedInt();
                _loc_6 = _loc_2.readUnsignedInt();
                _loc_7 = _loc_2.readUnsignedInt();
                _loc_8 = Item.createItemByBytes(_loc_2, _loc_5, UNIT_TYPE_ENUM.TYPEID_ITEM_SALE);
                if (_loc_7 > 0)
                {
                    if (_loc_7 < this.fivemin)
                    {
                        _loc_9 = Config.language("BlackMarket", 49);
                    }
                    else if (_loc_7 < this.hour)
                    {
                        _loc_9 = int(_loc_7 / this.muni) + Config.language("BlackMarket", 50);
                    }
                    else if (_loc_7 < this.day)
                    {
                        _loc_9 = int(_loc_7 / this.hour) + Config.language("BlackMarket", 51);
                    }
                    else if (_loc_7 >= this.day)
                    {
                        _loc_9 = int(_loc_7 / this.day) + Config.language("BlackMarket", 52);
                    }
                }
                else if (_loc_7 <= 0)
                {
                    _loc_9 = Config.language("BlackMarket", 53);
                }
                if (_loc_6 < 10000)
                {
                    _loc_9 = Config.language("BlackMarket", 57) + Config.coinShow(_loc_6) + Config.language("BlackMarket", 58) + _loc_9;
                }
                else if (_loc_6 < 1000000)
                {
                    _loc_9 = Config.language("BlackMarket", 57) + "<font color=\'#0000ff\'>" + Config.coinShow(_loc_6) + "</font>" + Config.language("BlackMarket", 58) + _loc_9;
                }
                else if (_loc_6 < 100000000)
                {
                    _loc_9 = Config.language("BlackMarket", 57) + "<font color=\'#399765\'>" + Config.coinShow(_loc_6) + "</font>" + Config.language("BlackMarket", 58) + _loc_9;
                }
                else
                {
                    _loc_9 = Config.language("BlackMarket", 57) + "<font color=\'#ff3333\'>" + Config.coinShow(_loc_6) + "</font>" + Config.language("BlackMarket", 58) + _loc_9;
                }
                _loc_8.display();
                this._slotMysaleArray[_loc_4].saleId = _loc_5;
                this._slotMysaleArray[_loc_4].iconSlot.item = _loc_8;
                this._slotMysaleArray[_loc_4].infoText.text = _loc_9;
                this._slotMysaleArray[_loc_4].price = _loc_6;
                this._slotMysaleArray[_loc_4].canBtn.enabled = true;
                _loc_4 = _loc_4 + 1;
            }
            return;
        }// end function

        private function clickautoaddprice(event:MouseEvent) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_2:* = event.currentTarget;
            if (_loc_2.enabled)
            {
                if (this.putpricepanel != null)
                {
                    this.putpricepanel.close();
                }
                this.ii = int(parseInt(_loc_2.name));
                this.putpricepanel = new Window(this.container, this.x + 20, this.y + 50);
                this.putpricepanel.title = Config.language("BlackMarket", 59);
                this.putpricepanel.resize(205, 135);
                _loc_3 = new Label(this.putpricepanel, 10, 30);
                _loc_3.html = true;
                _loc_3.text = Config.language("BlackMarket", 60) + this.auctionitemobjarr[this.ii]._auctionprice + Config.language("BlackMarket", 61) + int(this.auctionitemobjarr[this.ii]._auctionprice * 1.05);
                this._auctionewprice = int(this.auctionitemobjarr[this.ii]._auctionprice * 1.05);
                _loc_4 = new PushButton(this.putpricepanel, 25, 95, Config.language("BlackMarket", 62), Config.create(this.confirmprice, this.ii, int(this.auctionitemobjarr[this.ii]._auctionprice)));
                _loc_5 = new PushButton(this.putpricepanel, 112, 95, Config.language("BlackMarket", 63), this.conselprice);
                _loc_4.width = 60;
                _loc_5.width = 60;
                this.putpricepanel.open();
            }
            return;
        }// end function

        private function conselprice(event:MouseEvent)
        {
            this.putpricepanel.close();
            return;
        }// end function

        private function ckickmanualaddprice(event:MouseEvent) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_2:* = event.currentTarget;
            if (_loc_2.enabled)
            {
                this.ii = int(parseInt(_loc_2.name));
                if (this.putpricepanel != null)
                {
                    this.putpricepanel.close();
                }
                this.putpricepanel = new Window(this.container, this.x + 20, this.y + 50);
                this.addChild(this.putpricepanel);
                this.putpricepanel.title = Config.language("BlackMarket", 64);
                this.putpricepanel.resize(205, 135);
                _loc_3 = new Label(this.putpricepanel, 10, 30);
                _loc_3.text = Config.language("BlackMarket", 65) + this.auctionitemobjarr[this.ii]._auctionprice + "\n\n" + Config.language("BlackMarket", 66);
                this._priceput = new InputText(this.putpricepanel, 50, 60, "", Config.create(this.inputAmount, int(this.auctionitemobjarr[this.ii]._auctionprice)));
                this._priceput.setSize(80, 20);
                this._priceput.restrict = "0-9";
                _loc_4 = new PushButton(this.putpricepanel, 25, 100, Config.language("BlackMarket", 62), Config.create(this.confirmprice, this.ii, int(this.auctionitemobjarr[this.ii]._auctionprice)));
                _loc_5 = new PushButton(this.putpricepanel, 110, 100, Config.language("BlackMarket", 63), this.conselprice);
                _loc_4.width = 60;
                _loc_5.width = 60;
                this.putpricepanel.open();
            }
            return;
        }// end function

        private function inputAmount(param1, param2:int)
        {
            if (parseInt(this._priceput.text) < 1 || this._priceput.text == null || this._priceput.text == "")
            {
                this._priceput.text = "1";
            }
            else if (parseInt(this._priceput.text) >= Config.player.money4)
            {
                this._priceput.text = Config.player.money4;
            }
            else
            {
                this._priceput.text = parseInt(this._priceput.text).toString();
            }
            this._auctionewprice = int(parseInt(this._priceput.text));
            return;
        }// end function

        private function sendmoneyback(event:MouseEvent) : void
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_AUCTION_REBATE);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function clearauctionitem()
        {
            var _loc_1:* = 0;
            if (this._allslotArray != null)
            {
                _loc_1 = 0;
                while (_loc_1 < this._allslotArray.length)
                {
                    
                    if (this._allslotArray[_loc_1].item != null)
                    {
                        this._allslotArray[_loc_1].item.destroy();
                    }
                    _loc_1++;
                }
            }
            return;
        }// end function

        private function backauctionitemlist(event:SocketEvent) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = undefined;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_4:* = event.data;
            this._itemnum = _loc_4.readUnsignedInt();
            this.clearauctionitem();
            this.auctionitemobjarr = [];
            this._allslotArray = [];
            _loc_2 = 0;
            while (_loc_2 < this._itemnum)
            {
                
                _loc_5 = new Object();
                _loc_5._auctionID = _loc_4.readUnsignedInt();
                _loc_5._itemID = _loc_4.readUnsignedInt();
                _loc_5._auctionquality = _loc_4.readUnsignedInt();
                _loc_5._auctionnumber = _loc_4.readUnsignedInt();
                _loc_5._auctionprice = _loc_4.readUnsignedInt();
                _loc_6 = _loc_4.readUnsignedShort();
                _loc_5._auctionplayername = _loc_4.readUTFBytes(_loc_6);
                _loc_5._auctionstate = _loc_4.readByte();
                _loc_5._auctiontime = _loc_4.readUnsignedInt();
                _loc_7 = _loc_4.readUnsignedInt();
                _loc_8 = _loc_4.readUnsignedShort();
                _loc_5.item = Item.createItemByBytes(_loc_4, _loc_5._auctionID, UNIT_TYPE_ENUM.TYPEID_ITEM_AUCTION);
                _loc_5.item._position = _loc_8;
                _loc_5.item.amount = _loc_5._auctionnumber;
                _loc_5.item.display();
                this._allslotArray[_loc_2] = _loc_5;
                _loc_2 = _loc_2 + 1;
            }
            this.pagetotal = (this._allslotArray.length - 1) / 6 + 1;
            if (this.pg > this.pagetotal || this.pg == 0 && this.pagetotal != 0)
            {
                if (this.pagetotal == 0)
                {
                    this.pg = 0;
                }
                else
                {
                    this.pg = 1;
                }
            }
            this.tabel.text = this.pg + "/" + this.pagetotal;
            this._allslotArray.sortOn("_auctiontime", Array.DESCENDING | Array.NUMERIC);
            _loc_2 = (this.pg - 1) * 6;
            _loc_3 = 0;
            while (_loc_2 < this._allslotArray.length)
            {
                
                if (this._slotArray != null)
                {
                    if (this._slotArray[_loc_3] != null)
                    {
                        if (_loc_2 < (this.pg - 1) * 6 + 6)
                        {
                            this._slotArray[_loc_3].item = this._allslotArray[_loc_2].item;
                            this.auctionitemobjarr.push(this._allslotArray[_loc_2]);
                            this.autoaddArr[_loc_3].enabled = true;
                            this.manualaddArr[_loc_3].enabled = true;
                        }
                    }
                }
                _loc_2 = _loc_2 + 1;
                _loc_3 = _loc_3 + 1;
            }
            this.showauctionlist();
            this._backmoneypool = _loc_4.readUnsignedInt();
            this.pooltable._tf.text = String(this._backmoneypool);
            return;
        }// end function

        private function showauctionlist()
        {
            var _loc_1:* = 0;
            while (_loc_1 < this.auctionitemobjarr.length)
            {
                
                this._tabauctionprice[_loc_1].text = Config.coinShow(this.auctionitemobjarr[_loc_1]._auctionprice);
                if (this.auctionitemobjarr[_loc_1]._auctionstate == 0)
                {
                    if (this.auctionitemobjarr[_loc_1]._auctiontime < this.fivemin)
                    {
                        this._tabauctiontime[_loc_1].text = Config.language("BlackMarket", 49);
                    }
                    else if (this.auctionitemobjarr[_loc_1]._auctiontime < this.hour)
                    {
                        this._tabauctiontime[_loc_1].text = int(this.auctionitemobjarr[_loc_1]._auctiontime / this.muni) + Config.language("BlackMarket", 50);
                    }
                    else if (this.auctionitemobjarr[_loc_1]._auctiontime < this.day)
                    {
                        this._tabauctiontime[_loc_1].text = int(this.auctionitemobjarr[_loc_1]._auctiontime / this.hour) + Config.language("BlackMarket", 51) + int(this.auctionitemobjarr[_loc_1]._auctiontime % this.hour / this.muni) + Config.language("BlackMarket", 50);
                    }
                    else if (this.auctionitemobjarr[_loc_1]._auctiontime >= this.day)
                    {
                        this._tabauctiontime[_loc_1].text = int(this.auctionitemobjarr[_loc_1]._auctiontime / this.day) + Config.language("BlackMarket", 52) + int(this.auctionitemobjarr[_loc_1]._auctiontime % this.day / this.hour) + Config.language("BlackMarket", 51);
                    }
                    if (this.auctionitemobjarr[_loc_1]._auctionprice >= 2000000000)
                    {
                        this.autoaddArr[_loc_1].enabled = false;
                        this.manualaddArr[_loc_1].enabled = false;
                    }
                }
                else if (this.auctionitemobjarr[_loc_1]._auctionstate == 1)
                {
                    this._tabauctiontime[_loc_1].text = Config.language("BlackMarket", 53);
                    this.autoaddArr[_loc_1].enabled = false;
                    this.manualaddArr[_loc_1].enabled = false;
                }
                else if (this.auctionitemobjarr[_loc_1]._auctionstate == 2)
                {
                    this._tabauctiontime[_loc_1].text = Config.language("BlackMarket", 67);
                    this.autoaddArr[_loc_1].enabled = false;
                    this.manualaddArr[_loc_1].enabled = false;
                }
                this._tabauctionplayername[_loc_1].text = "" + this.auctionitemobjarr[_loc_1]._auctionplayername;
                _loc_1 = _loc_1 + 1;
            }
            return;
        }// end function

        private function confirmprice(event:MouseEvent, param2, param3)
        {
            var _loc_4:* = null;
            if (this.auctionitemobjarr[param2]._auctionstate != 1 || this.auctionitemobjarr[param2]._auctionstate != 2)
            {
                if (this.putpricepanel != null)
                {
                    this.putpricepanel.close();
                }
                _loc_4 = new DataSet();
                _loc_4.addHead(CONST_ENUM.C2G_AUCTION_BID);
                _loc_4.add32(this.auctionitemobjarr[param2]._auctionID);
                _loc_4.add32(this._auctionewprice);
                ClientSocket.send(_loc_4);
            }
            return;
        }// end function

        private function backauctionitemerr(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = new Object();
            _loc_3._auctionID = _loc_2.readUnsignedInt();
            var _loc_4:* = _loc_2.readByte();
            switch(_loc_4)
            {
                case 0:
                {
                    this.minTimerfun();
                    Config.message(Config.language("BlackMarket", 68));
                    break;
                }
                case 1:
                {
                    Config.message(Config.language("BlackMarket", 69));
                    break;
                }
                case 2:
                {
                    Config.message(Config.language("BlackMarket", 70));
                    this.openalert();
                    break;
                }
                case 3:
                {
                    Config.message(Config.language("BlackMarket", 71));
                    break;
                }
                case 4:
                {
                    Config.message(Config.language("BlackMarket", 72));
                    break;
                }
                case 5:
                {
                    Config.message(Config.language("BlackMarket", 97));
                    break;
                }
                default:
                {
                    break;
                }
            }
            _loc_3._auctionprice = _loc_2.readUnsignedInt();
            _loc_3._auctiontime = _loc_2.readUnsignedInt();
            return;
        }// end function

        public function openalert()
        {
            AlertUI.alert(Config.language("BlackMarket", 98), Config.language("BlackMarket", 99), [Config.language("BlackMarket", 62), Config.language("BlackMarket", 63)], [this.openshopui]);
            return;
        }// end function

        private function openshopui(param1)
        {
            Config.ui._shopmail.openListPanel(3);
            Config.ui._shopmail.itemcontain.verticalScrollPosition = 85;
            return;
        }// end function

        private function sendtzlist(event:MouseEvent = null) : void
        {
            if (this.panelobj.page < 1)
            {
                this.panelobj.page = 1;
            }
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_ORDER_LIST);
            if (event == null)
            {
                _loc_2.add32(this.panelobj.page);
            }
            else
            {
                _loc_2.add32(1);
            }
            _loc_2.add32(20);
            _loc_2.add32(this.panelobj.type);
            _loc_2.add32(this.panelobj.subtype);
            var _loc_3:* = this.panelobj.nameinput.text;
            if (_loc_3 == Config.language("BlackMarket", 39))
            {
                _loc_3 = "";
            }
            _loc_2.addUTF(_loc_3);
            _loc_2.add16(int(this.panelobj.minlevel.text));
            _loc_2.add16(int(this.panelobj.maxlevel.text));
            var _loc_4:* = this.panelobj.inputname.text;
            if (this.panelobj.inputname.text == Config.language("BlackMarket", 40))
            {
                _loc_4 = "";
            }
            _loc_2.addUTF(_loc_4);
            _loc_2.add8(this.priceOrDate);
            _loc_2.add8(this.orderWay);
            this.epname = this.panelobj.nameinput.text;
            this.minle = int(this.panelobj.minlevel.text);
            this.maxle = int(this.panelobj.maxlevel.text);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function clearpanel() : void
        {
            this.destroyitem();
            this.removeallchild(this.panel);
            this._slotArray = [];
            clearInterval(this._minTimer);
            return;
        }// end function

        private function minTimerfun()
        {
            var _loc_1:* = new DataSet();
            _loc_1.addHead(CONST_ENUM.C2G_AUCTION_LIST);
            ClientSocket.send(_loc_1);
            return;
        }// end function

        private function removeallchild(param1:Sprite) : void
        {
            while (param1.numChildren > 0)
            {
                
                param1.removeChildAt((param1.numChildren - 1));
            }
            return;
        }// end function

        private function destroyitem()
        {
            var _loc_1:* = 0;
            _loc_1 = 0;
            while (_loc_1 < 20)
            {
                
                if (this._slotAllsaleArray[_loc_1].iconSlotAll.item != null)
                {
                    this._slotAllsaleArray[_loc_1]._salerNameCL.removeEventListener(TextEvent.LINK, Config.create(this.clickname, this._slotAllsaleArray[_loc_1]._salerNameCL.text));
                    this._slotAllsaleArray[_loc_1].iconSlotAll.item.destroy();
                    this._slotAllsaleArray[_loc_1].iconSlotAll.item = null;
                    this._slotAllsaleArray[_loc_1].saleItemPrice.text = "";
                    this._slotAllsaleArray[_loc_1].saleItemEnd.text = "";
                    this._slotAllsaleArray[_loc_1]._salerNameCL.text = "";
                    this._slotAllsaleArray[_loc_1].buySaleBtn.enabled = false;
                }
                _loc_1 = _loc_1 + 1;
            }
            _loc_1 = 0;
            while (_loc_1 < 20)
            {
                
                if (this._slotMysaleArray[_loc_1].iconSlot.item != null)
                {
                    this._slotMysaleArray[_loc_1].iconSlot.item.destroy();
                    this._slotMysaleArray[_loc_1].iconSlot.item = null;
                    this._slotMysaleArray[_loc_1].infoText.text = "";
                    this._slotMysaleArray[_loc_1].price = 0;
                    this._slotMysaleArray[_loc_1].canBtn.enabled = false;
                }
                _loc_1 = _loc_1 + 1;
            }
            return;
        }// end function

        private function handleSlotOverShop(param1)
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

        private function handleSlotOver(event:Event, param2:int, param3:int = 0) : void
        {
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_4:* = this._slotArray[param2];
            if (this._slotArray[param2].item != null)
            {
                _loc_5 = 0;
                _loc_6 = 0;
                if (param3 == 0)
                {
                    _loc_5 = _loc_4.x + _loc_4.parent.x + _loc_4.parent.parent.x + _loc_4.parent.parent.parent.x + this.x;
                    _loc_6 = _loc_4.y + _loc_4.parent.y + _loc_4.parent.parent.y + _loc_4.parent.parent.parent.y + this.y;
                }
                else if (param3 == 1)
                {
                    _loc_5 = _loc_4.x + _loc_4.parent.x + this.x;
                    _loc_6 = _loc_4.y + _loc_4.parent.y + this.y;
                }
                Holder.showInfo(_loc_4.item.outputInfo(false, true), new Rectangle(_loc_5, _loc_6, _loc_4._size, _loc_4._size), false, 0, 250);
            }
            return;
        }// end function

        private function auctionhandleSlotOver(event:Event) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = event.currentTarget;
            if (_loc_2.item != null)
            {
                _loc_3 = _loc_2.parent.localToGlobal(new Point(_loc_2.x, _loc_2.y));
                Holder.showInfo(_loc_2.item.outputInfo(), new Rectangle(_loc_3.x, _loc_3.y, _loc_2._size, _loc_2._size), false, 0, 200);
                if (int(_loc_2.item._itemData.suitID) > 0 && int(_loc_2.item._itemData.type) != 18)
                {
                    _loc_3 = _loc_2.parent.localToGlobal(new Point(_loc_2.x, _loc_2.y));
                    Holder.showRightInfo(_loc_2.item.outfitInfo(1), new Rectangle(_loc_3.x, _loc_3.y, _loc_2._size, _loc_2._size));
                }
            }
            return;
        }// end function

        private function handleSlotOut(event:MouseEvent) : void
        {
            Holder.closeInfo();
            return;
        }// end function

        private function salehandleSlotClick(event:MouseEvent) : void
        {
            if (Holder.item != null)
            {
                if (Holder.item._drawer == Config.ui._charUI._slotArray)
                {
                    if (Config.ui._charUI.getPosite(Holder.item._position) == 1)
                    {
                        if (Holder.item._itemData.binding != 1)
                        {
                            Holder.item._drawer[Holder.item._position].item = Holder.item;
                            this.openSale(Holder.item);
                        }
                        else
                        {
                            Holder.item._drawer[Holder.item._position].item = Holder.item;
                            Config.message(Config.language("BlackMarket", 35));
                        }
                        Holder.item = null;
                    }
                    else if (Config.ui._charUI.getPosite(Holder.item._position) == 2)
                    {
                        Config.message(Config.language("BlackMarket", 36));
                    }
                    else if (Config.ui._charUI.getPosite(Holder.item._position) == 3)
                    {
                        Config.message(Config.language("BlackMarket", 37));
                    }
                }
            }
            return;
        }// end function

        private function openSale(param1:Item) : void
        {
            this.itemPos = param1._position;
            this.addChild(this._salePanel);
            this._salePriceNS.focus = true;
            this._salePriceNS.text = "";
            this.taxPercentText.text = Config.language("BlackMarket", 73);
            return;
        }// end function

        private function typeselect(event:AccTreeEvent) : void
        {
            this.panelobj.type = event.typeobj.type;
            this.panelobj.subtype = event.typeobj.subtype;
            this.sendtzlist();
            return;
        }// end function

        private function backitemselect(event:MouseEvent, param2:int) : void
        {
            if (this.selsctflag != -1 && this._slotArray[param2].item != null)
            {
                this._slotArray[this.selsctflag].selected = false;
            }
            if (this._slotArray[param2].item != null)
            {
                this._slotArray[param2].selected = true;
                this.selsctflag = param2;
            }
            return;
        }// end function

        private function showmlist() : void
        {
            var _loc_1:* = 0;
            if (this._opening && this.btnbar.selectpage == 2)
            {
                _loc_1 = 0;
                while (_loc_1 < this.itemlistarr.length)
                {
                    
                    this.itemlistarr[_loc_1].item.display();
                    this._slotArray[_loc_1].item = this.itemlistarr[_loc_1].item;
                    this._slotArray[_loc_1].addEventListener(MouseEvent.ROLL_OVER, Config.create(this.handleSlotOver, _loc_1, 1));
                    this._slotArray[_loc_1].addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
                    this._slotArray[_loc_1].addEventListener(MouseEvent.CLICK, Config.create(this.backitemselect, _loc_1));
                    _loc_1 = _loc_1 + 1;
                }
            }
            return;
        }// end function

        private function inputprice(param1)
        {
            if (parseInt(this._salePriceNS.text) < 100000)
            {
                this.taxPercentText.text = Config.language("BlackMarket", 76);
            }
            else if (parseInt(this._salePriceNS.text) < 10000000)
            {
                this.taxPercentText.text = Config.language("BlackMarket", 77);
            }
            else if (parseInt(this._salePriceNS.text) < 100000000)
            {
                this.taxPercentText.text = Config.language("BlackMarket", 78);
            }
            else if (parseInt(this._salePriceNS.text) >= 100000000)
            {
                if (parseInt(this._salePriceNS.text) > 1000000000)
                {
                    this._salePriceNS.text = "1000000000";
                }
                this.taxPercentText.text = Config.language("BlackMarket", 79);
            }
            return;
        }// end function

        private function handleSaleConfirm(event:MouseEvent)
        {
            if (this._salePriceNS.text == "" || this._salePriceNS.text == null || parseInt(this._salePriceNS.text) == 0)
            {
                Config.message(Config.language("BlackMarket", 80));
                return;
            }
            if (this._salePanel.parent == this)
            {
                removeChild(this._salePanel);
            }
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_PEND_ORDER);
            _loc_2.add16(this.itemPos);
            _loc_2.add32(parseInt(this._salePriceNS.text));
            _loc_2.add32(this.sendTime);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function salesuccess(event:SocketEvent)
        {
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            var _loc_4:* = _loc_2.readUnsignedInt();
            var _loc_5:* = _loc_2.readUnsignedInt();
            var _loc_6:* = Item.createItemByBytes(_loc_2, _loc_3, UNIT_TYPE_ENUM.TYPEID_ITEM_SALE);
            if (_loc_5 > 0)
            {
                if (_loc_5 < this.fivemin)
                {
                    _loc_7 = Config.language("BlackMarket", 49);
                }
                else if (_loc_5 < this.hour)
                {
                    _loc_7 = int(_loc_5 / this.muni) + Config.language("BlackMarket", 50);
                }
                else if (_loc_5 < this.day)
                {
                    _loc_7 = int(_loc_5 / this.hour) + Config.language("BlackMarket", 51);
                }
                else if (_loc_5 >= this.day)
                {
                    _loc_7 = int(_loc_5 / this.day) + Config.language("BlackMarket", 52);
                }
            }
            else if (_loc_5 <= 0)
            {
                _loc_7 = Config.language("BlackMarket", 53);
            }
            if (_loc_4 < 10000)
            {
                _loc_7 = Config.language("BlackMarket", 57) + Config.coinShow(_loc_4) + Config.language("BlackMarket", 58) + _loc_7;
            }
            else if (_loc_4 < 1000000)
            {
                _loc_7 = Config.language("BlackMarket", 57) + "<font color=\'#0000ff\'>" + Config.coinShow(_loc_4) + "</font>" + Config.language("BlackMarket", 58) + _loc_7;
            }
            else if (_loc_4 < 100000000)
            {
                _loc_7 = Config.language("BlackMarket", 57) + "<font color=\'#399765\'>" + Config.coinShow(_loc_4) + "</font>" + Config.language("BlackMarket", 58) + _loc_7;
            }
            else
            {
                _loc_7 = Config.language("BlackMarket", 57) + "<font color=\'#ff3333\'>" + Config.coinShow(_loc_4) + "</font>" + Config.language("BlackMarket", 58) + _loc_7;
            }
            while (_loc_8 < 20)
            {
                
                if (this._slotMysaleArray[_loc_8].iconSlot.item == null)
                {
                    _loc_6.display();
                    this._slotMysaleArray[_loc_8].saleId = _loc_3;
                    this._slotMysaleArray[_loc_8].iconSlot.item = _loc_6;
                    this._slotMysaleArray[_loc_8].infoText.text = _loc_7;
                    this._slotMysaleArray[_loc_8].price = _loc_4;
                    this._slotMysaleArray[_loc_8].canBtn.enabled = true;
                    break;
                }
                _loc_8 = _loc_8 + 1;
            }
            return;
        }// end function

        private function cancelsaleitem(event:MouseEvent, param2:uint)
        {
            var _loc_3:* = null;
            if (this._slotMysaleArray[param2].canBtn.enabled && Holder.item == null)
            {
                _loc_3 = new DataSet();
                _loc_3.addHead(CONST_ENUM.C2G_REVOKE_ORDER);
                _loc_3.add32(this._slotMysaleArray[param2].saleId);
                ClientSocket.send(_loc_3);
            }
            return;
        }// end function

        private function backcancelsale(event:SocketEvent)
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            var _loc_4:* = 0;
            while (_loc_4 < 20)
            {
                
                if (this._slotMysaleArray[_loc_4].saleId == _loc_3)
                {
                    if (this._slotMysaleArray[_loc_4].iconSlot.item != null)
                    {
                        this._slotMysaleArray[_loc_4].iconSlot.item.destroy();
                    }
                    this._slotMysaleArray[_loc_4].iconSlot.item = null;
                    this._slotMysaleArray[_loc_4].infoText.text = "";
                    this._slotMysaleArray[_loc_4].canBtn.enabled = false;
                }
                _loc_4++;
            }
            return;
        }// end function

        private function handleSaleConsel(event:MouseEvent)
        {
            if (this._salePanel.parent == this)
            {
                removeChild(this._salePanel);
            }
            return;
        }// end function

        private function getsaletime(param1)
        {
            if (this.comboxSale.selectedItem.data == 0)
            {
                this.sendTime = 1;
                this.commissionText.text = Config.language("BlackMarket", 81, 50);
            }
            else if (this.comboxSale.selectedItem.data == 1)
            {
                this.sendTime = 3;
                this.commissionText.text = Config.language("BlackMarket", 81, 100);
            }
            else if (this.comboxSale.selectedItem.data == 2)
            {
                this.sendTime = 7;
                this.commissionText.text = Config.language("BlackMarket", 81, 300);
            }
            return;
        }// end function

        private function backmoneypool(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            this.pooltable._tf.text = "0";
            return;
        }// end function

        private function goheadinfo(event:MouseEvent, param2:int)
        {
            var _loc_3:* = 0;
            var _loc_4:* = undefined;
            this.pagetotal = (this._allslotArray.length - 1) / 6 + 1;
            if (this.pagetotal == 0)
            {
                this.pg = 0;
            }
            if (param2 == 2)
            {
                if (this.pg > 1)
                {
                    var _loc_5:* = this;
                    var _loc_6:* = this.pg - 1;
                    _loc_5.pg = _loc_6;
                    this.auctionitemobjarr = [];
                    this.removeslotitem(param2);
                    _loc_3 = (this.pg - 1) * 6;
                    _loc_4 = 0;
                    while (_loc_3 < this.nowpg)
                    {
                        
                        this._allslotArray[_loc_3].item.display();
                        this._slotArray[_loc_4].item = null;
                        this._slotArray[_loc_4].item = this._allslotArray[_loc_3].item;
                        this.auctionitemobjarr.push(this._allslotArray[_loc_3]);
                        _loc_3 = _loc_3 + 1;
                        _loc_4 = _loc_4 + 1;
                    }
                }
            }
            else if (param2 == 3)
            {
                if (this.pg < this.pagetotal)
                {
                    var _loc_5:* = this;
                    var _loc_6:* = this.pg + 1;
                    _loc_5.pg = _loc_6;
                    this.auctionitemobjarr = [];
                    this.removeslotitem(param2);
                    _loc_3 = (this.pg - 1) * 6;
                    _loc_4 = 0;
                    while (_loc_3 < this.nowpg)
                    {
                        
                        this._allslotArray[_loc_3].item.display();
                        this._slotArray[_loc_4].item = null;
                        this._slotArray[_loc_4].item = this._allslotArray[_loc_3].item;
                        this.auctionitemobjarr.push(this._allslotArray[_loc_3]);
                        _loc_3 = _loc_3 + 1;
                        _loc_4 = _loc_4 + 1;
                    }
                }
            }
            _loc_3 = 0;
            while (_loc_3 < 6)
            {
                
                if (this._slotArray[_loc_3].item != null)
                {
                    this.autoaddArr[_loc_3].enabled = true;
                    this.manualaddArr[_loc_3].enabled = true;
                }
                _loc_3 = _loc_3 + 1;
            }
            this.showauctionlist();
            this.tabel.text = this.pg + "/" + this.pagetotal;
            return;
        }// end function

        private function removeslotitem(param1)
        {
            var _loc_2:* = 0;
            while (_loc_2 < 6)
            {
                
                this._tabauctionprice[_loc_2].text = "";
                this._tabauctiontime[_loc_2].text = "";
                this._tabauctionplayername[_loc_2].text = "";
                this._slotArray[_loc_2].item = null;
                this.autoaddArr[_loc_2].enabled = false;
                this.manualaddArr[_loc_2].enabled = false;
                _loc_2 = _loc_2 + 1;
            }
            if (param1 != 4)
            {
                if (this._allslotArray.length <= this.pg * 6)
                {
                    this.nowpg = this._allslotArray.length;
                }
                else
                {
                    this.nowpg = this.pg * 6;
                }
            }
            return;
        }// end function

        private function lbinputchange(param1)
        {
            if (int(this.lbinput.text) > 120)
            {
                this.lbinput.text = "120";
            }
            else if (this.lbinput.text == null || this.lbinput.text == "")
            {
                this.lbinput.text = "0";
            }
            else
            {
                this.lbinput.text = parseInt(this.lbinput.text).toString();
            }
            this.panelobj.minlevel = this.lbinput;
            return;
        }// end function

        private function lb2inputchange(param1)
        {
            if (int(this.lb2input.text) > 120)
            {
                this.lb2input.text = "120";
            }
            else if (this.lb2input.text == null || this.lb2input.text == "")
            {
                this.lb2input.text = "0";
            }
            else
            {
                this.lb2input.text = parseInt(this.lb2input.text).toString();
            }
            this.panelobj.maxlevel = this.lb2input;
            return;
        }// end function

        private function panelblack(event:MouseEvent = null) : void
        {
            this.clearpanel();
            this.panel.addChild(this._mcanvas);
            this.btnbar.selectpage = 0;
            var _loc_2:* = new PushButton(this.panel, 200, 345, Config.language("BlackMarket", 100), this.goldsell);
            _loc_2.width = 60;
            var _loc_3:* = new PushButton(this.panel, 260, 345, Config.language("BlackMarket", 101), Config.ui._easyShop.openeasyshop);
            var _loc_4:* = new PushButton(this.panel, 360, 345, Config.language("BlackMarket", 102), this.sellFun);
            new PushButton(this.panel, 360, 345, Config.language("BlackMarket", 102), this.sellFun).width = 120;
            dispatchEvent(new ObEvent("page:0"));
            return;
        }// end function

        public function openBlackPanel(param1:int) : void
        {
            this.open();
            this._mcanvas.verticalScrollPosition = int(param1);
            return;
        }// end function

        public function itemidposition(param1:int, param2:Boolean = false)
        {
            if (!param2)
            {
                this.open();
            }
            this.scrollToItem(param1);
            return;
        }// end function

        private function goldsell(event:MouseEvent)
        {
            Config.ui._bagUI.open();
            Config.ui._bagUI.sellFuc();
            return;
        }// end function

        private function sellFun(event:MouseEvent)
        {
            Config.ui._easyShop.openeasyshop();
            Config.ui._easyShop.putallwrith();
            return;
        }// end function

        private function initblackmarket()
        {
            var _loc_2:* = undefined;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            this._slotArray = new Array();
            var _loc_1:* = new Array();
            this._mcanvas = new CanvasUI(null, 10, 50, 470, 275);
            for (_loc_2 in Config._buy)
            {
                
                if (Config._buy[_loc_2].shopsid == 10001)
                {
                    _loc_3 = Config._buy[_loc_2].itemId;
                    _loc_4 = Item.newItem(Config._itemMap[_loc_3], 0, 0, UNIT_TYPE_ENUM.TYPEID_ITEMCLONE, 0);
                    if (Config._itemMap[_loc_3].type == 4 && Config._itemMap[_loc_3].subType < 10)
                    {
                        if (int(Config._itemMap[_loc_3].relatedId) > 0)
                        {
                            _loc_6 = int(Config._itemMap[_loc_3].relatedId).toString(2);
                            _loc_6 = "000000" + _loc_6;
                            _loc_6 = ("000000" + _loc_6).substring(_loc_6.length - 6, _loc_6.length);
                            _loc_7 = 0;
                            while (_loc_7 < 3)
                            {
                                
                                _loc_8 = new Object();
                                _loc_8.open = true;
                                _loc_8.id = 0;
                                _loc_8.type = parseInt(_loc_6.substr(_loc_7 * 2, 2), 2);
                                _loc_4._itemData.gem.push(_loc_8);
                                _loc_7 = _loc_7 + 1;
                            }
                        }
                    }
                    _loc_4.sortId = Config._buy[_loc_2].buyIteminit;
                    _loc_5 = int(Config._buy[_loc_2].buyValue);
                    _loc_4._itemData.goldValue = _loc_5;
                    _loc_4._itemData.buyType = Config._buy[_loc_2].buyType;
                    _loc_1.push(_loc_4);
                }
            }
            _loc_1.sortOn("sortId", Array.NUMERIC);
            this._initArray = _loc_1;
            this._initArrayIndex = 0;
            trace(_loc_1.length);
            Config.startLoop(this.initLoop);
            return;
        }// end function

        private function finishInitLoop()
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_1:* = this._initArray;
            if (this._initArrayIndex < _loc_1.length)
            {
                _loc_2 = new Array();
                _loc_3 = this._initArrayIndex;
                while (_loc_3 < _loc_1.length)
                {
                    
                    _loc_4 = new Sprite();
                    this._mcanvas.addChildUI(_loc_4);
                    _loc_4.graphics.beginFill(16777215, 0.4);
                    _loc_4.graphics.drawRoundRect(0, 0, 225, 50, 5);
                    _loc_4.graphics.endFill();
                    if (_loc_3 % 2 == 0)
                    {
                        _loc_4.x = 5;
                    }
                    else
                    {
                        _loc_4.x = 235;
                    }
                    if (_loc_3 % 2 == 0)
                    {
                        _loc_4.y = int(_loc_3 / 2) * 55;
                    }
                    else
                    {
                        _loc_4.y = int((_loc_3 - 1) / 2) * 55;
                    }
                    this._itemPos[_loc_1[_loc_3]._itemData.id] = _loc_4.y;
                    _loc_5 = new Label(_loc_4, 50, 5, _loc_1[_loc_3]._itemData.name);
                    _loc_6 = new CloneSlot(0, 32);
                    this._slotArray.push(_loc_6);
                    _loc_4.addChild(_loc_6);
                    _loc_6.x = 10;
                    _loc_6.y = 10;
                    _loc_1[_loc_3].display();
                    _loc_6.item = _loc_1[_loc_3];
                    _loc_6.item._drawer = this._slotArray;
                    _loc_6.addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOverShop);
                    _loc_6.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
                    _loc_7 = new Label(_loc_4, 50, 25);
                    _loc_7.text = Config.language("BlackMarket", 57) + Config.coinShow(_loc_1[_loc_3]._itemData.goldValue);
                    _loc_8 = new PushButton(_loc_4, 130, 25, Config.language("BlackMarket", 96), Config.create(this.buyitemfuc1, _loc_1[_loc_3]));
                    _loc_8.width = 50;
                    _loc_2.push(_loc_8);
                    this._itemToPanelMap[_loc_1[_loc_3]._itemData.id] = _loc_4;
                    this._itemToBuyBtnMap[_loc_1[_loc_3]._itemData.id] = _loc_8;
                    _loc_3 = _loc_3 + 1;
                }
                this._initArrayIndex = _loc_1.length;
            }
            Config.stopLoop(this.initLoop);
            return;
        }// end function

        private function initLoop(param1)
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            if (!Config._mapLoading)
            {
                return;
            }
            var _loc_2:* = this._initArray;
            var _loc_3:* = new Array();
            var _loc_4:* = this._initArrayIndex;
            while (_loc_4 < Math.min(_loc_2.length, this._initArrayIndex + 3))
            {
                
                _loc_5 = new Sprite();
                this._mcanvas.addChildUI(_loc_5);
                _loc_5.graphics.beginFill(16777215, 0.4);
                _loc_5.graphics.drawRoundRect(0, 0, 225, 50, 5);
                _loc_5.graphics.endFill();
                if (_loc_4 % 2 == 0)
                {
                    _loc_5.x = 5;
                }
                else
                {
                    _loc_5.x = 235;
                }
                if (_loc_4 % 2 == 0)
                {
                    _loc_5.y = int(_loc_4 / 2) * 55;
                }
                else
                {
                    _loc_5.y = int((_loc_4 - 1) / 2) * 55;
                }
                this._itemPos[_loc_2[_loc_4]._itemData.id] = _loc_5.y;
                _loc_6 = new Label(_loc_5, 50, 5, _loc_2[_loc_4]._itemData.name);
                _loc_7 = new CloneSlot(0, 32);
                this._slotArray.push(_loc_7);
                _loc_5.addChild(_loc_7);
                _loc_7.x = 10;
                _loc_7.y = 10;
                _loc_2[_loc_4].display();
                _loc_7.item = _loc_2[_loc_4];
                _loc_7.item._drawer = this._slotArray;
                _loc_7.addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOverShop);
                _loc_7.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
                _loc_8 = new Label(_loc_5, 50, 25);
                _loc_8.text = Config.language("BlackMarket", 57) + Config.coinShow(_loc_2[_loc_4]._itemData.goldValue);
                _loc_9 = new PushButton(_loc_5, 130, 25, Config.language("BlackMarket", 96), Config.create(this.buyitemfuc1, _loc_2[_loc_4]));
                _loc_9.width = 50;
                _loc_3.push(_loc_9);
                this._itemToPanelMap[_loc_2[_loc_4]._itemData.id] = _loc_5;
                this._itemToBuyBtnMap[_loc_2[_loc_4]._itemData.id] = _loc_9;
                _loc_4 = _loc_4 + 1;
            }
            this._initArrayIndex = _loc_4;
            if (this._initArrayIndex >= _loc_2.length)
            {
                Config.stopLoop(this.initLoop);
            }
            return;
        }// end function

        public function sendbuy(param1:int, param2:int) : void
        {
            var _loc_3:* = new DataSet();
            _loc_3.addHead(CONST_ENUM.C2G_BUY_ITEM_FROM_EASYSHOP);
            _loc_3.add8(1);
            _loc_3.add32(param1);
            _loc_3.add32(param2);
            ClientSocket.send(_loc_3);
            return;
        }// end function

        private function buyitemfuc1(event:MouseEvent, param2:Item)
        {
            if (Config.getMouseState() == "sell")
            {
                Config.setMouseState("", true);
            }
            var _loc_3:* = new Object();
            _loc_3.item = param2;
            _loc_3.id = int(param2._data.id);
            _loc_3.goldcoin = param2._itemData.goldValue;
            _loc_3.moneyflag = 7;
            Config.ui._shopbuy.initdata(_loc_3);
            Config.ui._shopbuy.x = this.x + 230;
            Config.ui._shopbuy.y = this.y;
            Config.ui._shopbuy.open();
            return;
        }// end function

        private function sortmysalelist(event:AccTreeEvent)
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_2:* = new Array();
            if (event.typeobj.i == 1)
            {
                _loc_3 = 0;
                while (_loc_3 < this._slotMysaleArray.length)
                {
                    
                    if (this._slotMysaleArray[_loc_3].iconSlot.item != null)
                    {
                        _loc_4 = new Object();
                        _loc_4.saleId = this._slotMysaleArray[_loc_3].saleId;
                        _loc_4.infoText = this._slotMysaleArray[_loc_3].infoText.text;
                        _loc_4.item = this._slotMysaleArray[_loc_3].iconSlot.item;
                        _loc_4.canBtn = this._slotMysaleArray[_loc_3].cancelBtn;
                        _loc_4.price = this._slotMysaleArray[_loc_3].price;
                        _loc_2.push(_loc_4);
                        this._slotMysaleArray[_loc_3].iconSlot.item = null;
                        this._slotMysaleArray[_loc_3].infoText.text = "";
                        this._slotMysaleArray[_loc_3].canBtn.enabled = false;
                    }
                    _loc_3++;
                }
                if (event.typeobj.sort)
                {
                    _loc_2.sortOn("price", Array.NUMERIC | Array.DESCENDING);
                }
                else
                {
                    _loc_2.sortOn("price", Array.NUMERIC);
                }
                _loc_3 = 0;
                while (_loc_3 < _loc_2.length)
                {
                    
                    this._slotMysaleArray[_loc_3].saleId = _loc_2[_loc_3].saleId;
                    this._slotMysaleArray[_loc_3].iconSlot.item = _loc_2[_loc_3].item;
                    this._slotMysaleArray[_loc_3].infoText.text = _loc_2[_loc_3].infoText;
                    this._slotMysaleArray[_loc_3].price = _loc_2[_loc_3].price;
                    this._slotMysaleArray[_loc_3].canBtn.enabled = true;
                    _loc_3++;
                }
            }
            return;
        }// end function

        private function sortallsalelist(event:AccTreeEvent)
        {
            var _loc_3:* = 0;
            var _loc_2:* = new Array();
            if (event.typeobj.i == 2 || event.typeobj.i == 3)
            {
                if (event.typeobj.i == 3)
                {
                    if (event.typeobj.sort)
                    {
                        this.priceOrDate = 1;
                        this.orderWay = 1;
                        this.sendtzlist();
                    }
                    else
                    {
                        this.priceOrDate = 1;
                        this.orderWay = 0;
                        this.sendtzlist();
                    }
                }
                else if (event.typeobj.i == 2)
                {
                    if (event.typeobj.sort)
                    {
                        this.priceOrDate = 2;
                        this.orderWay = 1;
                        this.sendtzlist();
                    }
                    else
                    {
                        this.priceOrDate = 2;
                        this.orderWay = 0;
                        this.sendtzlist();
                    }
                }
            }
            return;
        }// end function

        private function clickname(param1, param2)
        {
            var _loc_3:* = new Array();
            _loc_3 = [Config.language("BlackMarket", 83), Config.language("BlackMarket", 84), Config.language("BlackMarket", 85)];
            DropDown.dropDown(_loc_3, Config.create(this.handleDropDownClick, param2));
            return;
        }// end function

        private function handleDropDownClick(param1:int, param2) : void
        {
            switch(param1)
            {
                case 0:
                {
                    Config.ui._mailpanel.sendmailshow(null, param2);
                    Config.ui._mailpanel.open();
                    break;
                }
                case 1:
                {
                    Config.ui._friendUI.addFriend(param2);
                    break;
                }
                case 2:
                {
                    Config.ui._chatUI.whisperTo(param2);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function changepage(event:MouseEvent, param2:int) : void
        {
            if (this.selsctflag != -1)
            {
                this.selsctflag = -1;
            }
            if (param2 == 2)
            {
                if (this.panelobj.page != 0)
                {
                    if ((this.panelobj.page - 1) >= 1)
                    {
                        (this.panelobj.page - 1);
                    }
                    else
                    {
                        this.panelobj.page = 1;
                    }
                }
                else
                {
                    this.panelobj.page = 0;
                }
            }
            else if (param2 == 3)
            {
                if (this.panelobj.page != 0)
                {
                    if ((this.panelobj.page + 1) <= this.panelobj.allpage)
                    {
                        (this.panelobj.page + 1);
                    }
                    else
                    {
                        this.panelobj.page = this.panelobj.allpage;
                    }
                }
                else
                {
                    this.panelobj.page = 0;
                }
            }
            this.sendtzlist();
            return;
        }// end function

        override public function testGuide()
        {
            if (GuideUI.testId(118))
            {
                Config.ui._blackmarket.itemidposition(10002, true);
                GuideUI.doId(118, this._itemToBuyBtnMap[10002]);
            }
            return;
        }// end function

        public function scrollToItem(param1:int)
        {
            if (this._itemPos[param1] != null)
            {
                this._mcanvas.verticalScrollPosition = this._mcanvas.backPosition(this._itemPos[param1] + 50 / 2);
            }
            return;
        }// end function

        override protected function doOb(param1:Array) : Boolean
        {
            if (super.doOb(param1))
            {
                return true;
            }
            switch(param1[0])
            {
                case "page":
                {
                    if (param1[1] == "0")
                    {
                        this.panelblack();
                    }
                    else if (param1[1] == "1")
                    {
                        this.panela();
                    }
                    else
                    {
                        this.panelb();
                    }
                    return true;
                }
                default:
                {
                    break;
                }
            }
            return false;
        }// end function

    }
}
