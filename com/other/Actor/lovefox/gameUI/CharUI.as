package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import flash.utils.*;
    import lovefox.component.*;
    import lovefox.game.*;
    import lovefox.socket.*;
    import lovefox.unit.*;

    public class CharUI extends Window
    {
        private var _charPropObj:Object;
        public var _equipStartIndex:Object = 1001;
        private var _slotSize:Object = 32;
        private var _slotNumber:Object = 24;
        public var _slotArray:Array;
        public var _showClothCB:CheckBox;
        public var _showHorseCB:CheckBox;
        public var _showWingCB:CheckBox;
        private var _invX:Object = 10;
        private var _invY:Object = 30;
        private var _invOffset:Object = 34;
        private var mainpanel:Sprite;
        private var leftpanel:Sprite;
        private var _charPanel:Sprite;
        private var _propPanel:Sprite;
        private var _fatimaPanel:Sprite;
        public var _itemArray:Array;
        public var _itembagwareArr:Array;
        private var _player:Unit;
        private var _sampleClip:UnitClip;
        private var _horseClip:UnitClip;
        private var _left:Object;
        private var _infoLB:Label;
        public var _holderBuff:Object;
        private var _charTxtObj:Object;
        private var splitpanel:ItemSplit;
        private var splitposition:int = -1;
        private var lockarr:Array;
        private var _lockExtract:Boolean = false;
        private var _lockExtractTimer:Object;
        private var _firenum:int = 0;
        private var protip:Sprite;
        private var _hairTxt:TextField;
        private var _fashionAlertId:uint;
        private var _fashionClip:UnitClip;
        private var _titleStack:Object;
        private var _titleCB:ComboBox;
        private var _pageButton:ButtonBar;
        private var fubenFlag:Boolean = false;
        private var futempId:int = 0;
        private var futempNpcId:int = 0;
        private var _entertainInfo:Array;
        private var blessBtn:PushButton;
        private var _spr:FightSprit;
        private var _producbitArr:Array;
        private var _producArr:Array;
        private var _hammerAlertID:int = -1;
        private var followBtn:PushButton;
        private var _followerClip:UnitClip;
        public static var _buffProp:Object;

        public function CharUI(param1)
        {
            this._charPropObj = new Object();
            this._itemArray = [];
            this._itembagwareArr = [];
            this._charTxtObj = {};
            this._titleStack = [];
            this._entertainInfo = [];
            this._producbitArr = [];
            this._producArr = [];
            super(param1);
            resize(580, 395);
            title = Config.language("CharUI", 1);
            this.initDraw();
            this.lockarr = new Array();
            this._spr = new FightSprit();
            this._spr.x = 5;
            this._spr.y = -25;
            this.graphics.endFill();
            return;
        }// end function

        override public function testGuide()
        {
            if (GuideUI.testId(47))
            {
                GuideUI.doId(47, this._pageButton.tabarr[1]);
            }
            else if (GuideUI.testId(10))
            {
                GuideUI.doId(10, this._titleCB.button);
                this._titleCB.addEventListener(Event.OPEN, this.handleTitleCBOpen);
            }
            else if (GuideUI.testId(31))
            {
                GuideUI.doId(31, this._pageButton.tabarr[2]);
            }
            else if (GuideUI.testId(81))
            {
                GuideUI.doId(81, this._pageButton.tabarr[3]);
            }
            return;
        }// end function

        private function handleTitleCBOpen(param1)
        {
            var _loc_2:* = 0;
            while (_loc_2 < this._titleCB.itemArray.length)
            {
                
                if (this._titleCB.itemArray[_loc_2].id == 100)
                {
                    GuideUI.testDoId(13, this._titleCB.getItemBackground(this._titleCB.itemArray[_loc_2]));
                    this._titleCB.removeEventListener(Event.OPEN, this.handleTitleCBOpen);
                    return;
                }
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        override public function open(event:MouseEvent = null)
        {
            Config.ui._followcharui.close();
            super.open(event);
            this.x = Config.ui._followcharui.x;
            this.y = Config.ui._followcharui.y;
            if (this._sampleClip != null)
            {
                this._sampleClip.wakeAnimation();
            }
            if (this._horseClip != null)
            {
                this._horseClip.wakeAnimation();
            }
            if (this._charTxtObj != null && this._charTxtObj.gildname != null && Config.player != null)
            {
                this._charTxtObj.gildname.text = Config.language("CharUI", 2) + Config.player._gilename;
            }
            if (this._pageButton != null)
            {
                if (this._pageButton.selectpage == 2)
                {
                    this._spr.panelflag = 0;
                    this._spr.changeExtrapropcolor(0);
                    this._spr.showinfor();
                }
            }
            if (this.followBtn != null)
            {
                if (Config.player.level >= 80)
                {
                    if (this._followerClip != null)
                    {
                        this._followerClip.wakeAnimation();
                        this._charPanel.addChild(this._followerClip);
                        this._charPanel.addChild(this._titleCB);
                    }
                    this.followBtn.visible = true;
                }
                else
                {
                    this.followBtn.visible = false;
                }
            }
            return;
        }// end function

        public function redrawFollower()
        {
            if (this._followerClip != null)
            {
                this._followerClip.destroy();
                if (this._followerClip.parent != null)
                {
                    this._followerClip.parent.removeChild(this._followerClip);
                }
                this._followerClip = null;
            }
            if (Config.player._followerID > 0)
            {
                this._followerClip = UnitClip.newUnitClip(Config._model[Config.player._followerID]);
                this._followerClip.changeStateTo("idle");
                this._followerClip.changeDirectionTo(1);
                this._followerClip.x = 140 + 18;
                this._followerClip.y = 155;
                this._followerClip.shadow = false;
                if (_opening)
                {
                    this._followerClip.wakeAnimation();
                    this._charPanel.addChild(this._followerClip);
                    this._charPanel.addChild(this._titleCB);
                }
            }
            Config.ui._followcharui.redrawFollower();
            return;
        }// end function

        override public function close()
        {
            super.close();
            if (this._sampleClip != null)
            {
                this._sampleClip.sleepAnimation();
            }
            if (this._horseClip != null)
            {
                this._horseClip.sleepAnimation();
            }
            if (this._spr != null)
            {
                this._spr.removebitmap();
            }
            if (this._followerClip != null)
            {
                this._followerClip.sleepAnimation();
            }
            return;
        }// end function

        public function getOneItemSlot(param1)
        {
            var _loc_2:* = this.getOneItem(param1);
            if (_loc_2 != null)
            {
                return this._slotArray[_loc_2._position];
            }
            return null;
        }// end function

        public function getOneItemTypeSlot(param1)
        {
            var _loc_2:* = this.getOneItemType(param1);
            if (_loc_2 != null)
            {
                return this._slotArray[_loc_2._position];
            }
            return null;
        }// end function

        public function getOneItemType(param1, param2 = null)
        {
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            _loc_4 = 0;
            while (_loc_4 < this._itemArray.length)
            {
                
                _loc_3 = this._itemArray[_loc_4];
                if (int(_loc_3._itemData.type) == param1 && (param2 == null || param2 == int(_loc_3._itemData.subType)))
                {
                    return _loc_3;
                }
                _loc_4 = _loc_4 + 1;
            }
            return null;
        }// end function

        public function getOneItem(param1)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            _loc_3 = 0;
            while (_loc_3 < this._itemArray.length)
            {
                
                _loc_2 = this._itemArray[_loc_3];
                if (int(_loc_2._itemData.baseID) == param1)
                {
                    return _loc_2;
                }
                _loc_3 = _loc_3 + 1;
            }
            return null;
        }// end function

        public function getItemAmount(param1)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = 0;
            _loc_3 = 0;
            while (_loc_3 < this._itemArray.length)
            {
                
                _loc_2 = this._itemArray[_loc_3];
                if (int(_loc_2._itemData.baseID) == param1)
                {
                    _loc_4 = _loc_4 + _loc_2.amount;
                }
                _loc_3 = _loc_3 + 1;
            }
            return _loc_4;
        }// end function

        public function getItemAmountBag(param1)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = 0;
            _loc_3 = 0;
            while (_loc_3 < this._itemArray.length)
            {
                
                _loc_2 = this._itemArray[_loc_3];
                if (_loc_2._position < this._equipStartIndex)
                {
                    if (int(_loc_2._itemData.baseID) == param1)
                    {
                        _loc_4 = _loc_4 + _loc_2.amount;
                    }
                }
                _loc_3 = _loc_3 + 1;
            }
            return _loc_4;
        }// end function

        public function getItemArr(param1) : Array
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_2:* = new Array();
            var _loc_3:* = 0;
            while (_loc_3 < this._itemArray.length)
            {
                
                _loc_4 = this._itemArray[_loc_3];
                if (_loc_4._itemData.baseID == param1)
                {
                    _loc_5 = new Object();
                    _loc_5.amount = _loc_4.amount;
                    _loc_5.position = _loc_4._position;
                    _loc_2.push(_loc_5);
                }
                _loc_3 = _loc_3 + 1;
            }
            return _loc_2;
        }// end function

        public function getItemIdArr() : Array
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_1:* = [];
            _loc_2 = 0;
            while (_loc_2 < this._itemArray.length)
            {
                
                _loc_3 = this._itemArray[_loc_2];
                if (_loc_3._itemData.type == 4 && (_loc_3._itemData.subType == 11 || _loc_3._itemData.subType == 13))
                {
                    _loc_1.push(_loc_3._itemData.baseID);
                }
                _loc_2 = _loc_2 + 1;
            }
            _loc_2 = 0;
            while (_loc_2 < this._itembagwareArr.length)
            {
                
                _loc_3 = this._itembagwareArr[_loc_2];
                if (_loc_3._itemData.type == 4 && (_loc_3._itemData.subType == 11 || _loc_3._itemData.subType == 13))
                {
                    _loc_1.push(_loc_3._itemData.baseID);
                }
                _loc_2 = _loc_2 + 1;
            }
            return _loc_1;
        }// end function

        private function initDraw()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = undefined;
            var _loc_3:* = null;
            this._slotArray = [];
            this._charPanel = new Sprite();
            this._charPanel.x = 5;
            this.protip = new Sprite();
            _loc_1 = this._equipStartIndex;
            while (_loc_1 < this._equipStartIndex + 14)
            {
                
                this._slotArray[_loc_1] = new InvSlot(_loc_1, this._slotSize);
                this._charPanel.addChild(this._slotArray[_loc_1]);
                this._slotArray[_loc_1].bg = Config.findUI("charui")["icon" + (_loc_1 - this._equipStartIndex + 1)];
                this._slotArray[_loc_1].addEventListener("sglClick", this.handleSlotClick);
                this._slotArray[_loc_1].addEventListener("drag", this.handleSlotClick);
                this._slotArray[_loc_1].addEventListener("dblClick", this.handleSlotDoubleClick);
                this._slotArray[_loc_1].addEventListener("up", this.handleSlotUp);
                this._slotArray[_loc_1].addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
                this._slotArray[_loc_1].addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
                _loc_1 = _loc_1 + 1;
            }
            var _loc_4:* = 17;
            var _loc_5:* = 197;
            var _loc_6:* = 60;
            var _loc_7:* = 44;
            this._slotArray[this._equipStartIndex + 0].x = _loc_4;
            this._slotArray[this._equipStartIndex + 0].y = _loc_6 + _loc_7 * 3;
            this._slotArray[(this._equipStartIndex + 1)].x = _loc_4;
            this._slotArray[(this._equipStartIndex + 1)].y = _loc_6;
            this._slotArray[this._equipStartIndex + 2].x = _loc_4;
            this._slotArray[this._equipStartIndex + 2].y = _loc_6 + _loc_7;
            this._slotArray[this._equipStartIndex + 3].x = _loc_4;
            this._slotArray[this._equipStartIndex + 3].y = _loc_6 + _loc_7 * 2;
            this._slotArray[this._equipStartIndex + 4].x = _loc_5;
            this._slotArray[this._equipStartIndex + 4].y = _loc_6 + _loc_7 * 3;
            this._slotArray[this._equipStartIndex + 5].x = _loc_4;
            this._slotArray[this._equipStartIndex + 5].y = _loc_6 + _loc_7 * 4;
            this._slotArray[this._equipStartIndex + 6].x = _loc_5;
            this._slotArray[this._equipStartIndex + 6].y = _loc_6 + _loc_7;
            this._slotArray[this._equipStartIndex + 7].x = _loc_5;
            this._slotArray[this._equipStartIndex + 7].y = _loc_6 + _loc_7 * 2;
            this._slotArray[this._equipStartIndex + 8].x = _loc_5;
            this._slotArray[this._equipStartIndex + 8].y = _loc_6;
            this._slotArray[this._equipStartIndex + 9].x = _loc_5;
            this._slotArray[this._equipStartIndex + 9].y = _loc_6 + _loc_7 * 4;
            this._slotArray[this._equipStartIndex + 11].x = 48;
            this._slotArray[this._equipStartIndex + 11].y = 290;
            this._slotArray[this._equipStartIndex + 10].x = 86;
            this._slotArray[this._equipStartIndex + 10].y = 290;
            this._slotArray[this._equipStartIndex + 12].x = 124;
            this._slotArray[this._equipStartIndex + 12].y = 290;
            this._slotArray[this._equipStartIndex + 13].x = 162;
            this._slotArray[this._equipStartIndex + 13].y = 290;
            this._showClothCB = new CheckBox(this._charPanel, 63, 85, Config.language("CharUI", 3), this.handleShowCloth);
            this._showHorseCB = new CheckBox(this._charPanel, 63, 105, Config.language("CharUI", 36), this.handleShowHorse);
            this._showWingCB = new CheckBox(this._charPanel, 63, 125, Config.language("CharUI", 48), this.handleShowWing);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.SMSG_ITEM_LIST, this.handleItemList);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.SMSG_ITEM_UPDATE, this.handleItemUpdate);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.SMSG_ITEM_BUY, this.handleItemBuy);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.SMSG_ITEM_CD, this.handleItemCd);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_ITEM_COOLDOWN, this.handleItemCd1);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_ITEM_COOLDOWN_LIST, this.handleItemCd1List);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_ROLE_INFO, this.handleCharQuery);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_GET_ITEM, this.itemmessage);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_NEEDFIRE_COUNT, this.getfirenum);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_EQUIP_SHOW, this.handleItemShow);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_HAIRCOLOR, this.handleHairColor);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_TITLE_LIST, this.hanleTitleList);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_TITLE_ADD, this.hanleTitleAdd);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_TITLE_DELETE, this.hanleTitleDelete);
            this.mainpanel = new Sprite();
            this.addChild(this.mainpanel);
            this.mainpanel.x = 255;
            this.mainpanel.y = 50;
            this.leftpanel = new Sprite();
            this.addChild(this.leftpanel);
            this.leftpanel.y = 50;
            this._pageButton = new ButtonBar(this, 10, 28, 250, -7);
            this._pageButton.lineFlag = true;
            this._pageButton.addTab(Config.language("CharUI", 43), this.equipPanel);
            this._pageButton.addTab(Config.language("CharUI", 44), this.wizardPanel);
            this._pageButton.addTab(Config.language("CharUI", 41), this.fightspritePanel);
            this._pageButton.addTab(Config.language("CharUI", 45), this.elementPanel);
            this._propPanel = new Sprite();
            this.playerInfor();
            this._infoLB = new Label(this._charPanel, 55, 15);
            this._infoLB.autoSize = false;
            this._infoLB.height = 40;
            this._infoLB.width = 140;
            this._infoLB.html = true;
            this._titleCB = new ComboBox(this._charPanel, 63, 55, this.handleTitleBoxChange);
            this._titleCB.width = 125;
            this.equipPanel();
            this.followBtn = new PushButton(this._charPanel, 140, 120, Config.language("CharUI", 51), this.openfollowpanel);
            this.followBtn.setTable("table18", "table31");
            this.followBtn.width = 40;
            this.followBtn.height = 25;
            this.followBtn.textColor = Style.GOLD_FONT;
            this.followBtn.visible = false;
            return;
        }// end function

        private function openfollowpanel(event:MouseEvent)
        {
            Config.ui._charUI.close();
            Config.ui._followcharui.open();
            return;
        }// end function

        public function setLevel(param1:int) : void
        {
            if (param1 < 20 || !Config.ver_zhufu)
            {
                this._pageButton.tabarr[1].visible = false;
            }
            else
            {
                this._pageButton.tabarr[1].visible = true;
            }
            if (param1 < 60 || !Config.ver_zhanhun)
            {
                this._pageButton.tabarr[2].visible = false;
            }
            else
            {
                this._pageButton.tabarr[2].visible = true;
            }
            if (param1 < 70 || !Config.ver_yuansu)
            {
                this._pageButton.tabarr[3].visible = false;
            }
            else
            {
                this._pageButton.tabarr[3].visible = true;
            }
            return;
        }// end function

        private function fightspiritopen(event:MouseEvent = null)
        {
            if (Config.player.level >= 60)
            {
                this._charPanel.addChild(this._spr);
                this._spr.panelflag = 0;
                this._spr.changeExtrapropcolor(0);
                this._spr.showinfor();
            }
            return;
        }// end function

        public function closefightsprit()
        {
            if (this._spr != null)
            {
                if (this._spr.parent != null)
                {
                    this._spr.parent.removeChild(this._spr);
                }
            }
            return;
        }// end function

        public function selectPage(param1:int = 0) : void
        {
            if (param1 != this._pageButton.selectpage)
            {
                this.open();
            }
            else
            {
                this.switchOpen();
            }
            if (param1 == 0)
            {
                this._pageButton.selectpage = 0;
                this.playerInfor();
            }
            else if (param1 == 1)
            {
                this.wizardPanel();
                this._pageButton.selectpage = 1;
            }
            return;
        }// end function

        private function fightspritePanel(event:MouseEvent = null) : void
        {
            this.removeallchild(this.leftpanel);
            this.leftpanel.graphics.clear();
            this.leftpanel.addChild(this._spr);
            this._spr.panelflag = 0;
            this._spr.changeExtrapropcolor(0);
            this._spr.showinfor();
            GuideUI.testDoId(32, this._spr._slotArray[this._equipStartIndex]);
            return;
        }// end function

        private function equipPanel(event:MouseEvent = null) : void
        {
            this.removeallchild(this.leftpanel);
            this.leftpanel.graphics.clear();
            this.leftpanel.addChild(this._charPanel);
            return;
        }// end function

        private function wizardPanel(event:MouseEvent = null) : void
        {
            this.removeallchild(this.leftpanel);
            this.leftpanel.graphics.clear();
            this.leftpanel.addChild(Config.ui._blessings);
            Config.ui._blessings.open();
            return;
        }// end function

        private function elementPanel(event:MouseEvent = null) : void
        {
            this.removeallchild(this.leftpanel);
            this.leftpanel.graphics.clear();
            this.leftpanel.addChild(Config.ui._elementUI);
            Config.ui._elementUI.open();
            return;
        }// end function

        private function playerInfor(event:MouseEvent = null) : void
        {
            this.removeallchild(this.mainpanel);
            this.mainpanel.graphics.clear();
            this.mainpanel.graphics.beginFill(16777215, 0.4);
            this.mainpanel.graphics.drawRect(0, 0, 318, 75);
            this.mainpanel.graphics.beginFill(16777215, 0.4);
            this.mainpanel.graphics.drawRect(0, 80, 318, 75);
            this.mainpanel.graphics.beginFill(16777215, 0.4);
            this.mainpanel.graphics.drawRect(0, 160, 318, 135);
            this.mainpanel.graphics.beginFill(16777215, 0.4);
            this.mainpanel.graphics.drawRect(0, 300, 318, 35);
            this.mainpanel.graphics.endFill();
            this.mainpanel.addChild(this._propPanel);
            return;
        }// end function

        private function initCharText() : void
        {
            var _loc_3:* = undefined;
            var _loc_4:* = null;
            this.removeallchild(this._propPanel);
            this._charTxtObj = new Object();
            this._charTxtObj.hp = new Label(this._propPanel, 10, 5, Config.language("CharUI", 4) + Config.player.hp + "/" + Config.player.hpMax);
            this._charTxtObj.gildname = new Label(this._propPanel, 180, 5, Config.language("CharUI", 2) + Config.player._gilename);
            this._charTxtObj.mp = new Label(this._propPanel, 10, 25, Config.language("CharUI", 5) + Config.player.mp + "/" + Config.player.mpMax);
            this._charTxtObj.speed = new Label(this._propPanel, 180, 25, Config.language("CharUI", 6) + Config.player.speed);
            this._charTxtObj.explabel = new Label(this._propPanel, 10, 50, Config.language("CharUI", 7));
            var _loc_1:* = new ProgressBar(this._propPanel, 60, 50);
            _loc_1.height = 15;
            _loc_1.width = 240;
            _loc_1.gradientFillDirection = Math.PI;
            _loc_1.roundCorner = 1;
            _loc_1.color = 15981107;
            _loc_1.subColor = 16750899;
            _loc_1.maximum = Config.player.expUpdate;
            _loc_1.value = Config.player.exp;
            this._charTxtObj.expbar = _loc_1;
            this._charTxtObj.exp = new Label(this._propPanel, 100, 50, Config.player.exp + " / " + Config.player.expUpdate);
            this._charTxtObj.exp.x = 60 + (240 - this._charTxtObj.exp.width) / 2;
            var _loc_2:* = 0;
            for (_loc_3 in Config._playerPropMap)
            {
                
                _loc_4 = this.getPropBtn(Config._playerPropMap[_loc_3], _loc_2);
                this._propPanel.addChild(_loc_4);
                _loc_4.x = _loc_2 % 2 * 140 + 10;
                _loc_4.y = 20 * int(_loc_2 / 2) + 90;
                if (_loc_2 >= 6)
                {
                    _loc_4.y = _loc_4.y + 15;
                }
                if (_loc_2 >= 18)
                {
                    _loc_4.y = _loc_4.y + 25;
                }
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        private function getPropBtn(param1:Object, param2:int) : Sprite
        {
            var _loc_3:* = new Sprite();
            _loc_3.graphics.beginFill(6710886, 0.2);
            var _loc_4:* = new Label(_loc_3, 0, 0, param1.name);
            var _loc_5:* = new Label(_loc_3, 90, 0, Config.player[param1.lb]);
            this._charTxtObj[param1.lb] = _loc_5;
            if (param2 % 2 == 0)
            {
                _loc_3.graphics.drawRect(85, 3, 50, 14);
                _loc_5.x = 90;
            }
            else
            {
                _loc_3.graphics.drawRect(110, 3, 50, 14);
                _loc_5.x = 115;
            }
            _loc_3.graphics.endFill();
            _loc_3.addEventListener(MouseEvent.ROLL_OUT, this.handleCloseTips);
            _loc_3.addEventListener(MouseEvent.ROLL_OVER, Config.create(this.handleShowTips, param1));
            return _loc_3;
        }// end function

        private function handleShowTips(event:Event, param2:Object) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = undefined;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = NaN;
            var _loc_11:* = NaN;
            if (param2.hasOwnProperty("tips"))
            {
                _loc_3 = param2.tips;
                if (param2.hasOwnProperty("conprop"))
                {
                    _loc_9 = /%a""%a/g;
                    _loc_3 = _loc_3.replace(_loc_9, String(Number(Config.player[param2.conprop])));
                }
                _loc_4 = /%b""%b/g;
                _loc_3 = _loc_3.replace(_loc_4, String(Number(Config.player[param2.lb])));
                _loc_5 = /%c""%c/g;
                if (int(param2.xflag) == 1)
                {
                    _loc_3 = _loc_3.replace(_loc_5, String(Number(Config.player[param2.lb])));
                }
                else
                {
                    _loc_3 = _loc_3.replace(_loc_5, String(int(Number(Config.player[param2.lb]) * Config._proRevise[Config.player.level]["m" + param2.proNum])));
                }
                _loc_6 = /%d""%d/g;
                switch(int(param2.ation))
                {
                    case 1:
                    {
                        if (_loc_10 < 0)
                        {
                        }
                        break;
                    }
                    case 2:
                    {
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                switch(int(param2.ation))
                {
                    case 1:
                    {
                        if (_loc_11 < 0)
                        {
                        }
                        break;
                    }
                    case 2:
                    {
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                _loc_7 = event.currentTarget;
                _loc_8 = _loc_7.parent.localToGlobal(new Point(_loc_7.x + 140, _loc_7.y));
                Holder.showInfo(_loc_3, new Rectangle(_loc_8.x, _loc_8.y, 0, 0), false, 1);
            }
            return;
        }// end function

        private function handleCloseTips(event:MouseEvent) : void
        {
            Holder.closeInfo();
            return;
        }// end function

        private function handleTitleBoxChange(param1)
        {
            this.selectTitle(this._titleCB.selectedItem.id);
            return;
        }// end function

        public function titleIdChange(param1)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            _loc_3 = 0;
            while (_loc_3 < this._titleCB.itemArray.length)
            {
                
                if (this._titleCB.itemArray[_loc_3].id == param1)
                {
                    _loc_2 = this._titleCB.itemArray[_loc_3];
                    break;
                }
                _loc_3 = _loc_3 + 1;
            }
            this._titleCB.selectedItem = _loc_2;
            return;
        }// end function

        private function refreshTitleCB()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_3:* = [];
            var _loc_7:* = Config._replace1;
            for (_loc_1 in this._titleStack)
            {
                
                _loc_6 = "";
                _loc_2 = 1;
                while (_loc_2 < 11)
                {
                    
                    if (Config._titleMap[_loc_1]["effectId" + _loc_2] != 0)
                    {
                        if (_loc_6 != "")
                        {
                            _loc_6 = _loc_6 + "\n";
                        }
                        _loc_6 = _loc_6 + String(Config._itemPropMap[Config._titleMap[_loc_1]["effectId" + _loc_2]].prop).replace(_loc_7, Config._titleMap[_loc_1]["effectValue" + _loc_2]);
                    }
                    _loc_2 = _loc_2 + 1;
                }
                if (_loc_6 == "")
                {
                    _loc_6 = Config.language("CharUI", 8);
                }
                _loc_5 = {id:_loc_1, time:this._titleStack[_loc_1], label:Config._titleMap[_loc_1].name, data:Config._titleMap[_loc_1], tip:_loc_6};
                _loc_3.push(_loc_5);
                if (Config.player != null && _loc_1 == Config.player.titleId)
                {
                    _loc_4 = _loc_5;
                }
            }
            if (_loc_3.length > 0)
            {
                _loc_5 = {id:0, label:Config.language("CharUI", 9)};
                _loc_3.push(_loc_5);
                if (Config.player != null && Config.player.titleId == 0)
                {
                    _loc_4 = _loc_5;
                }
            }
            else
            {
                _loc_5 = {id:0, label:Config.language("CharUI", 10)};
                _loc_3.push(_loc_5);
                if (Config.player != null && Config.player.titleId == 0)
                {
                    _loc_4 = _loc_5;
                }
            }
            _loc_3.sortOn("id", Array.NUMERIC);
            this._titleCB.itemArray = _loc_3;
            this._titleCB.selectedItem = _loc_4;
            return;
        }// end function

        private function hanleTitleList(param1)
        {
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_2:* = param1.data;
            var _loc_6:* = _loc_2.readUnsignedShort();
            _loc_3 = 0;
            while (_loc_3 < _loc_6)
            {
                
                _loc_4 = _loc_2.readUnsignedInt();
                _loc_5 = _loc_2.readUnsignedInt();
                this._titleStack[_loc_4] = _loc_5;
                _loc_3 = _loc_3 + 1;
            }
            this.refreshTitleCB();
            return;
        }// end function

        private function hanleTitleAdd(param1)
        {
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_2:* = param1.data;
            _loc_3 = _loc_2.readUnsignedInt();
            _loc_4 = _loc_2.readUnsignedInt();
            this._titleStack[_loc_3] = _loc_4;
            if (Config._titleMap[_loc_3] != null)
            {
                if (_loc_3 == 100)
                {
                    GuideUI.testDoId(2, Config.ui._systemUI._charPB);
                }
                BubbleUI.bubble(Config.language("CharUI", 39, Config._titleMap[_loc_3].name), 55551);
                Config.addHistory(Config.language("CharUI", 39, Config._titleMap[_loc_3].name));
                if (Config.map != null && getTimer() - Config.player.effectTime > 30000)
                {
                    UnitEffect.motionEffectParam(Config.map, Config.player, null, "1065_3_0_100_5_20_20_-1_1_0.2_0_0_0_1_0_0_0_0_0_1_0.5_0_0_0_0_0");
                }
            }
            this.refreshTitleCB();
            return;
        }// end function

        private function hanleTitleDelete(param1)
        {
            var _loc_2:* = param1.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            delete this._titleStack[_loc_3];
            this.refreshTitleCB();
            return;
        }// end function

        private function selectTitle(param1)
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_TITLE_SELECT);
            _loc_2.add32(param1);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function handleHairColor(param1)
        {
            var _loc_7:* = undefined;
            var _loc_8:* = undefined;
            var _loc_9:* = undefined;
            var _loc_10:* = undefined;
            var _loc_11:* = undefined;
            var _loc_2:* = param1.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            var _loc_4:* = new Sprite();
            var _loc_5:* = Config.player._data;
            var _loc_6:* = UnitClip.newUnitClip(Config._model[Number(_loc_5.model)]);
            UnitClip.newUnitClip(Config._model[Number(_loc_5.model)]).multiLayer = true;
            _loc_6.layerStack = _loc_5.id;
            if (Player.job == 1)
            {
                if (Player.sex == 1)
                {
                    _loc_7 = Config._model[Number(Config._hairMap[_loc_3].fightMale)];
                }
                else
                {
                    _loc_7 = Config._model[Number(Config._hairMap[_loc_3].fightFemale)];
                }
            }
            else if (Player.job == 4)
            {
                if (Player.sex == 1)
                {
                    _loc_7 = Config._model[Number(Config._hairMap[_loc_3].rangerMale)];
                }
                else
                {
                    _loc_7 = Config._model[Number(Config._hairMap[_loc_3].rangerFemale)];
                }
            }
            else if (Player.job == 10)
            {
                if (Player.sex == 1)
                {
                    _loc_7 = Config._model[Number(Config._hairMap[_loc_3].magicMale)];
                }
                else
                {
                    _loc_7 = Config._model[Number(Config._hairMap[_loc_3].magicFemale)];
                }
            }
            _loc_6.hair = _loc_7;
            if (Config.player.clothId != null && Config.player.clothId != 0)
            {
                _loc_8 = Config._itemMap[Config.player.clothId];
                if (Config.player.sex == 1)
                {
                    _loc_10 = String(_loc_8.mModel);
                }
                else
                {
                    _loc_10 = String(_loc_8.fModel);
                }
                if (_loc_10.indexOf(":") == -1)
                {
                    _loc_9 = Config._model[Number(_loc_10)];
                }
                else
                {
                    _loc_11 = _loc_10.split(":");
                    if (Config.player.job == 1)
                    {
                        _loc_9 = Config._model[Number(_loc_11[0])];
                    }
                    else if (Config.player.job == 4)
                    {
                        _loc_9 = Config._model[Number(_loc_11[1])];
                    }
                    else if (Config.player.job == 10)
                    {
                        _loc_9 = Config._model[Number(_loc_11[2])];
                    }
                }
                _loc_6.cloth = _loc_9;
            }
            else
            {
                _loc_6.cloth = Config._model[Number(_loc_5.cloth)];
            }
            if (Config.player.weaponId != null && Config.player.weaponId != 0)
            {
                _loc_8 = Config._itemMap[Config.player.weaponId];
                if (Config.player.sex == 1)
                {
                    _loc_9 = Config._model[Number(_loc_8.mModel)];
                }
                else
                {
                    _loc_9 = Config._model[Number(_loc_8.fModel)];
                }
                _loc_6.weapon = _loc_9;
            }
            else
            {
                _loc_6.weapon = null;
            }
            _loc_6.changeStateTo("idle");
            _loc_6.x = 92;
            _loc_6.y = 64;
            _loc_4.addChild(_loc_6);
            if (this._hairTxt == null)
            {
                this._hairTxt = Config.getSimpleTextField();
                this._hairTxt.multiline = true;
                this._hairTxt.x = 0;
                this._hairTxt.y = 96;
            }
            this._hairTxt.htmlText = Config.language("CharUI", 11);
            _loc_4.addChild(this._hairTxt);
            AlertUI.remove(this._fashionAlertId);
            if (this._fashionClip != null)
            {
                if (this._fashionClip.parent != null)
                {
                    this._fashionClip.parent.removeChild(this._fashionClip);
                }
                this._fashionClip.destroy();
                this._fashionClip = null;
            }
            this._fashionClip = _loc_6;
            this._fashionAlertId = AlertUI.alert(Config.language("CharUI", 12), "", [Config.language("CharUI", 13), Config.language("CharUI", 14)], [this.acceptHair, this.cancelHair], _loc_6, false, true, false, _loc_4, false, null, null, 200);
            return;
        }// end function

        private function acceptHair(param1:UnitClip)
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_HAIRCOLOR);
            _loc_2.add8(1);
            ClientSocket.send(_loc_2);
            if (this._fashionClip != null)
            {
                if (this._fashionClip.parent != null)
                {
                    this._fashionClip.parent.removeChild(this._fashionClip);
                }
                this._fashionClip.destroy();
                this._fashionClip = null;
            }
            return;
        }// end function

        private function cancelHair(param1:UnitClip)
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_HAIRCOLOR);
            _loc_2.add8(0);
            ClientSocket.send(_loc_2);
            if (this._fashionClip != null)
            {
                if (this._fashionClip.parent != null)
                {
                    this._fashionClip.parent.removeChild(this._fashionClip);
                }
                this._fashionClip.destroy();
                this._fashionClip = null;
            }
            return;
        }// end function

        private function handleShowCloth(param1)
        {
            this.handleShow();
            return;
        }// end function

        private function handleShowHorse(param1)
        {
            this.handleShow();
            return;
        }// end function

        private function handleShowWing(param1)
        {
            this.handleShow();
            return;
        }// end function

        private function handleShow()
        {
            var _loc_1:* = "";
            if (this._showClothCB.selected)
            {
                _loc_1 = _loc_1 + "0";
            }
            else
            {
                _loc_1 = _loc_1 + "1";
            }
            if (this._showHorseCB.selected)
            {
                _loc_1 = "0" + _loc_1;
            }
            else
            {
                _loc_1 = "1" + _loc_1;
            }
            if (this._showWingCB.selected)
            {
                _loc_1 = "0" + _loc_1;
            }
            else
            {
                _loc_1 = "1" + _loc_1;
            }
            _loc_1 = "00000" + _loc_1;
            var _loc_2:* = parseInt(_loc_1, 2);
            var _loc_3:* = new DataSet();
            _loc_3.addHead(CONST_ENUM.C2G_EQUIP_SHOW);
            _loc_3.add8(_loc_2);
            ClientSocket.send(_loc_3);
            return;
        }// end function

        private function handleItemShow(param1)
        {
            var _loc_2:* = param1.data;
            var _loc_3:* = _loc_2.readByte();
            return;
        }// end function

        private function refreshPlayerInfo()
        {
            this._infoLB.text = "<p align=\'center\'><font size=\'14\'><b>" + Config.player.name + "</b></font>\n" + Config.language("CharUI", 15, Config.player.level, Config._jobTitleMap[Config.player.job]) + "</p>";
            return;
        }// end function

        public function drawPlayerClip(param1:Player)
        {
            this._player = param1;
            this._sampleClip = UnitClip.newUnitClip();
            this._sampleClip.changeStateTo("idle");
            this._sampleClip.changeDirectionTo(1);
            this._sampleClip.x = 120;
            this._sampleClip.y = 225;
            this._charPanel.addChild(this._sampleClip);
            this._horseClip = UnitClip.newUnitClip();
            this._horseClip.changeStateTo("idle");
            this._horseClip.changeDirectionTo(1);
            this._horseClip.x = 120;
            this._horseClip.y = 225 + 28;
            this._charPanel.addChild(this._titleCB);
            param1.addEventListener("redraw", this.handlePlayerRedraw);
            return;
        }// end function

        public function drawHorseClip(param1 = null)
        {
            if (param1 == null)
            {
                if (this._horseClip != null && this._horseClip.parent != null)
                {
                    this._horseClip.parent.removeChild(this._horseClip);
                }
            }
            else
            {
                this._charPanel.addChild(this._horseClip);
                if (this._sampleClip != null)
                {
                    this._charPanel.addChild(this._sampleClip);
                }
                this._charPanel.addChild(this._titleCB);
                this._horseClip.clone(param1);
            }
            return;
        }// end function

        public function handlePlayerRedraw(param1 = null)
        {
            if (this._player != null && this._player._img != null && this._player._img.ready)
            {
                Config.startLoop(this.subHandlePlayerRedraw);
            }
            return;
        }// end function

        public function subHandlePlayerRedraw(param1 = null)
        {
            if (this._player != null && this._player._img != null)
            {
                Config.stopLoop(this.subHandlePlayerRedraw);
                if (this._player._img.ready)
                {
                    this._sampleClip.clone(this._player._img);
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

        private function clickSlot(param1)
        {
            var _loc_2:* = null;
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
                    this.unlockfromid(Holder.item._id);
                    _loc_2 = new DataSet();
                    _loc_2.addHead(CONST_ENUM.CMSG_TRADE_REMOVEITEM);
                    _loc_2.add16(Holder.item._position);
                    ClientSocket.send(_loc_2);
                }
            }
            else if (Holder.item._drawer == this._slotArray)
            {
                trace(Holder.item._position, Holder.item.id, param1.item, "6666777");
                if (Holder.item == param1.item)
                {
                    this.addproductbitmap(param1.item._position);
                    param1.item = Holder.item;
                    Holder.item = null;
                }
                else
                {
                    this._holderBuff = param1.item;
                    this.swapItem(Holder.item, param1._id);
                }
            }
            return;
        }// end function

        private function handleSlotDoubleClick(param1)
        {
            var _loc_2:* = param1.currentTarget;
            if (_loc_2.item != null && Holder.item == null && Config.getMouseState() == "")
            {
                this.useItem(_loc_2.item);
            }
            return;
        }// end function

        private function handleSlotOver(param1)
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_2:* = param1.currentTarget;
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
                _loc_4 = _loc_2._id - this._equipStartIndex + 1;
                if (_loc_4 >= 8)
                {
                    _loc_4 = _loc_4 - 1;
                }
                _loc_5 = Config._itemType[0].children()[2].children();
                _loc_6 = Config.language("CharUI", 38, _loc_5[(_loc_4 - 1)].@label);
                _loc_3 = _loc_2.parent.localToGlobal(new Point(_loc_2.x, _loc_2.y));
                Holder.showInfo(_loc_6, new Rectangle(_loc_3.x, _loc_3.y, _loc_2._size, _loc_2._size), true, 0, 250);
            }
            return;
        }// end function

        private function handleSlotOut(param1)
        {
            Holder.closeInfo();
            return;
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

        private function handlePlayerUpdate(event:UnitEvent) : void
        {
            this._charPropObj[event.param] = event.value;
            switch(event.param)
            {
                case "level":
                case "name":
                {
                    this.refreshPlayerInfo();
                    break;
                }
                case "hp":
                case "hpMax":
                {
                    if (this._charTxtObj.hasOwnProperty("hp"))
                    {
                        this._charTxtObj.hp.text = Config.language("CharUI", 4) + Config.player.hp + "/" + Config.player.hpMax;
                    }
                    break;
                }
                case "mp":
                case "mpMax":
                {
                    if (this._charTxtObj.hasOwnProperty("mp"))
                    {
                        this._charTxtObj.mp.text = Config.language("CharUI", 5) + Config.player.mp + "/" + Config.player.mpMax;
                    }
                    break;
                }
                case "speed":
                {
                    if (this._charTxtObj.hasOwnProperty("speed"))
                    {
                        this._charTxtObj.speed.text = Config.language("CharUI", 6) + Config.player.speed;
                    }
                    break;
                }
                case "exp":
                case "expUpdate":
                {
                    if (isNaN(Config.player.expUpdate) || isNaN(Config.player.exp) || !this._charTxtObj.hasOwnProperty("expbar") || !this._charTxtObj.hasOwnProperty("exp"))
                    {
                        return;
                    }
                    this._charTxtObj.expbar.maximum = Config.player.expUpdate;
                    this._charTxtObj.expbar.value = Config.player.exp;
                    this._charTxtObj.exp.text = Config.player.exp + " / " + Config.player.expUpdate;
                    this._charTxtObj.exp.x = 60 + (220 - this._charTxtObj.exp.width) / 2;
                    break;
                }
                case "autoHp":
                case "autoMp":
                {
                    Config.ui._autoDrug.autoUpdate(1);
                    break;
                }
                default:
                {
                    if (this._charTxtObj.hasOwnProperty(event.param))
                    {
                        this._charTxtObj[event.param].text = this._charPropObj[event.param];
                    }
                    break;
                    break;
                }
            }
            return;
        }// end function

        public function queryChar()
        {
            var _loc_1:* = null;
            _loc_1 = new DataSet();
            _loc_1.addHead(CONST_ENUM.CMSG_CHAR_QUERY);
            ClientSocket.send(_loc_1);
            return;
        }// end function

        private function handleCharQuery(param1)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = 0;
            var _loc_4:* = undefined;
            if (Config.player == null)
            {
                _buffProp = {};
                _loc_2 = _buffProp;
                _loc_2.raceAtkStack = [];
                _loc_2.raceDefStack = [];
            }
            else
            {
                _loc_2 = Config.player;
            }
            var _loc_5:* = param1.data;
            var _loc_6:* = param1.data.readUnsignedInt();
            _loc_3 = _loc_5.readUnsignedShort();
            _loc_2.name = _loc_5.readUTFBytes(_loc_3);
            _loc_2.titleId = _loc_5.readInt();
            _loc_2.sex = _loc_5.readByte();
            _loc_2.hairId = _loc_5.readUnsignedInt();
            var _loc_7:* = _loc_5.readUnsignedInt();
            _loc_2.job = _loc_5.readByte();
            _loc_2.level = _loc_5.readInt();
            _loc_2.exp = _loc_5.readUnsignedInt();
            _loc_2.expUpdate = _loc_5.readUnsignedInt();
            _loc_2.hp = _loc_5.readUnsignedInt();
            _loc_2.hpMax = _loc_5.readUnsignedInt();
            _loc_2.mp = _loc_5.readUnsignedInt();
            _loc_2.mpMax = _loc_5.readUnsignedInt();
            _loc_2.speed = _loc_5.readInt();
            _loc_2.evade = _loc_5.readInt();
            _loc_2.rate = _loc_5.readInt();
            _loc_2.skillEvade = _loc_5.readInt();
            _loc_2.skillRate = _loc_5.readInt();
            _loc_2.criticalRate = _loc_5.readInt();
            _loc_2.criticalEvade = _loc_5.readInt();
            _loc_2.criticalMulti = _loc_5.readInt();
            _loc_2.criticalResist = _loc_5.readInt();
            _loc_2.skillCriticalRate = _loc_5.readInt();
            _loc_2.skillCriticalEvade = _loc_5.readInt();
            _loc_2.skillCriticalMulti = _loc_5.readInt();
            _loc_2.skillCriticalResist = _loc_5.readInt();
            _loc_2.criticalAdd = _loc_5.readInt();
            _loc_2.criticalMinus = _loc_5.readInt();
            _loc_2.atk = _loc_5.readInt();
            _loc_2.atkRanged = _loc_5.readInt();
            _loc_2.atkMagic = _loc_5.readInt();
            _loc_2.def = _loc_5.readInt();
            _loc_2.defRanged = _loc_5.readInt();
            _loc_2.defMagic = _loc_5.readInt();
            _loc_2.atkAdd = _loc_5.readInt();
            _loc_2.defAdd = _loc_5.readInt();
            _loc_2.money1 = _loc_5.readUnsignedInt();
            _loc_2.money2 = _loc_5.readUnsignedInt();
            _loc_2.money3 = _loc_5.readUnsignedInt();
            _loc_2.money4 = _loc_5.readUnsignedInt();
            var _loc_8:* = _loc_5.readUnsignedInt();
            var _loc_9:* = _loc_5.readUnsignedInt();
            var _loc_10:* = _loc_5.readUnsignedInt().toString(2);
            if (_loc_5.readUnsignedInt().toString(2).substr((_loc_5.readUnsignedInt().toString(2).length - 1), 1) != "1")
            {
                this._showClothCB.selected = true;
            }
            else
            {
                this._showClothCB.selected = false;
            }
            if (_loc_10.length < 2 || _loc_10.substr(_loc_10.length - 2, 1) != "1")
            {
                this._showHorseCB.selected = true;
            }
            else
            {
                this._showHorseCB.selected = false;
            }
            if (_loc_10.length < 3 || _loc_10.substr(_loc_10.length - 3, 1) != "1")
            {
                this._showWingCB.selected = true;
            }
            else
            {
                this._showWingCB.selected = false;
            }
            _loc_3 = _loc_5.readUnsignedInt();
            if (_loc_3 != 0)
            {
                _loc_2.forceClip = _loc_3;
            }
            var _loc_11:* = _loc_5.readInt();
            Config.ui._pkmode.combattype = _loc_11;
            var _loc_12:* = _loc_5.readUnsignedInt();
            var _loc_13:* = _loc_5.readUnsignedShort();
            var _loc_14:* = _loc_5.readUTFBytes(_loc_13);
            var _loc_15:* = _loc_5.readByte();
            Config.ui._gangs.mytype = _loc_15;
            Config.ui._gangs.gildid = _loc_12;
            Config.ui._gangs.downgildtasknum = _loc_8;
            _loc_2.guildInfo = [_loc_12, _loc_14, _loc_15, 0, 0];
            Skill.goldhandTime = _loc_5.readByte();
            Skill.picksoulTime = _loc_5.readByte();
            _loc_2.equiplucky = _loc_5.readInt();
            _loc_2.otheratk = _loc_5.readInt();
            _loc_2.otherdef = _loc_5.readInt();
            _loc_2.othermondef = _loc_5.readInt();
            _loc_2.weaponId = _loc_5.readUnsignedInt();
            _loc_2.clothId = _loc_5.readUnsignedInt();
            var _loc_16:* = _loc_5.readByte();
            Config.ui._playerHead.fcmstatus = _loc_16;
            _loc_2.atkRangedAdd = _loc_5.readInt();
            _loc_2.defRangedAdd = _loc_5.readInt();
            _loc_2.atkMagicAdd = _loc_5.readInt();
            _loc_2.defMagicAdd = _loc_5.readInt();
            _loc_2.atkSpeedLevel = _loc_5.readInt();
            _loc_2.atkSkill = _loc_5.readInt();
            _loc_2.defSkill = _loc_5.readInt();
            Config.ui._bagUI.BagCount(_loc_5.readByte());
            _loc_2.lucky = _loc_5.readInt();
            _loc_2.comAtk = _loc_5.readInt();
            _loc_2.comDef = _loc_5.readInt();
            _loc_2.comAtkAdd = _loc_5.readInt();
            _loc_2.comDefAdd = _loc_5.readInt();
            _loc_2.comRate = _loc_5.readInt();
            _loc_2.comEvade = _loc_5.readInt();
            _loc_2.comSkillRate = _loc_5.readInt();
            _loc_2.comSkillEvade = _loc_5.readInt();
            _loc_2.comSkillAtk = _loc_5.readInt();
            _loc_2.comSkillCriticalAdd = _loc_5.readInt();
            _loc_2.comSkillCriticalDel = _loc_5.readInt();
            _loc_2.comAtkCriticalAdd = _loc_5.readInt();
            _loc_2.comAtkCriticalDel = _loc_5.readInt();
            _loc_2.comSkillCritical = _loc_5.readInt();
            _loc_2.comSkillCriticalDef = _loc_5.readInt();
            _loc_2.comCritical = _loc_5.readInt();
            _loc_2.comCriticalDef = _loc_5.readInt();
            _loc_2.comBuffAtk1 = _loc_5.readInt();
            _loc_2.comBuffAtk2 = _loc_5.readInt();
            _loc_2.comBuffAtk3 = _loc_5.readInt();
            _loc_2.comBuffAtk4 = _loc_5.readInt();
            _loc_2.comBuffAtk5 = _loc_5.readInt();
            _loc_2.comBuffAtk6 = _loc_5.readInt();
            _loc_2.comBuffAtk7 = _loc_5.readInt();
            _loc_2.comBuffAtk8 = _loc_5.readInt();
            _loc_2.comBuffAtk9 = _loc_5.readInt();
            _loc_2.comBuffAtk10 = _loc_5.readInt();
            _loc_2.comBuffDef1 = _loc_5.readInt();
            _loc_2.comBuffDef2 = _loc_5.readInt();
            _loc_2.comBuffDef3 = _loc_5.readInt();
            _loc_2.comBuffDef4 = _loc_5.readInt();
            _loc_2.comBuffDef5 = _loc_5.readInt();
            _loc_2.comBuffDef6 = _loc_5.readInt();
            _loc_2.comBuffDef7 = _loc_5.readInt();
            _loc_2.comBuffDef8 = _loc_5.readInt();
            _loc_2.comBuffDef9 = _loc_5.readInt();
            _loc_2.comBuffDef10 = _loc_5.readInt();
            _loc_2.moneyLifeTime = _loc_5.readInt();
            _loc_2.moneyLifeNum = _loc_5.readInt();
            _loc_2.autoHp = _loc_5.readInt();
            _loc_2.autoMp = _loc_5.readInt();
            _loc_2.dispAtk = _loc_5.readInt();
            _loc_2.dispDef = _loc_5.readInt();
            _loc_2.dispDmgAdd = _loc_5.readInt();
            _loc_2.dispDmgReduce = _loc_5.readInt();
            _loc_2.dispAtkSpeed = _loc_5.readInt();
            _loc_2.dispSkillAdd = _loc_5.readInt();
            _loc_2.dispRate = _loc_5.readInt();
            _loc_2.dispSkillRate = _loc_5.readInt();
            _loc_2.dispEvade = _loc_5.readInt();
            _loc_2.dispSkillEvade = _loc_5.readInt();
            _loc_2.dispCriticalRate = _loc_5.readInt();
            _loc_2.dispSkillCriticalRate = _loc_5.readInt();
            _loc_2.dispCriticalEvade = _loc_5.readInt();
            _loc_2.dispSkillCriticalEvade = _loc_5.readInt();
            _loc_2.dispCriticalAdd = _loc_5.readInt();
            _loc_2.dispSkillCriticalAdd = _loc_5.readInt();
            _loc_2.dispCriticalReduce = _loc_5.readInt();
            _loc_2.dispSkillCriticalReduce = _loc_5.readInt();
            _loc_2.dispGodAtk = _loc_5.readInt();
            _loc_2.dispLuck = _loc_5.readInt();
            _loc_2.hue = _loc_5.readInt();
            _loc_2.instanceSore = _loc_5.readInt();
            _loc_2.honor = _loc_5.readInt();
            this._entertainInfo.push(_loc_5.readInt());
            this._entertainInfo.push(_loc_5.readInt());
            this._entertainInfo.push(_loc_5.readInt());
            this._entertainInfo.push(_loc_5.readInt());
            this._entertainInfo.push(_loc_5.readInt());
            this._entertainInfo.push(_loc_5.readInt());
            _loc_2.gildCoin = _loc_5.readInt();
            _loc_2.escortra = _loc_5.readInt();
            _loc_2.escortrob = _loc_5.readInt();
            _loc_2.escortstatus = _loc_5.readByte();
            _loc_2.escortentryId = _loc_5.readInt();
            if (_loc_2.escortentryId > 0)
            {
                Config.ui._transport.onlineaddevent(_loc_2.escortentryId);
            }
            Config.ui._interPkPanel.pkSource = _loc_5.readInt();
            Config.ui._interPkPanel.DayMoneyNum = _loc_5.readInt();
            Config.ui._interPkPanel.winNum = _loc_5.readInt();
            Config.ui._petPanel.tempAtk = _loc_5.readInt();
            Config.ui._petPanel.tempDef = _loc_5.readInt();
            Config.ui._petPanel.tempHp = _loc_5.readInt();
            Config.ui._petPanel.tempMp = _loc_5.readInt();
            _loc_2.speedLevel = 0;
            _loc_2.dispSpeed = 0;
            this.initCharText();
            Config.ui._autoDrug.autoUpdate(1);
            Config.startLoop(this.setEntertain);
            return;
        }// end function

        private function setEntertain(param1)
        {
            Config.stopLoop(this.setEntertain);
            if (this._entertainInfo[1] == 0)
            {
                Config.ui._quickUI._soulUI.close();
            }
            else if (this._entertainInfo[1] == 1)
            {
                Config.ui._quickUI._soulUI.open();
            }
            Config.ui._quickUI._soulUI.num = this._entertainInfo[2];
            Config.ui._quickUI._soulUI.setSoul(this._entertainInfo[3]);
            Config.ui._quickUI._soulUI.amount = this._entertainInfo[4];
            var _loc_2:* = Config.now;
            var _loc_3:* = Math.max(0, this._entertainInfo[0] * 1000 - _loc_2.getTime());
            var _loc_4:* = Math.max(0, this._entertainInfo[5] * 1000 - _loc_2.getTime());
            Skill._entertainCdStack = [_loc_3, 0, _loc_4];
            Config.ui._skillUI.testAllSkill();
            return;
        }// end function

        private function handleError(param1)
        {
            var _loc_2:* = param1.data.readByte();
            trace("失败" + _loc_2);
            return;
        }// end function

        private function handleItemCd(param1)
        {
            var _loc_5:* = undefined;
            var _loc_2:* = param1.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            var _loc_4:* = _loc_2.readUnsignedInt();
            _loc_5 = 0;
            while (_loc_5 < this._itemArray.length)
            {
                
                if (this._itemArray[_loc_5]._itemData.relatedId == _loc_3)
                {
                    this._itemArray[_loc_5].cd = _loc_4;
                }
                _loc_5 = _loc_5 + 1;
            }
            Config.ui._quickUI.handleItemCd(_loc_3, _loc_4);
            return;
        }// end function

        private function handleItemCd1(param1)
        {
            var _loc_5:* = undefined;
            var _loc_2:* = param1.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            var _loc_4:* = _loc_2.readUnsignedInt();
            _loc_5 = 0;
            while (_loc_5 < this._itemArray.length)
            {
                
                if (this._itemArray[_loc_5]._itemData.id == _loc_3)
                {
                    this._itemArray[_loc_5].cd = _loc_4;
                }
                _loc_5 = _loc_5 + 1;
            }
            return;
        }// end function

        private function handleItemCd1List(param1)
        {
            var _loc_4:* = 0;
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            var _loc_2:* = param1.data;
            var _loc_3:* = _loc_2.readByte();
            var _loc_5:* = 0;
            while (_loc_5 < _loc_3)
            {
                
                _loc_6 = _loc_2.readUnsignedInt();
                _loc_7 = _loc_2.readUnsignedInt();
                _loc_4 = 0;
                while (_loc_4 < this._itemArray.length)
                {
                    
                    if (this._itemArray[_loc_4]._itemData.id == _loc_6)
                    {
                        this._itemArray[_loc_4].cd = _loc_7;
                    }
                    _loc_4++;
                }
                _loc_5++;
            }
            return;
        }// end function

        private function handleItemBuy(param1)
        {
            var _loc_2:* = param1.data;
            var _loc_3:* = _loc_2.readByte();
            if (_loc_3 != 0)
            {
                if (_loc_3 == 89)
                {
                    Config.message(Config.language("CharUI", 16));
                }
                else
                {
                    Config.message(Config.language("CharUI", 17));
                }
            }
            return;
        }// end function

        private function getfirenum(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            this._firenum = _loc_2.readUnsignedShort();
            return;
        }// end function

        public function handleItemSwap(param1:int)
        {
            if (param1 != 0)
            {
                Config.message(Config._codeWords[WordsType.TYPEID_ERR][param1]);
            }
            return;
        }// end function

        public function handleItemUpdate(param1)
        {
            var _loc_4:* = null;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            var _loc_8:* = undefined;
            var _loc_9:* = undefined;
            var _loc_10:* = undefined;
            var _loc_11:* = undefined;
            var _loc_12:* = undefined;
            var _loc_13:* = undefined;
            var _loc_14:* = undefined;
            var _loc_15:* = undefined;
            var _loc_16:* = undefined;
            var _loc_18:* = undefined;
            var _loc_19:* = null;
            var _loc_20:* = 0;
            var _loc_21:* = undefined;
            if (Holder.item != null)
            {
                if (Holder.item._drawer == Config.ui._shopUI._slotArray)
                {
                    Config.ui._shopUI._slotArray[Holder.item._position].item = Holder.item;
                    Holder.item = null;
                }
                else if (Holder.item._drawer == Config.ui._shopUI._buybackSlotArray)
                {
                    Holder.item.destroy();
                    Holder.item = null;
                }
            }
            var _loc_2:* = param1.data;
            var _loc_3:* = _loc_2.readUnsignedShort();
            var _loc_17:* = null;
            _loc_11 = 0;
            while (_loc_11 < _loc_3)
            {
                
                _loc_16 = _loc_2.readByte();
                if (_loc_16 == 0)
                {
                    _loc_5 = _loc_2.readUnsignedShort();
                    _loc_4 = this._slotArray[_loc_5].item;
                    _loc_10 = 0;
                    while (_loc_10 < this._itemArray.length)
                    {
                        
                        if (this._itemArray[_loc_10] == _loc_4)
                        {
                            this._itemArray.splice(_loc_10, 1);
                        }
                        _loc_10 = _loc_10 + 1;
                    }
                    this.onSlotDel(_loc_5);
                    if (_loc_4 != null)
                    {
                        _loc_4.destroy();
                    }
                    this._slotArray[_loc_5].item = null;
                    if (Holder.item == _loc_4)
                    {
                        Holder.item = null;
                    }
                    if (this._holderBuff == _loc_4)
                    {
                        this._holderBuff = null;
                    }
                    if (_loc_5 >= 1001 && _loc_5 <= 1010 || _loc_5 >= 1021 && _loc_5 <= 1030 || _loc_5 == 1012 || _loc_5 == 1014)
                    {
                        this.removebitma(_loc_5);
                    }
                }
                else if (_loc_16 == 1)
                {
                    _loc_6 = _loc_2.readUnsignedInt();
                    _loc_5 = _loc_2.readUnsignedShort();
                    _loc_4 = Item.createItemByBytes(_loc_2, _loc_6);
                    _loc_4.display();
                    _loc_4._drawer = this._slotArray;
                    this._itemArray.push(_loc_4);
                    this._slotArray[_loc_5].item = _loc_4;
                    this.onSlotAdd(_loc_5);
                    dispatchEvent(new GeneralEvent("addItem", _loc_4));
                    if (_loc_4._itemData.id == 10113 || _loc_4._itemData.id == 10111)
                    {
                        _loc_19 = Config.ui._quickUI.findBlankSlot(1)[0];
                        if (_loc_19 != null)
                        {
                            _loc_19.item = _loc_4;
                        }
                    }
                    if (GuideUI.testId(78) && (_loc_4._itemData.type == 12 && (_loc_4._itemData.reqJob == Player.job || _loc_4._itemData.reqJob == 0) && _loc_4._itemData.reqLevel <= Player.level))
                    {
                        GuideUI.testDoId(78, Config.ui._systemUI._bagPB, Config.ui._bagUI);
                    }
                    else if (GuideUI.testId(177) && (int(_loc_4._itemData.id) == 31004 || int(_loc_4._itemData.id) == 32004 || int(_loc_4._itemData.id) == 33004))
                    {
                        if (Player.job == 1)
                        {
                            _loc_18 = Config.ui._charUI.getOneItemSlot(31004);
                        }
                        else if (Player.job == 4)
                        {
                            _loc_18 = Config.ui._charUI.getOneItemSlot(32004);
                        }
                        else if (Player.job == 10)
                        {
                            _loc_18 = Config.ui._charUI.getOneItemSlot(33004);
                        }
                        if (_loc_18 != null)
                        {
                            if (_loc_18._id >= Config.ui._bagUI._slotStartIndex)
                            {
                                Config.ui._bagUI.gotoSlotPage(_loc_18);
                            }
                            GuideUI.testDoId(177, Config.ui._systemUI._bagPB, Config.ui._bagUI);
                        }
                    }
                    else if (GuideUI.testId(196) && int(_loc_4._itemData.id) == 960017)
                    {
                        _loc_18 = Config.ui._charUI.getOneItemSlot(960017);
                        if (_loc_18 != null)
                        {
                            if (_loc_18._id >= Config.ui._bagUI._slotStartIndex)
                            {
                                Config.ui._bagUI.gotoSlotPage(_loc_18);
                            }
                            GuideUI.doId(196, _loc_18, [Config.ui._radar._jianBtn]);
                        }
                    }
                    else if (GuideUI.testId(209) && (int(_loc_4._itemData.type) == 10 && int(_loc_4._itemData.subType) == 12))
                    {
                        _loc_18 = _loc_4.slot;
                        if (_loc_18 != null)
                        {
                            if (_loc_18._id >= Config.ui._bagUI._slotStartIndex)
                            {
                                Config.ui._bagUI.gotoSlotPage(_loc_18);
                            }
                            GuideUI.doId(209, _loc_18);
                        }
                    }
                }
                else if (_loc_16 == 2)
                {
                    _loc_6 = _loc_2.readUnsignedInt();
                    _loc_20 = _loc_2.readUnsignedShort();
                    _loc_5 = _loc_20;
                    _loc_10 = this._itemArray.length - 1;
                    while (_loc_10 >= 0)
                    {
                        
                        if (this._itemArray[_loc_10]._id == _loc_6 || this._itemArray[_loc_10]._position == _loc_20)
                        {
                            this._itemArray.splice(_loc_10, 1);
                        }
                        _loc_10 = _loc_10 - 1;
                    }
                    if (Holder.item != null)
                    {
                        if (Holder.item._id == _loc_6)
                        {
                            Holder.item = null;
                        }
                    }
                    for (_loc_21 in this._slotArray)
                    {
                        
                        if (this._slotArray[_loc_21].item != null)
                        {
                            if (this._slotArray[_loc_21].item._id == _loc_6 || _loc_21 == _loc_20)
                            {
                                if (Holder.item != null)
                                {
                                    if (Holder.item._position == _loc_21)
                                    {
                                        Holder.item = null;
                                    }
                                }
                                this._slotArray[_loc_21].item.destroy();
                                this._slotArray[_loc_21].item = null;
                                _loc_8 = _loc_21;
                            }
                        }
                    }
                    _loc_4 = Item.createItemByBytes(_loc_2, _loc_6);
                    _loc_4.display();
                    _loc_4._drawer = this._slotArray;
                    _loc_4._position = _loc_20;
                    if (this.getPosite(_loc_4._position) == 1 || this.getPosite(_loc_4._position) == 3)
                    {
                        this._itemArray.push(_loc_4);
                    }
                    else if (this.getPosite(_loc_4._position) == 2)
                    {
                        this._itembagwareArr.push(_loc_4);
                    }
                    this._slotArray[_loc_20].item = _loc_4;
                    this.onSlotAdd(_loc_20);
                    if (this.getPosite(_loc_4._position) == 3)
                    {
                        _loc_17 = this._slotArray[_loc_20];
                        if (_loc_8 != _loc_4._position)
                        {
                            Config.message(Config.language("CharUI", 18));
                        }
                    }
                    this.onSlotDel(_loc_4._position);
                    if (_loc_5 >= 1001 && _loc_5 <= 1010 || _loc_5 >= 1021 && _loc_5 <= 1030 || _loc_5 == 1012 || _loc_5 == 1014)
                    {
                        if (_loc_5 >= 1001 && _loc_5 <= 1010)
                        {
                            this._spr.panelflag = 0;
                            this._spr.changeExtrapropcolor(_loc_5);
                            this._spr.showinfor();
                        }
                        else if (_loc_5 >= 1021 && _loc_5 <= 1030)
                        {
                            this._spr.panelflag = 20;
                            this._spr.changeExtrapropcolor(_loc_5);
                            this._spr.showinfor();
                        }
                        if (this._slotArray[_loc_5].item != null)
                        {
                            this.addproductbitmap(_loc_5);
                        }
                    }
                }
                _loc_11 = _loc_11 + 1;
            }
            this._holderBuff = null;
            if (_loc_5 == int(this._equipStartIndex + 12) || _loc_8 == int(this._equipStartIndex + 12))
            {
                this.dispatchEvent(new Event("petchange"));
                GuideUI.testDoId(210, Config.ui._quickUI._pethandSlot);
            }
            else
            {
                Config.ui._monsterIndexUI._setupPanel.testPropSlot();
                Config.ui._quickUI.testPropSlot();
                ItemTypeSlot.testPropSlot();
                Config.ui._producepanel.refashpd();
                Npc.checkAll();
                Config.ui._monsterIndexUI._setupPanel.freshUseList();
                Config.ui._bagUI.refreshMouseSlot();
                Config.ui._autoDrug.autoUpdate(2);
                Config.ui._nationalDayPanel.reshowItem();
                this.dispatchEvent(new Event("itemchange"));
            }
            return;
        }// end function

        private function onSlotAdd(param1)
        {
            var _loc_2:* = null;
            if (param1 >= this._equipStartIndex && param1 < this._equipStartIndex + 12)
            {
                _loc_2 = this._slotArray[param1].item;
                if (_loc_2 != null)
                {
                    if (GuideUI.testId(9))
                    {
                        GuideUI.doId(9, _loc_2);
                    }
                    else if (_loc_2._itemData.baseID == 23000 && GuideUI.testId(87))
                    {
                        GuideUI.doId(87, _loc_2);
                    }
                    else if (_loc_2._itemData.baseID == 24000 && GuideUI.testId(90))
                    {
                        GuideUI.doId(90, _loc_2);
                    }
                }
            }
            return;
        }// end function

        private function onSlotDel(param1)
        {
            return;
        }// end function

        private function handleItemList(event:SocketEvent)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            Config.ui._bagUI.clearBag();
            var _loc_7:* = event.data;
            var _loc_8:* = event.data.readUnsignedShort();
            this._itemArray = [];
            this._itembagwareArr = [];
            _loc_2 = 0;
            while (_loc_2 < _loc_8)
            {
                
                _loc_5 = _loc_7.readUnsignedInt();
                _loc_6 = _loc_7.readUnsignedShort();
                _loc_4 = Item.createItemByBytes(_loc_7, _loc_5);
                _loc_4.display();
                _loc_4._drawer = this._slotArray;
                _loc_4._position = _loc_6;
                if (this.getPosite(_loc_4._position) == 1 || this.getPosite(_loc_4._position) == 3)
                {
                    this._itemArray.push(_loc_4);
                }
                else if (this.getPosite(_loc_4._position) == 2)
                {
                    this._itembagwareArr.push(_loc_4);
                }
                this._slotArray[_loc_6].item = _loc_4;
                if (this._slotArray[_loc_6].item != null)
                {
                    this.addproductbitmap(_loc_6);
                }
                if (_loc_6 == int(this._equipStartIndex + 12))
                {
                    this.dispatchEvent(new Event("petchange"));
                }
                _loc_2 = _loc_2 + 1;
            }
            Config.ui._monsterIndexUI._setupPanel.freshUseList();
            return;
        }// end function

        public function itemlock(param1:uint) : void
        {
            this._slotArray[param1].lock();
            return;
        }// end function

        public function itemunlock(param1:uint) : void
        {
            this._slotArray[param1].unlock();
            this.addproductbitmap(param1);
            return;
        }// end function

        public function allunloc() : void
        {
            var _loc_1:* = undefined;
            _loc_1 = 1;
            while (_loc_1 < this._slotArray.length)
            {
                
                if (this._slotArray[_loc_1] != null)
                {
                    this._slotArray[_loc_1].unlock();
                }
                _loc_1 = _loc_1 + 1;
            }
            return;
        }// end function

        public function unlockfromid(param1:int) : void
        {
            var _loc_2:* = Item.getItem(UNIT_TYPE_ENUM.TYPEID_ITEM, param1);
            _loc_2.slot.unlock();
            return;
        }// end function

        private function itemmessage(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            var _loc_4:* = _loc_2.readUnsignedInt();
            var _loc_5:* = Config._itemMap[_loc_3];
            var _loc_6:* = Number(_loc_5.type);
            if (_loc_3 == 90002)
            {
                if (!this._lockExtract)
                {
                    UnitEffect.colorTransform(Config.player, 55551, 0, 6);
                    UnitEffect.extract(Config.player);
                }
            }
            if (_loc_3 == 90002 && GuideUI.testId(10))
            {
                GuideUI.testDoId(10, Config.ui._playerHead._menegyLB);
            }
            else if ((_loc_3 == 92001 || _loc_3 == 92002 || _loc_3 == 92003 || _loc_3 == 92011 || _loc_3 == 92012 || _loc_3 == 92013) && GuideUI.testId(65))
            {
                GuideUI.doId(65);
            }
            else if ((_loc_3 == 93000 || _loc_3 == 93010) && GuideUI.testId(75))
            {
                GuideUI.doId(75);
            }
            else if ((_loc_3 == 92101 || _loc_3 == 92102 || _loc_3 == 92103 || _loc_3 == 92111 || _loc_3 == 92112 || _loc_3 == 92113) && GuideUI.testId(76))
            {
                GuideUI.doId(76);
            }
            else if (_loc_6 == 12 && GuideUI.testId(78))
            {
                GuideUI.testDoId(78, Config.ui._systemUI._bagPB, Config.ui._bagUI);
            }
            else if (_loc_3 == 95391 && GuideUI.testId(151))
            {
                GuideUI.testDoId(151, Config.ui._systemUI._bagPB, Config.ui._bagUI);
            }
            else if (AutoDrug.canBuy && (_loc_3 == 66001 || _loc_3 == 66002 || _loc_3 == 66003) && GuideUI.testId(35))
            {
                GuideUI.testDoId(35, Config.ui._systemUI._bagPB, Config.ui._bagUI);
            }
            else if (AutoDrug.canBuy && (_loc_3 == 66501 || _loc_3 == 66502 || _loc_3 == 66503) && GuideUI.testId(36))
            {
                GuideUI.testDoId(36, Config.ui._systemUI._bagPB, Config.ui._bagUI);
            }
            else if (_loc_3 == 10100 && GuideUI.testId(228))
            {
                GuideUI.testDoId(228, Config.ui._systemUI._bagPB, Config.ui._bagUI);
            }
            else if (_loc_3 == 95105 && GuideUI.testId(234))
            {
                GuideUI.testDoId(234, Config.ui._systemUI._bagPB, Config.ui._bagUI);
            }
            else if (_loc_3 == 94504 && GuideUI.testId(46))
            {
                GuideUI.doId(46, Config.ui._systemUI._charPB);
            }
            else if (_loc_3 == 95407 && GuideUI.testId(84))
            {
                GuideUI.doId(84, Config.ui._systemUI._bagPB);
            }
            else if (int(_loc_5.type) == 10 && int(_loc_5.subType) == 2 && GuideUI.testId(207))
            {
                GuideUI.testDoId(207, Config.ui._systemUI._bagPB, Config.ui._bagUI);
            }
            else if (int(_loc_5.type) == 10 && int(_loc_5.subType) == 5 && GuideUI.testId(213))
            {
                GuideUI.testDoId(213, Config.ui._systemUI._bagPB, Config.ui._bagUI);
            }
            else if (int(_loc_5.type) == 10 && int(_loc_5.subType) == 4 && GuideUI.testId(215))
            {
                GuideUI.testDoId(215, Config.ui._systemUI._petPB, Config.ui._petPanel);
            }
            if (_loc_4 > 1)
            {
                BubbleUI.bubble(Config.language("CharUI", 19) + _loc_5.name + "(" + _loc_4 + ")", 55551);
                Config.addHistory(Config.language("CharUI", 19) + _loc_5.name + "(" + _loc_4 + ")");
            }
            else if (_loc_4 == 1)
            {
                BubbleUI.bubble(Config.language("CharUI", 19) + _loc_5.name, 55551);
                Config.addHistory(Config.language("CharUI", 19) + _loc_5.name);
            }
            if (_loc_3 == 61011 && !GuideUI.getAct(253))
            {
                setTimeout(this.delay61011, 500);
                GuideUI.setAct(253);
            }
            if (_loc_3 == 62011 && !GuideUI.getAct(254))
            {
                setTimeout(this.delay62011, 500);
                GuideUI.setAct(254);
            }
            return;
        }// end function

        private function delay61011()
        {
            Config.ui._monsterIndexUI._setupPanel.addHpPotion(61011, 4);
            return;
        }// end function

        private function delay62011()
        {
            Config.ui._monsterIndexUI._setupPanel.addMpPotion(62011, 1);
            return;
        }// end function

        public function lockExtract()
        {
            this._lockExtract = true;
            clearTimeout(this._lockExtractTimer);
            this._lockExtractTimer = setTimeout(this.releaselockExtract, 200);
            return;
        }// end function

        public function releaselockExtract()
        {
            clearTimeout(this._lockExtractTimer);
            this._lockExtract = false;
            return;
        }// end function

        public function useItem(param1:Item)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = undefined;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            if (param1.cd > 0)
            {
                BubbleUI.bubble(Config.language("CharUI", 20));
                return;
            }
            if (param1._itemData.sex == 1 && Player.sex == 2 || param1._itemData.sex == 2 && Player.sex == 1)
            {
                return;
            }
            if (int(param1._itemData.baseID) == 10100)
            {
                if (Config.ui._taskpanel.getTaskState(68) == 3)
                {
                    GuideUI.testDoId(106);
                }
            }
            if (int(param1._itemData.baseID) == 94505)
            {
                Config.ui._energyPanel.switchOpen();
                _loc_5 = new MouseEvent(MouseEvent.DOUBLE_CLICK);
                Config.ui._energyPanel.selectPage(_loc_5, 1);
                return;
            }
            if (int(param1._itemData.baseID) == 51000)
            {
                Config.ui._expball.openball(param1._position);
            }
            else if (param1._itemData.type <= 2 && param1._itemData.subType != 2 && param1._itemData.subType != 3)
            {
                if (param1._itemData.subType == 6)
                {
                    if (Config.ui._followcharui.followlev >= Setting.FOLLOW_MAX_LEVEL || Config.ui._followcharui.followlev == Config.player.level)
                    {
                        AlertUI.alert(Config.language("CharUI", 31), Config.language("CharUI", 50), [Config.language("CharUI", 25)]);
                        return;
                    }
                }
                if (param1._itemData.useLimitType == 1 && param1._itemData.useLimitValue_s == 20)
                {
                    if (Config.map.data.type != 20)
                    {
                        Config.message(Config.language("CharUI", 49));
                        return;
                    }
                }
                if (Config.ui._charUI.firenum >= 10 && param1._itemData.id == 95105)
                {
                    Config.message(Config.language("CharUI", 37));
                    return;
                }
                _loc_6 = Number(param1._itemData.skillId);
                if (_loc_6 != 0)
                {
                    _loc_4 = Skill.getSkill(_loc_6);
                    _loc_4.select(param1._position);
                }
            }
            else if (param1._itemData.type == 23)
            {
                if (param1._position >= 1031 && param1._position <= 1035)
                {
                    _loc_2 = Config.ui._bagUI.getMinEmptySlot();
                    if (_loc_2 != null)
                    {
                        this.swapItem(param1, _loc_2._id);
                    }
                }
                else if (Config.ui._followcharui._opening)
                {
                    _loc_7 = 0;
                    while (_loc_7 < 5)
                    {
                        
                        if (this._slotArray[1031 + _loc_7].item == null)
                        {
                            this.swapItem(param1, 1031 + _loc_7);
                            break;
                        }
                        _loc_7++;
                    }
                }
            }
            else if (param1._itemData.type == 4)
            {
                _loc_8 = 0;
                if (param1._position >= 1021 && param1._position <= 1030 || Config.ui._followcharui._opening)
                {
                    _loc_8 = 20;
                }
                if (param1._itemData.subType < 7)
                {
                    if (param1._position == param1._itemData.subType + 1000 + _loc_8)
                    {
                        _loc_2 = Config.ui._bagUI.getMinEmptySlot();
                        if (_loc_2 != null)
                        {
                            this.swapItem(param1, _loc_2._id);
                            this.addchangeposi(param1._position);
                        }
                    }
                    else
                    {
                        this.swapItem(param1, param1._itemData.subType + 1000 + _loc_8);
                    }
                }
                else if (param1._itemData.subType == 7)
                {
                    if (param1._position == param1._itemData.subType + 1000 + _loc_8 || param1._position == param1._itemData.subType + 1001 + _loc_8)
                    {
                        _loc_2 = Config.ui._bagUI.getMinEmptySlot();
                        if (_loc_2 != null)
                        {
                            this.swapItem(param1, _loc_2._id);
                            this.addchangeposi(param1._position);
                        }
                    }
                    else if (Config.ui._charUI._slotArray[param1._itemData.subType + 1000 + _loc_8].item == null)
                    {
                        this.swapItem(param1, param1._itemData.subType + 1000 + _loc_8);
                    }
                    else if (Config.ui._charUI._slotArray[param1._itemData.subType + 1001 + _loc_8].item == null)
                    {
                        this.swapItem(param1, param1._itemData.subType + 1001 + _loc_8);
                    }
                    else
                    {
                        this.swapItem(param1, param1._itemData.subType + 1000 + _loc_8);
                    }
                }
                else if (param1._itemData.subType > 7)
                {
                    if (param1._itemData.subType > 10)
                    {
                        _loc_8 = 0;
                    }
                    if (param1._position == param1._itemData.subType + 1001 + _loc_8)
                    {
                        _loc_2 = Config.ui._bagUI.getMinEmptySlot();
                        if (_loc_2 != null)
                        {
                            this.swapItem(param1, _loc_2._id);
                            this.addchangeposi(param1._position);
                        }
                    }
                    else
                    {
                        this.swapItem(param1, param1._itemData.subType + 1001 + _loc_8);
                    }
                }
            }
            else if (param1._itemData.type == 8 && param1._itemData.subType == 10000)
            {
                if (Config.ui._bagUI._bagActiveNumber < Config.ui._bagUI._slotNumber)
                {
                    AlertUI.alert(Config.language("CharUI", 21), Config.language("CharUI", 22), [Config.language("CharUI", 13), Config.language("CharUI", 14)], [this.openThirdBag]);
                }
                else
                {
                    AlertUI.alert(Config.language("CharUI", 23), Config.language("CharUI", 24), [Config.language("CharUI", 25)]);
                }
            }
            else if (param1._itemData.type == 7 || param1._itemData.type == 8 || param1._itemData.type == 12 || param1._itemData.type == 24 || param1._itemData.type == 18 || param1._itemData.type == 10 && param1._itemData.subType == 3)
            {
                if (int(param1._itemData.baseID) == 95300 && Config.player.level < 10)
                {
                    Config.message(Config.language("CharUI", 26));
                    return;
                }
                if (int(param1._itemData.baseID) == 95301 && Config.player.level < 20)
                {
                    Config.message(Config.language("CharUI", 26));
                    return;
                }
                if (int(param1._itemData.baseID) == 95302 && Config.player.level < 30)
                {
                    Config.message(Config.language("CharUI", 26));
                    return;
                }
                if (int(param1._itemData.baseID) == 95303 && Config.player.level < 40)
                {
                    Config.message(Config.language("CharUI", 26));
                    return;
                }
                if (int(param1._itemData.baseID) == 95304 && Config.player.level < 50)
                {
                    Config.message(Config.language("CharUI", 26));
                    return;
                }
                if (int(param1._itemData.baseID) == 95305 && Config.player.level < 60)
                {
                    Config.message(Config.language("CharUI", 26));
                    return;
                }
                _loc_3 = new DataSet();
                _loc_3.addHead(CONST_ENUM.CMSG_ITEM_USE);
                _loc_3.add16(param1._position);
                ClientSocket.send(_loc_3);
            }
            else if (param1._itemData.type == 10 && param1._itemData.subType == 2)
            {
                Config.ui._petPanel.pickItemPosition = param1._position;
                Config.ui._petPanel.checkPick();
            }
            else if (param1._itemData.type == 10 && param1._itemData.subType == 5)
            {
                _loc_3 = new DataSet();
                _loc_3.addHead(CONST_ENUM.CMSG_ITEM_USE);
                _loc_3.add16(param1._position);
                ClientSocket.send(_loc_3);
            }
            else if (param1._itemData.type == 10 && param1._itemData.subType == 12)
            {
                if (param1._position == param1._itemData.subType + 1001)
                {
                    _loc_2 = Config.ui._bagUI.getMinEmptySlot();
                    if (_loc_2 != null)
                    {
                        this.swapItem(param1, _loc_2._id);
                    }
                }
                else
                {
                    this.swapItem(param1, param1._itemData.subType + 1001);
                }
            }
            else
            {
                _loc_3 = new DataSet();
                _loc_3.addHead(CONST_ENUM.CMSG_ITEM_USE);
                _loc_3.add16(param1._position);
                ClientSocket.send(_loc_3);
            }
            return;
        }// end function

        public function findThirdBag()
        {
            return Config.ui._charUI.getOneItemType(8, 10000);
        }// end function

        public function openThirdBag(param1 = null)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = null;
            if (Config.ui._bagUI._bagActiveNumber < Config.ui._bagUI._slotNumber)
            {
                _loc_2 = this.findThirdBag();
                if (_loc_2 != null)
                {
                    _loc_3 = new DataSet();
                    _loc_3.addHead(CONST_ENUM.CMSG_ITEM_USE);
                    _loc_3.add16(_loc_2._position);
                    ClientSocket.send(_loc_3);
                }
                else
                {
                    AlertUI.alert(Config.language("CharUI", 29), Config.language("CharUI", 30), [Config.language("CharUI", 25)]);
                }
            }
            else
            {
                AlertUI.alert(Config.language("CharUI", 23), Config.language("CharUI", 24), [Config.language("CharUI", 25)]);
            }
            return;
        }// end function

        public function swapItem(param1:Item, param2)
        {
            var _loc_3:* = {position:param2, item:param1};
            if ((param1._position == 1013 || param2 == 1013) && Config.ui._petPanel.checkHammerSaving())
            {
                AlertUI.remove(this._hammerAlertID);
                this._hammerAlertID = AlertUI.alert(Config.language("CharUI", 31), Config.language("CharUI", 46), [Config.language("CharUI", 13), Config.language("CharUI", 14)], [this.doSwapItem], _loc_3);
            }
            else
            {
                this.doSwapItem(_loc_3);
            }
            return;
        }// end function

        private function doSwapItem(param1:Object)
        {
            Config.ui._petPanel.closeHammer();
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.CMSG_ITEM_SWAP);
            _loc_2.add16(param1.item._position);
            _loc_2.add16(param1.position);
            ClientSocket.send(_loc_2);
            if ((param1.position >= 1021 || param1.item._position >= 1021) && (param1.position <= 1030 || param1.item._position <= 1030))
            {
                Config.ui._followcharui.sendlistinfor();
            }
            return;
        }// end function

        public function get firenum() : int
        {
            return this._firenum;
        }// end function

        public function set firenum(param1:int) : void
        {
            this._firenum = param1;
            return;
        }// end function

        private function resettip(event:MouseEvent = null) : void
        {
            var _loc_2:* = Config.stage.mouseX + 10;
            var _loc_3:* = Config.stage.mouseY + 10;
            if (_loc_2 + this.protip.width > Config.stage.stageWidth)
            {
                _loc_2 = Config.stage.mouseX - 10 - this.protip.width;
            }
            if (_loc_3 + 10 + this.protip.height > Config.stage.stageHeight)
            {
                _loc_3 = Config.stage.mouseY - 10 - this.protip.height;
            }
            this.protip.x = _loc_2;
            this.protip.y = _loc_3;
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

        public function getPosite(param1:int) : int
        {
            var _loc_2:* = 1;
            if (param1 < 500)
            {
                _loc_2 = 1;
            }
            else if (param1 > 1000)
            {
                _loc_2 = 3;
            }
            else
            {
                _loc_2 = 2;
            }
            return _loc_2;
        }// end function

        public function getOutfitNum(param1:int, param2:int, param3:int) : int
        {
            var _loc_4:* = 0;
            var _loc_5:* = this._equipStartIndex + param3;
            while (_loc_5 < this._equipStartIndex + param3 + 10)
            {
                
                if (this._slotArray[_loc_5].item != null)
                {
                    if (int(this._slotArray[_loc_5].item._itemData.suitID) == param1)
                    {
                        _loc_4++;
                    }
                }
                _loc_5 = _loc_5 + 1;
            }
            if (param2 != 3)
            {
                _loc_4 = 1;
            }
            return _loc_4;
        }// end function

        public function checkOutfit(param1:int, param2:int, param3:int, param4:int) : Boolean
        {
            var _loc_5:* = false;
            if (this._slotArray[this._equipStartIndex + param4 + param1 - 1].item != null)
            {
                if (this._slotArray[this._equipStartIndex + param4 + param1 - 1].item._itemData.id == param2 && this._slotArray[this._equipStartIndex + param4 + param1 - 1].item._itemData.suitID == param3)
                {
                    _loc_5 = true;
                }
                if (param1 == 7)
                {
                    if (this._slotArray[this._equipStartIndex + param4 + param1 - 1].item._itemData.id == param2 && this._slotArray[this._equipStartIndex + param4 + param1 - 1].item._itemData.suitID == param3)
                    {
                        _loc_5 = true;
                    }
                }
                else if (param1 == 8)
                {
                    if (this._slotArray[this._equipStartIndex + param4 + param1 - 1].item._itemData.id == param2 && this._slotArray[this._equipStartIndex + param4 + param1 - 1].item._itemData.suitID == param3)
                    {
                        _loc_5 = true;
                    }
                }
            }
            return _loc_5;
        }// end function

        public function getequprop(param1:uint) : Array
        {
            var _loc_3:* = 0;
            var _loc_2:* = new Array();
            if (this._slotArray[param1].item != null)
            {
                if (this._slotArray[param1].item._itemData.quality >= 6)
                {
                    _loc_3 = 0;
                    while (_loc_3 < this._slotArray[param1].item._itemData.addEffect.length)
                    {
                        
                        _loc_2.push(this._slotArray[param1].item._itemData.addEffect[_loc_3].id);
                        _loc_3 = _loc_3 + 1;
                    }
                }
            }
            return _loc_2;
        }// end function

        public function fightspr() : FightSprit
        {
            return this._spr;
        }// end function

        public function addproductbitmap(param1:int)
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (param1 >= 1001 && param1 <= 1010 || param1 == 1012 || param1 == 1014)
            {
                this.removebitma(param1);
                if (this._slotArray[param1].item._itemData.reqLevel == 1)
                {
                    return;
                }
                if (param1 == 1012)
                {
                    if (!Config.ver_zuoji)
                    {
                        return;
                    }
                }
                else if (param1 == 1014)
                {
                    if (!Config.ver_chibang)
                    {
                        return;
                    }
                }
                if (this._slotArray[param1].item._itemData.qual <= 5 && !this._slotArray[param1]._locked)
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
                    _loc_2.x = this._slotArray[param1].x + 19;
                    _loc_2.y = this._slotArray[param1].y + 19;
                }
            }
            else if (param1 >= 1021 && param1 <= 1030)
            {
                Config.ui._followcharui.addfollowproductbitmap(param1);
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
            if (this._slotArray[param2].item != null)
            {
                Config.ui._producepanel.openproduce(this._slotArray[param2].item, param2);
            }
            return;
        }// end function

        public function removebitma(param1:int)
        {
            if (param1 >= 1001 && param1 <= 1010 || param1 == 1012 || param1 == 1014)
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
            }
            else if (param1 >= 1021 && param1 <= 1030)
            {
                Config.ui._followcharui.removebitma(param1);
            }
            return;
        }// end function

        private function addchangeposi(param1:int)
        {
            if (param1 >= 1001 && param1 <= 1010)
            {
                this.removebitma(param1);
            }
            else if (param1 >= 1021 && param1 <= 1030)
            {
                this.removebitma(param1);
            }
            else if (param1 == 1012 || param1 == 1014)
            {
                this.removebitma(param1);
            }
            return;
        }// end function

    }
}
