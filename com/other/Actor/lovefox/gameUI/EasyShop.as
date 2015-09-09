package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import lovefox.socket.*;
    import lovefox.unit.*;

    public class EasyShop extends Window
    {
        private var _cloneBagPanel:Panel;
        private var _cloneSlotArray:Array;
        private var _slotStartIndex:int = 0;
        private var _page:Object = 0;
        private var _gridWidth:Object = 6;
        private var _gridHeight:Object = 6;
        private var _sellSlotNum:uint = 42;
        private var _gridMatrix:Array;
        private var _sellSlotArr:Array;
        private var totalmoney:int = 0;
        private var _cloneLeft:PushButton;
        private var _cloneRight:PushButton;
        private var _clonePageLB:TextField;
        private var _maygetMoney:Label;

        public function EasyShop(param1:DisplayObjectContainer = null, param2:Number = 0, param3:Number = 0)
        {
            this._cloneSlotArray = [];
            this._gridMatrix = [];
            this._sellSlotArr = [];
            super(param1, param2, param3);
            resize(505, 390);
            this.title = Config.language("EasyShop", 1);
            this.initpanel();
            return;
        }// end function

        public function openeasyshop(event:MouseEvent = null)
        {
            super.open();
            return;
        }// end function

        override public function close()
        {
            var _loc_1:* = 0;
            while (_loc_1 < this._sellSlotArr.length)
            {
                
                if (this._sellSlotArr[_loc_1].item != null)
                {
                    this._sellSlotArr[_loc_1].item._drawer[this._sellSlotArr[_loc_1].item._position].unlock();
                    this._sellSlotArr[_loc_1].item = null;
                }
                _loc_1 = _loc_1 + 1;
            }
            this._maygetMoney.text = Config.language("EasyShop", 2);
            this.totalmoney = 0;
            super.close();
            return;
        }// end function

        private function initpanel()
        {
            var _loc_2:* = null;
            var _loc_3:* = undefined;
            var _loc_1:* = new Shape();
            addChild(_loc_1);
            _loc_1.graphics.lineStyle(1);
            _loc_1.graphics.moveTo(252, 50);
            _loc_1.graphics.lineTo(252, 175);
            _loc_1.graphics.moveTo(252, 220);
            _loc_1.graphics.lineTo(252, 360);
            new Label(this, 240, 190, "＜ ＜");
            this._cloneBagPanel = new Panel(this, 275, 60);
            this._cloneBagPanel.alpha = 0;
            _loc_2 = new Label(this, 20, 32);
            _loc_2.html = true;
            _loc_2.text = "<b><font SIZE=\'16\'>" + Config.language("EasyShop", 3) + "</font></b>";
            _loc_2 = new Label(this, 280, 30);
            _loc_2.html = true;
            _loc_2.text = "<b><font SIZE=\'16\'>" + Config.language("EasyShop", 4) + "</font></b>";
            new Label(this._cloneBagPanel, 0, 0, Config.language("EasyShop", 5));
            this._slotStartIndex = Config.ui._bagUI._slotStartIndex;
            _loc_3 = this._slotStartIndex;
            while (_loc_3 < this._slotStartIndex + this.bagActiveNumber)
            {
                
                Config.ui._charUI._slotArray[_loc_3].removeEventListener(Event.CHANGE, this.hangleSlotUpdate);
                Config.ui._charUI._slotArray[_loc_3].removeEventListener("lockchange", this.hangleSlotUpdate);
                Config.ui._charUI._slotArray[_loc_3].addEventListener(Event.CHANGE, this.hangleSlotUpdate);
                Config.ui._charUI._slotArray[_loc_3].addEventListener("lockchange", this.hangleSlotUpdate);
                this._cloneSlotArray[_loc_3] = new CloneSlot(_loc_3, 32);
                this._cloneSlotArray[_loc_3].addEventListener(MouseEvent.ROLL_OVER, this.handleCloneSlotOver);
                this._cloneSlotArray[_loc_3].addEventListener(MouseEvent.ROLL_OUT, this.handleCloneSlotOut);
                this._cloneSlotArray[_loc_3].addEventListener("sglClick", this.handleCloneSlotClick);
                this._cloneSlotArray[_loc_3].addEventListener("dblClick", this.handleCloneSlotDoubleClick);
                this._cloneSlotArray[_loc_3].addEventListener("drag", this.handleCloneSlotClick);
                _loc_3 = _loc_3 + 1;
            }
            this.arrange();
            this._cloneLeft = new PushButton(this._cloneBagPanel, 60, 260, "<", this.handleCloneLeft);
            this._cloneLeft.width = 30;
            this._cloneRight = new PushButton(this._cloneBagPanel, 132, 260, ">", this.handleCloneRight);
            this._cloneRight.width = 30;
            var _loc_4:* = Math.ceil(this.bagActiveNumber / (this._gridWidth * this._gridHeight));
            this._clonePageLB = Config.getSimpleTextField();
            this._clonePageLB.defaultTextFormat = new TextFormat(null, 16, Style.WINDOW_FONT, true);
            this._clonePageLB.text = (this._page + 1) + "/" + _loc_4;
            this._clonePageLB.x = 100;
            this._clonePageLB.y = 260;
            this._cloneBagPanel.addChild(this._clonePageLB);
            var _loc_5:* = new PushButton(this._cloneBagPanel, 5, 290, Config.language("EasyShop", 8), Config.ui._bagUI.handleSort);
            new PushButton(this._cloneBagPanel, 5, 290, Config.language("EasyShop", 8), Config.ui._bagUI.handleSort).width = 40;
            var _loc_6:* = new PushButton(this._cloneBagPanel, 50, 290, Config.language("EasyShop", 9), this.putallwrith);
            new PushButton(this._cloneBagPanel, 50, 290, Config.language("EasyShop", 9), this.putallwrith).width = 90;
            var _loc_7:* = new PushButton(this._cloneBagPanel, 145, 290, Config.language("EasyShop", 10), this.putall);
            new PushButton(this._cloneBagPanel, 145, 290, Config.language("EasyShop", 10), this.putall).width = 70;
            this.sellarrange();
            this._maygetMoney = new Label(this, 30, 325, Config.language("EasyShop", 2));
            var _loc_8:* = new PushButton(this, 70, 350, Config.language("EasyShop", 11), this.sellall);
            return;
        }// end function

        public function resettotalmoney()
        {
            var _loc_1:* = 0;
            if (this._sellSlotArr != null)
            {
                this.totalmoney = 0;
                _loc_1 = 0;
                while (_loc_1 < this._sellSlotArr.length)
                {
                    
                    if (this._sellSlotArr[_loc_1].item != null)
                    {
                        this.totalmoney = this.totalmoney + int(this._sellSlotArr[_loc_1].item._itemData.goldValue) * this.getamount(int(this._sellSlotArr[_loc_1].item.amount));
                    }
                    _loc_1 = _loc_1 + 1;
                }
                this._maygetMoney.text = Config.language("EasyShop", 2) + this.totalmoney;
            }
            return;
        }// end function

        public function putallwrith(event:MouseEvent = null)
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            if (this._sellSlotArr != null)
            {
                if (Holder.item != null)
                {
                    Config.ui._charUI._slotArray[Holder.item._position].item = Holder.item;
                    Holder.item = null;
                }
                this.totalmoney = 0;
                _loc_2 = 0;
                while (_loc_2 < this._sellSlotArr.length)
                {
                    
                    if (this._sellSlotArr[_loc_2].item == null)
                    {
                        _loc_3 = 1;
                        while (_loc_3 < (this.bagActiveNumber + 1))
                        {
                            
                            if (Config.ui._charUI._slotArray[_loc_3].item != null && Config.ui._charUI._slotArray[_loc_3]._locked == false)
                            {
                                if (Config.ui._charUI._slotArray[_loc_3].item._itemData.type == 4 && Config.ui._charUI._slotArray[_loc_3].item._itemData.destroyable != 1 && Config.ui._charUI._slotArray[_loc_3].item._itemData.nameColor == 0)
                                {
                                    if (int(Config.ui._charUI._slotArray[_loc_3].item._itemData.subType) >= 1 && int(Config.ui._charUI._slotArray[_loc_3].item._itemData.subType) <= 9)
                                    {
                                        Config.ui._charUI._slotArray[_loc_3].lock();
                                        this._sellSlotArr[_loc_2].item = Config.ui._charUI._slotArray[_loc_3].item;
                                        this.totalmoney = this.totalmoney + int(Config.ui._charUI._slotArray[_loc_3].item._itemData.goldValue) * this.getamount(int(Config.ui._charUI._slotArray[_loc_3].item.amount));
                                        break;
                                    }
                                }
                            }
                            _loc_3 = _loc_3 + 1;
                        }
                    }
                    else
                    {
                        this.totalmoney = this.totalmoney + int(this._sellSlotArr[_loc_2].item._itemData.goldValue) * this.getamount(int(this._sellSlotArr[_loc_2].item.amount));
                    }
                    _loc_2 = _loc_2 + 1;
                }
                this._maygetMoney.text = Config.language("EasyShop", 2) + this.totalmoney;
            }
            return;
        }// end function

        private function putall(event:MouseEvent)
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            if (this._sellSlotArr != null)
            {
                if (Holder.item != null)
                {
                    Config.ui._charUI._slotArray[Holder.item._position].item = Holder.item;
                    Holder.item = null;
                }
                this.totalmoney = 0;
                _loc_2 = 0;
                while (_loc_2 < this._sellSlotArr.length)
                {
                    
                    if (this._sellSlotArr[_loc_2].item == null)
                    {
                        _loc_3 = 1;
                        while (_loc_3 < (this.bagActiveNumber + 1))
                        {
                            
                            if (Config.ui._charUI._slotArray[_loc_3].item != null && Config.ui._charUI._slotArray[_loc_3]._locked == false)
                            {
                                if (Config.ui._charUI._slotArray[_loc_3].item._itemData.destroyable == 1 || Config.ui._charUI._slotArray[_loc_3].item._itemData.destroyable == 3)
                                {
                                }
                                else
                                {
                                    Config.ui._charUI._slotArray[_loc_3].lock();
                                    this._sellSlotArr[_loc_2].item = Config.ui._charUI._slotArray[_loc_3].item;
                                    this.totalmoney = this.totalmoney + int(Config.ui._charUI._slotArray[_loc_3].item._itemData.goldValue) * this.getamount(int(Config.ui._charUI._slotArray[_loc_3].item.amount));
                                    trace(Config.ui._charUI._slotArray[_loc_3].item._itemData.destroyable);
                                    break;
                                }
                            }
                            _loc_3 = _loc_3 + 1;
                        }
                    }
                    else
                    {
                        this.totalmoney = this.totalmoney + int(this._sellSlotArr[_loc_2].item._itemData.goldValue) * this.getamount(int(this._sellSlotArr[_loc_2].item.amount));
                    }
                    _loc_2 = _loc_2 + 1;
                }
                this._maygetMoney.text = Config.language("EasyShop", 2) + this.totalmoney;
            }
            return;
        }// end function

        private function sellall(event:MouseEvent)
        {
            var _loc_3:* = 0;
            var _loc_2:* = 0;
            this.totalmoney = 0;
            this._maygetMoney.text = Config.language("EasyShop", 2) + this.totalmoney;
            _loc_3 = 0;
            while (_loc_3 < this._sellSlotArr.length)
            {
                
                if (this._sellSlotArr[_loc_3].item != null)
                {
                    _loc_2 = _loc_2 + 1;
                }
                _loc_3 = _loc_3 + 1;
            }
            var _loc_4:* = new DataSet();
            new DataSet().addHead(CONST_ENUM.C2G_EASY_SHOP_ITEM_SOLD);
            _loc_4.add16(_loc_2);
            _loc_3 = 0;
            while (_loc_3 < this._sellSlotArr.length)
            {
                
                if (this._sellSlotArr[_loc_3].item != null)
                {
                    trace(this._sellSlotArr[_loc_3].item._position, this._sellSlotArr[_loc_3].item.id, this._sellSlotArr[_loc_3].item._itemData.name);
                    _loc_4.add32(this._sellSlotArr[_loc_3].item.id);
                    _loc_4.add16(this._sellSlotArr[_loc_3].item._position);
                }
                _loc_3 = _loc_3 + 1;
            }
            ClientSocket.send(_loc_4);
            return;
        }// end function

        public function selloneitem(param1:Item)
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_EASY_SHOP_ITEM_SOLD);
            _loc_2.add16(1);
            _loc_2.add32(param1.id);
            _loc_2.add16(param1._position);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function handleCloneSlotDoubleClick(event:MouseEvent)
        {
            var _loc_3:* = 0;
            var _loc_2:* = event.currentTarget;
            if (_loc_2.item != null)
            {
                if (_loc_2.item._itemData.destroyable == 1 || _loc_2.item._itemData.destroyable == 3)
                {
                    Config.message(Config.language("EasyShop", 12));
                    return;
                }
                if (this._sellSlotArr != null)
                {
                    if (Holder.item != null)
                    {
                        Config.ui._charUI._slotArray[Holder.item._position].item = Holder.item;
                        Holder.item = null;
                    }
                    _loc_3 = 0;
                    while (_loc_3 < this._sellSlotArr.length)
                    {
                        
                        if (this._sellSlotArr[_loc_3].item == null)
                        {
                            this.totalmoney = this.totalmoney + int(_loc_2.item._itemData.goldValue) * this.getamount(int(_loc_2.item.amount));
                            _loc_2.item._drawer[_loc_2.item._position].lock();
                            this._sellSlotArr[_loc_3].item = _loc_2.item;
                            break;
                        }
                        _loc_3 = _loc_3 + 1;
                    }
                }
                this._maygetMoney.text = Config.language("EasyShop", 2) + this.totalmoney;
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
                if (this._cloneSlotArray[param1.target._id].item._itemData.destroyable == 1 || this._cloneSlotArray[param1.target._id].item._itemData.destroyable == 3)
                {
                    this._cloneSlotArray[param1.target._id].lock();
                }
            }
            return;
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

        private function sellarrange()
        {
            var _loc_1:* = 0;
            while (_loc_1 < this._sellSlotNum)
            {
                
                this._sellSlotArr[_loc_1] = new CloneSlot(_loc_1, 32);
                this._sellSlotArr[_loc_1].addEventListener(MouseEvent.ROLL_OVER, this.handleCloneSlotOver);
                this._sellSlotArr[_loc_1].addEventListener(MouseEvent.ROLL_OUT, this.handleCloneSlotOut);
                this._sellSlotArr[_loc_1].addEventListener("up", this.clickputItem);
                this._sellSlotArr[_loc_1].addEventListener("sglClick", this.clickputItem);
                this._sellSlotArr[_loc_1].addEventListener("dblClick", this.handleSlotClick);
                this.addChild(this._sellSlotArr[_loc_1]);
                this._sellSlotArr[_loc_1].x = int(_loc_1 % 6) * 37 + 10;
                this._sellSlotArr[_loc_1].y = int(_loc_1 / 6) * 37 + 65;
                _loc_1 = _loc_1 + 1;
            }
            return;
        }// end function

        private function handleSlotClick(event:MouseEvent)
        {
            var _loc_2:* = event.currentTarget;
            if (_loc_2.item != null)
            {
                _loc_2.item._drawer[_loc_2.item._position].unlock();
                this.totalmoney = this.totalmoney - int(_loc_2.item._itemData.goldValue) * this.getamount(int(_loc_2.item.amount));
                this._maygetMoney.text = Config.language("EasyShop", 2) + this.totalmoney;
                _loc_2.item = null;
            }
            return;
        }// end function

        private function clickputItem(event:MouseEvent)
        {
            var _loc_2:* = event.currentTarget;
            if (_loc_2.item == null)
            {
                if (Holder.item != null)
                {
                    if (Holder.item._itemData.destroyable == 1 || Holder.item._itemData.destroyable == 3)
                    {
                        Config.message(Config.language("EasyShop", 12));
                        return;
                    }
                    this.totalmoney = this.totalmoney + int(Holder.item._itemData.goldValue) * this.getamount(int(Holder.item.amount));
                    Holder.item._drawer[Holder.item._position].lock();
                    Holder.item._drawer[Holder.item._position].item = Holder.item;
                    _loc_2.item = Holder.item;
                    Holder.item = null;
                    this._maygetMoney.text = Config.language("EasyShop", 2) + this.totalmoney;
                }
            }
            return;
        }// end function

        public function arrange()
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

        private function getamount(param1:int) : int
        {
            var _loc_2:* = 0;
            if (param1 == 0)
            {
                _loc_2 = 1;
            }
            else
            {
                _loc_2 = param1;
            }
            return _loc_2;
        }// end function

    }
}
