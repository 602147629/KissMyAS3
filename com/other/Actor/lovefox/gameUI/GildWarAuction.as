package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;
    import lovefox.component.*;
    import lovefox.socket.*;

    public class GildWarAuction extends Window
    {
        private var panel:Sprite;
        private var gildid:uint;
        private var auctprice:uint;
        private var putpricepanel:Window;
        private var _priceput:InputText;
        private var _auctionewprice:int;
        private var bgpanelArr:Array;
        private var textName:TextField;
        private var texTime:TextField;
        private var textOccupy:TextField;
        private var textAuction:TextField;
        private var textPirce:TextField;
        private var textMade:TextField;
        private var npcName:ClickLabel;
        private var listArr:Array;
        private var textArrauc:Array;
        private var textArrpir:Array;

        public function GildWarAuction(param1:DisplayObjectContainer = null, param2:Number = 450, param3:Number = 100) : void
        {
            super(param1, param2, param3);
            resize(560, 250);
            this.init();
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_BEACHHEAD_AUCTION_BUY, this.backauctiongild);
            return;
        }// end function

        private function init()
        {
            this.title = Config.language("GildWarAuction", 1);
            this.panel = new Sprite();
            this.addChild(this.panel);
            var _loc_1:* = new ClickLabel(this, 335, 220, Config.language("GildWarAuction", 1), this.clable, true);
            _loc_1.html = true;
            _loc_1.clickColor([26367, 6837142]);
            return;
        }// end function

        private function clable(event:TextEvent)
        {
            Config.ui._gildWarStraction.open();
            return;
        }// end function

        public function getgildname(param1:Array) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            this.clearpanel();
            this.listArr = [];
            this.textArrauc = [];
            this.textArrpir = [];
            this.listArr = param1;
            this.bgpanelArr = new Array();
            var _loc_2:* = new CanvasUI(this.panel, 15, 25, 535, 210);
            var _loc_3:* = 0;
            while (_loc_3 < param1.length)
            {
                
                trace(param1[_loc_3].id, param1[_loc_3].gildname, param1[_loc_3].auctionprice, param1[_loc_3].name, param1[_loc_3].ifauciton, param1[_loc_3].gildwaror);
                if (param1[_loc_3].ifauciton == 0)
                {
                    this.addcontainer();
                    _loc_2.addChildUI(this.bgpanelArr[_loc_3]);
                    if (param1[_loc_3].id == 5)
                    {
                        this.textName.htmlText = "<font color=\'" + Style.FONT_White + "\'>" + param1[_loc_3].name + "</font> <font color=\'" + Style.FONT_3_Orange + "\'>" + Config.language("GildWarAuction", 3) + "</font>";
                    }
                    else if (param1[_loc_3].id == 8)
                    {
                        this.textName.htmlText = "<font color=\'" + Style.FONT_White + "\'>" + param1[_loc_3].name + "</font> <font color=\'" + Style.FONT_3_Orange + "\'>" + Config.language("GildWarAuction", 4) + "</font>";
                    }
                }
                else if (param1[_loc_3].ifauciton == 1)
                {
                    this.addcontainer();
                    _loc_2.addChildUI(this.bgpanelArr[_loc_3]);
                    if (param1[_loc_3].id == 5)
                    {
                        this.textName.htmlText = "<font color=\'" + Style.FONT_White + "\'>" + param1[_loc_3].name + "</font> <font color=\'" + Style.FONT_Green + "\'>" + Config.language("GildWarAuction", 5) + "</font>";
                    }
                    else if (param1[_loc_3].id == 8)
                    {
                        this.textName.htmlText = "<font color=\'" + Style.FONT_White + "\'>" + param1[_loc_3].name + "</font> <font color=\'" + Style.FONT_Green + "\'>" + Config.language("GildWarAuction", 6) + "</font>";
                    }
                    _loc_4 = new PushButton(this.bgpanelArr[_loc_3], 363, 65, Config.language("GildWarAuction", 7), Config.create(this.clickautoaddprice, param1[_loc_3].id));
                    _loc_4.width = 35;
                    _loc_5 = new PushButton(this.bgpanelArr[_loc_3], 402, 65, Config.language("GildWarAuction", 8), Config.create(this.clickmanualaddprice, param1[_loc_3].id));
                    _loc_5.width = 35;
                }
                if (param1[_loc_3].id == 5)
                {
                    this.npcName = new ClickLabel(this.bgpanelArr[_loc_3], 375, 8, Config.language("GildWarAuction", 9), Config.create(this.autofindroad, 60001), true);
                    this.npcName.clickColor([16252004, 16252004]);
                    this.texTime.text = Config.language("GildWarAuction", 10);
                }
                else if (param1[_loc_3].id == 8)
                {
                    this.npcName = new ClickLabel(this.bgpanelArr[_loc_3], 375, 8, Config.language("GildWarAuction", 11), Config.create(this.autofindroad, 60002), true);
                    this.npcName.clickColor([16252004, 16252004]);
                    this.texTime.text = Config.language("GildWarAuction", 12);
                }
                if (param1[_loc_3].gildname == null || param1[_loc_3].gildname == "")
                {
                    this.textOccupy.text = Config.language("GildWarAuction", 13);
                }
                else
                {
                    this.textOccupy.text = param1[_loc_3].gildname;
                }
                if (param1[_loc_3].auctiongildname == null || param1[_loc_3].auctiongildname == "")
                {
                    this.textAuction.text = Config.language("GildWarAuction", 13);
                }
                else
                {
                    this.textAuction.text = param1[_loc_3].auctiongildname;
                }
                this.textPirce.text = param1[_loc_3].auctionprice;
                if (param1[_loc_3].ifauciton == 0)
                {
                    this.textMade.text = Config.language("GildWarAuction", 14);
                    this.textMade.textColor = 11344686;
                }
                this.textArrauc.push({auctionT:this.textAuction});
                this.textArrpir.push({pirceT:this.textPirce});
                this.bgpanelArr[_loc_3].y = _loc_3 * 100;
                _loc_3++;
            }
            _loc_2.reFresh();
            return;
        }// end function

        private function autofindroad(event:TextEvent, param2)
        {
            Hang.hangNpc(param2);
            return;
        }// end function

        public function updatelist(param1:Object)
        {
            var _loc_2:* = 0;
            if (this._opening)
            {
                _loc_2 = 0;
                while (_loc_2 < this.listArr.length)
                {
                    
                    if (param1.id == this.listArr[_loc_2].id)
                    {
                        this.textArrauc[_loc_2].auctionT.text = param1.auctiongildname;
                        this.textArrpir[_loc_2].pirceT.text = param1.auctionprice;
                        this.listArr[_loc_2].auctionprice = param1.auctionprice;
                    }
                    _loc_2 = _loc_2 + 1;
                }
            }
            return;
        }// end function

        private function addcontainer()
        {
            var _loc_2:* = null;
            var _loc_1:* = new Sprite();
            _loc_1.graphics.lineStyle(1, 7689037);
            _loc_1.graphics.drawRect(0, 0, 520, 90);
            _loc_1.graphics.beginFill(7689037);
            _loc_1.graphics.drawRoundRect(0, 0, 520, 30, 0);
            _loc_1.graphics.beginFill(16777215, 0.4);
            _loc_1.graphics.drawRoundRect(0, 30, 520, 60, 0);
            _loc_1.graphics.endFill();
            _loc_1.graphics.lineStyle(1, 0);
            _loc_1.graphics.moveTo(5, 60);
            _loc_1.graphics.lineTo(515, 60);
            _loc_1.graphics.moveTo(110, 32);
            _loc_1.graphics.lineTo(110, 88);
            _loc_1.graphics.moveTo(207, 32);
            _loc_1.graphics.lineTo(207, 88);
            _loc_1.graphics.moveTo(283, 32);
            _loc_1.graphics.lineTo(283, 88);
            _loc_1.graphics.moveTo(350, 32);
            _loc_1.graphics.lineTo(350, 88);
            this.textName = Config.getSimpleTextField();
            this.texTime = Config.getSimpleTextField();
            this.textOccupy = Config.getSimpleTextField();
            this.textAuction = Config.getSimpleTextField();
            this.textPirce = Config.getSimpleTextField();
            this.textMade = Config.getSimpleTextField();
            this.textName.x = 5;
            this.texTime.x = 0;
            this.textOccupy.x = 110;
            this.textAuction.x = 207;
            this.textPirce.x = 283;
            this.textMade.x = 350;
            this.textName.y = 8;
            this.texTime.y = 68;
            this.textOccupy.y = 68;
            this.textAuction.y = 68;
            this.textPirce.y = 68;
            this.textMade.y = 68;
            this.textName.width = 320;
            this.texTime.width = 110;
            this.textOccupy.width = 97;
            this.textAuction.width = 76;
            this.textPirce.width = 67;
            this.textMade.width = 176;
            this.texTime.autoSize = TextFieldAutoSize.CENTER;
            this.textOccupy.autoSize = TextFieldAutoSize.CENTER;
            this.textAuction.autoSize = TextFieldAutoSize.CENTER;
            this.textPirce.autoSize = TextFieldAutoSize.CENTER;
            this.textMade.autoSize = TextFieldAutoSize.CENTER;
            _loc_1.addChild(this.textName);
            _loc_1.addChild(this.texTime);
            _loc_1.addChild(this.textOccupy);
            _loc_1.addChild(this.textAuction);
            _loc_1.addChild(this.textPirce);
            _loc_1.addChild(this.textMade);
            _loc_2 = new Label(_loc_1, 30, 38, Config.language("GildWarAuction", 15));
            _loc_2 = new Label(_loc_1, 135, 38, Config.language("GildWarAuction", 16));
            _loc_2 = new Label(_loc_1, 222, 38, Config.language("GildWarAuction", 17));
            _loc_2 = new Label(_loc_1, 293, 38, Config.language("GildWarAuction", 18));
            _loc_2 = new Label(_loc_1, 410, 38, Config.language("GildWarAuction", 19));
            _loc_2 = new Label(_loc_1, 335, 8, Config.language("GildWarAuction", 20));
            _loc_2.html = true;
            _loc_2.tf.textColor = 16777215;
            this.bgpanelArr.push(_loc_1);
            return;
        }// end function

        private function getauctprice(param1)
        {
            var _loc_2:* = 0;
            while (_loc_2 < this.listArr.length)
            {
                
                if (this.listArr[_loc_2].id == param1)
                {
                    this.auctprice = this.listArr[_loc_2].auctionprice;
                }
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        private function clickautoaddprice(event:MouseEvent, param2) : void
        {
            var _loc_3:* = null;
            if (Config.ui._gangs.mytype == 1 || Config.ui._gangs.mytype == 2)
            {
                this.getauctprice(param2);
                if (int(this.auctprice * 1.1) <= 2000000000)
                {
                    _loc_3 = new DataSet();
                    _loc_3.addHead(CONST_ENUM.C2G_BEACHHEAD_AUCTION_BUY);
                    _loc_3.add32(param2);
                    _loc_3.add32(int(this.auctprice * 1.1));
                    ClientSocket.send(_loc_3);
                }
                else
                {
                    Config.message(Config.language("GildWarAuction", 21));
                }
            }
            else
            {
                Config.message(Config.language("GildWarAuction", 22));
            }
            return;
        }// end function

        private function clickmanualaddprice(event:MouseEvent, param2) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            if (Config.ui._gangs.mytype == 1 || Config.ui._gangs.mytype == 2)
            {
                if (this.putpricepanel != null)
                {
                    this.putpricepanel.close();
                }
                this.getauctprice(param2);
                this.putpricepanel = new Window(this.container, this.x + 280, this.y + 50);
                this.addChild(this.putpricepanel);
                this.putpricepanel.title = Config.language("GildWarAuction", 23);
                this.putpricepanel.resize(205, 135);
                _loc_3 = new Label(this.putpricepanel, 10, 30);
                _loc_3.text = Config.language("GildWarAuction", 24) + Config.coinShow(this.auctprice) + "\n\n" + Config.language("GildWarAuction", 25);
                this._priceput = new InputText(this.putpricepanel, 50, 60, "", Config.create(this.inputAmount, this.auctprice));
                this._priceput.setSize(80, 20);
                this._priceput.restrict = "0-9";
                _loc_4 = new PushButton(this.putpricepanel, 25, 100, Config.language("GildWarAuction", 26), Config.create(this.confirmprice, this.auctprice, param2));
                _loc_5 = new PushButton(this.putpricepanel, 110, 100, Config.language("GildWarAuction", 27), this.conselprice);
                _loc_4.width = 60;
                _loc_5.width = 60;
                this.putpricepanel.open();
            }
            else
            {
                Config.message(Config.language("GildWarAuction", 28));
            }
            return;
        }// end function

        private function backauctiongild(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readByte();
            if (_loc_3 == 0)
            {
                Config.message(Config.language("GildWarAuction", 29));
            }
            else if (_loc_3 == 1)
            {
                Config.message(Config.language("GildWarAuction", 30));
            }
            else if (_loc_3 == 2)
            {
                Config.message(Config.language("GildWarAuction", 31));
            }
            else if (_loc_3 == 3)
            {
                Config.message(Config.language("GildWarAuction", 32));
            }
            else if (_loc_3 == 4)
            {
                Config.message(Config.language("GildWarAuction", 33));
            }
            else if (_loc_3 == 5)
            {
                Config.message(Config.language("GildWarAuction", 34));
            }
            else if (_loc_3 == 6)
            {
                Config.message(Config.language("GildWarAuction", 35));
            }
            else if (_loc_3 == 7)
            {
                Config.message(Config.language("GildWarAuction", 36));
            }
            else if (_loc_3 == 8)
            {
                Config.message(Config.language("GildWarAuction", 37));
            }
            else if (_loc_3 == 9)
            {
                Config.message(Config.language("GildWarAuction", 38));
            }
            else if (_loc_3 == 10)
            {
                Config.message(Config.language("GildWarAuction", 39));
            }
            else
            {
                Config.message(Config.language("GildWarAuction", 40) + _loc_3);
            }
            return;
        }// end function

        private function inputAmount(param1, param2:uint)
        {
            if (parseInt(this._priceput.text) < 1 || this._priceput.text == null || this._priceput.text == "")
            {
                this._priceput.text = "1";
            }
            else if (parseInt(this._priceput.text) >= Config.ui._gangs.gild_money)
            {
                if (parseInt(this._priceput.text) > 2000000000 && Config.ui._gangs.gild_money > 2000000000)
                {
                    this._priceput.text = "" + 2000000000;
                }
                else
                {
                    this._priceput.text = "" + Config.ui._gangs.gild_money;
                }
            }
            else
            {
                this._priceput.text = parseInt(this._priceput.text).toString();
            }
            this._auctionewprice = int(parseInt(this._priceput.text));
            return;
        }// end function

        private function confirmprice(event:MouseEvent, param2, param3)
        {
            if (this.putpricepanel != null)
            {
                this.putpricepanel.close();
            }
            var _loc_4:* = new DataSet();
            new DataSet().addHead(CONST_ENUM.C2G_BEACHHEAD_AUCTION_BUY);
            _loc_4.add32(param3);
            _loc_4.add32(this._auctionewprice);
            ClientSocket.send(_loc_4);
            return;
        }// end function

        private function conselprice(event:MouseEvent)
        {
            this.putpricepanel.close();
            return;
        }// end function

        private function clearpanel() : void
        {
            while (this.panel.numChildren > 0)
            {
                
                this.panel.removeChildAt((this.panel.numChildren - 1));
            }
            return;
        }// end function

    }
}
