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

    public class FollowCharUI extends Window
    {
        private var _pageButton:ButtonBar;
        private var _charPanel:Sprite;
        private var protip:Sprite;
        private var leftpanel:Sprite;
        private var _propPanel:Sprite;
        private var _equipStartIndex:uint = 1021;
        private var _fightspr:FightSprit;
        private var _charTxtObj:Object;
        private var _infolaber:Label;
        private var proptextArr:Array;
        private var _followexp:uint;
        private var _maxexp:uint;
        private var _followlev:int = 0;
        private var _propArr:Array;
        private var _skillidArr:Array;
        private var _producbitArr:Array;
        private var _producArr:Array;
        private var _sampleClip:UnitClip;
        private var _goCharPB:PushButton;
        private var _goUpPB:PushButton;

        public function FollowCharUI(param1:DisplayObjectContainer = null)
        {
            this._skillidArr = [1, 2, 130, 131, 19, 20, 40, 125, 132, 134, 133, 135, 128, 126, 129, 127, 138, 136, 139, 137, 11, 124];
            this._producbitArr = [];
            this._producArr = [];
            super(param1);
            this.initsocket();
            this.initFolowchar();
            return;
        }// end function

        override public function open(event:MouseEvent = null)
        {
            super.open();
            this.x = Config.ui._charUI.x;
            this.y = Config.ui._charUI.y;
            this.title = Config.language("FollowCharUI", 1, Config.player.name);
            this._pageButton.selectpage = 0;
            this.equp();
            this._infolaber.text = Config.language("FollowCharUI", 2, Config.player.name, this.followlev);
            this.sendlistinfor();
            this.sendifopen(1);
            if (this._sampleClip != null)
            {
                this._sampleClip.wakeAnimation();
            }
            return;
        }// end function

        public function redrawFollower()
        {
            if (this._sampleClip != null)
            {
                this._sampleClip.destroy();
                if (this._sampleClip.parent != null)
                {
                    this._sampleClip.parent.removeChild(this._sampleClip);
                }
                this._sampleClip = null;
            }
            if (Config.player._followerID > 0)
            {
                this._sampleClip = UnitClip.newUnitClip(Config._model[Config.player._followerID]);
                this._sampleClip.changeStateTo("idle");
                this._sampleClip.changeDirectionTo(1);
                this._sampleClip.x = 120;
                this._sampleClip.y = 225;
                this._charPanel.addChild(this._sampleClip);
                if (_opening)
                {
                    this._sampleClip.wakeAnimation();
                }
            }
            return;
        }// end function

        override public function close()
        {
            super.close();
            this.sendifopen(0);
            if (this._sampleClip != null)
            {
                this._sampleClip.sleepAnimation();
            }
            return;
        }// end function

        private function initsocket()
        {
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_ACCOMPANY_INIT, this.initfollowinfor);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_ACCOMPANY_ATTRIB, this.getfollowinfor);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_ACCOMPANY_EXP, this.updatafollowexp);
            return;
        }// end function

        private function initFolowchar()
        {
            var _loc_2:* = undefined;
            var _loc_3:* = null;
            resize(580, 395);
            this.leftpanel = new Sprite();
            this.leftpanel.y = 50;
            this.addChild(this.leftpanel);
            this._pageButton = new ButtonBar(this, 10, 28, 250, -7);
            this._pageButton.lineFlag = true;
            this._pageButton.addTab(Config.language("CharUI", 43), this.equp);
            this._pageButton.addTab(Config.language("CharUI", 44), this.bless);
            this._pageButton.addTab(Config.language("CharUI", 41), this.frihtspr);
            this.initequip();
            this._infolaber = new Label(this._charPanel, 55, 15);
            this._infolaber.html = true;
            this._infolaber.autoSize = false;
            this._infolaber.height = 40;
            this._infolaber.width = 140;
            this._propPanel = new Sprite();
            this._propPanel.x = 255;
            this._propPanel.y = 50;
            this._propPanel.graphics.beginFill(16777215, 0.4);
            this._propPanel.graphics.drawRect(0, 0, 318, 75);
            this._propPanel.graphics.beginFill(16777215, 0.4);
            this._propPanel.graphics.drawRect(0, 80, 318, 75);
            this._propPanel.graphics.beginFill(16777215, 0.4);
            this._propPanel.graphics.drawRect(0, 160, 318, 135);
            this._propPanel.graphics.beginFill(16777215, 0.4);
            this._propPanel.graphics.drawRect(0, 300, 318, 35);
            this._propPanel.graphics.endFill();
            this.addChild(this._propPanel);
            this._charTxtObj = new Object();
            this._charTxtObj.hp = new Label(this._propPanel, 10, 15);
            this._charTxtObj.explabel = new Label(this._propPanel, 10, 50, Config.language("CharUI", 7));
            this._charTxtObj.expbar = new ProgressBar(this._propPanel, 60, 50);
            this._charTxtObj.expbar.height = 15;
            this._charTxtObj.expbar.width = 240;
            this._charTxtObj.expbar.gradientFillDirection = Math.PI;
            this._charTxtObj.expbar.roundCorner = 1;
            this._charTxtObj.expbar.color = 15981107;
            this._charTxtObj.expbar.subColor = 16750899;
            this._charTxtObj.exp = new Label(this._propPanel, 100, 50, this.followexp + " / " + this.maxexp);
            this.proptextArr = [];
            var _loc_1:* = 0;
            for (_loc_2 in Config._playerPropMap)
            {
                
                _loc_3 = this.getPropBtn(Config._playerPropMap[_loc_2], _loc_1);
                this._propPanel.addChild(_loc_3);
                _loc_3.x = _loc_1 % 2 * 140 + 10;
                _loc_3.y = 20 * int(_loc_1 / 2) + 90;
                if (_loc_1 >= 6)
                {
                    _loc_3.y = _loc_3.y + 15;
                }
                if (_loc_1 >= 18)
                {
                    _loc_3.y = _loc_3.y + 25;
                }
                _loc_1 = _loc_1 + 1;
            }
            return;
        }// end function

        private function equp(event:MouseEvent = null) : void
        {
            this.removeallchild(this.leftpanel);
            this.leftpanel.graphics.clear();
            this.leftpanel.addChild(this._charPanel);
            return;
        }// end function

        private function bless(event:MouseEvent) : void
        {
            this.removeallchild(this.leftpanel);
            this.leftpanel.graphics.clear();
            this.leftpanel.addChild(Config.ui._blessings);
            Config.ui._blessings.open(0);
            return;
        }// end function

        private function frihtspr(event:MouseEvent) : void
        {
            this.removeallchild(this.leftpanel);
            this.leftpanel.graphics.clear();
            this._fightspr = Config.ui._charUI.fightspr();
            this.leftpanel.addChild(this._fightspr);
            this._fightspr.panelflag = 20;
            this._fightspr.changeExtrapropcolor(0);
            this._fightspr.showinfor();
            return;
        }// end function

        private function setLevel(param1:int) : void
        {
            if (param1 < 20)
            {
                this._pageButton.tabarr[1].visible = false;
            }
            else
            {
                this._pageButton.tabarr[1].visible = true;
            }
            if (param1 < 60)
            {
                this._pageButton.tabarr[2].visible = false;
            }
            else
            {
                this._pageButton.tabarr[2].visible = true;
            }
            return;
        }// end function

        private function initequip()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = undefined;
            var _loc_3:* = null;
            this._charPanel = new Sprite();
            this._charPanel.x = 5;
            this.protip = new Sprite();
            _loc_1 = this._equipStartIndex;
            while (_loc_1 < this._equipStartIndex + 15)
            {
                
                Config.ui._charUI._slotArray[_loc_1] = new InvSlot(_loc_1, 32);
                this._charPanel.addChild(Config.ui._charUI._slotArray[_loc_1]);
                if (_loc_1 < this._equipStartIndex + 10)
                {
                    Config.ui._charUI._slotArray[_loc_1].bg = Config.findUI("charui")["icon" + (_loc_1 - this._equipStartIndex + 1)];
                }
                Config.ui._charUI._slotArray[_loc_1].addEventListener("sglClick", this.handleSlotClick);
                Config.ui._charUI._slotArray[_loc_1].addEventListener("drag", this.handleSlotClick);
                Config.ui._charUI._slotArray[_loc_1].addEventListener("dblClick", this.handleSlotDoubleClick);
                Config.ui._charUI._slotArray[_loc_1].addEventListener("up", this.handleSlotUp);
                Config.ui._charUI._slotArray[_loc_1].addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
                Config.ui._charUI._slotArray[_loc_1].addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
                _loc_1 = _loc_1 + 1;
            }
            var _loc_4:* = 17;
            var _loc_5:* = 197;
            var _loc_6:* = 60;
            var _loc_7:* = 44;
            Config.ui._charUI._slotArray[this._equipStartIndex + 0].x = _loc_4;
            Config.ui._charUI._slotArray[this._equipStartIndex + 0].y = _loc_6 + _loc_7 * 3;
            Config.ui._charUI._slotArray[(this._equipStartIndex + 1)].x = _loc_4;
            Config.ui._charUI._slotArray[(this._equipStartIndex + 1)].y = _loc_6;
            Config.ui._charUI._slotArray[this._equipStartIndex + 2].x = _loc_4;
            Config.ui._charUI._slotArray[this._equipStartIndex + 2].y = _loc_6 + _loc_7;
            Config.ui._charUI._slotArray[this._equipStartIndex + 3].x = _loc_4;
            Config.ui._charUI._slotArray[this._equipStartIndex + 3].y = _loc_6 + _loc_7 * 2;
            Config.ui._charUI._slotArray[this._equipStartIndex + 4].x = _loc_5;
            Config.ui._charUI._slotArray[this._equipStartIndex + 4].y = _loc_6 + _loc_7 * 3;
            Config.ui._charUI._slotArray[this._equipStartIndex + 5].x = _loc_4;
            Config.ui._charUI._slotArray[this._equipStartIndex + 5].y = _loc_6 + _loc_7 * 4;
            Config.ui._charUI._slotArray[this._equipStartIndex + 6].x = _loc_5;
            Config.ui._charUI._slotArray[this._equipStartIndex + 6].y = _loc_6 + _loc_7;
            Config.ui._charUI._slotArray[this._equipStartIndex + 7].x = _loc_5;
            Config.ui._charUI._slotArray[this._equipStartIndex + 7].y = _loc_6 + _loc_7 * 2;
            Config.ui._charUI._slotArray[this._equipStartIndex + 8].x = _loc_5;
            Config.ui._charUI._slotArray[this._equipStartIndex + 8].y = _loc_6;
            Config.ui._charUI._slotArray[this._equipStartIndex + 9].x = _loc_5;
            Config.ui._charUI._slotArray[this._equipStartIndex + 9].y = _loc_6 + _loc_7 * 4;
            Config.ui._charUI._slotArray[this._equipStartIndex + 10].x = 30;
            Config.ui._charUI._slotArray[this._equipStartIndex + 10].y = 290;
            Config.ui._charUI._slotArray[this._equipStartIndex + 11].x = 68;
            Config.ui._charUI._slotArray[this._equipStartIndex + 11].y = 290;
            Config.ui._charUI._slotArray[this._equipStartIndex + 12].x = 106;
            Config.ui._charUI._slotArray[this._equipStartIndex + 12].y = 290;
            Config.ui._charUI._slotArray[this._equipStartIndex + 13].x = 144;
            Config.ui._charUI._slotArray[this._equipStartIndex + 13].y = 290;
            Config.ui._charUI._slotArray[this._equipStartIndex + 14].x = 182;
            Config.ui._charUI._slotArray[this._equipStartIndex + 14].y = 290;
            this._goCharPB = new PushButton(this._charPanel, 55, 60, Config.language("FollowCharUI", 3), this.opencharpanel);
            this._goCharPB.setTable("table18", "table31");
            this._goCharPB.width = 65;
            this._goCharPB.height = 25;
            this._goCharPB.textColor = Style.GOLD_FONT;
            this.leftpanel.addChild(this._charPanel);
            this._goUpPB = new PushButton(this._charPanel, 125, 60, Config.language("FollowCharUI", 7), this.openFollowerUppanel);
            this._goUpPB.setTable("table18", "table31");
            this._goUpPB.width = 65;
            this._goUpPB.height = 25;
            this._goUpPB.textColor = Style.GOLD_FONT;
            this.hasUpPB = false;
            return;
        }// end function

        public function set hasUpPB(param1:Boolean) : void
        {
            this._goUpPB.visible = param1;
            if (param1)
            {
                this._goCharPB.x = 55;
            }
            else
            {
                this._goCharPB.x = 90;
            }
            return;
        }// end function

        private function opencharpanel(event:MouseEvent)
        {
            Config.ui._charUI.open();
            return;
        }// end function

        private function openFollowerUppanel(event:MouseEvent)
        {
            Config.ui._followupui.open();
            return;
        }// end function

        private function handleSlotClick(event:MouseEvent) : void
        {
            var _loc_2:* = event.currentTarget;
            this.clickSlot(_loc_2);
            return;
        }// end function

        private function handleSlotDoubleClick(event:MouseEvent) : void
        {
            var _loc_2:* = event.currentTarget;
            if (_loc_2.item != null && Holder.item == null && Config.getMouseState() == "")
            {
                Config.ui._charUI.useItem(_loc_2.item);
            }
            return;
        }// end function

        private function handleSlotUp(event:MouseEvent) : void
        {
            var _loc_2:* = event.currentTarget;
            if (Holder.item != null)
            {
                this.clickSlot(_loc_2);
            }
            return;
        }// end function

        private function clickSlot(param1) : void
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            if (Holder.item == null)
            {
                if (param1.item != null)
                {
                    if (Config.getMouseState() == "wing")
                    {
                        Config.ui._bagUI.wing(param1.item);
                        param1.item.backToSlot();
                        Config.setMouseState("", true);
                        return;
                    }
                    if (Config.getMouseState() == "recycle")
                    {
                        Config.ui._bagUI.recycle(param1.item);
                        param1.item.backToSlot();
                        Config.setMouseState("", true);
                        return;
                    }
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
                    this.removebitma(param1.item._position);
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
                    _loc_5 = new DataSet();
                    _loc_5.addHead(CONST_ENUM.CMSG_TRADE_REMOVEITEM);
                    _loc_5.add16(Holder.item._position);
                    ClientSocket.send(_loc_5);
                }
            }
            else if (Holder.item._drawer == Config.ui._charUI._slotArray)
            {
                if (Holder.item == param1.item)
                {
                    this.addfollowproductbitmap(param1.item._position);
                    param1.item = Holder.item;
                    Holder.item = null;
                }
                else
                {
                    Config.ui._charUI._holderBuff = param1.item;
                    Config.ui._charUI.swapItem(Holder.item, param1._id);
                    trace(param1._id, "slot._id", Holder.item._position);
                }
            }
            return;
        }// end function

        private function handleSlotOver(event:MouseEvent) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_2:* = event.currentTarget;
            if (_loc_2.item != null)
            {
                Holder.showInfo(_loc_2.item.outputInfo(), new Rectangle(_loc_2.x + _loc_2.parent.x + _loc_2.parent.parent.x + _loc_2.parent.parent.parent.x + _loc_2.parent.parent.parent.parent.x, _loc_2.y + _loc_2.parent.y + _loc_2.parent.parent.y + _loc_2.parent.parent.parent.y + _loc_2.parent.parent.parent.parent.y, _loc_2._size, _loc_2._size), false, 0, 250, _loc_2.item.star);
                if (int(_loc_2.item._itemData.suitID) > 0)
                {
                    _loc_3 = _loc_2.parent.localToGlobal(new Point(_loc_2.x, _loc_2.y));
                    Holder.showRightInfo(_loc_2.item.outfitInfo(3), new Rectangle(_loc_3.x, _loc_3.y, _loc_2._size, _loc_2._size));
                }
            }
            else
            {
                _loc_4 = "";
                _loc_5 = _loc_2._id - this._equipStartIndex + 1;
                if (_loc_5 >= 8)
                {
                    _loc_5 = _loc_5 - 1;
                }
                if (_loc_5 < 14)
                {
                    _loc_6 = Config._itemType[0].children()[2].children();
                    _loc_4 = Config.language("CharUI", 38, _loc_6[(_loc_5 - 1)].@label);
                }
                if (_loc_2._id >= 1031 && _loc_2._id <= 1035)
                {
                    _loc_4 = Config.language("FollowCharUI", 4);
                }
                _loc_3 = _loc_2.parent.localToGlobal(new Point(_loc_2.x, _loc_2.y));
                Holder.showInfo(_loc_4, new Rectangle(_loc_3.x, _loc_3.y, _loc_2._size, _loc_2._size), true, 0, 250);
            }
            return;
        }// end function

        private function handleSlotOut(event:MouseEvent) : void
        {
            Holder.closeInfo();
            return;
        }// end function

        private function initCharText() : void
        {
            var _loc_3:* = undefined;
            var _loc_1:* = "";
            _loc_1 = Config.language("CharUI", 4) + this._propArr[1];
            if (_loc_1 == null)
            {
                _loc_1 = "";
            }
            this._charTxtObj.hp.text = _loc_1;
            if (this.followlev < Setting.FOLLOW_MAX_LEVEL)
            {
                this._charTxtObj.expbar.maximum = this.maxexp;
                this._charTxtObj.expbar.value = this.followexp;
                this._charTxtObj.exp.text = this.followexp + " / " + this.maxexp;
            }
            else
            {
                this._charTxtObj.expbar.maximum = this.maxexp;
                this._charTxtObj.expbar.value = 0;
                this._charTxtObj.exp.text = Config.language("FollowCharUI", 5);
            }
            this._charTxtObj.exp.x = 60 + (240 - this._charTxtObj.exp.width) / 2;
            var _loc_2:* = 0;
            for (_loc_3 in Config._playerPropMap)
            {
                
                _loc_1 = Config._playerPropMap[_loc_3].name;
                if (_loc_1 == null)
                {
                    _loc_1 = "";
                }
                this.proptextArr[_loc_2].lb.text = _loc_1;
                _loc_1 = this._propArr[Config._playerPropMap[_loc_3].skillid];
                if (_loc_1 == null)
                {
                    _loc_1 = "";
                }
                this.proptextArr[_loc_2].ptext.text = _loc_1;
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        private function getPropBtn(param1:Object, param2:int) : Sprite
        {
            var _loc_3:* = new Sprite();
            _loc_3.graphics.beginFill(6710886, 0.2);
            var _loc_4:* = new Object();
            new Object().lb = new Label(_loc_3, 0, 0);
            _loc_4.ptext = new Label(_loc_3, 90, 0);
            this.proptextArr.push(_loc_4);
            if (param2 % 2 == 0)
            {
                _loc_3.graphics.drawRect(85, 3, 50, 14);
                _loc_4.ptext.x = 90;
            }
            else
            {
                _loc_3.graphics.drawRect(110, 3, 50, 14);
                _loc_4.ptext.x = 115;
            }
            _loc_3.graphics.endFill();
            return _loc_3;
        }// end function

        private function initfollowinfor(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            this.followlev = _loc_2.readUnsignedShort();
            this.followexp = _loc_2.readUnsignedInt();
            this.maxexp = _loc_2.readUnsignedInt();
            this._infolaber.text = Config.language("FollowCharUI", 2, Config.player.name, this.followlev);
            if (this.followlev >= Setting.FOLLOW_MAX_LEVEL)
            {
                this._charTxtObj.exp.text = Config.language("FollowCharUI", 5);
            }
            this.setLevel(this.followlev);
            return;
        }// end function

        public function sendlistinfor() : void
        {
            var _loc_1:* = new DataSet();
            _loc_1.addHead(CONST_ENUM.C2G_ACCOMPANY_ATTRIB);
            ClientSocket.send(_loc_1);
            return;
        }// end function

        private function getfollowinfor(event:SocketEvent) : void
        {
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            this._propArr = [];
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readByte();
            var _loc_4:* = 0;
            while (_loc_4 < this._skillidArr.length)
            {
                
                this._propArr[this._skillidArr[_loc_4]] = 0;
                _loc_4++;
            }
            var _loc_5:* = 0;
            while (_loc_5 < _loc_3)
            {
                
                _loc_6 = _loc_2.readUnsignedShort();
                _loc_7 = _loc_2.readUnsignedInt();
                this._propArr[_loc_6] = _loc_7;
                trace(_loc_6, _loc_7, "+++++++++");
                _loc_5++;
            }
            this.initCharText();
            return;
        }// end function

        private function sendifopen(param1:int) : void
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_ACCOMPANY_OPEN);
            _loc_2.add8(param1);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function updatafollowexp(event:SocketEvent) : void
        {
            var _loc_5:* = 0;
            var _loc_2:* = event.data;
            var _loc_3:* = this.followexp;
            this.followexp = _loc_2.readUnsignedInt();
            var _loc_4:* = _loc_2.readUnsignedByte();
            this._charTxtObj.expbar.maximum = this.maxexp;
            this._charTxtObj.expbar.value = this.followexp;
            this._charTxtObj.exp.text = this.followexp + " / " + this.maxexp;
            if (_loc_4 == 1)
            {
                _loc_5 = _loc_2.readInt();
                Config.ui._mesHistoryPanel.addHistory(Config.language("FollowCharUI", 6, _loc_5));
            }
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

        public function set followlev(param1:int) : void
        {
            this._followlev = param1;
            return;
        }// end function

        public function get followlev() : int
        {
            return this._followlev;
        }// end function

        public function set followexp(param1:uint) : void
        {
            this._followexp = param1;
            return;
        }// end function

        public function get followexp() : uint
        {
            return this._followexp;
        }// end function

        public function set maxexp(param1:uint) : void
        {
            this._maxexp = param1;
            return;
        }// end function

        public function get maxexp() : uint
        {
            return this._maxexp;
        }// end function

        public function addfollowproductbitmap(param1:int)
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (param1 >= 1021 && param1 <= 1030)
            {
                this.removebitma(param1);
                if (Config.ui._charUI._slotArray[param1].item._itemData.reqLevel == 1)
                {
                    return;
                }
                if (Config.ui._charUI._slotArray[param1].item._itemData.qual <= 5 && !Config.ui._charUI._slotArray[param1]._locked)
                {
                    _loc_2 = new Sprite();
                    _loc_2.buttonMode = true;
                    this.removebitma(param1);
                    this._charPanel.addChild(_loc_2);
                    this._producArr[param1] = _loc_2;
                    _loc_3 = new Bitmap();
                    _loc_3.bitmapData = Config.findsysUI("button/message_3", 15, 15);
                    _loc_2.addChild(_loc_3);
                    this._producbitArr[param1] = _loc_3;
                    _loc_2.addEventListener(MouseEvent.ROLL_OUT, this.iconOut);
                    _loc_2.addEventListener(MouseEvent.ROLL_OVER, this.iconOver);
                    _loc_2.addEventListener(MouseEvent.CLICK, Config.create(this.openproducepanel, param1));
                    _loc_2.x = Config.ui._charUI._slotArray[param1].x + 19;
                    _loc_2.y = Config.ui._charUI._slotArray[param1].y + 19;
                }
            }
            return;
        }// end function

        private function iconOut(event:MouseEvent)
        {
            Holder.closeInfo();
            return;
        }// end function

        private function iconOver(event:MouseEvent)
        {
            var _loc_2:* = event.currentTarget;
            var _loc_3:* = _loc_2.parent.localToGlobal(new Point(_loc_2.x, _loc_2.y));
            Holder.showInfo(Config.language("CharUI", 47), new Rectangle(_loc_3.x, _loc_3.y, 20, 20), true, 0, 220);
            return;
        }// end function

        private function openproducepanel(event:MouseEvent, param2:int)
        {
            if (Config.ui._charUI._slotArray[param2].item != null)
            {
                Config.ui._producepanel.openproduce(Config.ui._charUI._slotArray[param2].item, param2);
            }
            return;
        }// end function

        public function removebitma(param1:int)
        {
            if (this._producbitArr[param1] != null)
            {
                if (this._producbitArr[param1].hasOwnProperty("bitmapData"))
                {
                    this._producbitArr[param1].bitmapData.dispose();
                    this._producbitArr[param1] = null;
                }
            }
            if (this._producArr[param1] != null)
            {
                if (this._producArr[param1].parent != null)
                {
                    this._producArr[param1].removeEventListener(MouseEvent.ROLL_OUT, this.iconOut);
                    this._producArr[param1].removeEventListener(MouseEvent.ROLL_OVER, this.iconOver);
                    this._producArr[param1].removeEventListener(MouseEvent.CLICK, Config.create(this.openproducepanel, param1));
                    this._producArr[param1].parent.removeChild(this._producArr[param1]);
                }
            }
            return;
        }// end function

    }
}
