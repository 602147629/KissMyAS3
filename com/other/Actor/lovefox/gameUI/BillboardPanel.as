package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;
    import lovefox.component.*;
    import lovefox.socket.*;
    import lovefox.unit.*;

    public class BillboardPanel extends Window
    {
        private var panel:Sprite;
        private var pagelabel:TextField;
        private var gradetxt:Label;
        private var oweTypetxt:Label;
        private var famoustxt:Label;
        private var disdaintxt:Label;
        private var mygradetxt:Label;
        private var myoweMoneytxt:Label;
        private var myfamoustxt:Label;
        private var mydisdaintxt:Label;
        private var myfam:uint = 0;
        private var mydisd:uint = 0;
        private var scoreType:uint = 1;
        private var pageTotal:uint = 10;
        private var pagenum:int = 1;
        private var playArrlist:Array;
        private var billPlayerId:int = 0;
        private var colimnarr:Array;
        private var getSelfinfoArr:Array;
        private var bar:Sprite;
        private var manualbar:Sprite;
        private var arrSprbar:Array;
        private var arrSpr:Array;
        private var datalist:DataGridUI;
        private var _unitClip:UnitClip;
        private var _horseClip:UnitClip;
        private var _name:String;
        private var _nameTf:TextField;
        private var billBmp:Bitmap;
        private var lv:int = 0;
        private var addbtn:ButtonBar;
        private var billNamearr:Array;
        private var typelistmc:AccordionTree;

        public function BillboardPanel(param1:DisplayObjectContainer = null, param2:Number = 0, param3:Number = 0)
        {
            this.getSelfinfoArr = [];
            super(param1, param2, param3);
            resize(600, 380);
            this.initsocket();
            this.init();
            this.initpanel();
            return;
        }// end function

        private function initsocket() : void
        {
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_TOPLIST, this.getplayerlist);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_SETTOP, this.famousOrdisdain);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_PLRTOPINFO, this.getplayerinfo);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_GETTOPINFO, this.getselfinfo);
            return;
        }// end function

        override public function open(event:MouseEvent = null)
        {
            super.open();
            this.typeselect(1);
            this.typelistmc.verticalScrollPosition = 0;
            return;
        }// end function

        private function init() : void
        {
            this.panel = new Sprite();
            this.addChild(this.panel);
            this.title = Config.language("BillboardPanel", 1);
            this.typelistmc = new AccordionTree(this.panel, 10, 40, 110, 170);
            var _loc_1:* = <list>r
n	t	t	t	t	t	t	t<id>1</id>r
n	t	t	t	t	t	t	t<billtype type=""1"" label=""""/>r
n	t	t	t	t	t	t	t<billtype type=""2"" label=""""/>r
n	t	t	t	t	t	t	t<billtype type=""3"" label=""""/>r
n	t	t	t	t	t	t	t<billtype type=""4"" label=""""/>r
n	t	t	t	t	t	t	t<billtype type=""5"" label=""""/>r
n	t	t	t	t	t	t	t<billtype type=""6"" label=""""/>r
n	t	t	t	t	t	t	t<billtype type=""7"" label=""""/>r
n	t	t	t	t	t	t	t<billtype type=""8"" label=""""/>r
n	t	t	t	t	t	t	t<billtype type=""9"" label=""""/>r
n	t	t	t	t	t	t	t<billtype type=""10"" label=""""/>r
n	t	t	t	t	t	t	t<billtype type=""11"" label=""""/>r
n	t	t	t	t	t	t	t<billtype type=""12"" label=""""/>r
n	t	t	t	t	t	t	t<billtype type=""13"" label=""""/>r
n	t	t	t	t	t	t	t<billtype type=""14"" label=""""/>r
n	t	t	t	t	t	t</list>")("<list>
							<id>1</id>
							<billtype type="1" label=""/>
							<billtype type="2" label=""/>
							<billtype type="3" label=""/>
							<billtype type="4" label=""/>
							<billtype type="5" label=""/>
							<billtype type="6" label=""/>
							<billtype type="7" label=""/>
							<billtype type="8" label=""/>
							<billtype type="9" label=""/>
							<billtype type="10" label=""/>
							<billtype type="11" label=""/>
							<billtype type="12" label=""/>
							<billtype type="13" label=""/>
							<billtype type="14" label=""/>
						</list>;
            var _loc_2:* = _loc_1.children();
            var _loc_3:* = [Config.language("BillboardPanel", 40), Config.language("BillboardPanel", 41), Config.language("BillboardPanel", 42), Config.language("BillboardPanel", 43), Config.language("BillboardPanel", 44), Config.language("BillboardPanel", 45), Config.language("BillboardPanel", 46), Config.language("BillboardPanel", 47), Config.language("BillboardPanel", 48), Config.language("BillboardPanel", 49), Config.language("BillboardPanel", 55), Config.language("BillboardPanel", 56), Config.language("BillboardPanel", 57), "鲜花排行"];
            var _loc_4:* = 0;
            while (_loc_4 < (_loc_2.length() - 1))
            {
                
                _loc_1.billtype[_loc_4].attributes()[1] = _loc_3[_loc_4];
                _loc_4++;
            }
            this.typelistmc.dataProvider = _loc_1;
            this.typelistmc.addEventListener(AccTreeEvent.TREE_SELECT, this.typeselectBtn);
            return;
        }// end function

        private function initpanel()
        {
            var _loc_2:* = null;
            var _loc_1:* = new Shape();
            _loc_1.graphics.beginFill(12095576, 0.5);
            _loc_1.graphics.drawRoundRect(400, 50, 196, 325, 5);
            _loc_1.graphics.endFill();
            _loc_1.graphics.lineStyle(2, 7689037);
            _loc_1.graphics.moveTo(5, 230);
            _loc_1.graphics.lineTo(130, 230);
            _loc_1.graphics.moveTo(130, 22);
            _loc_1.graphics.lineTo(130, 376);
            _loc_1.graphics.lineStyle(1, 7689037);
            _loc_1.graphics.moveTo(400, 50);
            _loc_1.graphics.lineTo(400, 375);
            _loc_1.graphics.moveTo(408, 293);
            _loc_1.graphics.lineTo(590, 293);
            _loc_1.graphics.lineStyle(1, 12281894);
            _loc_1.graphics.moveTo(135, 49);
            _loc_1.graphics.lineTo(595, 49);
            this.panel.addChild(_loc_1);
            _loc_2 = new Label(this.panel, 10, 235);
            _loc_2.html = true;
            _loc_2.text = "<b><font SIZE=\'14\'>" + Config.language("BillboardPanel", 2) + "</font></b>";
            _loc_2 = new Label(this.panel, 10, 260);
            _loc_2.html = true;
            _loc_2.text = Config.language("BillboardPanel", 3);
            var _loc_3:* = new PushButton(this.panel, 180, 340, "<<", Config.create(this.changepage, 1));
            _loc_3.width = 30;
            var _loc_4:* = new PushButton(this.panel, 215, 340, "<", Config.create(this.changepage, 2));
            new PushButton(this.panel, 215, 340, "<", Config.create(this.changepage, 2)).width = 30;
            var _loc_5:* = new PushButton(this.panel, 287, 340, ">", Config.create(this.changepage, 3));
            new PushButton(this.panel, 287, 340, ">", Config.create(this.changepage, 3)).width = 30;
            var _loc_6:* = new PushButton(this.panel, 322, 340, ">>", Config.create(this.changepage, 4));
            new PushButton(this.panel, 322, 340, ">>", Config.create(this.changepage, 4)).width = 30;
            this.pagelabel = Config.getSimpleTextField();
            this.pagelabel.defaultTextFormat = new TextFormat(null, 16, Style.WINDOW_FONT, true);
            this.pagelabel.x = 245;
            this.pagelabel.y = 340;
            this.pagelabel.width = 42;
            this.pagelabel.autoSize = TextFieldAutoSize.CENTER;
            this.panel.addChild(this.pagelabel);
            var _loc_7:* = new PushButton(this.panel, 550, 240, Config.language("BillboardPanel", 8), Config.create(this.famous, 0));
            new PushButton(this.panel, 550, 240, Config.language("BillboardPanel", 8), Config.create(this.famous, 0)).width = 40;
            var _loc_8:* = new PushButton(this.panel, 550, 265, Config.language("BillboardPanel", 9), Config.create(this.famous, 1));
            new PushButton(this.panel, 550, 265, Config.language("BillboardPanel", 9), Config.create(this.famous, 1)).width = 40;
            this.gradetxt = new Label(this.panel, 410, 202);
            this.gradetxt.html = true;
            this.oweTypetxt = new Label(this.panel, 410, 220);
            this.oweTypetxt.html = true;
            this.famoustxt = new Label(this.panel, 410, 242);
            this.disdaintxt = new Label(this.panel, 410, 267);
            this.disdaintxt.html = true;
            this.mygradetxt = new Label(this.panel, 410, 297);
            this.mygradetxt.html = true;
            this.myoweMoneytxt = new Label(this.panel, 410, 315);
            this.myoweMoneytxt.html = true;
            this.myfamoustxt = new Label(this.panel, 410, 333);
            this.mydisdaintxt = new Label(this.panel, 410, 351);
            this.mydisdaintxt.html = true;
            this._nameTf = Config.getSimpleTextField();
            this._nameTf.textColor = Style.WINDOW_FONT;
            this._nameTf.y = 55;
            this.addbtn = new ButtonBar(this.panel, 145, 28, 260);
            this.addbtn.visible = false;
            this.addbtn.addTab(Config.language("BillboardPanel", 51), this.queckrace);
            this.addbtn.addTab(Config.language("BillboardPanel", 52), this.queckrace);
            this.addbtn.addTab(Config.language("BillboardPanel", 53), this.queckrace);
            this.addbtn.addTab(Config.language("BillboardPanel", 54), this.queckrace);
            this.addbtn.addTab(Config.language("BillboardPanel", 59), this.queckrace);
            this.addbtn.selectpage = 0;
            return;
        }// end function

        public function opentype(param1:uint)
        {
            super.open();
            if (param1 == 11)
            {
                this.addselect();
            }
            if (param1 <= 7)
            {
                this.typelistmc.verticalScrollPosition = 0;
            }
            else
            {
                this.typelistmc.verticalScrollPosition = 100;
            }
            this.typeselect(param1);
            return;
        }// end function

        private function addselect()
        {
            this.lv = int(Config.player.level / 10) - 4;
            if (this.lv < 0)
            {
                this.lv = 0;
            }
            else if (this.lv > 3)
            {
                this.lv = 3;
            }
            return;
        }// end function

        private function typeselectBtn(event:AccTreeEvent) : void
        {
            this.typeselect(int(event.typeobj.type));
            return;
        }// end function

        private function typeselect(param1:uint = 1) : void
        {
            var _loc_5:* = 0;
            if (this.datalist != null)
            {
                this.panel.removeChild(this.datalist);
            }
            this.colimnarr = new Array();
            this.colimnarr = [{datafield:"grade", label:Config.language("BillboardPanel", 10), len:48, childmc:"grade"}, {datafield:"manualbar", label:Config.language("BillboardPanel", 11), len:100, childmc:"manualbar"}, {datafield:"score", label:"", len:112}];
            this.billNamearr = [Config.language("BillboardPanel", 12), Config.language("BillboardPanel", 13), Config.language("BillboardPanel", 14), Config.language("BillboardPanel", 15), Config.language("BillboardPanel", 16), Config.language("BillboardPanel", 17), Config.language("BillboardPanel", 18), Config.language("BillboardPanel", 19), Config.language("BillboardPanel", 20), Config.language("BillboardPanel", 21), Config.language("BillboardPanel", 50), Config.language("BillboardPanel", 56), Config.language("BillboardPanel", 58), "鲜花数量"];
            this.colimnarr[2].label = this.billNamearr[(param1 - 1)];
            this.addbtn.visible = false;
            if (param1 == 11)
            {
                this.addbtn.visible = true;
                this.addselect();
                this.addbtn.selectpage = this.lv;
            }
            this.scoreType = param1;
            var _loc_2:* = param1 - 1;
            this.datalist = new DataGridUI(this.colimnarr, this.panel, 135, 55, 260, 280);
            var _loc_3:* = "";
            var _loc_4:* = "";
            if (this.scoreType == 12 || this.scoreType == 13)
            {
                _loc_5 = 0;
                while (_loc_5 < this.getSelfinfoArr.length)
                {
                    
                    if (this.scoreType == 13 && this.getSelfinfoArr[_loc_5].typ == 51)
                    {
                        _loc_2 = _loc_5;
                        break;
                    }
                    else if (this.scoreType == 12 && this.getSelfinfoArr[_loc_5].typ == 13)
                    {
                        _loc_2 = _loc_5;
                        break;
                    }
                    _loc_5 = _loc_5 + 1;
                }
            }
            if (this.getSelfinfoArr[_loc_2].order > 0)
            {
                _loc_3 = Config.language("BillboardPanel", 22, String(this.getSelfinfoArr[_loc_2].order));
            }
            else
            {
                _loc_3 = Config.language("BillboardPanel", 23);
            }
            if (this.scoreType == 3)
            {
                _loc_4 = Config.coinShow(this.getSelfinfoArr[_loc_2].score);
            }
            else
            {
                _loc_4 = this.getSelfinfoArr[_loc_2].score;
            }
            this.mygradetxt.text = Config.language("BillboardPanel", 24) + "<font color=\'" + Style.FONT_Red + "\'>" + _loc_3 + "</font>";
            this.myoweMoneytxt.text = Config.language("BillboardPanel", 25, this.colimnarr[2].label) + ": " + "<font color=\'" + Style.FONT_Red + "\'>" + _loc_4 + "</font>";
            this.myfamoustxt.text = Config.language("BillboardPanel", 26) + this.myfam;
            this.mydisdaintxt.text = Config.language("BillboardPanel", 27) + "<font color=\'" + Style.FONT_Red + "\'>" + this.mydisd + "</font>";
            this.sendlist(this.scoreType, 1);
            return;
        }// end function

        private function sendlist(param1:int, param2:int)
        {
            if (param1 == 11)
            {
                param1 = 41 + this.lv;
            }
            else if (param1 == 12)
            {
                param1 = 13;
            }
            else if (param1 == 13)
            {
                param1 = 51;
            }
            var _loc_3:* = new DataSet();
            _loc_3.addHead(CONST_ENUM.C2G_TOPLIST);
            _loc_3.add32(param1);
            _loc_3.add32(param2);
            ClientSocket.send(_loc_3);
            return;
        }// end function

        private function famous(event:MouseEvent, param2)
        {
            if (this.billPlayerId == Config.player._id)
            {
                Config.message(Config.language("BillboardPanel", 28));
                return;
            }
            var _loc_3:* = new DataSet();
            _loc_3.addHead(CONST_ENUM.C2G_SETTOP);
            _loc_3.add32(this.billPlayerId);
            _loc_3.add8(param2);
            ClientSocket.send(_loc_3);
            return;
        }// end function

        private function famousOrdisdain(event:SocketEvent)
        {
            var _loc_6:* = 0;
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            var _loc_4:* = _loc_2.readByte();
            var _loc_5:* = _loc_2.readByte();
            if (_loc_2.readByte() == 0)
            {
                _loc_6 = _loc_2.readUnsignedInt();
                if (_loc_4 == 0)
                {
                    this.famoustxt.text = Config.language("BillboardPanel", 29) + _loc_6;
                }
                else if (_loc_4 == 1)
                {
                    this.disdaintxt.text = Config.language("BillboardPanel", 30) + "<font color=\'" + Style.FONT_Red + "\'>" + _loc_6 + "</font>";
                }
            }
            else
            {
                Config.message(Config.language("BillboardPanel", 31));
            }
            return;
        }// end function

        private function getplayerlist(event:SocketEvent)
        {
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_10:* = undefined;
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            this.pagenum = _loc_2.readUnsignedInt();
            var _loc_4:* = _loc_2.readUnsignedInt();
            if (this.arrSpr != null)
            {
                _loc_6 = 0;
                while (_loc_6 < this.arrSpr.length)
                {
                    
                    this.removeallchild(this.arrSpr[_loc_6]);
                    this.removeallchild(this.arrSprbar[_loc_6]);
                    this.arrSpr[_loc_6].parent.removeChild(this.arrSpr[_loc_6]);
                    this.arrSprbar[_loc_6].parent.removeChild(this.arrSprbar[_loc_6]);
                    _loc_6++;
                }
            }
            this.arrSprbar = [];
            this.arrSpr = [];
            this.playArrlist = [];
            _loc_5 = 0;
            while (_loc_5 < _loc_4)
            {
                
                this.bar = new Sprite();
                this.arrSprbar.push(this.bar);
                this.panel.addChild(this.bar);
                this.manualbar = new Sprite();
                this.arrSpr.push(this.manualbar);
                this.panel.addChild(this.manualbar);
                _loc_5++;
            }
            _loc_5 = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_7 = new Object();
                _loc_7.gra = _loc_2.readUnsignedInt();
                if (_loc_7.gra == 1)
                {
                    this.billBmp = new Bitmap();
                    this.billBmp.bitmapData = Config.findIcon("misc/star3");
                    this.arrSprbar[_loc_5].addChild(this.billBmp);
                    this.billBmp.x = -5;
                    this.billBmp.y = -6;
                }
                else if (_loc_7.gra == 2 || _loc_7.gra == 3)
                {
                    this.billBmp = new Bitmap();
                    this.billBmp.bitmapData = Config.findIcon("misc/star2");
                    this.arrSprbar[_loc_5].addChild(this.billBmp);
                    this.billBmp.x = -5;
                    this.billBmp.y = -6;
                }
                new Label(this.arrSprbar[_loc_5], 20, 0, String(_loc_7.gra));
                _loc_7.grade = this.arrSprbar[_loc_5];
                _loc_7.playerId = _loc_2.readUnsignedInt();
                _loc_8 = _loc_2.readUnsignedShort();
                _loc_7.name = _loc_2.readUTFBytes(_loc_8);
                this.panel.addChild(this.manualbar);
                _loc_9 = new ClickLabel(this.arrSpr[_loc_5], 26, 2, _loc_7.name, Config.create(this.nameclick, _loc_7.name, _loc_7.playerId), true);
                _loc_9.clickColor([26367, 6837142]);
                _loc_9.x = (100 - _loc_9.width) / 2;
                _loc_7.manualbar = this.arrSpr[_loc_5];
                _loc_10 = _loc_2.readUnsignedInt();
                if (_loc_3 >= 41 && _loc_3 <= 45)
                {
                    _loc_10 = Config.timeShow(_loc_10);
                }
                _loc_7.score = _loc_10;
                this.playArrlist.push(_loc_7);
                _loc_5++;
            }
            this.pageTotal = _loc_2.readUnsignedInt();
            if (this.pagenum > this.pageTotal)
            {
                this.pagenum = this.pageTotal;
            }
            this.datalist.dataProvider = this.playArrlist;
            this.datalist.addEventListener(DataGridEvent.ROW_SELECT, this.selectfrow);
            this.pagelabel.text = this.pagenum + "/" + this.pageTotal;
            if (this.playArrlist.length > 0)
            {
                this._name = this.playArrlist[0].name;
                this.selectfrow(null, this.playArrlist[0].playerId, this.playArrlist[0].score);
            }
            return;
        }// end function

        private function nameclick(event:TextEvent, param2, param3:int)
        {
            var _loc_4:* = null;
            if (Config._switchMobage)
            {
                _loc_4 = [Config.language("BillboardPanel", 60), Config.language("BillboardPanel", 32), Config.language("BillboardPanel", 34), Config.language("BillboardPanel", 35), Config.language("BillboardPanel", 36)];
            }
            else
            {
                _loc_4 = [Config.language("BillboardPanel", 60), Config.language("BillboardPanel", 32), Config.language("BillboardPanel", 33), Config.language("BillboardPanel", 34), Config.language("BillboardPanel", 35), Config.language("BillboardPanel", 36), Config.language("BillboardPanel", 37)];
            }
            DropDown.dropDown(_loc_4, Config.create(this.childmune, param2, param3));
            return;
        }// end function

        private function childmune(param1:int, param2:String, param3)
        {
            if (Config._switchMobage)
            {
                if (param1 > 0)
                {
                    param1++;
                }
            }
            switch(param1)
            {
                case 0:
                {
                    if (Config.ui._giveflower.todaysendnum < 5)
                    {
                        Config.ui._giveflower.open();
                        Config.ui._giveflower.flowerplayerid = param3;
                        Config.ui._giveflower.flowerplayername = param2;
                    }
                    else
                    {
                        Config.message(Config.language("BillboardPanel", 61));
                    }
                    break;
                }
                case 1:
                {
                    Config.ui._teamUI.inviteTeam(param3);
                    break;
                }
                case 2:
                {
                    Config.ui._chatUI.whisperTo(param2);
                    break;
                }
                case 3:
                {
                    Config.ui._mailpanel.sendmailshow(null, param2);
                    Config.ui._mailpanel.open();
                    break;
                }
                case 4:
                {
                    Config.ui._friendUI.addFriend(param2);
                    break;
                }
                case 5:
                {
                    Config.ui._friendUI.sendAddEnemy(param2);
                    break;
                }
                case 6:
                {
                    Config.ui._friendUI.sendaddblack(null, param2);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function getselfinfo(event:SocketEvent)
        {
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedShort();
            if (_loc_3 > 1)
            {
                this.getSelfinfoArr = [];
            }
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = new Object();
                _loc_6 = _loc_2.readByte();
                _loc_5.typ = _loc_6;
                _loc_5.order = _loc_2.readUnsignedInt();
                _loc_5.score = _loc_2.readUnsignedInt();
                trace(_loc_6, _loc_5.order, _loc_5.score);
                if (_loc_6 == 51)
                {
                    Config.ui._interPkPanel.pkBill = _loc_5.order;
                }
                if (_loc_3 == 1)
                {
                    _loc_7 = 0;
                    while (_loc_7 < this.getSelfinfoArr.length)
                    {
                        
                        if (this.getSelfinfoArr[_loc_7].typ == _loc_5.typ)
                        {
                            this.getSelfinfoArr[_loc_7] = _loc_5;
                            break;
                        }
                        _loc_7 = _loc_7 + 1;
                    }
                }
                else
                {
                    this.getSelfinfoArr.push(_loc_5);
                }
                _loc_4 = _loc_4 + 1;
            }
            this.myfam = _loc_2.readUnsignedInt();
            this.mydisd = _loc_2.readUnsignedInt();
            trace(this.getSelfinfoArr.length, "getSelfinfoArr++++++");
            return;
        }// end function

        private function selectfrow(event:DataGridEvent = null, param2:int = 0, param3:int = 0)
        {
            var _loc_5:* = 0;
            var _loc_6:* = undefined;
            var _loc_8:* = undefined;
            var _loc_4:* = 1;
            var _loc_7:* = new DataSet();
            new DataSet().addHead(CONST_ENUM.C2G_PLRTOPINFO);
            if (event != null)
            {
                this._name = event.rowobj.name;
                _loc_7.add32(event.rowobj.playerId);
                _loc_5 = event.rowobj.playerId;
                _loc_6 = event.rowobj.score;
            }
            else
            {
                _loc_7.add32(param2);
                _loc_6 = param3;
                _loc_5 = param2;
            }
            for (_loc_8 in this.playArrlist)
            {
                
                if (_loc_5 == this.playArrlist[_loc_8].playerId)
                {
                    _loc_4 = this.playArrlist[_loc_8].gra;
                }
            }
            ClientSocket.send(_loc_7);
            this.gradetxt.text = Config.language("BillboardPanel", 38, Style.FONT_Red, _loc_4);
            if (this.scoreType == 3)
            {
                _loc_6 = Config.coinShow(_loc_6);
            }
            this.oweTypetxt.text = this.colimnarr[2].label + ": <font color=\'" + Style.FONT_Red + "\'>" + _loc_6 + "</font>";
            return;
        }// end function

        private function getplayerinfo(event:SocketEvent)
        {
            var _loc_12:* = undefined;
            var _loc_13:* = undefined;
            var _loc_14:* = undefined;
            var _loc_15:* = null;
            var _loc_16:* = undefined;
            var _loc_17:* = undefined;
            var _loc_18:* = undefined;
            var _loc_19:* = undefined;
            var _loc_20:* = undefined;
            var _loc_21:* = undefined;
            var _loc_22:* = undefined;
            var _loc_23:* = undefined;
            var _loc_24:* = undefined;
            var _loc_25:* = undefined;
            var _loc_26:* = undefined;
            var _loc_29:* = undefined;
            var _loc_2:* = event.data;
            this.billPlayerId = _loc_2.readUnsignedInt();
            var _loc_3:* = _loc_2.readByte();
            var _loc_4:* = _loc_2.readByte();
            var _loc_5:* = _loc_2.readUnsignedInt();
            var _loc_6:* = _loc_2.readUnsignedShort();
            var _loc_7:* = _loc_2.readByte();
            trace(this.billPlayerId, _loc_3, _loc_4, _loc_5, _loc_6, _loc_7);
            var _loc_8:* = _loc_2.readUnsignedInt();
            var _loc_9:* = _loc_2.readUnsignedInt();
            var _loc_10:* = _loc_2.readUnsignedShort();
            this._nameTf.htmlText = "<font size=\'14\'><b>" + this._name + "</b></font>" + "[" + Config.language("BillboardPanel", 39, _loc_6, Config._jobTitleMap[_loc_4]) + "]";
            if (this._unitClip != null)
            {
                this._unitClip.destroy();
                this.panel.removeChild(this._unitClip);
                this._unitClip = null;
            }
            if (this._horseClip != null)
            {
                this._horseClip.destroy();
                this.panel.removeChild(this._horseClip);
                this._horseClip = null;
            }
            var _loc_11:* = Config._charactorMap[(_loc_3 - 1) * 12 + _loc_4];
            this._unitClip = UnitClip.newUnitClip(Config._model[Number(_loc_11.model)]);
            this._unitClip.multiLayer = true;
            this._unitClip.layerStack = _loc_11.id;
            if (_loc_5 != 0)
            {
                if (_loc_4 == 1)
                {
                    if (_loc_3 == 1)
                    {
                        _loc_12 = Config._model[Number(Config._hairMap[_loc_5].fightMale)];
                    }
                    else
                    {
                        _loc_12 = Config._model[Number(Config._hairMap[_loc_5].fightFemale)];
                    }
                }
                else if (_loc_4 == 4)
                {
                    if (_loc_3 == 1)
                    {
                        _loc_12 = Config._model[Number(Config._hairMap[_loc_5].rangerMale)];
                    }
                    else
                    {
                        _loc_12 = Config._model[Number(Config._hairMap[_loc_5].rangerFemale)];
                    }
                }
                else if (_loc_4 == 10)
                {
                    if (_loc_3 == 1)
                    {
                        _loc_12 = Config._model[Number(Config._hairMap[_loc_5].magicMale)];
                    }
                    else
                    {
                        _loc_12 = Config._model[Number(Config._hairMap[_loc_5].magicFemale)];
                    }
                }
                this._unitClip.hair = _loc_12;
            }
            this._unitClip.x = 495;
            this._unitClip.y = 160;
            this._unitClip.changeDirectionTo(1);
            this._unitClip.changeStateTo("idle");
            this.panel.addChild(this._unitClip);
            var _loc_27:* = false;
            var _loc_28:* = 0;
            while (_loc_28 < _loc_10)
            {
                
                _loc_13 = _loc_2.readUnsignedInt();
                _loc_14 = _loc_2.readUnsignedShort();
                _loc_15 = Item.createItemByBytes(_loc_2, _loc_13);
                trace(_loc_14, _loc_15._data.name);
                _loc_17 = _loc_15._data.id;
                if (_loc_14 == 1001)
                {
                    _loc_16 = Config._itemMap[_loc_17];
                    if (_loc_3 == 1)
                    {
                        _loc_18 = Config._model[Number(_loc_16.mModel)];
                    }
                    else
                    {
                        _loc_18 = Config._model[Number(_loc_16.fModel)];
                    }
                    if (this._unitClip != null)
                    {
                        this._unitClip.weapon = _loc_18;
                    }
                }
                else if (_loc_14 == 1011 && _loc_7 == 0)
                {
                    _loc_27 = true;
                    _loc_16 = Config._itemMap[_loc_17];
                    if (_loc_3 == 1)
                    {
                        _loc_19 = String(_loc_16.mModel);
                    }
                    else
                    {
                        _loc_19 = String(_loc_16.fModel);
                    }
                    if (_loc_19.indexOf(":") == -1)
                    {
                        _loc_18 = Config._model[Number(_loc_19)];
                    }
                    else
                    {
                        _loc_20 = _loc_19.split(":");
                        if (_loc_4 == 1)
                        {
                            _loc_18 = Config._model[Number(_loc_20[0])];
                        }
                        else if (_loc_4 == 4)
                        {
                            _loc_18 = Config._model[Number(_loc_20[1])];
                        }
                        else if (_loc_4 == 10)
                        {
                            _loc_18 = Config._model[Number(_loc_20[2])];
                        }
                    }
                    this._unitClip.cloth = _loc_18;
                }
                else if (_loc_14 == 1012)
                {
                    _loc_16 = Config._itemMap[_loc_17];
                    if (_loc_3 == 1)
                    {
                        _loc_19 = String(_loc_16.mModel);
                    }
                    else
                    {
                        _loc_19 = String(_loc_16.fModel);
                    }
                    if (_loc_19.indexOf("|") == -1)
                    {
                        _loc_18 = Config._model[Number(_loc_19)];
                    }
                    else
                    {
                        _loc_20 = _loc_19.split("|");
                        if (_loc_15.star < 10)
                        {
                            _loc_18 = Config._model[Number(_loc_20[0])];
                        }
                        else if (_loc_15.star < 20)
                        {
                            _loc_18 = Config._model[Number(_loc_20[1])];
                        }
                        else if (_loc_15.star < 30)
                        {
                            _loc_18 = Config._model[Number(_loc_20[2])];
                        }
                        else
                        {
                            _loc_18 = Config._model[Number(_loc_20[3])];
                        }
                    }
                    this._horseClip = UnitClip.newUnitClip(_loc_18);
                    this._horseClip.shadow = false;
                    this._horseClip.changeDirectionTo(1);
                    this._horseClip.changeStateTo("idle");
                    this._horseClip.x = 495;
                    this._horseClip.y = 160 + 28;
                    this.panel.addChild(this._horseClip);
                    this.panel.addChild(this._unitClip);
                }
                else if (_loc_14 == 1014)
                {
                    _loc_16 = Config._itemMap[_loc_17];
                    if (_loc_3 == 1)
                    {
                        _loc_19 = String(_loc_16.mModel);
                    }
                    else
                    {
                        _loc_19 = String(_loc_16.fModel);
                    }
                    if (_loc_19.indexOf("|") == -1)
                    {
                        _loc_23 = _loc_19;
                    }
                    else
                    {
                        _loc_20 = _loc_19.split("|");
                        if (_loc_15.star < 10)
                        {
                            _loc_23 = String(_loc_20[0]);
                        }
                        else if (_loc_15.star < 20)
                        {
                            _loc_23 = String(_loc_20[1]);
                        }
                        else if (_loc_15.star < 30)
                        {
                            _loc_23 = String(_loc_20[2]);
                        }
                        else
                        {
                            _loc_23 = String(_loc_20[3]);
                        }
                    }
                    if (_loc_23.indexOf(";") == -1)
                    {
                        _loc_24 = _loc_23;
                    }
                    else
                    {
                        _loc_25 = _loc_23.split(";");
                        if (_loc_4 == 1)
                        {
                            _loc_24 = String(_loc_25[0]);
                        }
                        else if (_loc_4 == 4)
                        {
                            _loc_24 = String(_loc_25[1]);
                        }
                        else if (_loc_4 == 10)
                        {
                            _loc_24 = String(_loc_25[2]);
                        }
                    }
                    _loc_26 = _loc_24.split(",");
                    _loc_21 = Config._model[Number(_loc_26[0])];
                    _loc_22 = Config._model[Number(_loc_26[1])];
                    this._unitClip.lWing = _loc_21;
                    this._unitClip.rWing = _loc_22;
                }
                _loc_15.destroy();
                _loc_28 = _loc_28 + 1;
            }
            if (!_loc_27)
            {
                _loc_29 = Config._charactorMap[_loc_4 + (_loc_3 - 1) * 12];
                this._unitClip.cloth = Config._model[Number(_loc_29.cloth)];
            }
            this.panel.addChild(this._nameTf);
            this._nameTf.x = 495 - int(this._nameTf.width / 2);
            if (this.playArrlist.length > 0)
            {
                this.famoustxt.text = Config.language("BillboardPanel", 29) + _loc_8;
                this.disdaintxt.text = Config.language("BillboardPanel", 30) + "<font color=\'" + Style.FONT_Red + "\'>" + _loc_9 + "</font>";
            }
            if (this.billPlayerId == Config.player._id)
            {
                this.myfamoustxt.text = Config.language("BillboardPanel", 26) + _loc_8;
                this.mydisdaintxt.text = Config.language("BillboardPanel", 27) + "<font color=\'" + Style.FONT_Red + "\'>" + _loc_9 + "</font>";
            }
            return;
        }// end function

        private function changepage(event:MouseEvent, param2:uint)
        {
            if (param2 == 1)
            {
                this.pagenum = 1;
            }
            else if (param2 == 2)
            {
                if (this.pagenum == 1)
                {
                    this.pagenum = 1;
                }
                else
                {
                    var _loc_3:* = this;
                    var _loc_4:* = this.pagenum - 1;
                    _loc_3.pagenum = _loc_4;
                }
            }
            else if (param2 == 3)
            {
                if (this.pagenum == this.pageTotal)
                {
                    this.pagenum = this.pageTotal;
                }
                else
                {
                    var _loc_3:* = this;
                    var _loc_4:* = this.pagenum + 1;
                    _loc_3.pagenum = _loc_4;
                }
            }
            else if (param2 == 4)
            {
                this.pagenum = this.pageTotal;
            }
            this.sendlist(this.scoreType, this.pagenum);
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

        private function queckrace(event:MouseEvent = null)
        {
            trace(this.addbtn.selectpage);
            this.scoreType = 41 + this.addbtn.selectpage;
            this.pagenum = 1;
            this.sendlist(this.scoreType, this.pagenum);
            return;
        }// end function

    }
}
