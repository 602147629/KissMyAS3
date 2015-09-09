package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.geom.*;
    import flash.utils.*;
    import lovefox.component.*;
    import lovefox.socket.*;

    public class BagWare extends Window
    {
        private var _slotStartIndex:Object = 501;
        private var _slotNumber:Object = 48;
        private var _gridMatrix:Array;
        private var tips:TextAreaUI;
        private var leveltip:Sprite;
        private var rechtip:Sprite;
        private var _npcid:int = 0;

        public function BagWare(param1:DisplayObjectContainer)
        {
            this._gridMatrix = [];
            super(param1);
            this.initsocket();
            this.initpanel();
            return;
        }// end function

        public function initsocket() : void
        {
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.SMSG_BANK_LIST, this.getwarelist);
            return;
        }// end function

        private function initpanel() : void
        {
            var _loc_1:* = undefined;
            this.title = Config.language("BagWare", 1);
            resize(240, 360);
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
            var _loc_2:* = new Panel(this, 4, 325);
            _loc_2.color = 13545363;
            _loc_2.shadow = 0;
            _loc_2.width = 232;
            _loc_2.height = 31;
            var _loc_3:* = new PushButton(this, 10, 330, Config.language("BagWare", 2), this.handleSort);
            _loc_3.width = 49;
            _loc_3.height = 19;
            this.tips = new TextAreaUI(this, 65, 332, 270, 40);
            this.tips.autoHeight = true;
            this.tips.textColor = 4860702;
            this.arrange();
            return;
        }// end function

        private function handlePickAll(param1)
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.CMSG_ITEM_EXTRACT);
            _loc_2.add8(2);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function handleSort(param1)
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.CMSG_ITEM_ARRANGE);
            _loc_2.add8(2);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        public function arrange() : void
        {
            var _loc_1:* = undefined;
            this._gridMatrix = [];
            _loc_1 = this._slotStartIndex;
            while (_loc_1 < this._slotStartIndex + this._slotNumber)
            {
                
                Config.ui._charUI._slotArray[_loc_1].x = (_loc_1 - this._slotStartIndex) % 6 * 37 + 11;
                Config.ui._charUI._slotArray[_loc_1].y = int((_loc_1 - this._slotStartIndex) / 6) * 37 + 28;
                addChild(Config.ui._charUI._slotArray[_loc_1]);
                _loc_1 = _loc_1 + 1;
            }
            return;
        }// end function

        private function clickSlot(param1)
        {
            var _loc_2:* = null;
            if (Holder.item == null)
            {
                if (param1.item != null)
                {
                    if (Config.getMouseState() == "split")
                    {
                        Config.ui._bagUI.split(param1.item);
                        return;
                    }
                    if (Config.getMouseState() == "sell")
                    {
                        Config.ui._bagUI.sell(param1.item);
                        return;
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
                }
                else if (param1.item != null && Holder.item._itemData.baseID == param1.item._itemData.baseID && Holder.item._itemData.maxSum > 1)
                {
                    Config.ui._charUI._holderBuff = param1.item;
                    _loc_2 = new DataSet();
                    _loc_2.addHead(CONST_ENUM.CMSG_ITEM_STACK);
                    _loc_2.add16(Holder.item._position);
                    _loc_2.add16(param1._id);
                    _loc_2.add32(this._npcid);
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
            var _loc_2:* = param1.currentTarget;
            if (_loc_2.item != null)
            {
                _loc_3 = Config.ui._bagUI.getMinEmptySlot();
                if (_loc_3 == null)
                {
                    Config.message(Config.language("BagWare", 3));
                }
                else
                {
                    Config.ui._charUI.swapItem(_loc_2.item, _loc_3._id);
                }
            }
            return;
        }// end function

        private function handleSlotOver(param1)
        {
            var _loc_3:* = null;
            var _loc_2:* = param1.currentTarget;
            if (_loc_2.item != null)
            {
                _loc_3 = _loc_2.parent.localToGlobal(new Point(_loc_2.x, _loc_2.y));
                Holder.showInfo(_loc_2.item.outputInfo(), new Rectangle(_loc_3.x, _loc_3.y, _loc_2._size, _loc_2._size), false, 0, 200);
                if (int(_loc_2.item._itemData.suitID) > 0 && int(_loc_2.item._itemData.type) != 18)
                {
                    _loc_3 = _loc_2.parent.localToGlobal(new Point(_loc_2.x, _loc_2.y));
                    Holder.showRightInfo(_loc_2.item.outfitInfo(2), new Rectangle(_loc_3.x, _loc_3.y, _loc_2._size, _loc_2._size));
                }
            }
            return;
        }// end function

        private function handleSlotOut(param1)
        {
            Holder.closeInfo();
            return;
        }// end function

        public function get slotNumber()
        {
            return this._slotNumber;
        }// end function

        public function set slotNumber(param1) : void
        {
            this._slotNumber = param1;
            return;
        }// end function

        public function openware() : void
        {
            return;
        }// end function

        public function get npcid() : int
        {
            return this._npcid;
        }// end function

        public function set npcid(param1:int) : void
        {
            this._npcid = param1;
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.CMSG_BANK_LIST);
            _loc_2.add32(this._npcid);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function getwarelist(event:SocketEvent) : void
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            this.clearWare();
            var _loc_7:* = event.data;
            var _loc_8:* = event.data.readByte();
            var _loc_9:* = _loc_7.readUnsignedShort();
            _loc_3 = this._slotStartIndex;
            while (_loc_3 < this._slotStartIndex + this._slotNumber)
            {
                
                if (Config.ui._charUI._slotArray[_loc_3].item != null)
                {
                    Config.ui._charUI._slotArray[_loc_3].item.destroy();
                }
                _loc_3 = _loc_3 + 1;
            }
            _loc_2 = 0;
            while (_loc_2 < _loc_9)
            {
                
                _loc_5 = _loc_7.readUnsignedInt();
                _loc_6 = _loc_7.readUnsignedShort();
                _loc_4 = Item.createItemByBytes(_loc_7, _loc_5);
                if (_loc_4 != null)
                {
                    _loc_4.display();
                    _loc_4._drawer = Config.ui._charUI._slotArray;
                }
                if (Config.ui._charUI._slotArray[_loc_6] != null)
                {
                    Config.ui._charUI._slotArray[_loc_6].item = _loc_4;
                }
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function clearWare()
        {
            var _loc_2:* = undefined;
            var _loc_1:* = true;
            _loc_2 = this._slotStartIndex;
            while (_loc_2 < this._slotStartIndex + this._slotNumber)
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

    }
}
