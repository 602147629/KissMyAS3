package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import lovefox.socket.*;
    import lovefox.unit.*;

    public class DealUI extends Window
    {
        private var _slotStartIndex:uint = 1;
        private var _slotNumber:Object = 6;
        public var _selfSlotArray:Array;
        private var _otherSlotArray:Array;
        private var _otherNameLB:Label;
        private var _otherCoinLB:Label;
        private var _waitokLB:Label;
        private var _selfNameLB:Label;
        private var _selfCoinIT:InputText;
        private var _okPB:PushButton;
        private var _cancelPB:PushButton;
        private var _selflockPB:PushButton;
        private var _selfunlockPB:PushButton;
        private var _dblClickTimer:Object;
        private var _preClickTime:Object;
        private var _preClickSlot:Object;
        private var _dealalert:Object;
        private var _dealflag:Boolean;
        private var _holderBuff:Object;
        private var btnarr:Array;
        private var todealid:int;
        private var _selfovershape:Sprite;
        private var _otherovershape:Sprite;
        private var _othercheck:CheckBox;
        private var _selfcheck:CheckBox;
        private var valuecoin:uint;
        private var tempmoney:uint = 0;
        public var tempdealplayer:int = 0;
        public var nowplayerid:int = 0;
        public var dealflag:Boolean = false;
        private var alertTimer:Timer;
        private var num:int = 0;
        private var sendobj:Object;

        public function DealUI(param1)
        {
            this._selfSlotArray = [];
            this._otherSlotArray = [];
            this.btnarr = new Array();
            super(param1);
            title = Config.language("DealUI", 1);
            resize(230, 400);
            this.x = 240;
            this.initDraw();
            return;
        }// end function

        public function initDraw()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_6:* = null;
            _loc_1 = this._slotStartIndex;
            while (_loc_1 < this._slotStartIndex + this._slotNumber)
            {
                
                _loc_6 = new Sprite();
                _loc_6.graphics.beginFill(16777215, 0.3);
                _loc_6.graphics.drawRect(125, _loc_1 * 40 + 27, 93, 38);
                _loc_6.graphics.endFill();
                addChild(_loc_6);
                this._selfSlotArray[_loc_1] = new InvSlot(_loc_1, 32);
                addChild(this._selfSlotArray[_loc_1]);
                this._selfSlotArray[_loc_1].x = 130;
                this._selfSlotArray[_loc_1].y = _loc_1 * 40 + 30;
                this._selfSlotArray[_loc_1].addEventListener("sglClick", this.handleSlotClick);
                this._selfSlotArray[_loc_1].addEventListener("drag", this.handleSlotClick);
                this._selfSlotArray[_loc_1].addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
                this._selfSlotArray[_loc_1].addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
                _loc_1 = _loc_1 + 1;
            }
            _loc_1 = this._slotStartIndex;
            while (_loc_1 < this._slotStartIndex + this._slotNumber)
            {
                
                _loc_6 = new Sprite();
                _loc_6.graphics.beginFill(16777215, 0.3);
                _loc_6.graphics.drawRect(15, _loc_1 * 40 + 27, 90, 38);
                _loc_6.graphics.endFill();
                addChild(_loc_6);
                this._otherSlotArray[_loc_1] = new InvSlot(_loc_1, 32);
                addChild(this._otherSlotArray[_loc_1]);
                this._otherSlotArray[_loc_1].x = 20;
                this._otherSlotArray[_loc_1].y = _loc_1 * 40 + 30;
                this._otherSlotArray[_loc_1].addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
                this._otherSlotArray[_loc_1].addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
                _loc_1 = _loc_1 + 1;
            }
            var _loc_4:* = new Sprite();
            new Sprite().graphics.lineStyle(4, 16777215);
            _loc_4.graphics.moveTo(7, 25);
            _loc_4.graphics.lineTo(7, 355);
            _loc_4.graphics.lineTo(110, 355);
            _loc_4.graphics.lineTo(110, 25);
            _loc_4.graphics.lineTo(7, 25);
            addChild(_loc_4);
            var _loc_5:* = new Sprite();
            new Sprite().graphics.lineStyle(4, 16777215);
            _loc_5.graphics.moveTo(117, 25);
            _loc_5.graphics.lineTo(117, 355);
            _loc_5.graphics.lineTo(223, 355);
            _loc_5.graphics.lineTo(223, 25);
            _loc_5.graphics.lineTo(117, 25);
            addChild(_loc_5);
            this.alertTimer = new Timer(1000);
            this.alertTimer.addEventListener(TimerEvent.TIMER, this.showtime);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.SMSG_TRADE_REQUEST, this.getrequest);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.SMSG_TRADE_REQUEST_RESULT, this.getrequest1);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.SMSG_TRADE_CANCEL, this.canceldeal);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.SMSG_TRADE_CANCEL_RESULT, this.canceldeal1);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.SMSG_TRADE_ACCEPT, this.accept);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.SMSG_TRADE_ACCEPT_RESULT, this.accept1);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.SMSG_TRADE_ITEM_UPDATE, this.handleItemUpdate);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.SMSG_TRADE_COMPLETE, this.dealcomplete);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.SMSG_TRADE_SUBMIT, this.getsubmit);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.SMSG_TRADE_MONEY_UPDATE, this.updatecoin);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.SMSG_TRADE_LOCKUNLOCK, this.backlockcheck);
            this._otherNameLB = new Label(this, 10, 30);
            this._otherNameLB.html = true;
            this._otherCoinLB = new Label(this, 20, 310);
            this._selfNameLB = new Label(this, 120, 30);
            this._selfNameLB.html = true;
            this._waitokLB = new Label(this, 20, 365);
            this._selfCoinIT = new InputText(this, 130, 310, "0", this.inputAmount);
            this._selfCoinIT.setSize(78, 20);
            this._selfCoinIT.restrict = "0-9";
            this._okPB = new PushButton(this, 85, 365, Config.language("DealUI", 1), this.dealsubmit);
            this._okPB.mode = PushButton.CHECK_MODE;
            this._okPB.width = 60;
            this._okPB.enabled = false;
            this._okPB.selected = false;
            this._cancelPB = new PushButton(this, 155, 365, Config.language("DealUI", 2), this.canceldeal2);
            this._cancelPB.width = 60;
            this._selfovershape = new Sprite();
            this._otherovershape = new Sprite();
            this.addChild(this._selfovershape);
            this.addChild(this._otherovershape);
            this._selfovershape.mouseEnabled = false;
            this._otherovershape.mouseEnabled = false;
            return;
        }// end function

        private function inputAmount(param1)
        {
            if (Number(this._selfCoinIT.text) >= Config.player.money4 + this.tempmoney)
            {
                this._selfCoinIT.text = (Config.player.money4 + this.tempmoney).toString();
            }
            else if (Number(this._selfCoinIT.text) < 1 || this._selfCoinIT.text == null || this._selfCoinIT.text == "")
            {
                this._selfCoinIT.text = "0";
            }
            else
            {
                this._selfCoinIT.text = Number(this._selfCoinIT.text).toString();
            }
            return;
        }// end function

        private function handleSlotClick(param1)
        {
            var _loc_2:* = param1.currentTarget;
            this.clickSlot(_loc_2);
            return;
        }// end function

        private function clickSlot(param1)
        {
            var _loc_2:* = null;
            if (Holder.item == null)
            {
                if (param1.item != null)
                {
                    Config.ui._charUI.unlockfromid(param1.item._id);
                    _loc_2 = new DataSet();
                    _loc_2.addHead(CONST_ENUM.CMSG_TRADE_REMOVEITEM);
                    _loc_2.add16(param1.item._position);
                    ClientSocket.send(_loc_2);
                }
            }
            else if (Holder.item._drawer == Config.ui._charUI._slotArray)
            {
                if (Config.ui._charUI.getPosite(int(Holder.item._position)) == 3)
                {
                    Config.message(Config.language("DealUI", 3));
                }
                else if (Config.ui._charUI.getPosite(int(Holder.item._position)) == 2)
                {
                    Config.message(Config.language("DealUI", 4));
                }
                else if (Holder.item._itemData.binding == 1)
                {
                    Config.message(Config.language("DealUI", 5));
                }
                else
                {
                    _loc_2 = new DataSet();
                    if (param1.item == null)
                    {
                        _loc_2.addHead(CONST_ENUM.CMSG_TRADE_ADDITEM);
                        _loc_2.add16(Holder.item._position);
                        _loc_2.add16(param1._id);
                        ClientSocket.send(_loc_2);
                        trace(Holder.item._position, param1._id);
                    }
                }
            }
            else if (Holder.item._drawer == this._selfSlotArray)
            {
                Holder.item._drawer[Holder.item._position].item = Holder.item;
                Holder.item = null;
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

        private function updatecoin(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            var _loc_4:* = _loc_2.readUnsignedInt();
            if (_loc_3 == Config.player._id)
            {
                this._selfCoinIT.text = String(_loc_4);
            }
            else
            {
                this._otherCoinLB.text = String(_loc_4);
            }
            return;
        }// end function

        public function handleItemSwap(param1)
        {
            trace("handleItemSwap");
            return;
        }// end function

        public function handleConfirm(event:MouseEvent) : void
        {
            return;
        }// end function

        public function handleCacel(param1)
        {
            trace("handleCacel");
            return;
        }// end function

        public function sendtodeal(param1:int) : void
        {
            var _loc_2:* = new DataSet();
            if (this.tempdealplayer == 0 || this.tempdealplayer == Config.player._id)
            {
                _loc_2.addHead(CONST_ENUM.CMSG_TRADE_REQUEST);
                _loc_2.add32(param1);
                ClientSocket.send(_loc_2);
            }
            else
            {
                this.nowplayerid = param1;
                this.dealflag = true;
                _loc_2.addHead(CONST_ENUM.CMSG_TRADE_CANCEL);
                _loc_2.add32(this.tempdealplayer);
                ClientSocket.send(_loc_2);
            }
            return;
        }// end function

        private function getrequest1(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            this.tempdealplayer = _loc_2.readUnsignedInt();
            var _loc_3:* = _loc_2.readUnsignedShort();
            if (_loc_3 > 0)
            {
                this.tempdealplayer = 0;
                Config.message(Config._codeWords[WordsType.TYPEID_ERR][_loc_3]);
            }
            return;
        }// end function

        private function getrequest(event:SocketEvent) : void
        {
            var _loc_4:* = null;
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            if (Config.player._id != Number(_loc_3))
            {
                _loc_4 = Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_PLAYER, _loc_3);
                this.sendobj = new Object();
                this.sendobj.type = 5;
                this.sendobj.fname = _loc_4.name;
                this.sendobj.title = Config.language("DealUI", 6);
                this.sendobj.msg = Config.language("DealUI", 7, _loc_4.name);
                this.sendobj.btns = [Config.language("DealUI", 8), Config.language("DealUI", 9)];
                this.sendobj.funcs = [this.sendokmsg, this.sendcancelmsg];
                this.sendobj.d = {fromplayer:_loc_3};
                if (Config.disturbMode)
                {
                    this._dealflag = true;
                    ListTip.addList(this.sendobj);
                }
                else
                {
                    this._dealflag = false;
                    this._dealalert = AlertUI.alert(Config.language("DealUI", 6), Config.language("DealUI", 7, _loc_4.name), [Config.language("DealUI", 8), Config.language("DealUI", 9)], [this.sendokmsg, this.sendcancelmsg], {fromplayer:_loc_3}, false, true, false, null, true);
                }
                this.alertTimer.stop();
                this.num = 0;
                this.alertTimer.start();
            }
            else
            {
                Config.message(Config.language("DealUI", 10));
            }
            return;
        }// end function

        private function showtime(event:TimerEvent)
        {
            var _loc_2:* = this;
            var _loc_3:* = this.num + 1;
            _loc_2.num = _loc_3;
            if (this.num >= 30)
            {
                this.num = 0;
                this.alertTimer.stop();
                if (this._dealflag)
                {
                    this._dealalert = Config.ui._listtip._dealalert1;
                }
                AlertUI.remove(this._dealalert);
                this.sendcancelmsg(this.sendobj.d);
            }
            return;
        }// end function

        private function sendokmsg(param1) : void
        {
            this.alertTimer.stop();
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.CMSG_TRADE_ACCEPT);
            _loc_2.add32(param1.fromplayer);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function sendcancelmsg(param1) : void
        {
            this.alertTimer.stop();
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.CMSG_TRADE_CANCEL);
            _loc_2.add32(param1.fromplayer);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function canceldeal1(event:SocketEvent) : void
        {
            var _loc_5:* = null;
            this.tempdealplayer = 0;
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            var _loc_4:* = _loc_2.readUnsignedShort();
            if (_loc_2.readUnsignedShort() == 0)
            {
                this.closedealpanel();
                if (this.dealflag)
                {
                    this.dealflag = false;
                    _loc_5 = new DataSet();
                    _loc_5.addHead(CONST_ENUM.CMSG_TRADE_REQUEST);
                    _loc_5.add32(this.nowplayerid);
                    ClientSocket.send(_loc_5);
                }
            }
            else
            {
                Config.message(Config._codeWords[WordsType.TYPEID_ERR][_loc_4]);
            }
            return;
        }// end function

        private function canceldeal(event:SocketEvent) : void
        {
            this.tempdealplayer = 0;
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readByte();
            var _loc_4:* = _loc_2.readUnsignedInt();
            var _loc_5:* = _loc_2.readUnsignedShort();
            var _loc_6:* = _loc_2.readUTFBytes(_loc_5);
            if (!this.dealflag)
            {
                if (Config.player._id != Number(_loc_4))
                {
                    if (_loc_3 == 1)
                    {
                        Config.message(Config.language("DealUI", 11, _loc_6));
                    }
                    else
                    {
                        Config.message(Config.language("DealUI", 12));
                    }
                    ListTip.removeList(5, _loc_6);
                    if (this._dealalert != null)
                    {
                        if (this._dealflag)
                        {
                            this._dealalert = Config.ui._listtip._dealalert1;
                        }
                        AlertUI.remove(this._dealalert);
                    }
                }
                this.closedealpanel();
            }
            return;
        }// end function

        private function farclose(event:SocketEvent) : void
        {
            var _loc_5:* = null;
            this.tempdealplayer = 0;
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            var _loc_4:* = _loc_2.readUnsignedInt();
            if (Config.player._id != Number(_loc_4))
            {
                _loc_5 = Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_PLAYER, _loc_4);
            }
            else
            {
                _loc_5 = Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_PLAYER, _loc_3);
            }
            ListTip.removeList(5, _loc_5.name);
            if (this._dealalert != null)
            {
                if (this._dealflag)
                {
                    this._dealalert = Config.ui._listtip._dealalert1;
                }
                AlertUI.remove(this._dealalert);
            }
            this.closedealpanel();
            return;
        }// end function

        private function closealert(event:Event) : void
        {
            AlertUI.close();
            return;
        }// end function

        private function accept1(event:SocketEvent) : void
        {
            var _loc_5:* = null;
            this.tempdealplayer = 0;
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            var _loc_4:* = _loc_2.readUnsignedShort();
            if (_loc_2.readUnsignedShort() == 0)
            {
                this.todealid = _loc_3;
                _loc_5 = Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_PLAYER, this.todealid);
                this._otherNameLB.text = Config.language("DealUI", 13, _loc_5.name, _loc_5.level);
                this._selfNameLB.text = Config.language("DealUI", 13, Config.player.name, Config.player.level);
                Config.ui._bagUI.open();
                this._selfCoinIT.text = "0";
                this._otherCoinLB.text = "0";
                open();
                Config.ui._bagUI.tempbtn.enabled = false;
                Config.player.lock = true;
                this.tempmoney = 0;
                if (this._othercheck != null)
                {
                    removeChild(this._othercheck);
                }
                if (this._selfcheck != null)
                {
                    removeChild(this._selfcheck);
                }
                if (this._selflockPB != null)
                {
                    removeChild(this._selflockPB);
                }
                if (this._selfunlockPB != null)
                {
                    removeChild(this._selfunlockPB);
                }
                this._othercheck = new CheckBox(this, 20, 340, Config.language("DealUI", 14));
                this._selfcheck = new CheckBox(this, 125, 340, Config.language("DealUI", 14));
                this._othercheck.enabled = false;
                this._selfcheck.enabled = false;
                this._othercheck.buttonMode = false;
                this._selfcheck.buttonMode = false;
                this._selflockPB = new PushButton(this, 15, 365, Config.language("DealUI", 15), Config.create(this.exchangelocked, 0));
                this._selflockPB.width = 60;
                this._selflockPB.visible = true;
                this._selfunlockPB = new PushButton(this, 15, 365, Config.language("DealUI", 16), Config.create(this.exchangelocked, 1));
                this._selfunlockPB.width = 60;
                this._selfunlockPB.visible = false;
            }
            return;
        }// end function

        private function accept(event:SocketEvent) : void
        {
            this.tempdealplayer = 0;
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            this.todealid = _loc_3;
            var _loc_4:* = Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_PLAYER, this.todealid);
            if (Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_PLAYER, this.todealid) != null)
            {
                this._otherNameLB.text = Config.language("DealUI", 13, _loc_4.name, _loc_4.level);
            }
            this._selfNameLB.text = Config.language("DealUI", 13, Config.player.name, Config.player.level);
            Config.ui._bagUI.open();
            this._selfCoinIT.text = "0";
            this._otherCoinLB.text = "0";
            open();
            Config.ui._bagUI.tempbtn.enabled = false;
            Config.player.lock = true;
            this.tempmoney = 0;
            if (this._othercheck != null)
            {
                removeChild(this._othercheck);
            }
            if (this._selfcheck != null)
            {
                removeChild(this._selfcheck);
            }
            if (this._selflockPB != null)
            {
                removeChild(this._selflockPB);
            }
            if (this._selfunlockPB != null)
            {
                removeChild(this._selfunlockPB);
            }
            this._othercheck = new CheckBox(this, 20, 340, Config.language("DealUI", 14));
            this._selfcheck = new CheckBox(this, 125, 340, Config.language("DealUI", 14));
            this._othercheck.enabled = false;
            this._selfcheck.enabled = false;
            this._othercheck.buttonMode = false;
            this._selfcheck.buttonMode = false;
            this._selflockPB = new PushButton(this, 15, 365, Config.language("DealUI", 15), Config.create(this.exchangelocked, 0));
            this._selflockPB.width = 60;
            this._selflockPB.visible = true;
            this._selfunlockPB = new PushButton(this, 15, 365, Config.language("DealUI", 16), Config.create(this.exchangelocked, 1));
            this._selfunlockPB.width = 60;
            this._selfunlockPB.visible = false;
            return;
        }// end function

        private function handleItemUpdate(event:SocketEvent) : void
        {
            var _loc_2:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_3:* = event.data;
            var _loc_4:* = _loc_3.readUnsignedInt();
            var _loc_5:* = _loc_3.readByte();
            var _loc_6:* = _loc_3.readUnsignedShort();
            if (_loc_5 == 0)
            {
                if (Number(_loc_4) == Config.player._id)
                {
                    _loc_2 = this._selfSlotArray[_loc_6].item;
                    if (_loc_2 != null)
                    {
                        _loc_2.destroy();
                    }
                    if (Holder.item != null)
                    {
                        Holder.item = null;
                    }
                    this._selfSlotArray[_loc_6].item = null;
                }
                else
                {
                    _loc_2 = this._otherSlotArray[_loc_6].item;
                    if (_loc_2 != null)
                    {
                        _loc_2.destroy();
                    }
                    this._otherSlotArray[_loc_6].item = null;
                }
            }
            else if (_loc_5 == 1)
            {
                _loc_7 = _loc_3.readUnsignedInt();
                _loc_8 = _loc_3.readUnsignedShort();
                _loc_2 = Item.createItemByBytes(_loc_3, _loc_7, UNIT_TYPE_ENUM.TYPEID_ITEMCLONE);
                _loc_2._position = _loc_6;
                _loc_2.display();
                _loc_2._drawer = this._selfSlotArray;
                if (Number(_loc_4) == Config.player._id)
                {
                    if (this._selfSlotArray[_loc_6].item != null)
                    {
                        this._selfSlotArray[_loc_6].item.destroy();
                        this._selfSlotArray[_loc_6].item = null;
                    }
                    this._selfSlotArray[_loc_6].item = _loc_2;
                    _loc_9 = Item.getItem(UNIT_TYPE_ENUM.TYPEID_ITEM, _loc_7);
                    if (_loc_9 != null && _loc_9 == Holder.item)
                    {
                        _loc_9._drawer[_loc_9._position].item = _loc_9;
                        Config.ui._charUI.itemlock(_loc_9._position);
                        Holder.item = null;
                    }
                }
                else
                {
                    if (this._otherSlotArray[_loc_6].item != null)
                    {
                        this._otherSlotArray[_loc_6].item.destroy();
                        this._otherSlotArray[_loc_6].item = null;
                    }
                    this._otherSlotArray[_loc_6].item = _loc_2;
                }
            }
            return;
        }// end function

        private function submitshape(param1:int, param2:Boolean) : void
        {
            if (param2)
            {
                if (param1 == 0)
                {
                    this._otherovershape.graphics.clear();
                    this._otherovershape.graphics.lineStyle(3, 7879997, 0.5);
                    this._otherovershape.graphics.beginFill(11296350, 0.3);
                    this._otherovershape.graphics.drawRoundRect(10, 30, 95, 300, 8);
                    this._otherovershape.graphics.endFill();
                }
                else
                {
                    this._selfovershape.graphics.clear();
                    this._selfovershape.graphics.lineStyle(3, 7879997, 0.5);
                    this._selfovershape.graphics.beginFill(11296350, 0.3);
                    this._selfovershape.graphics.drawRoundRect(120, 30, 98, 300, 8);
                    this._selfovershape.graphics.endFill();
                }
            }
            return;
        }// end function

        private function dealsubmit(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            if (this._okPB.enabled)
            {
                if (!this._okPB.selected)
                {
                    this._waitokLB.text = Config.language("DealUI", 17);
                    this._okPB.selected = true;
                    _loc_2 = new DataSet();
                    _loc_2.addHead(CONST_ENUM.CMSG_TRADE_SUBMIT);
                    ClientSocket.send(_loc_2);
                }
            }
            return;
        }// end function

        private function getsubmit(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            this._waitokLB.text = Config.language("DealUI", 18);
            return;
        }// end function

        private function dealcomplete(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedShort();
            if (_loc_3 == 0)
            {
                Config.message(Config.language("DealUI", 19));
            }
            else
            {
                Config.message(Config._codeWords[WordsType.TYPEID_ERR][_loc_3]);
            }
            this._otherovershape.graphics.clear();
            this._selfovershape.graphics.clear();
            this.closedealpanel();
            this._okPB.enabled = false;
            this._okPB.selected = false;
            var _loc_4:* = 1;
            while (_loc_4 < this._selfSlotArray.length)
            {
                
                _loc_4 = _loc_4 + 1;
            }
            this._waitokLB.text = "";
            return;
        }// end function

        private function canceldeal2(event:MouseEvent = null) : void
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.CMSG_TRADE_CANCEL);
            _loc_2.add32(this.todealid);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        override public function close()
        {
            this.canceldeal2();
            Config.player.lock = false;
            Config.ui._bagUI.tempbtn.enabled = true;
            return;
        }// end function

        public function closedealpanel() : void
        {
            var _loc_1:* = this._slotStartIndex;
            while (_loc_1 < this._selfSlotArray.length)
            {
                
                if (this._selfSlotArray[_loc_1].item != null)
                {
                    Config.ui._charUI.itemunlock(this._selfSlotArray[_loc_1].item._position);
                    this._selfSlotArray[_loc_1].item.destroy();
                    this._selfSlotArray[_loc_1].item = null;
                }
                _loc_1 = _loc_1 + 1;
            }
            var _loc_2:* = this._slotStartIndex;
            while (_loc_2 < this._otherSlotArray.length)
            {
                
                if (this._otherSlotArray[_loc_2].item != null)
                {
                    this._otherSlotArray[_loc_2].item.destroy();
                    this._otherSlotArray[_loc_2].item = null;
                }
                _loc_2 = _loc_2 + 1;
            }
            super.close();
            Config.player.lock = false;
            Config.ui._bagUI.tempbtn.enabled = true;
            this._okPB.enabled = false;
            this._okPB.selected = false;
            this._waitokLB.text = "";
            this._selfovershape.graphics.clear();
            this._otherovershape.graphics.clear();
            this._selfCoinIT.tf.type = TextFieldType.INPUT;
            if (Config._switchEnglish)
            {
                this._selfCoinIT.tf.restrict = "^一-龥";
            }
            this._selfCoinIT.tf.selectable = true;
            Config.ui._charUI.allunloc();
            return;
        }// end function

        private function exchangelocked(event:MouseEvent, param2)
        {
            var _loc_4:* = 0;
            var _loc_5:* = null;
            if (param2 == 0)
            {
                this.submitshape(1, true);
                this._selfCoinIT.tf.type = TextFieldType.DYNAMIC;
                this._selfCoinIT.tf.selectable = false;
                if (this._selfCoinIT.text != "")
                {
                    _loc_5 = new DataSet();
                    _loc_5.addHead(CONST_ENUM.CMSG_TRADE_SETMONEY);
                    _loc_5.add32(Number(this._selfCoinIT.text));
                    ClientSocket.send(_loc_5);
                }
                _loc_4 = this._slotStartIndex;
                while (_loc_4 < this._selfSlotArray.length)
                {
                    
                    if (this._selfSlotArray[_loc_4].item != null)
                    {
                        this._selfSlotArray[_loc_4].lock();
                    }
                    _loc_4++;
                }
            }
            else if (param2 == 1)
            {
                this._selfCoinIT.tf.type = TextFieldType.INPUT;
                this._selfCoinIT.tf.selectable = true;
                if (Config._switchEnglish)
                {
                    this._selfCoinIT.tf.restrict = "^一-龥";
                }
                this.tempmoney = Number(this._selfCoinIT.text);
                this._selfovershape.graphics.clear();
                _loc_4 = this._slotStartIndex;
                while (_loc_4 < this._selfSlotArray.length)
                {
                    
                    if (this._selfSlotArray[_loc_4].item != null)
                    {
                        this._selfSlotArray[_loc_4].unlock();
                    }
                    _loc_4++;
                }
            }
            if (this._selfcheck.selected == false)
            {
                _loc_4 = 0;
                this._selfcheck.label = Config.language("DealUI", 21);
                this._selfcheck.buttonMode = false;
                this._selfcheck.enabled = false;
                this._selflockPB.visible = false;
                this._selfunlockPB.visible = true;
                this._selfcheck.selected = true;
                Config.message(Config.language("DealUI", 20));
            }
            else
            {
                _loc_4 = 1;
                this._selfcheck.label = Config.language("DealUI", 14);
                this._selfcheck.buttonMode = false;
                this._selfcheck.enabled = false;
                this._selflockPB.visible = true;
                this._selfunlockPB.visible = false;
                this._selfcheck.selected = false;
                this._othercheck.label = Config.language("DealUI", 14);
                this._othercheck.buttonMode = false;
                this._othercheck.enabled = false;
                this._othercheck.selected = false;
                this._otherovershape.graphics.clear();
                this._otherCoinLB.text = "0";
                Config.message(Config.language("DealUI", 22));
            }
            this.treatenble();
            var _loc_3:* = new DataSet();
            _loc_3.addHead(CONST_ENUM.CMSG_TRADE_LOCKUNLOCK);
            _loc_3.add8(_loc_4);
            ClientSocket.send(_loc_3);
            return;
        }// end function

        private function backlockcheck(event:SocketEvent) : void
        {
            var _loc_5:* = undefined;
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readByte();
            var _loc_4:* = _loc_2.readUnsignedInt();
            if (_loc_3 == 0 && _loc_4 != Config.player.id)
            {
                this._othercheck.label = Config.language("DealUI", 21);
                this._othercheck.buttonMode = false;
                this._othercheck.enabled = false;
                this._othercheck.selected = true;
                this.submitshape(0, true);
                Config.message(Config.language("DealUI", 23));
            }
            else if (_loc_3 == 1 && _loc_4 != Config.player.id)
            {
                Config.message(Config.language("DealUI", 23));
                this._othercheck.label = Config.language("DealUI", 14);
                this._othercheck.buttonMode = false;
                this._othercheck.enabled = false;
                this._othercheck.selected = false;
                this._otherovershape.graphics.clear();
                this._selfcheck.label = Config.language("DealUI", 14);
                this._selfcheck.buttonMode = false;
                this._selfcheck.enabled = false;
                this._selflockPB.visible = true;
                this._selfunlockPB.visible = false;
                this._selfcheck.selected = false;
                this._selfovershape.graphics.clear();
                this._selfCoinIT.tf.type = TextFieldType.INPUT;
                if (Config._switchEnglish)
                {
                    this._selfCoinIT.tf.restrict = "^一-龥";
                }
                this._selfCoinIT.tf.selectable = true;
                _loc_5 = this._slotStartIndex;
                while (_loc_5 < this._selfSlotArray.length)
                {
                    
                    if (this._selfSlotArray[_loc_5].item != null)
                    {
                        this._selfSlotArray[_loc_5].unlock();
                    }
                    _loc_5 = _loc_5 + 1;
                }
                this._otherCoinLB.text = "0";
            }
            this.treatenble();
            return;
        }// end function

        private function treatenble()
        {
            this._okPB.selected = false;
            if (this._selfcheck.label == Config.language("DealUI", 21) && this._othercheck.label == Config.language("DealUI", 21))
            {
                this._okPB.enabled = true;
            }
            else
            {
                this._okPB.enabled = false;
                this._waitokLB.text = "";
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
                    break;
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
