package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.net.*;
    import flash.text.*;
    import flash.utils.*;
    import lovefox.component.*;
    import lovefox.socket.*;
    import lovefox.unit.*;

    public class ShopMall extends Window
    {
        private var itemarr:Array;
        public var itemcontain:CanvasUI;
        private var _slotArray:Array;
        private var topbar:ButtonBar;
        private var giftItemarr:Array;
        private var moneylabel:Label;
        private var giftMoneylabel:Label;
        private var _fashionTxt:TextField;
        private var _fashionAlertId:uint;
        private var _fashionClip:UnitClip;
        private var Purchasepanel:Window;
        private var panel:Sprite;
        private var _giftBtn:PushButton;
        private var yebtn:Bitmap;
        private var vipitemarr:Array;
        private var _viprice:int;
        private var vipbitmap:Bitmap;
        private var vipbg:Shape;
        private var vipLaber:Label;
        private var _vipLv:int;
        private var _lostime:int;
        private var _washstoneprice:int;
        public var _visbitempriceArr:Array;
        public var _choujiang:Choujiang;
        private var _itemGiftPos:Object;
        private var _itemPos:Object;
        public var _itemExistMap:Object;
        public static var _preGuideTime:int = 0;

        public function ShopMall(param1)
        {
            this._slotArray = [];
            this._choujiang = new Choujiang();
            this._itemGiftPos = {};
            this._itemPos = {};
            this._itemExistMap = {};
            super(param1);
            this.initsocket();
            resize(538, 410);
            this.panel = new Sprite();
            this.initpanel();
            this.initgift();
            this.initvipanel();
            return;
        }// end function

        private function initsocket() : void
        {
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_STORE_ITEM_LIST, this.getitemlist);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_QQ_BUY, this.qqBuy);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_VIP_INFO, this.getvipinfo);
            return;
        }// end function

        override public function switchOpen() : void
        {
            super.switchOpen();
            this.initpanel();
            this.showitemlist(null, 99);
            this.moneylabel.text = Config.coinShow(Config.player.money1);
            this.moneylabel.x = 175 - (160 - this.moneylabel.width) / 2;
            Config.player.removeEventListener("update", this.updatemoney);
            Config.player.addEventListener("update", this.updatemoney);
            if (Config._lanVersion == LanVersion.QQ_ZH_CN)
            {
                Config.player.money1 = 999999;
            }
            return;
        }// end function

        public function scrollToItem(param1:int)
        {
            if (this._itemPos[param1] != null)
            {
                this.itemcontain.verticalScrollPosition = this.itemcontain.backPosition(this._itemPos[param1]);
            }
            return;
        }// end function

        public function scrollToItemGift(param1:int)
        {
            if (this._itemGiftPos[param1] != null)
            {
                this.itemcontain.verticalScrollPosition = this.itemcontain.backPosition(this._itemGiftPos[param1]);
            }
            return;
        }// end function

        private function initgift()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = undefined;
            var _loc_9:* = null;
            var _loc_10:* = null;
            this.giftItemarr = new Array();
            for (_loc_1 in Config._buy)
            {
                
                if (int(Config._buy[_loc_1].shopsid) == 10010)
                {
                    _loc_2 = new Object();
                    _loc_2.typeid = int(Config._buy[_loc_1].type);
                    _loc_2.id = int(Config._buy[_loc_1].itemId);
                    _loc_3 = Item.newItem(Config._itemMap[_loc_2.id], 0, 0, UNIT_TYPE_ENUM.TYPEID_ITEMCLONE, 0);
                    _loc_3.display();
                    _loc_2.item = _loc_3;
                    _loc_4 = new CloneSlot(0, 30);
                    _loc_4.x = 30;
                    _loc_4.y = 35;
                    _loc_4.item = _loc_2.item;
                    _loc_4.addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
                    _loc_4.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
                    _loc_2.slot = _loc_4;
                    _loc_2.moneyflag = Config._buy[_loc_1].buyType;
                    _loc_2.goldcoin = Config._buy[_loc_1].buyValue;
                    _loc_2.sortId = Config._buy[_loc_1].buyIteminit;
                    _loc_5 = new Sprite();
                    _loc_5.graphics.beginFill(16777215, 0.4);
                    _loc_5.graphics.drawRoundRect(0, 0, 246, 134, 5);
                    _loc_5.graphics.endFill();
                    _loc_6 = new Label(_loc_5, 10, 5, _loc_3._itemData.name);
                    _loc_5.addChild(_loc_2.slot);
                    _loc_2.itemcontainer = _loc_5;
                    _loc_7 = new TextAreaUI(_loc_5, 72, 22, 160);
                    _loc_7.autoHeight = true;
                    if (Config._itemMap[_loc_2.id].description == null)
                    {
                        Config._itemMap[_loc_2.id].description = "";
                    }
                    _loc_8 = Config._itemMap[_loc_2.id].description;
                    _loc_7.text = _loc_8;
                    _loc_7.y = (106 - _loc_7.height) / 2;
                    _loc_9 = new Label(_loc_5, 110, 108);
                    _loc_9.text = Config.language("ShopMall", 1) + Config.coinShow(_loc_2.goldcoin);
                    _loc_10 = new PushButton(_loc_5, 190, 105, Config.language("ShopMall", 2), this.create(this.openbuygift, _loc_2));
                    _loc_10.width = 50;
                    _loc_10.height = 18;
                    this.giftItemarr.push(_loc_2);
                }
            }
            return;
        }// end function

        private function initvipanel() : void
        {
            this.vipbg = new Shape();
            this.vipbg.graphics.beginFill(7689037);
            this.vipbg.graphics.drawRoundRect(10, 28, 520, 34, 5);
            this.vipbg.graphics.beginFill(13545363);
            this.vipbg.graphics.drawRoundRect(10, 100, 520, 290, 5);
            this.vipbg.graphics.endFill();
            this.vipLaber = new Label(null, 20, 35);
            this.vipLaber.html = true;
            return;
        }// end function

        private function initpanel() : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            if (this.itemcontain != null)
            {
                this.removeAllChildren(this.itemcontain);
            }
            this.removeAllChildren(this.panel);
            this.addChild(this.panel);
            this.title = Config.language("ShopMall", 3);
            var _loc_1:* = new Shape();
            this.panel.addChild(_loc_1);
            _loc_1.graphics.beginFill(13545363);
            _loc_1.graphics.drawRoundRect(10, 28, 520, 34, 5);
            _loc_1.graphics.drawRoundRect(10, 100, 520, 290, 5);
            if (Config._lanVersion == LanVersion.QQ_ZH_CN)
            {
            }
            else
            {
                _loc_1.graphics.beginFill(7689037);
                _loc_1.graphics.drawRoundRect(15, 31, 190, 28, 2);
            }
            _loc_1.graphics.endFill();
            this.moneylabel = new Label(this.panel, 40, 35);
            this.moneylabel.textColor = 16767082;
            if (Config._lanVersion == LanVersion.QQ_ZH_CN)
            {
                _loc_5 = new Sprite();
                this.panel.addChild(_loc_5);
                _loc_5.buttonMode = true;
                _loc_5.addEventListener(MouseEvent.CLICK, this.openvipPay);
                _loc_5.addEventListener(MouseEvent.ROLL_OVER, this.overQQBtn);
                _loc_5.addEventListener(MouseEvent.ROLL_OUT, this.outQQBtn);
                this.yebtn = new Bitmap();
                _loc_5.addChild(this.yebtn);
                _loc_5.x = 10;
                _loc_5.y = 30;
                this.setYeVip();
                _loc_6 = new Bitmap();
                this.panel.addChild(_loc_6);
                _loc_6.bitmapData = Config.findsysUI("headui/qq3", 128, 57);
                _loc_6.x = 130;
                _loc_6.y = 15;
            }
            else
            {
                _loc_7 = new Label(this.panel, 20, 35, Config.language("ShopMall", 4));
                _loc_7.textColor = 16767082;
            }
            var _loc_2:* = new PushButton(this.panel, 210, 35, Config.language("ShopMall", 5), this.getbtnurl);
            _loc_2.width = 60;
            var _loc_3:* = new PushButton(this.panel, 275, 35, Config.language("ShopMall", 30), this.giftcoupons);
            _loc_3.width = 80;
            this.giftMoneylabel = new Label(null, 40, 35);
            this.giftMoneylabel.textColor = 7689037;
            this._giftBtn = _loc_3;
            if (!Config._switchMobage)
            {
                _loc_8 = new PushButton(this.panel, 360, 35, Config.language("ShopMall", 29), this.vipshop);
                _loc_8.width = 80;
            }
            var _loc_4:* = new PushButton(this.panel, 445, 35, Config.language("Choujiang", 1), this.choujiang);
            new PushButton(this.panel, 445, 35, Config.language("Choujiang", 1), this.choujiang).width = 80;
            this.itemcontain = new CanvasUI(this.panel, 15, 105, 510, 275);
            this.topbar = new ButtonBar(this.panel, 15, 70);
            this.topbar.addTab(Config.language("ShopMall", 7), Config.create(this.showitemlist, 99));
            this.topbar.addTab(Config.language("ShopMall", 8), Config.create(this.showitemlist, 1), 77);
            this.topbar.addTab(Config.language("ShopMall", 9), Config.create(this.showitemlist, 3));
            this.topbar.addTab(Config.language("ShopMall", 10), Config.create(this.showitemlist, 5));
            this.topbar.addTab(Config.language("ShopMall", 11), Config.create(this.showitemlist, 6));
            this.topbar.addTab(Config.language("ShopMall", 12), Config.create(this.showitemlist, 7));
            this.topbar.addTab(Config.language("ShopMall", 13), Config.create(this.showitemlist, 8));
            this.topbar.addTab(Config.language("ShopMall", 14), Config.create(this.showitemlist, 0));
            return;
        }// end function

        override public function testGuide()
        {
            GuideUI.testDoId(63, this._giftBtn);
            if (_preGuideTime > 0 && getTimer() - _preGuideTime <= 10)
            {
                this.giftcoupons();
            }
            return;
        }// end function

        public function openListPanel(param1:int = 0) : void
        {
            this.backshopmail();
            switch(param1)
            {
                case 99:
                {
                    this.topbar.selectpage = 0;
                    break;
                }
                case 1:
                {
                    this.topbar.selectpage = 1;
                    break;
                }
                case 3:
                {
                    this.topbar.selectpage = 2;
                    break;
                }
                case 5:
                {
                    this.topbar.selectpage = 3;
                    break;
                }
                case 6:
                {
                    this.topbar.selectpage = 4;
                    break;
                }
                case 7:
                {
                    this.topbar.selectpage = 5;
                    break;
                }
                case 8:
                {
                    this.topbar.selectpage = 6;
                    break;
                }
                case 0:
                {
                    this.topbar.selectpage = 7;
                    break;
                }
                default:
                {
                    break;
                }
            }
            this.showitemlist(null, param1);
            open();
            return;
        }// end function

        private function showitemlist(event:MouseEvent = null, param2:int = 0) : void
        {
            this.itemcontain.removeAllChildren();
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            while (_loc_4 < this.itemarr.length)
            {
                
                if (this.itemarr[_loc_4].hot == 1 && param2 == 99)
                {
                    this.itemcontain.addChildUI(this.itemarr[_loc_4].itemcontainer);
                    this.itemarr[_loc_4].itemcontainer.x = _loc_3 % 2 * 255;
                    this.itemarr[_loc_4].itemcontainer.y = int(_loc_3 / 2) * 139;
                    _loc_3++;
                }
                else if (this.itemarr[_loc_4].type == param2 || param2 == 0)
                {
                    this.itemcontain.addChildUI(this.itemarr[_loc_4].itemcontainer);
                    this.itemarr[_loc_4].itemcontainer.x = _loc_3 % 2 * 255;
                    this.itemarr[_loc_4].itemcontainer.y = int(_loc_3 / 2) * 139;
                    _loc_3++;
                }
                this._itemPos[this.itemarr[_loc_4].item._itemData.id] = this.itemarr[_loc_4].itemcontainer.y;
                _loc_4 = _loc_4 + 1;
            }
            this.itemcontain.reFresh();
            return;
        }// end function

        private function getpage(event:MouseEvent, param2:int) : void
        {
            trace("ShopMall.getpage", param2);
            return;
        }// end function

        private function openbuy(event:MouseEvent = null, param2:int = 0, param3:int = 1, param4:int = 0) : void
        {
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            if (param4 == 0)
            {
                while (_loc_5 < this.itemarr.length)
                {
                    
                    if ((Config._itemMap[param2].maxSum == 0 || Config._itemMap[param2].maxSum == 1) && this.itemarr[_loc_5].id == param2)
                    {
                        if (this.Purchasepanel != null)
                        {
                            this.Purchasepanel.close();
                        }
                        Config.ui._shopbuy.close();
                        this.Purchasepanel = new Window(this.container, Config.ui._shopbuy.x, Config.ui._shopbuy.y);
                        this.Purchasepanel.resize(300, 220);
                        this.Purchasepanel.title = Config.language("ShopMall", 15);
                        _loc_6 = new CloneSlot(0, 30);
                        _loc_7 = Item.newItem(Config._itemMap[this.itemarr[_loc_5].id], 0, 0, UNIT_TYPE_ENUM.TYPEID_ITEMCLONE, 0);
                        _loc_7.display();
                        _loc_6.item = _loc_7;
                        this.Purchasepanel.addChild(_loc_6);
                        _loc_6.x = 20;
                        _loc_6.y = 50;
                        _loc_6.addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
                        _loc_6.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
                        _loc_8 = new Label(this.Purchasepanel, 70, 50, Config._itemMap[param2].name);
                        if (Config._lanVersion == LanVersion.QQ_ZH_CN)
                        {
                            _loc_11 = new Label(this.Purchasepanel, 70, 80, Config.language("ShopMall", 28) + param3);
                        }
                        else
                        {
                            _loc_11 = new Label(this.Purchasepanel, 70, 80, Config.language("ShopMall", 16) + param3);
                        }
                        _loc_9 = new InputText(this.Purchasepanel, 120, 115, "1");
                        _loc_9.tf.type = TextFieldType.DYNAMIC;
                        _loc_9.width = 60;
                        if (Config._lanVersion == LanVersion.QQ_ZH_CN)
                        {
                            _loc_12 = new Label(this.Purchasepanel, 70, 140);
                            _loc_12.textColor = 11344686;
                            _loc_12.text = Config.language("ShopMall", 27);
                            Math.round(param3 * 0.8);
                            _loc_13 = new Bitmap();
                            _loc_13.bitmapData = Config.findsysUI("headui/qq4", 22, 17);
                            _loc_13.x = 40;
                            _loc_13.y = 138;
                            this.Purchasepanel.addChild(_loc_13);
                        }
                        _loc_10 = new PushButton(this.Purchasepanel, 115, 170, Config.language("ShopMall", 2), this.create(this.itembuy, param2));
                        _loc_10.width = 60;
                        this.Purchasepanel.open();
                    }
                    else if (this.itemarr[_loc_5].id == param2)
                    {
                        if (this.Purchasepanel != null)
                        {
                            this.Purchasepanel.close();
                        }
                        Config.ui._shopbuy.initdata(this.itemarr[_loc_5], true);
                        Config.ui._shopbuy.open();
                    }
                    _loc_5 = _loc_5 + 1;
                }
            }
            else
            {
                while (_loc_5 < this.vipitemarr.length)
                {
                    
                    if (this.vipitemarr[_loc_5].id == param2)
                    {
                        if (this.Purchasepanel != null)
                        {
                            this.Purchasepanel.close();
                        }
                        Config.ui._shopbuy.initdata(this.vipitemarr[_loc_5], true);
                        Config.ui._shopbuy.open();
                    }
                    _loc_5 = _loc_5 + 1;
                }
            }
            return;
        }// end function

        private function itembuy(event:MouseEvent, param2)
        {
            if (this.Purchasepanel != null)
            {
                this.Purchasepanel.close();
            }
            this.sendbuy(param2, 1, 0);
            return;
        }// end function

        private function openbuygift(event:MouseEvent, param2)
        {
            if (this.Purchasepanel != null)
            {
                this.Purchasepanel.close();
            }
            Config.ui._shopbuy.initdata(param2);
            Config.ui._shopbuy.open();
            return;
        }// end function

        private function opentry(event:MouseEvent, param2, param3, param4) : void
        {
            var _loc_5:* = null;
            var _loc_8:* = undefined;
            var _loc_9:* = undefined;
            var _loc_10:* = undefined;
            var _loc_11:* = 0;
            var _loc_12:* = undefined;
            var _loc_13:* = undefined;
            _loc_5 = new Sprite();
            var _loc_6:* = Config.player._data;
            var _loc_7:* = UnitClip.newUnitClip(Config._model[Number(_loc_6.model)]);
            UnitClip.newUnitClip(Config._model[Number(_loc_6.model)]).multiLayer = true;
            _loc_7.layerStack = _loc_6.id;
            while (_loc_11 < this.itemarr.length)
            {
                
                if (this.itemarr[_loc_11].id == param2)
                {
                    _loc_13 = this.itemarr[_loc_11].item._data;
                }
                _loc_11 = _loc_11 + 1;
            }
            if (Config.player.sex == 1)
            {
                _loc_9 = String(_loc_13.mModel);
            }
            else
            {
                _loc_9 = String(_loc_13.fModel);
            }
            if (_loc_9.indexOf(":") == -1)
            {
                _loc_8 = Config._model[Number(_loc_9)];
            }
            else
            {
                _loc_10 = _loc_9.split(":");
                if (Config.player.job == 1)
                {
                    _loc_8 = Config._model[Number(_loc_10[0])];
                }
                else if (Config.player.job == 4)
                {
                    _loc_8 = Config._model[Number(_loc_10[1])];
                }
                else if (Config.player.job == 10)
                {
                    _loc_8 = Config._model[Number(_loc_10[2])];
                }
            }
            _loc_7.cloth = _loc_8;
            if (Config.player.job == 1)
            {
                if (Config.player.sex == 1)
                {
                    _loc_12 = Config._model[Number(Config._hairMap[Config.player.hairId].fightMale)];
                }
                else
                {
                    _loc_12 = Config._model[Number(Config._hairMap[Config.player.hairId].fightFemale)];
                }
            }
            else if (Config.player.job == 4)
            {
                if (Config.player.sex == 1)
                {
                    _loc_12 = Config._model[Number(Config._hairMap[Config.player.hairId].rangerMale)];
                }
                else
                {
                    _loc_12 = Config._model[Number(Config._hairMap[Config.player.hairId].rangerFemale)];
                }
            }
            else if (Config.player.job == 10)
            {
                if (Config.player.sex == 1)
                {
                    _loc_12 = Config._model[Number(Config._hairMap[Config.player.hairId].magicMale)];
                }
                else
                {
                    _loc_12 = Config._model[Number(Config._hairMap[Config.player.hairId].magicFemale)];
                }
            }
            _loc_7.hair = _loc_12;
            if (Config.player.weaponId != null && Config.player.weaponId != 0)
            {
                _loc_13 = Config._itemMap[Config.player.weaponId];
                if (Config.player.sex == 1)
                {
                    _loc_8 = Config._model[Number(_loc_13.mModel)];
                }
                else
                {
                    _loc_8 = Config._model[Number(_loc_13.fModel)];
                }
                _loc_7.weapon = _loc_8;
            }
            else
            {
                _loc_7.weapon = null;
            }
            _loc_7.changeStateTo("idle");
            _loc_7.x = 92;
            _loc_7.y = 64;
            _loc_5.addChild(_loc_7);
            if (this._fashionTxt == null)
            {
                this._fashionTxt = Config.getSimpleTextField();
                this._fashionTxt.x = 0;
                this._fashionTxt.y = 96;
            }
            this._fashionTxt.htmlText = Config.language("ShopMall", 17);
            _loc_5.addChild(this._fashionTxt);
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
            this._fashionClip = _loc_7;
            this._fashionAlertId = AlertUI.alert(Config.language("ShopMall", 17), "", [Config.language("ShopMall", 2), Config.language("ShopMall", 18)], [this.create(this.buyfashion, param2, param3, param4), this.closeFashion], _loc_7, false, true, false, _loc_5, false, null, null, 120);
            return;
        }// end function

        private function buyfashion(param1:UnitClip, param2:int, param3:int, param4:int)
        {
            this.closeFashion();
            this.openbuy(null, param2, param3, param4);
            return;
        }// end function

        private function closeFashion(param1:UnitClip = null)
        {
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

        private function getitemlist(event:SocketEvent) : void
        {
            var _loc_2:* = null;
            var _loc_4:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = undefined;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            this.itemarr = new Array();
            this.vipitemarr = new Array();
            this._visbitempriceArr = [];
            var _loc_3:* = event.data;
            var _loc_5:* = _loc_3.readUnsignedInt();
            var _loc_6:* = 0;
            while (_loc_6 < _loc_5)
            {
                
                _loc_7 = new Object();
                _loc_7.id = _loc_3.readUnsignedInt();
                this._itemExistMap[_loc_7.id] = true;
                _loc_7.type = _loc_3.readByte();
                _loc_7.hot = _loc_3.readByte();
                _loc_7.goldcoin = _loc_3.readUnsignedInt();
                if (_loc_7.id == 802065)
                {
                    this.washstoneprice = _loc_7.goldcoin;
                }
                _loc_7.viptype = _loc_3.readByte();
                _loc_7.ifvisble = _loc_3.readByte();
                _loc_2 = new Object();
                _loc_2._id = _loc_7.id;
                _loc_2._price = _loc_7.goldcoin;
                this._visbitempriceArr.push(_loc_2);
                if (_loc_7.ifvisble == 1)
                {
                    _loc_7.item = Item.newItem(Config._itemMap[_loc_7.id], 0, 0, UNIT_TYPE_ENUM.TYPEID_ITEMCLONE, 0);
                    _loc_7.item.display();
                    _loc_8 = new CloneSlot(0, 30);
                    _loc_8.x = 30;
                    _loc_8.y = 35;
                    _loc_8.item = _loc_7.item;
                    _loc_8.addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
                    _loc_8.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
                    _loc_7.slot = _loc_8;
                    _loc_7.moneyflag = 1;
                    _loc_9 = new Sprite();
                    _loc_9.graphics.beginFill(16777215, 0.4);
                    _loc_9.graphics.drawRoundRect(0, 0, 246, 134, 5);
                    _loc_9.graphics.endFill();
                    _loc_10 = new TextAreaUI(_loc_9, 72, 22, 160);
                    _loc_10.autoHeight = true;
                    if (Config._itemMap[_loc_7.id].description == null)
                    {
                        Config._itemMap[_loc_7.id].description = "";
                    }
                    _loc_11 = Config._itemMap[_loc_7.id].description;
                    if (Config._itemMap[_loc_7.id].type == 4 && Config._itemMap[_loc_7.id].subType == 10)
                    {
                        _loc_11 = _loc_11 + ("\n<font color=\'#3249F6\'>" + Config.language("ShopMall", 19) + int(Config._itemMap[_loc_7.id].timeLimit / 24) + Config.language("ShopMall", 20) + "</font>");
                    }
                    _loc_10.text = _loc_11;
                    _loc_10.y = (106 - _loc_10.height) / 2;
                    if (_loc_7.type == 5 && _loc_7.viptype == 0)
                    {
                        if (Number(Config._itemMap[_loc_7.id].sex) != 0 && Number(Config._itemMap[_loc_7.id].sex) != Player.sex || Config._itemMap[_loc_7.id].type == 8 && Config._itemMap[_loc_7.id].subType == 7)
                        {
                            _loc_4 = new PushButton(_loc_9, 20, 105, Config.language("ShopMall", 17));
                            _loc_4.enabled = false;
                        }
                        else
                        {
                            _loc_4 = new PushButton(_loc_9, 20, 105, Config.language("ShopMall", 17), this.create(this.opentry, _loc_7.id, _loc_7.goldcoin, _loc_7.viptype));
                        }
                        _loc_4.width = 50;
                        _loc_4.height = 18;
                    }
                    _loc_4 = new PushButton(_loc_9, 190, 105, Config.language("ShopMall", 2), this.create(this.openbuy, _loc_7.id, _loc_7.goldcoin, _loc_7.viptype));
                    _loc_4.width = 50;
                    _loc_4.height = 18;
                    _loc_12 = new Label(_loc_9, 10, 5, _loc_7.item._itemData.name);
                    _loc_9.addChild(_loc_7.slot);
                    if (_loc_7.viptype == 0)
                    {
                        _loc_13 = new Label(_loc_9, 110, 108);
                        _loc_13.text = Config.language("ShopMall", 21) + Config.coinShow(_loc_7.goldcoin);
                    }
                    else
                    {
                        _loc_13 = new Label(_loc_9, 10, 108);
                        _loc_7.goldCoinText = _loc_13;
                    }
                    _loc_7.itemcontainer = _loc_9;
                    if (_loc_7.viptype == 0)
                    {
                        this.itemarr.push(_loc_7);
                        this._slotArray.push(_loc_8);
                    }
                    else
                    {
                        this.vipitemarr.push(_loc_7);
                        _loc_14 = new Label(_loc_9, 10, 108, "-----------------");
                    }
                }
                _loc_6 = _loc_6 + 1;
            }
            return;
        }// end function

        private function checkbuy(param1) : void
        {
            if (Config.player.money1 >= param1.coin)
            {
                this.sendbuy(param1.id, param1.num, param1.coin);
            }
            else
            {
                Config.message(Config.language("ShopMall", 12));
            }
            return;
        }// end function

        public function sendbuy(param1:int, param2:int, param3:int) : void
        {
            var _loc_4:* = new DataSet();
            new DataSet().addHead(CONST_ENUM.C2G_BUY_ITEM_FROM_STORE);
            _loc_4.add8(param3);
            _loc_4.add32(param1);
            _loc_4.add32(param2);
            _loc_4.addUTF(Config.sourceURL + Config.findIconURL(Config._itemMap[param1].icon));
            _loc_4.addUTF(String(Config.navURL).split(".")[0]);
            ClientSocket.send(_loc_4);
            return;
        }// end function

        public function sendbuygift(param1:int, param2:int) : void
        {
            var _loc_3:* = new DataSet();
            _loc_3.addHead(CONST_ENUM.C2G_BUY_ITEM_FROM_EASYSHOP);
            _loc_3.add8(2);
            _loc_3.add32(param1);
            _loc_3.add32(param2);
            ClientSocket.send(_loc_3);
            return;
        }// end function

        public function giftcoupons(param1 = null) : void
        {
            this.removeAllChildren(this.itemcontain);
            this.removeAllChildren(this.panel);
            this.addChild(this.panel);
            this.title = Config.language("ShopMall", 22);
            var _loc_2:* = new Shape();
            this.panel.addChild(_loc_2);
            _loc_2.graphics.beginFill(7689037);
            _loc_2.graphics.drawRoundRect(10, 28, 520, 34, 5);
            _loc_2.graphics.beginFill(13545363);
            _loc_2.graphics.drawRoundRect(10, 100, 520, 290, 5);
            _loc_2.graphics.drawRoundRect(15, 31, 200, 28, 2);
            _loc_2.graphics.endFill();
            var _loc_3:* = new Label(this.panel, 20, 35, Config.language("ShopMall", 23));
            _loc_3.textColor = 7689037;
            this.panel.addChild(this.giftMoneylabel);
            this.giftMoneylabel.text = Config.coinShow(Config.player.money2);
            this.giftMoneylabel.x = 175 - (160 - this.giftMoneylabel.width) / 2;
            var _loc_4:* = new PushButton(this.panel, 360, 35, Config.language("ShopMall", 24), this.backshopmail);
            new PushButton(this.panel, 360, 35, Config.language("ShopMall", 24), this.backshopmail).width = 120;
            var _loc_5:* = new ButtonBar(this.panel, 15, 70);
            new ButtonBar(this.panel, 15, 70).addTab(Config.language("ShopMall", 25), this.giftcommonlist);
            this.giftcommonlist();
            return;
        }// end function

        private function giftcommonlist(event:MouseEvent = null)
        {
            this.removeAllChildren(this.itemcontain);
            var _loc_2:* = 0;
            this.itemcontain = new CanvasUI(this.panel, 15, 105, 510, 275);
            var _loc_3:* = 0;
            while (_loc_3 < this.giftItemarr.length)
            {
                
                if (this.giftItemarr[_loc_3].typeid != 1)
                {
                    this.itemcontain.addChildUI(this.giftItemarr[_loc_3].itemcontainer);
                    this.giftItemarr[_loc_3].itemcontainer.x = _loc_2 % 2 * 255;
                    this.giftItemarr[_loc_3].itemcontainer.y = int(_loc_2 / 2) * 139;
                    _loc_2 = _loc_2 + 1;
                    this._itemGiftPos[this.giftItemarr[_loc_3].item._itemData.id] = this.giftItemarr[_loc_3].itemcontainer.y;
                }
                _loc_3 = _loc_3 + 1;
            }
            this.itemcontain.reFresh();
            return;
        }// end function

        public function backshopmail(param1 = null)
        {
            this.initpanel();
            this.moneylabel.text = Config.coinShow(Config.player.money1);
            this.moneylabel.x = 175 - (160 - this.moneylabel.width) / 2;
            this.showitemlist(null, 99);
            if (this._choujiang.parent != null)
            {
                this._choujiang.parent.removeChild(this._choujiang);
            }
            this._choujiang.close();
            return;
        }// end function

        public function sendtogive(param1:String, param2:int, param3:int, param4:int, param5:String) : void
        {
            var _loc_6:* = new DataSet();
            new DataSet().addHead(CONST_ENUM.CMSG_STORE_PRESENT);
            _loc_6.addUTF(param1);
            _loc_6.add32(param2);
            _loc_6.add16(param3);
            _loc_6.add16(param4);
            _loc_6.addUTF(param5);
            ClientSocket.send(_loc_6);
            return;
        }// end function

        override public function handleMouseMove()
        {
            var _loc_1:* = undefined;
            super.handleMouseMove();
            var _loc_2:* = 0;
            while (_loc_2 < this._slotArray.length)
            {
                
                if (this._slotArray[_loc_2].hitTestPoint(Config.stage.mouseX, Config.stage.mouseY))
                {
                    _loc_1 = this._slotArray[_loc_2];
                    break;
                }
                _loc_2 = _loc_2 + 1;
            }
            if (_loc_1 != null)
            {
                if (_loc_1.item != null)
                {
                    Holder.showInfo(_loc_1.item.outputInfo(), new Rectangle(_loc_1.parent.x + this.x + 100, _loc_1.parent.y + this.y + 50, _loc_1._size, _loc_1._size));
                }
                else
                {
                    Holder.closeInfo();
                }
            }
            else
            {
                Holder.closeInfo();
            }
            return;
        }// end function

        private function removeAllChildren(param1:Sprite) : void
        {
            while (param1.numChildren > 0)
            {
                
                param1.removeChildAt((param1.numChildren - 1));
            }
            return;
        }// end function

        private function create(param1:Function, ... args) : Function
        {
            args = new activation;
            var F:Boolean;
            var f:* = param1;
            var arg:* = args;
            F;
            var _f:* = function (param1) : void
            {
                var _loc_2:* = arg;
                if (!F)
                {
                    F = true;
                    _loc_2.unshift(param1);
                }
                f.apply(null, _loc_2);
                return;
            }// end function
            ;
            return ;
        }// end function

        private function updatemoney(event:UnitEvent) : void
        {
            if (event.param == "money1")
            {
                this.moneylabel.text = Config.coinShow(event.value);
                this.moneylabel.x = 175 - (160 - this.moneylabel.width) / 2;
            }
            if (event.param == "money2")
            {
                this.giftMoneylabel.text = Config.coinShow(event.value);
                this.giftMoneylabel.x = 175 - (160 - this.giftMoneylabel.width) / 2;
            }
            return;
        }// end function

        public function getbtnurl(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            if (Config._switchMobage)
            {
                ExternalInterface.call("voucher");
            }
            else if (Config._lanVersion == LanVersion.QQ_ZH_CN)
            {
                _loc_2 = new URLVariables();
                _loc_2.data = "";
                _loc_2.url = "";
                _loc_2.onFailure = this.feedFailure;
                ExternalInterface.call("klapp.dialog.recharge", _loc_2);
            }
            else if (Config.sourceURL == "")
            {
                navigateToURL(new URLRequest("http://xj.kunlun.com/2011/0509/article_387.html"));
            }
            else
            {
                navigateToURL(new URLRequest(Config.payURL));
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
                Holder.showInfo(_loc_2.item.outputInfo(), new Rectangle(_loc_3.x, _loc_3.y, _loc_2._size, _loc_2._size), false, 0, 150);
            }
            return;
        }// end function

        private function handleSlotOut(param1)
        {
            Holder.closeInfo();
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

        public function openvipPay(event:MouseEvent = null) : void
        {
            navigateToURL(new URLRequest("http://pay.qq.com/qzone/index.shtml?aid=game100622149.op"));
            return;
        }// end function

        public function openVipYear(event:MouseEvent = null) : void
        {
            navigateToURL(new URLRequest("http://pay.qq.com/qzone/index.shtml?aid=game100622149.yop&paytime=year"));
            return;
        }// end function

        private function qqBuy(event:SocketEvent) : void
        {
            var _loc_2:* = event.data.readUTF();
            var _loc_3:* = new URLVariables();
            _loc_3.url_params = _loc_2;
            _loc_3.token = "";
            _loc_3.orderId = "";
            _loc_3.onSuccess = this.buyCompleted;
            _loc_3.onFailure = this.buyFailure;
            ExternalInterface.call("klapp.dialog.buy", _loc_3);
            return;
        }// end function

        public function setYeVip() : void
        {
            if (Config._QQInfo.is_yellow_vip)
            {
                this.yebtn.bitmapData = Config.findsysUI("headui/qq1", 110, 34);
            }
            else
            {
                this.yebtn.bitmapData = Config.findsysUI("headui/qq2", 114, 34);
            }
            return;
        }// end function

        private function buyCompleted() : void
        {
            Config.message("购买成功");
            return;
        }// end function

        private function buyFailure() : void
        {
            Config.message("购买失败");
            return;
        }// end function

        private function feedFailure() : void
        {
            Config.message("充值失败");
            return;
        }// end function

        public function choujiang(event:MouseEvent = null)
        {
            if (this._choujiang.testInTime())
            {
                if (this.vipbitmap != null)
                {
                    if (this.vipbitmap.hasOwnProperty("bitmapData"))
                    {
                        this.vipbitmap.bitmapData.dispose();
                        this.vipbitmap = null;
                    }
                }
                this.removeAllChildren(this.itemcontain);
                this.removeAllChildren(this.panel);
                this.addChild(this._choujiang);
                this._choujiang.open();
                this.title = Config.language("Choujiang", 1);
            }
            else
            {
                this._choujiang.jumpNotTime();
            }
            return;
        }// end function

        public function vipshop(event:MouseEvent = null)
        {
            if (this.vipbitmap != null)
            {
                if (this.vipbitmap.hasOwnProperty("bitmapData"))
                {
                    this.vipbitmap.bitmapData.dispose();
                    this.vipbitmap = null;
                }
            }
            this.removeAllChildren(this.itemcontain);
            this.removeAllChildren(this.panel);
            this.addChild(this.panel);
            this.title = Config.language("ShopMall", 29);
            this.panel.addChild(this.vipbg);
            this.panel.addChild(this.vipLaber);
            if (this.vipLv == 0)
            {
                this.vipLaber.text = "<font color=\'" + "#000000" + "\'>" + Config.language("ShopMall", 31) + "</font>  <b><font size=\'18\' color=\'" + Style.FONT_Gray + "\'>VIP 0</font></b>";
            }
            else
            {
                this.vipLaber.text = "<font color=\'" + "#000000" + "\'>" + Config.language("ShopMall", 31) + "</font>  <b><font size=\'18\' color=\'" + Style.FONT_3_Orange + "\'>VIP " + this.vipLv + "</font></b>";
            }
            this.vipbitmap = new Bitmap();
            this.vipbitmap.bitmapData = Config.findsysUI("headui/qq3", 128, 57);
            this.vipbitmap.x = 150;
            this.vipbitmap.y = 15;
            this.panel.addChild(this.vipbitmap);
            var _loc_2:* = new PushButton(this.panel, 360, 35, Config.language("ShopMall", 24), this.backshopmail);
            _loc_2.width = 120;
            var _loc_3:* = new ButtonBar(this.panel, 15, 70);
            _loc_3.addTab(Config.language("ShopMall", 32));
            this.vipitemlist();
            return;
        }// end function

        private function vipitemlist()
        {
            this.removeAllChildren(this.itemcontain);
            var _loc_1:* = 0;
            this.itemcontain = new CanvasUI(this.panel, 15, 105, 510, 275);
            var _loc_2:* = 0;
            while (_loc_2 < this.vipitemarr.length)
            {
                
                if (this.vipitemarr[_loc_2].typeid != 1)
                {
                    this.vipitemarr[_loc_2].goldCoinText.text = Config.language("ShopMall", 33) + Config.coinShow(this.vipitemarr[_loc_2].goldcoin) + "            " + Config.language("ShopMall", 34) + Config.coinShow(int(this.viprice / 100 * this.vipitemarr[_loc_2].goldcoin));
                    this.itemcontain.addChildUI(this.vipitemarr[_loc_2].itemcontainer);
                    this.vipitemarr[_loc_2].itemcontainer.x = _loc_1 % 2 * 255;
                    this.vipitemarr[_loc_2].itemcontainer.y = int(_loc_1 / 2) * 139;
                    _loc_1 = _loc_1 + 1;
                }
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        private function getvipinfo(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            this.vipLv = _loc_2.readByte();
            this.lostime = _loc_2.readUnsignedInt();
            this.viprice = _loc_2.readByte();
            Config.ui._vipPanel.freshviptime(this.lostime);
            if (this.vipLv != 0)
            {
                Config.ui._playerHead.changevipbitmap(this.vipLv);
            }
            return;
        }// end function

        public function set viprice(param1:int)
        {
            this._viprice = param1;
            return;
        }// end function

        public function get viprice() : int
        {
            return this._viprice;
        }// end function

        public function set lostime(param1:int)
        {
            this._lostime = param1;
            return;
        }// end function

        public function get lostime() : int
        {
            return this._lostime;
        }// end function

        public function set vipLv(param1:int)
        {
            this._vipLv = param1;
            return;
        }// end function

        public function get vipLv() : int
        {
            return this._vipLv;
        }// end function

        public function set washstoneprice(param1:int)
        {
            this._washstoneprice = param1;
            return;
        }// end function

        public function get washstoneprice() : int
        {
            return this._washstoneprice;
        }// end function

    }
}
