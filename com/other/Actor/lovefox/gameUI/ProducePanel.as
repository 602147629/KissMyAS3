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

    public class ProducePanel extends Window
    {
        private var mainpanel:Sprite;
        private var topbtn:ButtonBar;
        private var jobcombox:ComboBox;
        private var levelcombox:ComboBox;
        private var expbar:ProgressBar;
        private var explb:TextField;
        private var itemtree:AdvanceTreee;
        private var pdnum:NumericStepper;
        private var levelarr:Array;
        private var addexp:Label;
        private var needmoney:Label;
        private var addexpflag:int = 0;
        private var needmoneyflag:int = 0;
        private var needlevel:Label;
        private var ltext:Label;
        private var tomadename:Label;
        private var alabel:Label;
        private var blabel:Label;
        private var clabel:Label;
        private var dlabel:Label;
        private var elabel:Label;
        private var flabel:Label;
        private var hlabel:Label;
        private var ilabel:Label;
        private var searchLabel:ClickLabel;
        private var add1:ClickLabel;
        private var add2:ClickLabel;
        private var _slotArray:Array;
        private var madearr:Array;
        private var treesid:int = -1;
        private var learnarr:Array;
        private var pdobj:Object;
        private var levelexp:Array;
        private var levelexpdrag:Array;
        private var madebar:ProgressBar;
        private var loopnum:int = 100;
        private var looptime:int = 0;
        private var looptemp:int = 0;
        private var looptemp2:int = 0;
        private var loopflag:Boolean = false;
        private var madebtn:PushButton;
        private var rememberid:int = -1;
        private var _lianjinBtn:PagePushButton;
        private var consp:Sprite;
        private var pattrPanel:Window;
        private var pattrsp:Sprite;
        private var pattrid:uint;
        private var menubar:ButtonBar;
        private var washPanel:Window;
        private var wt1:Label;
        private var wt2:Label;
        private var wt3:CheckBox;
        private var wts2:Label;
        private var washarr:Array;
        private var wt4:Label;
        private var wt5:Label;
        private var wt6:Label;
        private var wt7:Label;
        private var washflag:int = 0;
        private var washmax:Object;
        private var overtext:Label;
        private var remobj:Object;
        private var smflag:Boolean = false;
        private var tvalue:int = 0;
        private var maxvalue:int = 0;
        private var s3:Label;
        private var s4:ClickLabel;
        private var pnumber:NumericStepper;
        private var timer:Timer;
        private var stopbtn:PushButton;
        private var _setstopflag:Boolean = false;
        private var btn:PushButton;

        public function ProducePanel(param1:DisplayObjectContainer)
        {
            this._slotArray = [];
            this.madearr = [];
            this.learnarr = [];
            this.washarr = [];
            this.washmax = {id:0, value:0};
            this.remobj = {};
            super(param1);
            this.initsocket();
            this.initpanel();
            this.initPattrPanel();
            this.initWashPanel();
            return;
        }// end function

        public function checkBarButtonVer()
        {
            if (this.topbtn != null)
            {
                if (Config.ver_zuoji)
                {
                    this.topbtn.tabarr[4].visible = true;
                }
                else
                {
                    this.topbtn.tabarr[4].visible = false;
                }
                if (Config.ver_chibang)
                {
                    this.topbtn.tabarr[5].visible = true;
                }
                else
                {
                    this.topbtn.tabarr[5].visible = false;
                }
            }
            return;
        }// end function

        override public function switchOpen() : void
        {
            super.switchOpen();
            if (this.parent != null)
            {
                switch(Config.player.job)
                {
                    case 1:
                    {
                        break;
                    }
                    case 4:
                    {
                        break;
                    }
                    case 10:
                    {
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                this.armmade(null, 1);
                if (this.rememberid != -1)
                {
                    this.stoploops();
                    if (this.remobj.hasOwnProperty("data"))
                    {
                        this.levelcombox.selectedItem = this.remobj;
                        this.reshowtree();
                    }
                    this.treesid = this.rememberid;
                    this.showformid(this.treesid);
                    this.itemtree.selectid(this.treesid);
                }
            }
            return;
        }// end function

        public function showItem(param1:int) : void
        {
            var _loc_2:* = null;
            this.topbtn.selectpage = int(Config._formula[param1].type);
            if (this.topbtn.selectpage == 0)
            {
                switch(int(Config._itemMap[int(Config._formula[param1].outmater)].reqJob))
                {
                    case 1:
                    {
                        this.jobcombox.selectedItem = this.jobcombox.itemArray[1];
                        break;
                    }
                    case 4:
                    {
                        this.jobcombox.selectedItem = this.jobcombox.itemArray[3];
                        break;
                    }
                    case 10:
                    {
                        this.jobcombox.selectedItem = this.jobcombox.itemArray[2];
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            if (this._slotArray[0].item != null)
            {
                _loc_2 = this._slotArray[0].item._drawer[this._slotArray[0].item._position];
                _loc_2.unlock();
                this.washflag = 0;
                this._slotArray[0].item = null;
            }
            this.armmade(null, this.topbtn.selectpage);
            this.levelcombox.selectedItem = this.levelcombox.itemArray[0];
            this.reshowtree();
            this.treesid = param1;
            this.rememberid = param1;
            this.itemtree.selectid(param1);
            this.showformid(param1);
            super.open();
            return;
        }// end function

        public function putBook(param1:InvSlot) : void
        {
            var _loc_2:* = null;
            this.showItem(param1.item._itemData.skillId);
            if (this._slotArray[6].item != null)
            {
                _loc_2 = this._slotArray[6].item._drawer[this._slotArray[6].item._position];
                _loc_2.unlock();
                _loc_2.item = null;
            }
            if (param1.item._itemData.addEffect.length > 0)
            {
                param1.lock();
                this._slotArray[6].item = param1.item;
            }
            return;
        }// end function

        override public function testGuide()
        {
            if (GuideUI.testId(23))
            {
                Config.startLoop(this.subGuide23);
            }
            return;
        }// end function

        private function subGuide23(param1)
        {
            Config.stopLoop(this.subGuide23);
            GuideUI.doId(23, this.itemtree._treearr[0]);
            return;
        }// end function

        private function initsocket() : void
        {
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.SMSG_PRODUCE_UPDATE, this.backproduce);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_PRODUCE_INFO, this.expinfo);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_IMPROVE_ITEM, this.backwashvalue);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_SPRODUCE, this.lnlist);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_SPRODUCE_ADD, this.plistadd);
            return;
        }// end function

        override public function close()
        {
            var _loc_1:* = null;
            this.itemlock(false);
            if (this._slotArray.length > 0)
            {
                if (this._slotArray[0].item != null)
                {
                    _loc_1 = this._slotArray[0].item._drawer[this._slotArray[0].item._position];
                    _loc_1.unlock();
                    Config.ui._charUI.addproductbitmap(this._slotArray[0].item._position);
                    this._slotArray[0].item = null;
                    this.washflag = 0;
                }
                if (this._slotArray[6].item != null)
                {
                    _loc_1 = this._slotArray[6].item._drawer[this._slotArray[6].item._position];
                    _loc_1.unlock();
                    this._slotArray[6].item = null;
                }
            }
            Config.ui._bagUI.cancelEnable();
            this.remobj = this.levelcombox.selectedItem;
            super.close();
            this.stoploops();
            this.removeallchild(this.mainpanel);
            if (this.washPanel.stage != null)
            {
                this.washPanel.close();
                this.timer.stop();
                this.timer.removeEventListener(TimerEvent.TIMER, this.allwash);
            }
            return;
        }// end function

        private function initpanel() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = null;
            super.resize(622, 380);
            this.x = 200;
            this.y = 100;
            this.title = Config.language("ProducePanel", 1);
            this.levelarr = [Config.language("ProducePanel", 2), Config.language("ProducePanel", 3), Config.language("ProducePanel", 4), Config.language("ProducePanel", 5), Config.language("ProducePanel", 6), Config.language("ProducePanel", 7), Config.language("ProducePanel", 8)];
            this.levelexp = [1000, 2000, 5000, 12000, 36000, 108000, Config.language("ProducePanel", 9)];
            this.levelexpdrag = [3600, 8760, 14300, 28000, 67100, 204000, Config.language("ProducePanel", 9)];
            this.topbtn = new ButtonBar(this, 15, 25);
            this.topbtn.addTab(Config.language("ProducePanel", 10), Config.create(this.armmade, 0));
            this.topbtn.addTab(Config.language("ProducePanel", 11), Config.create(this.armmade, 1));
            this.topbtn.addTab(Config.language("ProducePanel", 12), Config.create(this.armmade, 2));
            this._lianjinBtn = this.topbtn.addTab(Config.language("ProducePanel", 13), Config.create(this.armmade, 3));
            this.topbtn.addTab(Config.language("ProducePanel", 101), Config.create(this.armmade, 4));
            this.topbtn.addTab(Config.language("ProducePanel", 102), Config.create(this.armmade, 5));
            this.checkBarButtonVer();
            this.mainpanel = new Sprite();
            this.addChild(this.mainpanel);
            this.itemtree = new AdvanceTreee(this, 22, 125, 246, 230);
            this.itemtree.addEventListener(AdvanceTreeeEvent.CHECK_ID, this.showform);
            this.levelcombox = new ComboBox(this, 152, 100, this.reshowtree);
            this.levelcombox.addItem({label:Config.language("ProducePanel", 14), data:0});
            this.levelcombox.addItem({label:Config.language("ProducePanel", 15, String("10-19")), data:1});
            this.levelcombox.addItem({label:Config.language("ProducePanel", 15, String("20-29")), data:2});
            this.levelcombox.addItem({label:Config.language("ProducePanel", 15, String("30-39")), data:3});
            this.levelcombox.addItem({label:Config.language("ProducePanel", 15, String("40-49")), data:4});
            this.levelcombox.addItem({label:Config.language("ProducePanel", 15, String("50-59")), data:5});
            this.levelcombox.addItem({label:Config.language("ProducePanel", 15, String("60-69")), data:6});
            this.levelcombox.addItem({label:Config.language("ProducePanel", 15, String("70-79")), data:7});
            this.levelcombox.addItem({label:Config.language("ProducePanel", 15, String("80-89")), data:8});
            this.levelcombox.addItem({label:Config.language("ProducePanel", 15, String("90-94")), data:9});
            this.levelcombox.addItem({label:Config.language("ProducePanel", 15, String("95-99")), data:10});
            this.levelcombox.selectedItem = this.levelcombox.itemArray[0];
            this.levelcombox.width = 106;
            this.levelcombox.editable = false;
            this.jobcombox = new ComboBox(this, 20, 100, this.reshowtree);
            this.jobcombox.addItem({label:Config.language("ProducePanel", 16), data:0});
            this.jobcombox.addItem({label:Config.language("ProducePanel", 17), data:1});
            this.jobcombox.addItem({label:Config.language("ProducePanel", 18), data:2});
            this.jobcombox.addItem({label:Config.language("ProducePanel", 19), data:3});
            this.jobcombox.selectedItem = this.jobcombox.itemArray[0];
            this.jobcombox.width = 122;
            this.jobcombox.editable = false;
            this.expbar = new ProgressBar(this, 180, 65);
            this.expbar.height = 15;
            this.expbar.width = 300;
            this.expbar.gradientFillDirection = Math.PI;
            this.expbar.roundCorner = 6;
            this.expbar.color = 15981107;
            this.expbar.subColor = 16750899;
            this.madebar = new ProgressBar(null, 230 + 66, 360);
            this.madebar.height = 15;
            this.madebar.width = 290;
            this.madebar.gradientFillDirection = Math.PI;
            this.madebar.roundCorner = 6;
            this.madebar.color = 15981107;
            this.madebar.subColor = 16750899;
            this.madebar.maximum = 100;
            this.explb = Config.getSimpleTextField();
            this.explb.textColor = 16315890;
            this.explb.filters = [new GlowFilter(Style.WINDOW_FONT, 1, 3, 3, 10, 1)];
            this.explb.y = 65;
            this.explb.x = 30;
            addChild(this.explb);
            this.topbtn.selectpage = 0;
            this.pdnum = new NumericStepper(null, 290, 330);
            this.pdnum.width = 100;
            this.pdnum.percent = false;
            this.pdnum.maximum = 100;
            this.pdnum.addEventListener(Event.CHANGE, this.expChange);
            this.addexp = new Label(null, 400, 265);
            this.needmoney = new Label(null, 225, 265);
            this.needlevel = new Label(null, 225, 180);
            this.tomadename = new Label(null, 225 + 66, 100);
            this.tomadename.html = true;
            this.alabel = new Label(null, 225, 170);
            this.blabel = new Label(null, 300, 130);
            this.blabel.html = true;
            this.clabel = new Label(null, 235 + 52, 130, Config.language("ProducePanel", 20));
            this.dlabel = new Label(null, 365, 130, Config.language("ProducePanel", 21));
            this.elabel = new Label(null, 475, 150, Config.language("ProducePanel", 22));
            this.flabel = new Label(null, 235, 205, Config.language("ProducePanel", 23));
            this.hlabel = new Label(null, 315, 140);
            this.hlabel.html = true;
            this.ilabel = new Label(null, 440, 185);
            this.ilabel.html = true;
            this.ltext = new Label(this, 100, 63);
            this.add1 = new ClickLabel(null, 235 + 66, 185, Config.language("ProducePanel", 25), Config.create(this.addfuc, 1), true);
            this.add1.clickColor([39423, 16544]);
            this.add2 = new ClickLabel(null, 265 + 66, 185, Config.language("ProducePanel", 99), Config.create(this.addfuc, 2), true);
            this.add2.clickColor([39423, 16544]);
            this._slotArray = new Array();
            _loc_1 = 0;
            while (_loc_1 < 7)
            {
                
                _loc_2 = new CloneSlot(0, 32);
                if (_loc_1 == 0)
                {
                    _loc_2.addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver2);
                    _loc_2.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
                }
                else if (_loc_1 == 6)
                {
                    _loc_2.addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver3);
                    _loc_2.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
                }
                else
                {
                    _loc_2.iconsp.removeEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
                    _loc_2.iconsp.removeEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
                    _loc_2.iconsp.addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
                    _loc_2.iconsp.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
                }
                if (_loc_1 == 0)
                {
                    _loc_2.addEventListener("sglClick", this.handleSlotClick);
                    _loc_2.addEventListener("drag", this.handleSlotClick);
                    _loc_2.addEventListener("up", this.handleSlotUp);
                }
                else if (_loc_1 == 6)
                {
                    _loc_2.addEventListener("sglClick", this.handleSlotClick2);
                    _loc_2.addEventListener("drag", this.handleSlotClick2);
                    _loc_2.addEventListener("up", this.handleSlotUp2);
                }
                else
                {
                    _loc_2.nameshow = true;
                }
                this._slotArray.push(_loc_2);
                _loc_1 = _loc_1 + 1;
            }
            _loc_1 = 0;
            while (_loc_1 < 4)
            {
                
                _loc_2 = new CloneSlot(0, 32);
                _loc_2.iconsp.removeEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
                _loc_2.iconsp.removeEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
                _loc_2.iconsp.addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
                _loc_2.iconsp.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
                this.madearr.push(_loc_2);
                _loc_1 = _loc_1 + 1;
            }
            this._slotArray[6].bg = Config.findUI("charui")["icon18"];
            this.madearr[0].bg = Config.findUI("charui")["icon0"];
            this.madebtn = new PushButton(this, 400 + 66, 325, Config.language("ProducePanel", 26), this.sendpd);
            this.madebtn.width = 60;
            this.consp = new Sprite();
            this.consp.x = 300 + 76;
            this.consp.y = 130;
            this.overtext = new Label(this, 480, 340, Config.language("ProducePanel", 64));
            this.overtext.textColor = Style.FONT_3int_Orange;
            return;
        }// end function

        private function armmade(event:MouseEvent = null, param2:int = 0) : void
        {
            var _loc_3:* = 0;
            if (event != null)
            {
                this.smflag = true;
            }
            this.stoploops();
            this.removeallchild(this.mainpanel);
            this.levelcombox.selectedItem = this.levelcombox.itemArray[0];
            if (param2 == 3 || param2 == 4 || param2 == 5)
            {
                this.levelcombox.enabled = false;
            }
            else
            {
                this.levelcombox.enabled = true;
                _loc_3 = int(Config.player.level / 10);
                if (_loc_3 == 0)
                {
                    _loc_3 = 1;
                }
                else if (_loc_3 >= 10)
                {
                    _loc_3 = 10;
                }
                else if (_loc_3 >= 9)
                {
                    _loc_3 = int((Config.player.level - 90) / 5) + 9;
                }
                this.levelcombox.selectedItem = this.levelcombox.itemArray[_loc_3];
            }
            this.treesid = -1;
            this.reshowtree();
            this.reshowlevel();
            if (this.topbtn.selectpage == 0)
            {
                this.addChild(this.jobcombox);
            }
            else
            {
                if (this.jobcombox.parent != null)
                {
                    this.removeChild(this.jobcombox);
                }
                this.pdnum.maximum = 1;
                this.pdnum.value = 1;
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

        private function backproduce(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            if (GuideUI.testId(25))
            {
                GuideUI.doId(25, Config.ui._systemUI._bagPB, Config.ui._bagUI);
            }
            var _loc_3:* = _loc_2.readByte() + 1;
            var _loc_4:* = this.pdobj["level" + _loc_3];
            this.pdobj["level" + _loc_3] = _loc_2.readByte();
            this.pdobj["exp" + _loc_3] = _loc_2.readUnsignedInt();
            if (_loc_4 != this.pdobj["level" + _loc_3])
            {
                if (this.rememberid != -1)
                {
                    this.reshowtree();
                    this.itemtree.selectid(this.rememberid);
                    this.treesid = this.rememberid;
                }
            }
            this.showformid(this.rememberid);
            this.reshowlevel();
            return;
        }// end function

        private function showform(event:AdvanceTreeeEvent) : void
        {
            if (GuideUI.testId(24))
            {
                GuideUI.testDoId(24, this.madebtn);
            }
            else if (GuideUI.testId(83))
            {
                GuideUI.testDoId(83, this.madebtn);
            }
            this.washflag = 0;
            this.treesid = event.id;
            this.rememberid = this.treesid;
            this.stoploops();
            this.pattrPanel.close();
            this.washPanel.close();
            this.timer.stop();
            this.timer.removeEventListener(TimerEvent.TIMER, this.allwash);
            this.showformid(this.treesid);
            return;
        }// end function

        private function showformid(param1:int) : void
        {
            var _loc_2:* = false;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = 0;
            var _loc_12:* = undefined;
            var _loc_13:* = false;
            var _loc_14:* = 0;
            var _loc_15:* = 0;
            var _loc_16:* = 0;
            var _loc_17:* = null;
            var _loc_18:* = 0;
            var _loc_19:* = 0;
            if (param1 == -1)
            {
                return;
            }
            this.itemlock(false);
            this.madebtn.visible = true;
            this.pdnum.visible = true;
            if (int(Config._formula[param1].mainmater) != 0)
            {
                this.forgShow(param1);
                return;
            }
            if (int(Config._formula[param1].type) == 3 && int(Config._formula[param1].remouldLevel) == 6)
            {
                _loc_2 = this.adddrag(param1);
                if (!_loc_2)
                {
                    return;
                }
            }
            this.mainpanel.graphics.clear();
            this.mainpanel.graphics.beginFill(16777215, 0.5);
            this.mainpanel.graphics.drawRoundRect(12, 95, 266, 270, 5);
            this.mainpanel.graphics.drawRoundRect(12, 55, 598, 35, 5);
            this.mainpanel.graphics.drawRoundRect(284, 95, 326, 85, 5);
            this.mainpanel.graphics.drawRoundRect(284, 185, 326, 120, 5);
            if (this.add1.parent != null)
            {
                this.mainpanel.removeChild(this.add1);
            }
            if (this.add2.parent != null)
            {
                this.mainpanel.removeChild(this.add2);
            }
            if (this.consp.parent != null)
            {
                this.mainpanel.removeChild(this.consp);
            }
            if (this.topbtn.selectpage <= 3)
            {
                if (this.pdobj["level" + int((this.topbtn.selectpage + 1))] > Config._formula[param1].hlevel)
                {
                    this.addexp.text = Config.language("ProducePanel", 27) + "0";
                    this.addexpflag = 0;
                }
                else
                {
                    this.addexp.text = Config.language("ProducePanel", 27) + Config._formula[param1].exp;
                    this.addexpflag = Config._formula[param1].exp;
                }
                this.needmoney.text = Config.language("ProducePanel", 28) + Config._formula[param1].money;
                this.needmoneyflag = Config._formula[param1].money;
                this.needlevel.text = Config.language("ProducePanel", 29) + this.levelarr[Config._formula[param1].pdlevel];
                this.addexp.x = 400 + 66;
                this.addexp.y = 275;
                this.needmoney.x = 240 + 66;
                this.needmoney.y = 275;
                this.mainpanel.addChild(this.addexp);
                this.mainpanel.addChild(this.needmoney);
                _loc_3 = 0;
                switch(this.pdobj["level" + int((this.topbtn.selectpage + 1))])
                {
                    case 0:
                    {
                        _loc_3 = 1;
                        break;
                    }
                    case 1:
                    {
                        _loc_3 = 1;
                        break;
                    }
                    case 2:
                    {
                        _loc_3 = 1;
                        break;
                    }
                    case 3:
                    case 4:
                    case 5:
                    case 6:
                    case 7:
                    {
                        _loc_3 = 1;
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                if (this.topbtn.selectpage == 3)
                {
                    _loc_3 = 1;
                    this.alabel.text = "";
                    this.blabel.text = "";
                }
                else
                {
                    this.mainpanel.addChild(this.alabel);
                    this.mainpanel.addChild(this.blabel);
                }
                if (int(Config._formula[param1].mainmater) != 0)
                {
                    this.tomadename.text = Config.language("ProducePanel", 30) + Config._formula[param1].name + Config.language("ProducePanel", 31);
                    this.madebtn.label = Config.language("ProducePanel", 32);
                    if (this.pdnum.parent != null)
                    {
                        this.removeChild(this.pdnum);
                    }
                    _loc_3 = 1;
                    this.alabel.text = "";
                    this.blabel.text = "";
                }
                else
                {
                    this.tomadename.text = Config.language("ProducePanel", 33) + "<font color=\'#104ac1\'>" + Config._formula[param1].name + "</font>";
                    this.madebtn.label = Config.language("ProducePanel", 26);
                    this.addChild(this.pdnum);
                    this.alabel.text = "";
                    this.blabel.text = Config.language("ProducePanel", 34);
                    this.clabel.text = "";
                    this.dlabel.text = "";
                    this.elabel.text = "";
                    this.flabel.text = Config.language("ProducePanel", 23);
                    this.hlabel.text = "";
                    this.ilabel.text = "";
                    this.madebtn.x = 400 + 66;
                    this.mainpanel.addChild(this.flabel);
                    this.flabel.x = 230 + 66;
                    this.flabel.y = 190;
                }
                this.mainpanel.addChild(this.tomadename);
                if (this.topbtn.selectpage == 2)
                {
                    this.madebtn.label = Config.language("ProducePanel", 38);
                    this.madebtn.x = 400 + 66;
                }
                else if (this.topbtn.selectpage == 3)
                {
                    this.madebtn.label = Config.language("ProducePanel", 39);
                    this.madebtn.x = 400 + 66;
                }
                this.madebtn.enabled = true;
                this.madebtn.y = 330;
                _loc_4 = 0;
                while (_loc_4 < 4)
                {
                    
                    if (this.madearr[_loc_4].item != null)
                    {
                        this.madearr[_loc_4].item.destroy();
                    }
                    switch(_loc_4)
                    {
                        case 0:
                        {
                            break;
                        }
                        case 1:
                        {
                            break;
                        }
                        case 2:
                        {
                            break;
                        }
                        case 3:
                        {
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    if (_loc_4 > 0)
                    {
                    }
                    if (this.madearr[_loc_4].parent != null)
                    {
                    }
                    _loc_4 = _loc_4 + 1;
                }
                _loc_5 = 0;
                if (int(Config._formula[param1].mainmater) != 0)
                {
                    _loc_11 = 0;
                    while (_loc_11 < this._slotArray.length)
                    {
                        
                        this.mainpanel.addChild(this._slotArray[_loc_11]);
                        this._slotArray[_loc_11].x = 245 + 40 * _loc_11 + 66;
                        this._slotArray[_loc_11].y = 210;
                        if (_loc_11 > 0)
                        {
                            this._slotArray[_loc_11].x = this._slotArray[_loc_11].x + 20;
                        }
                        _loc_11++;
                    }
                    for (_loc_12 in Config._itemMap)
                    {
                        
                        if (int(Config._itemMap[_loc_12].produceId) == int(Config._formula[param1].mainmater))
                        {
                            if (Number(Config._itemMap[_loc_12].subType) < 7)
                            {
                                this._slotArray[0].bg = Config.findUI("charui")["icon" + Number(Config._itemMap[_loc_12].subType)];
                            }
                            else
                            {
                                this._slotArray[0].bg = Config.findUI("charui")["icon" + (Number(Config._itemMap[_loc_12].subType) + 1)];
                            }
                            break;
                        }
                    }
                }
                else
                {
                    if (this._slotArray[0].parent != null)
                    {
                        this.mainpanel.removeChild(this._slotArray[0]);
                    }
                    if (this._slotArray[0].item != null)
                    {
                        _loc_15 = this._slotArray[0].item._position;
                        Config.ui._charUI.itemunlock(_loc_15);
                        this._slotArray[0].item = null;
                    }
                    if (this._slotArray[6].item != null)
                    {
                        _loc_15 = this._slotArray[6].item._position;
                        Config.ui._charUI.itemunlock(_loc_15);
                        this._slotArray[6].item = null;
                    }
                    _loc_13 = false;
                    _loc_14 = 1;
                    while (_loc_14 < this._slotArray.length)
                    {
                        
                        if (int(Config._formula[param1]["materialid" + _loc_14]) != 0)
                        {
                            _loc_13 = true;
                            break;
                        }
                        _loc_14 = _loc_14 + 1;
                    }
                    if (_loc_13)
                    {
                        _loc_16 = 1;
                        while (_loc_16 < (this._slotArray.length - 1))
                        {
                            
                            this.mainpanel.addChild(this._slotArray[_loc_16]);
                            this._slotArray[_loc_16].x = 245 + 40 * (_loc_16 - 1) + 66;
                            this._slotArray[_loc_16].y = 220;
                            this._slotArray[_loc_16].visible = true;
                            _loc_16 = _loc_16 + 1;
                        }
                        if (this.madearr[0].parent != null)
                        {
                            this.madearr[0].visible = true;
                        }
                    }
                    else
                    {
                        _loc_16 = 1;
                        while (_loc_16 < (this._slotArray.length - 1))
                        {
                            
                            this._slotArray[_loc_16].visible = false;
                            _loc_16 = _loc_16 + 1;
                        }
                        if (this.madearr[0].parent != null)
                        {
                            this.madearr[0].visible = false;
                        }
                        this.madebtn.visible = false;
                        this.pdnum.visible = false;
                        this.clabel.text = "";
                        this.needmoney.text = "";
                        this.addexp.text = "";
                        this.flabel.text = "";
                    }
                    if (this._slotArray[6].parent != null)
                    {
                        this.mainpanel.removeChild(this._slotArray[6]);
                    }
                }
                _loc_4 = 1;
                while (_loc_4 < this._slotArray.length)
                {
                    
                    if (int(Config._formula[param1]["materialid" + _loc_4]) != 0 && _loc_4 < 6)
                    {
                        _loc_17 = Item.newItem(Config._itemMap[int(Config._formula[param1]["materialid" + _loc_4])], 0, 0, UNIT_TYPE_ENUM.TYPEID_ITEMCLONE, 0);
                        _loc_17.display();
                        _loc_18 = Config.ui._charUI.getItemAmountBag(int(Config._formula[param1]["materialid" + _loc_4]));
                        _loc_19 = int(Config._formula[param1]["materialnum" + _loc_4]);
                        _loc_17.numstr = _loc_18 + "/" + _loc_19;
                        if (_loc_18 >= _loc_19)
                        {
                            _loc_17.numstrcolor = 2092116;
                        }
                        else
                        {
                            _loc_17.numstrcolor = 16777215;
                        }
                        this._slotArray[_loc_4].item = _loc_17;
                    }
                    else if (this._slotArray[_loc_4].item != null)
                    {
                        if (_loc_4 != 0 && _loc_4 != 6)
                        {
                            this._slotArray[_loc_4].item.destroy();
                        }
                        this._slotArray[_loc_4].item = null;
                    }
                    _loc_4 = _loc_4 + 1;
                }
                this.pdnum.maximum = this.countnum();
                if (this.pdnum.maximum == 0)
                {
                    this.pdnum.value = 0;
                }
                else
                {
                    if (this.pdnum.value <= this.pdnum.maximum && this.pdnum.value > 1)
                    {
                    }
                    else
                    {
                        this.pdnum.value = 1;
                    }
                    if (this.looptime != 0)
                    {
                        this.pdnum.value = this.looptime;
                    }
                }
                Config.ui._bagUI.cancelEnable();
            }
            else
            {
                this.madebtn.visible = false;
                this.pdnum.visible = false;
                this.tomadename.text = Config.language("ProducePanel", 33) + "<font color=\'#104ac1\'>" + Config._formula[param1].name + "</font>";
                this.mainpanel.addChild(this.tomadename);
                this.clabel.text = "";
                this.needmoney.text = "";
                this.addexp.text = "";
                this.flabel.text = "";
                if (this._slotArray[0].item != null)
                {
                    _loc_15 = this._slotArray[0].item._position;
                    Config.ui._charUI.itemunlock(_loc_15);
                    this._slotArray[0].item = null;
                }
                _loc_16 = 0;
                while (_loc_16 < (this._slotArray.length - 1))
                {
                    
                    if (this._slotArray[_loc_16].parent != null)
                    {
                        this.mainpanel.removeChild(this._slotArray[_loc_16]);
                    }
                    _loc_16 = _loc_16 + 1;
                }
            }
            this.overtext.visible = false;
            return;
        }// end function

        private function forgShow(param1:int) : void
        {
            var _loc_5:* = undefined;
            var _loc_6:* = 0;
            var _loc_7:* = false;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_10:* = 0;
            var _loc_11:* = 0;
            this.mainpanel.graphics.clear();
            this.mainpanel.graphics.beginFill(16777215, 0.5);
            this.mainpanel.graphics.drawRoundRect(12, 95, 266, 270, 5);
            this.mainpanel.graphics.drawRoundRect(12, 55, 598, 35, 5);
            this.mainpanel.graphics.drawRoundRect(284, 95, 326, 30, 5);
            this.mainpanel.graphics.drawRoundRect(284, 130, 95, 80, 5);
            this.mainpanel.graphics.drawRoundRect(386, 130, 226, 80, 5);
            this.mainpanel.graphics.drawRoundRect(284, 215, 326, 115, 5);
            this.mainpanel.graphics.endFill();
            this.tomadename.text = Config.language("ProducePanel", 30) + "<font color=\'" + this.getColor(int(Config._formula[param1].remouldLevel), 1) + "\'>" + Config._formula[param1].name + "</font>";
            if (Config._formula[param1].remouldLevel == 5 || Config._formula[param1].remouldLevel == 6)
            {
                _loc_7 = false;
                _loc_6 = 0;
                while (_loc_6 < this.learnarr.length)
                {
                    
                    if (param1 == this.learnarr[_loc_6])
                    {
                        _loc_7 = true;
                        break;
                    }
                    _loc_6 = _loc_6 + 1;
                }
                if (!_loc_7)
                {
                    this.addexp.text = "";
                    this.needmoney.text = "";
                    this.needlevel.text = "";
                    this.alabel.text = "";
                    this.blabel.text = "";
                    this.clabel.text = "";
                    this.flabel.text = "";
                    this.overtext.visible = false;
                    this.madebtn.visible = false;
                    this.pdnum.visible = false;
                    if (this.add1.parent != null)
                    {
                        this.mainpanel.removeChild(this.add1);
                    }
                    if (this.add2.parent != null)
                    {
                        this.mainpanel.removeChild(this.add2);
                    }
                    if (this.consp.parent != null)
                    {
                        this.mainpanel.removeChild(this.consp);
                    }
                    _loc_8 = 0;
                    while (_loc_8 < (this._slotArray.length - 1))
                    {
                        
                        this._slotArray[_loc_8].visible = false;
                        _loc_8 = _loc_8 + 1;
                    }
                    if (this.madearr[0].parent != null)
                    {
                        this.madearr[0].visible = false;
                    }
                    AlertUI.alert(Config.language("ProducePanel", 46), Config.language("ProducePanel", 110), [Config.language("ProducePanel", 48)]);
                    return;
                }
            }
            if (this.consp.parent == null)
            {
                this.mainpanel.addChild(this.consp);
            }
            if (this.pdobj["level" + int((this.topbtn.selectpage + 1))] > Config._formula[param1].hlevel)
            {
                this.addexp.text = Config.language("ProducePanel", 27) + "0";
                this.addexpflag = 0;
            }
            else
            {
                this.addexp.text = Config.language("ProducePanel", 27) + Config._formula[param1].exp;
                this.addexpflag = Config._formula[param1].exp;
            }
            this.needmoney.text = Config.language("ProducePanel", 28) + Config._formula[param1].money;
            this.needmoneyflag = Config._formula[param1].money;
            this.needlevel.text = Config.language("ProducePanel", 29) + this.levelarr[Config._formula[param1].pdlevel];
            this.addexp.x = 350 + 66;
            this.addexp.y = 310;
            this.needmoney.x = 240 + 66;
            this.needmoney.y = 310;
            this.mainpanel.addChild(this.addexp);
            this.mainpanel.addChild(this.needmoney);
            var _loc_2:* = 1;
            if (this.topbtn.selectpage == 3)
            {
                _loc_2 = 1;
                this.alabel.text = "";
                this.blabel.text = "";
            }
            else
            {
                this.mainpanel.addChild(this.alabel);
                this.mainpanel.addChild(this.blabel);
                this.mainpanel.addChild(this.clabel);
                this.mainpanel.addChild(this.flabel);
                this.mainpanel.addChild(this.add1);
                this.mainpanel.addChild(this.add2);
            }
            this.madebtn.label = Config.language("ProducePanel", 32);
            this.madebtn.x = 340 + 66;
            this.madebtn.y = 340;
            if (this.pdnum.parent != null)
            {
                this.removeChild(this.pdnum);
            }
            _loc_2 = 1;
            this.alabel.text = "";
            this.blabel.text = "";
            this.clabel.text = Config.language("ProducePanel", 20);
            this.flabel.text = Config.language("ProducePanel", 23);
            this.flabel.x = 235 + 66;
            this.flabel.y = 225;
            this.mainpanel.addChild(this.tomadename);
            if (this.topbtn.selectpage == 2)
            {
                this.madebtn.label = Config.language("ProducePanel", 38);
            }
            else if (this.topbtn.selectpage == 3)
            {
                this.madebtn.label = Config.language("ProducePanel", 39);
            }
            if (this.madearr[0].parent != null)
            {
                this.mainpanel.removeChild(this.madearr[0]);
            }
            this.pdOutShow();
            this.changePut(param1);
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            while (_loc_4 < (this._slotArray.length - 1))
            {
                
                this.mainpanel.addChild(this._slotArray[_loc_4]);
                this._slotArray[_loc_4].x = 245 + 40 * (_loc_4 - 1) + 66;
                this._slotArray[_loc_4].y = 250;
                this._slotArray[_loc_4].visible = true;
                if (_loc_4 == 0)
                {
                    this._slotArray[_loc_4].x = 245 + 66 + 6;
                    this._slotArray[_loc_4].y = 150;
                }
                else if (_loc_4 == (this._slotArray.length - 1))
                {
                    this._slotArray[_loc_4].x = 375 + 66;
                    this._slotArray[_loc_4].y = 150;
                }
                _loc_4++;
            }
            for (_loc_5 in Config._itemMap)
            {
                
                if (int(Config._itemMap[_loc_5].produceId) == int(Config._formula[param1].mainmater))
                {
                    if (Number(Config._itemMap[_loc_5].subType) < 7)
                    {
                        this._slotArray[0].bg = Config.findUI("charui")["icon" + Number(Config._itemMap[_loc_5].subType)];
                    }
                    else
                    {
                        this._slotArray[0].bg = Config.findUI("charui")["icon" + (Number(Config._itemMap[_loc_5].subType) + 1)];
                    }
                    break;
                }
            }
            _loc_6 = 1;
            while (_loc_6 < 6)
            {
                
                if (int(Config._formula[this.treesid]["materialid" + _loc_6]) != 0)
                {
                    _loc_9 = Item.newItem(Config._itemMap[int(Config._formula[this.treesid]["materialid" + _loc_6])], 0, 0, UNIT_TYPE_ENUM.TYPEID_ITEMCLONE, 0);
                    _loc_9.display();
                    _loc_10 = Config.ui._charUI.getItemAmountBag(int(Config._formula[this.treesid]["materialid" + _loc_6]));
                    _loc_11 = int(Config._formula[this.treesid]["materialnum" + _loc_6]);
                    _loc_9.numstr = _loc_10 + "/" + _loc_11;
                    if (_loc_10 >= _loc_11)
                    {
                        _loc_9.numstrcolor = 2092116;
                    }
                    else
                    {
                        _loc_9.numstrcolor = 16777215;
                    }
                    this._slotArray[_loc_6].item = _loc_9;
                }
                else if (this._slotArray[_loc_6].item != null)
                {
                    if (_loc_6 != 0 && _loc_6 != 6)
                    {
                        this._slotArray[_loc_6].item.destroy();
                        this._slotArray[_loc_6].item = null;
                    }
                }
                _loc_6 = _loc_6 + 1;
            }
            this.pdnum.maximum = this.countnum();
            if (this.pdnum.maximum == 0)
            {
                this.pdnum.value = 0;
            }
            else
            {
                this.pdnum.value = 1;
                if (this.looptime != 0)
                {
                    this.pdnum.value = this.looptime;
                }
            }
            Config.ui._bagUI.setEnable(int(Config._formula[this.treesid].mainmater), int(Config._formula[this.treesid].remouldLevel));
            return;
        }// end function

        private function changePut(param1:int) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = null;
            var _loc_16:* = 0;
            var _loc_17:* = 0;
            var _loc_18:* = NaN;
            var _loc_19:* = NaN;
            var _loc_20:* = NaN;
            var _loc_21:* = null;
            var _loc_22:* = null;
            var _loc_23:* = null;
            var _loc_24:* = null;
            var _loc_25:* = null;
            var _loc_26:* = null;
            var _loc_27:* = null;
            this.removeallchild(this.consp);
            var _loc_2:* = [" ", "D", "C", "B", "A", "S", "S2"];
            if (this._slotArray[0].item != null)
            {
                if (int(this._slotArray[0].item._itemData.qual) >= int((Config._formula[this.treesid].remouldLevel - 1)) && int(this._slotArray[0].item._itemData.produceId) == int(Config._formula[this.treesid].mainmater))
                {
                }
                else
                {
                    _loc_3 = this._slotArray[0].item._position;
                    Config.ui._charUI.itemunlock(_loc_3);
                    this._slotArray[0].item = null;
                }
            }
            this.madebtn.visible = true;
            this.pdnum.visible = true;
            if (this._slotArray[0].item != null)
            {
                if (int(this._slotArray[0].item._itemData.qual) == int((Config._formula[param1].remouldLevel - 1)))
                {
                    if (this.topbtn.selectpage == 4 || this.topbtn.selectpage == 5)
                    {
                        this.treesid = Config._ridewingid[this._slotArray[0].item._itemData.baseID + ":" + Config._formula[this.treesid].remouldLevel + ":" + 99].listid;
                        _loc_4 = new Label(this.consp, 10, 15);
                        _loc_5 = 1;
                        if (Number(Config._formula[param1].remouldLevel) == 1)
                        {
                            _loc_5 = 11;
                        }
                        else if (Number(Config._formula[param1].remouldLevel) == 2)
                        {
                            _loc_5 = 131;
                        }
                        else if (Number(Config._formula[param1].remouldLevel) == 3)
                        {
                            _loc_5 = 1;
                        }
                        else if (Number(Config._formula[param1].remouldLevel) == 4)
                        {
                            _loc_5 = 130;
                        }
                        _loc_4.text = Config.language("ProducePanel", 103, _loc_2[Config._formula[param1].remouldLevel]) + ": " + Config._itemPropMap[_loc_5].name + " +" + Config._hflist[Number(Config._formula[param1].outmater) * 10 + Number(Config._formula[param1].remouldLevel)]["effectValue" + Number(Config._formula[param1].remouldLevel)];
                    }
                    else
                    {
                        _loc_4 = new Label(this.consp, 10, 15);
                        _loc_6 = new Label(this.consp, 66, 12);
                        _loc_6.html = true;
                        _loc_7 = new Label(this.consp, 80, 15);
                        _loc_7.html = true;
                        _loc_8 = new Label(this.consp, 10, 35);
                        _loc_9 = new Label(this.consp, 66, 32);
                        _loc_9.html = true;
                        _loc_10 = new Label(this.consp, 80, 35);
                        _loc_10.html = true;
                        _loc_11 = new Label(this.consp, 10, 55);
                        _loc_12 = {};
                        if (this._slotArray[0].item._itemData.qual > 0)
                        {
                            _loc_12 = Config._bIAttribute[this._slotArray[0].item._itemData.quality2 * 1000 + this._slotArray[0].item._itemData.subType * 10 + this._slotArray[0].item._itemData.qual];
                            _loc_8.text = Config._itemPropMap[_loc_12.effectId1].name + "  " + _loc_12.effectValue1;
                        }
                        else
                        {
                            _loc_12 = this._slotArray[0].item._itemData;
                            _loc_8.text = "HP  0";
                        }
                        _loc_13 = Config._bIAttribute[this._slotArray[0].item._itemData.quality2 * 1000 + this._slotArray[0].item._itemData.subType * 10 + int(Config._formula[param1].remouldLevel)];
                        if (int(_loc_12.atk) != 0 || int(_loc_12.atkRanged) != 0 || int(_loc_12.atkMagic) != 0)
                        {
                            _loc_4.text = Config.language("ProducePanel", 65) + Math.max(_loc_12.atk, _loc_12.atkRanged, _loc_12.atkMagic);
                            _loc_6.text = "<b><font size=\'18\' color=\'#666666\'>" + "»" + "</font></b>";
                            _loc_7.text = "<font size=\'12\' color=\'#00aeff\'>" + Math.max(_loc_13.atk, _loc_13.atkRanged, _loc_13.atkMagic) + "</font>";
                        }
                        if (int(_loc_12.def) != 0 || int(_loc_12.defRanged) != 0 || int(_loc_12.defMagic) != 0)
                        {
                            _loc_4.text = Config.language("ProducePanel", 66) + Math.max(_loc_12.def, _loc_12.defRanged, _loc_12.defMagic);
                            _loc_6.text = "<b><font size=\'14\' color=\'#666666\'>" + "»" + "</font></b>";
                            _loc_7.text = "<font size=\'12\' color=\'#00aeff\'>" + Math.max(_loc_13.def, _loc_13.defRanged, _loc_13.defMagic) + "</font>";
                        }
                        _loc_9.text = "<b><font size=\'14\' color=\'#666666\'>" + "»" + "</font></b>";
                        _loc_10.text = "<font size=\'12\' color=\'#00aeff\'>" + _loc_13.effectValue1 + "</font>";
                        if (Number(Config._formula[param1].remouldLevel) == 6)
                        {
                            _loc_11.text = Config.language("ProducePanel", 113);
                        }
                        else
                        {
                            _loc_11.text = Config.language("ProducePanel", 67, _loc_2[Config._formula[param1].remouldLevel]);
                        }
                        _loc_14 = new ClickLabel(this.consp, 130, 55, Config.language("ProducePanel", 68), Config.create(this.pattr, this._slotArray[0].item._itemData.quality2 * 10 + int(Config._formula[param1].remouldLevel)), true);
                        _loc_14.clickColor([39423, 16544]);
                    }
                    this.madebtn.enabled = true;
                    this.overtext.visible = false;
                }
                else
                {
                    _loc_15 = new PushButton(this.consp, 150, 55, Config.language("ProducePanel", 92), this.openWash);
                    _loc_15.width = 60;
                    _loc_15.enabled = true;
                    if (this.topbtn.selectpage == 4 || this.topbtn.selectpage == 5)
                    {
                        this.treesid = Config._ridewingid[this._slotArray[0].item._itemData.baseID + ":" + Config._formula[this.treesid].remouldLevel + ":" + 98].listid;
                        _loc_4 = new Label(this.consp, 10, 15);
                        _loc_4.html = true;
                        _loc_16 = Config._hflist[Number(Config._formula[this.treesid].outmater) * 10 + Number(Config._formula[this.treesid].remouldLevel)].everyvalue;
                        _loc_17 = Config._hflist[Number(Config._formula[this.treesid].outmater) * 10 + Number(Config._formula[this.treesid].remouldLevel)].valuemax;
                        _loc_4.text = Config.language("ProducePanel", 104, _loc_16, _loc_16, _loc_17);
                    }
                    else
                    {
                        _loc_12 = Config._bIAttribute[this._slotArray[0].item._itemData.quality2 * 1000 + this._slotArray[0].item._itemData.subType * 10 + this._slotArray[0].item._itemData.qual];
                        _loc_4 = new Label(this.consp, 10, 15);
                        _loc_4.html = true;
                        _loc_6 = new Label(this.consp, 10, 35);
                        _loc_6.html = true;
                        if (int(_loc_12.atk) != 0 || int(_loc_12.atkRanged) != 0 || int(_loc_12.atkMagic) != 0)
                        {
                            _loc_19 = Math.max(_loc_12.atk, _loc_12.atkRanged, _loc_12.atkMagic);
                            if (this._slotArray[0].item._itemData.addEffect.length > 5 && int(this._slotArray[0].item._itemData.addEffect[5].value) < 30 && int(this._slotArray[0].item._itemData.qual) == int(Config._formula[param1].remouldLevel))
                            {
                                if (this._slotArray[0].item._itemData.addEffect[5] != null)
                                {
                                    if (this._slotArray[0].item._itemData.addEffect[5].id == 210)
                                    {
                                        _loc_13 = Config._bIAttribute[this._slotArray[0].item._itemData.quality2 * 1000 + this._slotArray[0].item._itemData.subType * 10 + 5];
                                        _loc_19 = int((int(this._slotArray[0].item._itemData.addEffect[5].value) * int(Config._produceAttr[this._slotArray[0].item._itemData.quality2 * 10 + 6].value2max) / 100 + 1) * Math.max(_loc_13.atk, _loc_13.atkRanged, _loc_13.atkMagic));
                                        _loc_15.label = Config.language("ProducePanel", 114);
                                        _loc_4.text = Config.language("ProducePanel", 65) + _loc_19 + "  <b><font size=\'14\' color=\'#666666\'>" + "»" + "</font></b>  <font size=\'12\' color=\'#00aeff\'>" + int((int((this._slotArray[0].item._itemData.addEffect[5].value + 1)) * int(Config._produceAttr[this._slotArray[0].item._itemData.quality2 * 10 + 6].value2max) / 100 + 1) * Math.max(_loc_13.atk, _loc_13.atkRanged, _loc_13.atkMagic)) + "</font>";
                                    }
                                }
                            }
                            else
                            {
                                _loc_4.text = Config.language("ProducePanel", 65) + "<font size=\'12\' color=\'#00aeff\'>" + _loc_19 + "</font>";
                            }
                        }
                        if (int(_loc_12.def) != 0 || int(_loc_12.defRanged) != 0 || int(_loc_12.defMagic) != 0)
                        {
                            _loc_20 = Math.max(_loc_12.def, _loc_12.defRanged, _loc_12.defMagic);
                            if (this._slotArray[0].item._itemData.addEffect.length > 5 && int(this._slotArray[0].item._itemData.addEffect[5].value) < 30 && int(this._slotArray[0].item._itemData.qual) == int(Config._formula[param1].remouldLevel))
                            {
                                if (this._slotArray[0].item._itemData.addEffect[5] != null)
                                {
                                    if (this._slotArray[0].item._itemData.addEffect[5].id == 210)
                                    {
                                        _loc_13 = Config._bIAttribute[this._slotArray[0].item._itemData.quality2 * 1000 + this._slotArray[0].item._itemData.subType * 10 + 5];
                                        _loc_20 = int((int(this._slotArray[0].item._itemData.addEffect[5].value) * int(Config._produceAttr[this._slotArray[0].item._itemData.quality2 * 10 + 6].value2max) / 100 + 1) * Math.max(_loc_13.def, _loc_13.defRanged, _loc_13.defMagic));
                                        _loc_15.label = Config.language("ProducePanel", 114);
                                        _loc_4.text = Config.language("ProducePanel", 66) + _loc_20 + "  <b><font size=\'14\' color=\'#666666\'>" + "»" + "</font></b>  <font size=\'12\' color=\'#00aeff\'>" + int((int((this._slotArray[0].item._itemData.addEffect[5].value + 1)) * int(Config._produceAttr[this._slotArray[0].item._itemData.quality2 * 10 + 6].value2max) / 100 + 1) * Math.max(_loc_13.def, _loc_13.defRanged, _loc_13.defMagic)) + "</font>";
                                    }
                                }
                            }
                            else
                            {
                                _loc_4.text = Config.language("ProducePanel", 66) + "<font size=\'12\' color=\'#00aeff\'>" + _loc_20 + "</font>";
                            }
                        }
                        _loc_7 = new Label(this.consp, 10, 55);
                        _loc_7.html = true;
                        _loc_18 = _loc_12.effectValue1;
                        if (this._slotArray[0].item._itemData.addEffect.length > 5 && int(this._slotArray[0].item._itemData.qual) == int(Config._formula[param1].remouldLevel))
                        {
                            if (this._slotArray[0].item._itemData.addEffect[5] != null)
                            {
                                if (this._slotArray[0].item._itemData.addEffect[5].id == 210)
                                {
                                    _loc_18 = _loc_18 + int(this._slotArray[0].item._itemData.addEffect[5].value) * Config._produceAttr[this._slotArray[0].item._itemData.quality2 * 10 + 6].value3min;
                                    if (int(this._slotArray[0].item._itemData.addEffect[5].value) >= 30)
                                    {
                                        _loc_15.enabled = false;
                                        _loc_15.label = Config.language("ProducePanel", 114);
                                        _loc_6.text = Config._itemPropMap[_loc_12.effectId1].name + "  <font size=\'12\' color=\'#00aeff\'>" + _loc_18 + "</font>";
                                        _loc_7.text = "<font size=\'12\' color=\'#00aeff\'>" + Config.language("ProducePanel", 115) + int(this._slotArray[0].item._itemData.addEffect[5].value) + "%  (MAX)</font>";
                                    }
                                    else
                                    {
                                        _loc_6.text = Config._itemPropMap[_loc_12.effectId1].name + "  " + _loc_18 + "  <b><font size=\'14\' color=\'#666666\'>" + "»" + "</font></b>  <font size=\'12\' color=\'#00aeff\'>" + (int((this._slotArray[0].item._itemData.addEffect[5].value + 1)) * int(Config._produceAttr[this._slotArray[0].item._itemData.quality2 * 10 + 6].value3min) + _loc_12.effectValue1) + "</font>";
                                        _loc_7.text = Config.language("ProducePanel", 115) + int(this._slotArray[0].item._itemData.addEffect[5].value) + "%  <b><font size=\'14\' color=\'#666666\'>" + "»" + "</font></b>  <font size=\'12\' color=\'#00aeff\'>" + (int(this._slotArray[0].item._itemData.addEffect[5].value) + int(Config._produceAttr[this._slotArray[0].item._itemData.quality2 * 10 + 6].value2min)) + "%</font>";
                                    }
                                }
                            }
                        }
                        else
                        {
                            _loc_6.text = Config._itemPropMap[_loc_12.effectId1].name + "  " + "<font size=\'12\' color=\'#00aeff\'>" + _loc_18 + "</font>";
                            _loc_7.text = "<font size=\'12\' color=\'#00aeff\'>" + "[" + _loc_2[Config._formula[param1].remouldLevel] + "]" + Config._itemPropMap[this._slotArray[0].item._itemData.addEffect[(Config._formula[param1].remouldLevel - 1)].id].name + " " + this._slotArray[0].item._itemData.addEffect[(Config._formula[param1].remouldLevel - 1)].value + "</font>";
                        }
                    }
                    this.madebtn.enabled = false;
                    this.overtext.visible = true;
                }
            }
            else
            {
                _loc_21 = new TextAreaUI(this.consp, 10, 5, 225, 20);
                _loc_21.autoHeight = true;
                _loc_21.textColor = Style.WINDOW_FONT;
                _loc_22 = new TextAreaUI(this.consp, 10, 25, 225, 20);
                _loc_22.autoHeight = true;
                _loc_22.textColor = Style.WINDOW_FONT;
                _loc_23 = " ";
                _loc_24 = " ";
                if (Config._formula[param1].their != 0)
                {
                    _loc_25 = "";
                    _loc_26 = Style.FONT_0_White;
                    switch(int((Config._formula[param1].remouldLevel - 1)))
                    {
                        case 0:
                        {
                            _loc_26 = Style.FONT_Red;
                            break;
                        }
                        case 1:
                        {
                            _loc_25 = Config.language("ProducePanel", 70);
                            _loc_26 = Style.FONT_1_Blue;
                            break;
                        }
                        case 2:
                        {
                            _loc_25 = Config.language("ProducePanel", 71);
                            _loc_26 = Style.FONT_2_Purple;
                            break;
                        }
                        case 3:
                        {
                            _loc_25 = Config.language("ProducePanel", 72);
                            _loc_26 = Style.FONT_3_Orange;
                            break;
                        }
                        case 4:
                        {
                            _loc_25 = Config.language("ProducePanel", 73);
                            _loc_26 = Style.FONT_4_Gold;
                            break;
                        }
                        case 5:
                        {
                            _loc_25 = "[S]";
                            _loc_26 = Style.FONT_S_Equip;
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    _loc_23 = Config.language("ProducePanel", 74) + "<font color=\'" + _loc_26 + "\'>" + Config._formula[Config._formula[param1].their].name + _loc_25 + "</font>";
                    _loc_27 = this.getColor(int(Config._formula[param1].remouldLevel), 1);
                    _loc_23 = _loc_23 + (Config.language("ProducePanel", 75) + "<font color=\'" + _loc_27 + "\'>" + Config._formula[param1].name + "</font>");
                    _loc_24 = Config.language("ProducePanel", 74) + "<font color=\'" + _loc_27 + "\'>" + Config._formula[param1].name + "</font>";
                    if (Config._formula[param1].remouldLevel < Config._formula[param1].remouldMax)
                    {
                        _loc_24 = _loc_24 + Config.language("ProducePanel", 76);
                    }
                    _loc_24 = _loc_24 + Config.language("ProducePanel", 77, Style.FONT_1_Blue, _loc_2[Config._formula[param1].remouldLevel]);
                }
                _loc_21.text = _loc_23;
                _loc_22.text = _loc_24;
                _loc_22.y = _loc_21.y + _loc_21.height + 2;
                this.madebtn.enabled = true;
                this.overtext.visible = false;
            }
            return;
        }// end function

        private function pattr(event:TextEvent, param2:int) : void
        {
            this.pattrid = param2;
            this.pattrPanel.open();
            this.changePattr(null, 0);
            return;
        }// end function

        private function getquality(param1:int) : int
        {
            var _loc_2:* = 0;
            switch(param1)
            {
                case 0:
                case 1:
                case 2:
                case 3:
                case 4:
                {
                    _loc_2 = 1;
                    break;
                }
                case 5:
                case 6:
                case 7:
                {
                    _loc_2 = 2;
                    break;
                }
                case 8:
                case 9:
                case 10:
                {
                    _loc_2 = 3;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_2;
        }// end function

        private function getpercent(param1:int, param2:int) : int
        {
            var _loc_3:* = 0;
            var _loc_4:* = this.getquality(param1);
            switch(param1)
            {
                case 1:
                {
                    _loc_3 = 70 - param2 * 5;
                    break;
                }
                case 2:
                {
                    _loc_3 = 75 - param2 * 5;
                    break;
                }
                case 3:
                {
                    _loc_3 = 80 - param2 * 5;
                    break;
                }
                case 4:
                {
                    _loc_3 = 85 - param2 * 5;
                    break;
                }
                case 5:
                {
                    _loc_3 = 90 - param2 * 5;
                    break;
                }
                case 6:
                {
                    _loc_3 = 95 - param2 * 5;
                    break;
                }
                case 7:
                {
                    _loc_3 = 100 - param2 * 5;
                    break;
                }
                case 8:
                {
                    _loc_3 = 105 - param2 * 5;
                    if (_loc_3 > 100)
                    {
                        _loc_3 = 100;
                    }
                    break;
                }
                case 9:
                {
                    _loc_3 = 110 - param2 * 5;
                    if (_loc_3 > 100)
                    {
                        _loc_3 = 100;
                    }
                    break;
                }
                case 10:
                {
                    _loc_3 = 115 - param2 * 5;
                    if (_loc_3 > 100)
                    {
                        _loc_3 = 100;
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_3;
        }// end function

        private function handleSlotOver(param1)
        {
            var _loc_3:* = null;
            var _loc_2:* = param1.currentTarget.parent;
            if (_loc_2.item != null)
            {
                _loc_3 = localToGlobal(new Point(_loc_2.x, _loc_2.y));
                Holder.showInfo(_loc_2.item.outputInfo(), new Rectangle(_loc_3.x, _loc_3.y, _loc_2._size, _loc_2._size));
                if (int(_loc_2.item._itemData.suitID) > 0)
                {
                    _loc_3 = _loc_2.parent.localToGlobal(new Point(_loc_2.x, _loc_2.y));
                    Holder.showRightInfo(_loc_2.item.outfitInfo(1), new Rectangle(_loc_3.x, _loc_3.y, _loc_2._size, _loc_2._size));
                }
            }
            return;
        }// end function

        private function handleSlotOver2(param1)
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_2:* = param1.currentTarget;
            if (_loc_2.item != null)
            {
                _loc_3 = localToGlobal(new Point(_loc_2.x, _loc_2.y));
                Holder.showInfo(_loc_2.item.outputInfo(), new Rectangle(_loc_3.x, _loc_3.y, _loc_2._size, _loc_2._size));
                if (int(_loc_2.item._itemData.suitID) > 0 && int(_loc_2.item._itemData.type) != 18)
                {
                    _loc_3 = _loc_2.parent.localToGlobal(new Point(_loc_2.x, _loc_2.y));
                    Holder.showRightInfo(_loc_2.item.outfitInfo(1), new Rectangle(_loc_3.x, _loc_3.y, _loc_2._size, _loc_2._size));
                }
            }
            else if (Config._formula[this.treesid].their != 0)
            {
                _loc_4 = "";
                _loc_5 = "";
                _loc_6 = Style.FONT_0_White;
                switch(int(Config._formula[this.treesid].remouldLevel))
                {
                    case 1:
                    {
                        _loc_6 = Style.FONT_0_White;
                        break;
                    }
                    case 2:
                    {
                        _loc_5 = " D";
                        _loc_6 = Style.FONT_1_Blue;
                        break;
                    }
                    case 3:
                    {
                        _loc_5 = " C";
                        _loc_6 = Style.FONT_2_Purple;
                        break;
                    }
                    case 4:
                    {
                        _loc_5 = " B";
                        _loc_6 = Style.FONT_3_Orange;
                        break;
                    }
                    case 5:
                    {
                        _loc_5 = " A";
                        _loc_6 = Style.FONT_4_Gold;
                        break;
                    }
                    case 6:
                    {
                        _loc_5 = Config.language("ProducePanel", 41);
                        _loc_6 = Style.FONT_5_Green;
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                if (Config._formula[this.treesid].spItem == 0)
                {
                    _loc_4 = Config.language("ProducePanel", 42) + "<font color=\'" + _loc_6 + "\'>" + Config._formula[Config._formula[this.treesid].their].name + _loc_5 + "</font>";
                    _loc_7 = this.getColor(int(Config._itemMap[Config._formula[this.treesid].outmater].nameColor));
                    _loc_4 = _loc_4 + Config.language("ProducePanel", 76);
                }
                else
                {
                    _loc_4 = Config.language("ProducePanel", 44) + "<font color=\'" + _loc_6 + "\'>" + Config._formula[Config._formula[this.treesid].their].name + "</font>";
                }
                _loc_3 = localToGlobal(new Point(_loc_2.x, _loc_2.y));
                Holder.showInfo(_loc_4, new Rectangle(_loc_3.x, _loc_3.y, _loc_2._size, _loc_2._size));
            }
            return;
        }// end function

        private function handleSlotOver3(param1)
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_2:* = param1.currentTarget;
            if (_loc_2.item != null)
            {
                _loc_3 = localToGlobal(new Point(_loc_2.x, _loc_2.y));
                Holder.showInfo(_loc_2.item.outputInfo(), new Rectangle(_loc_3.x, _loc_3.y, _loc_2._size, _loc_2._size));
            }
            else if (Config._formula[this.treesid].their != 0)
            {
                _loc_4 = "";
                _loc_5 = this.getColor(int(Config._itemMap[Config._formula[this.treesid].materialid6].nameColor));
                _loc_4 = Config.language("ProducePanel", 42) + "<font color=\'" + _loc_5 + "\'>" + Config._itemMap[Config._formula[this.treesid].materialid6].name + "</font>";
                _loc_3 = localToGlobal(new Point(_loc_2.x, _loc_2.y));
                Holder.showInfo(_loc_4, new Rectangle(_loc_3.x, _loc_3.y, _loc_2._size, _loc_2._size));
            }
            return;
        }// end function

        private function handleSlotOut(param1)
        {
            Holder.closeInfo();
            return;
        }// end function

        public function stoploops() : void
        {
            Config.stopLoop(this.startloops);
            if (this.madebar.parent != null)
            {
                this.removeChild(this.madebar);
            }
            this.loopflag = false;
            this.madebar.value = 0;
            if (this.topbtn.selectpage == 0)
            {
                if (this.rememberid != -1)
                {
                    if (int(Config._formula[this.rememberid].mainmater) != 0)
                    {
                        this.madebtn.label = Config.language("ProducePanel", 32);
                    }
                    else
                    {
                        this.madebtn.label = Config.language("ProducePanel", 26);
                    }
                }
                else
                {
                    this.madebtn.label = Config.language("ProducePanel", 26);
                }
            }
            else if (this.topbtn.selectpage == 1)
            {
                this.madebtn.label = Config.language("ProducePanel", 45);
            }
            else if (this.topbtn.selectpage == 2)
            {
                this.madebtn.label = Config.language("ProducePanel", 38);
            }
            else if (this.topbtn.selectpage == 3)
            {
                this.madebtn.label = Config.language("ProducePanel", 39);
            }
            return;
        }// end function

        private function sendpd(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            if (Config.ui._bagUI.bagfull())
            {
                if (this.treesid != -1)
                {
                    _loc_2 = Config.ui._charUI.getOneItemSlot(int(Config._formula[this.treesid].outmater));
                    if (_loc_2 == null)
                    {
                        AlertUI.alert(Config.language("ProducePanel", 46), Config.language("ProducePanel", 47), [Config.language("ProducePanel", 48)]);
                        return;
                    }
                    if (_loc_2.item.amount == _loc_2.item._itemData.maxSum)
                    {
                        AlertUI.alert(Config.language("ProducePanel", 46), Config.language("ProducePanel", 47), [Config.language("ProducePanel", 48)]);
                        return;
                    }
                }
            }
            if (this.treesid != -1)
            {
                if (this.pdobj["level" + int((this.topbtn.selectpage + 1))] < Config._formula[this.treesid].pdlevel)
                {
                    Config.message(Config.language("ProducePanel", 49));
                    return;
                }
            }
            if (this.loopflag)
            {
                this.stoploops();
            }
            else if (this.treesid != -1)
            {
                if (this.countnum() > 0 || this.madecheck())
                {
                    if (Config.player.money4 < int(Config._formula[this.treesid].money))
                    {
                        Config.message(Config.language("ProducePanel", 50));
                        AlertUI.alert(Config.language("ProducePanel", 46), Config.language("ProducePanel", 79), [Config.language("ProducePanel", 80), Config.language("ProducePanel", 81)], [this.openshopui]);
                        return;
                    }
                    if (int(Config._formula[this.treesid].mainmater) != 0)
                    {
                        if (this._slotArray[0].item == null)
                        {
                            Config.message(Config.language("ProducePanel", 51));
                        }
                        else
                        {
                            this.looptime = 1;
                            this.looptemp = this._slotArray[0].item._position;
                            Config.startLoop(this.startloops);
                        }
                    }
                    else if (this.pdnum.value > 0)
                    {
                        this.looptime = this.pdnum.value;
                        this.looptemp = 0;
                        this.looptemp2 = 0;
                        Config.startLoop(this.startloops);
                    }
                }
                else
                {
                    Config.message(Config.language("ProducePanel", 53));
                }
            }
            else
            {
                Config.message(Config.language("ProducePanel", 54));
            }
            return;
        }// end function

        private function openshopui(param1)
        {
            Config.ui._shopmail.openListPanel(3);
            Config.ui._shopmail.itemcontain.verticalScrollPosition = 85;
            return;
        }// end function

        private function madecheck() : Boolean
        {
            var _loc_1:* = false;
            if (this._slotArray[0].item != null)
            {
                if (int(this._slotArray[0].item._itemData.id) == int(Config._formula[this.treesid].outmater))
                {
                    _loc_1 = true;
                }
            }
            _loc_1 = false;
            return _loc_1;
        }// end function

        private function startloops(param1) : void
        {
            this.madebtn.label = Config.language("ProducePanel", 55);
            this.loopflag = true;
            if (this.madebar.parent == null)
            {
                this.addChild(this.madebar);
            }
            if (this.madebar.value < 100)
            {
                this.madebar.value = this.madebar.value + 4;
            }
            else
            {
                this.madebar.value = 0;
                this.loopokfuc();
                var _loc_2:* = this;
                var _loc_3:* = this.looptime - 1;
                _loc_2.looptime = _loc_3;
                if (this.looptime <= 0 || Config.ui._bagUI.bagfull() && Config.ui._charUI.getOneItemSlot(int(Config._formula[this.treesid].outmater)) == null)
                {
                    if (Config.ui._bagUI.bagfull() && Config.ui._charUI.getOneItemSlot(int(Config._formula[this.treesid].outmater)) == null)
                    {
                        AlertUI.alert(Config.language("ProducePanel", 46), Config.language("ProducePanel", 47), [Config.language("ProducePanel", 48)]);
                    }
                    Config.stopLoop(this.startloops);
                    this.removeChild(this.madebar);
                    this.loopflag = false;
                    if (this.rememberid != -1)
                    {
                        if (int(Config._formula[this.rememberid].mainmater) != 0)
                        {
                            this.madebtn.label = Config.language("ProducePanel", 32);
                        }
                        else
                        {
                            this.madebtn.label = Config.language("ProducePanel", 26);
                        }
                    }
                    else
                    {
                        this.madebtn.label = Config.language("ProducePanel", 45);
                    }
                }
            }
            return;
        }// end function

        private function loopokfuc() : void
        {
            var _loc_1:* = new DataSet();
            if (this.topbtn.selectpage == 4 || this.topbtn.selectpage == 5)
            {
                _loc_1.addHead(CONST_ENUM.C2G_IMPROVE_ITEM);
                _loc_1.add32(this.treesid);
                _loc_1.add16(this.looptemp);
            }
            else
            {
                _loc_1.addHead(CONST_ENUM.CMSG_PRODUCE_ITEM);
                _loc_1.add32(this.treesid);
                _loc_1.add16(this.looptemp);
                _loc_1.add8(0);
            }
            ClientSocket.send(_loc_1);
            return;
        }// end function

        private function getposition(param1:int) : int
        {
            var _loc_4:* = null;
            var _loc_2:* = -1;
            var _loc_3:* = 0;
            while (_loc_3 < Config.ui._charUI._itemArray.length)
            {
                
                _loc_4 = Config.ui._charUI._itemArray[_loc_3];
                if (_loc_4 != null)
                {
                    if (_loc_4._itemData.baseID == param1)
                    {
                        _loc_2 = _loc_4._position;
                        break;
                    }
                }
                _loc_3 = _loc_3 + 1;
            }
            return _loc_2;
        }// end function

        private function countnum() : int
        {
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_1:* = 0;
            var _loc_2:* = new Array();
            var _loc_3:* = 1;
            while (_loc_3 < (this._slotArray.length - 1))
            {
                
                if (this._slotArray[_loc_3].item != null)
                {
                    _loc_4 = this._slotArray[_loc_3].item.numstr;
                    _loc_2.push(int(_loc_4.split("/")[0] / _loc_4.split("/")[1]));
                }
                _loc_3 = _loc_3 + 1;
            }
            if (_loc_2.length > 1)
            {
                _loc_1 = _loc_2[0];
                _loc_5 = 0;
                while (_loc_5 < (_loc_2.length - 1))
                {
                    
                    _loc_1 = Math.min(_loc_1, _loc_2[(_loc_5 + 1)]);
                    _loc_5 = _loc_5 + 1;
                }
            }
            else
            {
                _loc_1 = _loc_2[0];
            }
            return _loc_1;
        }// end function

        private function slotOver(event:AdvanceTreeeEvent) : void
        {
            var _loc_2:* = Item.newItem(Config._itemMap[int(Config._formula[event.id].outmater)], 0, 0, UNIT_TYPE_ENUM.TYPEID_ITEMCLONE, 0);
            if (_loc_2 != null)
            {
                Holder.showInfo(_loc_2.outputInfo(), new Rectangle(Config.stage.mouseX + 60, Config.stage.mouseY, 60, 10));
            }
            return;
        }// end function

        private function expinfo(event:SocketEvent) : void
        {
            var _loc_2:* = false;
            this.pdobj = new Object();
            var _loc_3:* = event.data;
            var _loc_4:* = _loc_3.readByte();
            var _loc_5:* = 1;
            while (_loc_5 < (_loc_4 + 1))
            {
                
                this.pdobj["level" + _loc_5] = _loc_3.readByte();
                this.pdobj["exp" + _loc_5] = _loc_3.readUnsignedInt();
                _loc_5 = _loc_5 + 1;
            }
            this.showformid(this.treesid);
            this.reshowlevel();
            return;
        }// end function

        private function reshowlevel() : void
        {
            trace(this.pdobj["level" + int((this.topbtn.selectpage + 1))]);
            switch(this.topbtn.selectpage)
            {
                case 0:
                {
                    this.ltext.text = Config.language("ProducePanel", 56) + this.levelarr[this.pdobj.level1];
                    this.expbar.maximum = this.levelexp[this.pdobj["level" + int((this.topbtn.selectpage + 1))]];
                    this.expbar.value = this.pdobj.exp1;
                    this.explb.text = this.pdobj.exp1 + "/" + this.levelexp[this.pdobj["level" + int((this.topbtn.selectpage + 1))]];
                    break;
                }
                case 1:
                {
                    this.ltext.text = Config.language("ProducePanel", 57) + this.levelarr[this.pdobj.level2];
                    this.expbar.maximum = this.levelexp[this.pdobj["level" + int((this.topbtn.selectpage + 1))]];
                    this.expbar.value = this.pdobj.exp2;
                    this.explb.text = this.pdobj.exp2 + "/" + this.levelexp[this.pdobj["level" + int((this.topbtn.selectpage + 1))]];
                    break;
                }
                case 2:
                {
                    this.ltext.text = Config.language("ProducePanel", 58) + this.levelarr[this.pdobj.level3];
                    this.expbar.maximum = this.levelexp[this.pdobj["level" + int((this.topbtn.selectpage + 1))]];
                    this.expbar.value = this.pdobj.exp3;
                    this.explb.text = this.pdobj.exp3 + "/" + this.levelexp[this.pdobj["level" + int((this.topbtn.selectpage + 1))]];
                    break;
                }
                case 3:
                {
                    this.ltext.text = Config.language("ProducePanel", 59) + this.levelarr[this.pdobj.level4];
                    this.expbar.maximum = this.levelexpdrag[this.pdobj["level" + int((this.topbtn.selectpage + 1))]];
                    this.expbar.value = this.pdobj.exp4;
                    this.explb.text = this.pdobj.exp4 + "/" + this.levelexpdrag[this.pdobj["level" + int((this.topbtn.selectpage + 1))]];
                    break;
                }
                case 4:
                {
                    this.ltext.text = Config.language("ProducePanel", 105) + this.levelarr[this.pdobj.level5];
                    this.expbar.maximum = 50000;
                    this.expbar.value = this.pdobj.exp5;
                    if (this.pdobj.exp5 >= 50000)
                    {
                        this.explb.text = this.levelexp[6];
                    }
                    else
                    {
                        this.explb.text = this.pdobj.exp5 + "/" + 50000;
                    }
                    break;
                }
                case 5:
                {
                    this.ltext.text = Config.language("ProducePanel", 106) + this.levelarr[this.pdobj.level6];
                    this.expbar.maximum = 50000;
                    this.expbar.value = this.pdobj.exp6;
                    if (this.pdobj.exp6 >= 50000)
                    {
                        this.explb.text = this.levelexp[6];
                    }
                    else
                    {
                        this.explb.text = this.pdobj.exp6 + "/" + 50000;
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (this.pdobj["level" + int((this.topbtn.selectpage + 1))] >= 6)
            {
                this.explb.text = this.levelexp[this.pdobj["level" + int((this.topbtn.selectpage + 1))]];
            }
            this.explb.x = this.expbar.x + (this.expbar.width - this.explb.width) / 2;
            return;
        }// end function

        private function lnlist(event:SocketEvent) : void
        {
            var _loc_5:* = 0;
            this.learnarr = [];
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedShort();
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = _loc_2.readUnsignedInt();
                this.learnarr.push(_loc_5);
                _loc_4 = _loc_4 + 1;
            }
            return;
        }// end function

        private function plistadd(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            this.learnarr.push(_loc_3);
            this.reshowtree();
            return;
        }// end function

        private function reshowtree(param1 = null) : void
        {
            var _loc_4:* = undefined;
            var _loc_5:* = false;
            var _loc_6:* = false;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = 0;
            var _loc_13:* = 0;
            var _loc_14:* = 0;
            if (param1 != null)
            {
                this.smflag = true;
            }
            this.itemtree.itemAllClear();
            var _loc_2:* = true;
            var _loc_3:* = Config._formula;
            for (_loc_4 in Config._formula)
            {
                
                if (int(Config._formula[_loc_4].type) == this.topbtn.selectpage)
                {
                    _loc_5 = true;
                    if (int(Config._formula[_loc_4].hide) == 1)
                    {
                        _loc_5 = false;
                    }
                    if (int(Config._formula[_loc_4].type) == 4 || int(Config._formula[_loc_4].type) == 5)
                    {
                        if (int(Config._formula[_loc_4].hide) == 0)
                        {
                            _loc_5 = false;
                            _loc_10 = Config.ui._charUI.getItemIdArr();
                            _loc_11 = [];
                            _loc_12 = 0;
                            while (_loc_12 < _loc_10.length)
                            {
                                
                                _loc_14 = 0;
                                while (_loc_14 < 5)
                                {
                                    
                                    _loc_11.push(Config._ridewingid[_loc_10[_loc_12] + ":" + _loc_14 + ":" + 99].opid);
                                    _loc_14++;
                                }
                                _loc_12++;
                            }
                            _loc_13 = 0;
                            while (_loc_13 < _loc_11.length)
                            {
                                
                                if (_loc_4 == _loc_11[_loc_13])
                                {
                                    _loc_5 = true;
                                    trace(_loc_4, Config._formula[_loc_4].name, _loc_11[_loc_13], Config._formula[_loc_4].outmater);
                                    break;
                                }
                                _loc_13++;
                            }
                        }
                    }
                    _loc_6 = true;
                    if (Config.player != null)
                    {
                        if (int(Config._formula[_loc_4].relevel) > Config.player.level)
                        {
                            _loc_6 = false;
                        }
                    }
                    _loc_7 = 1540636;
                    if (this.pdobj["level" + int((this.topbtn.selectpage + 1))] < Config._formula[_loc_4].pdlevel)
                    {
                        _loc_7 = 13834264;
                    }
                    if (int(Config._formula[_loc_4].hideitem) == 1)
                    {
                        _loc_7 = 13834264;
                    }
                    _loc_8 = 0;
                    while (_loc_8 < this.learnarr.length)
                    {
                        
                        if (int(Config._formula[_loc_4].id) == this.learnarr[_loc_8] && this.pdobj["level" + int((this.topbtn.selectpage + 1))] >= Config._formula[_loc_4].pdlevel)
                        {
                            _loc_7 = 1540636;
                            break;
                        }
                        _loc_8 = _loc_8 + 1;
                    }
                    _loc_9 = 0;
                    switch(this.jobcombox.selectedItem.data)
                    {
                        case 1:
                        {
                            _loc_9 = 1;
                            break;
                        }
                        case 2:
                        {
                            _loc_9 = 10;
                            break;
                        }
                        case 3:
                        {
                            _loc_9 = 4;
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    if (this.jobcombox.selectedItem.data > 0)
                    {
                        if (int(Config._itemMap[int(Config._formula[_loc_4].outmater)].reqJob) == _loc_9 || int(Config._itemMap[int(Config._formula[_loc_4].outmater)].reqJob) == 0)
                        {
                        }
                        else
                        {
                            _loc_5 = false;
                        }
                    }
                    if (this.levelcombox.selectedItem.data > 0)
                    {
                        if (this.levelcombox.selectedItem.data < 9)
                        {
                            if (int(Config._itemMap[int(Config._formula[_loc_4].outmater)].reqLevel) < this.levelcombox.selectedItem.data * 10 || int(Config._itemMap[int(Config._formula[_loc_4].outmater)].reqLevel) > this.levelcombox.selectedItem.data * 10 + 9)
                            {
                                _loc_5 = false;
                            }
                        }
                        else if (int(Config._itemMap[int(Config._formula[_loc_4].outmater)].reqLevel) < (this.levelcombox.selectedItem.data - 9) * 5 + 90 || int(Config._itemMap[int(Config._formula[_loc_4].outmater)].reqLevel) > (this.levelcombox.selectedItem.data - 9) * 5 + 90 + 4)
                        {
                            _loc_5 = false;
                        }
                    }
                    if (_loc_5)
                    {
                        this.itemtree.adddata(Config._formula[_loc_4], Config._formula[_loc_4].id, int(Config._formula[_loc_4].their), int(Config._formula[_loc_4].layer), [{str:Config._formula[_loc_4].name, len:160}, {str:this.levelarr[Config._formula[_loc_4].pdlevel], len:40}], false, _loc_6, _loc_7, int(Config._itemMap[int(Config._formula[_loc_4].outmater)].reqLevel), Config._formula[_loc_4].pdlevel);
                        if (_loc_2)
                        {
                            _loc_2 = false;
                            this.treesid = Config._formula[_loc_4].id;
                            continue;
                        }
                        this.treesid = Math.min(this.treesid, Config._formula[_loc_4].id);
                    }
                }
            }
            this.itemtree.sortTree = true;
            this.itemtree.showTree();
            if (!_loc_2)
            {
                this.itemtree.selectid(this.treesid);
                this.showformid(this.treesid);
                if (this.smflag)
                {
                    this.rememberid = this.treesid;
                    this.smflag = false;
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

        private function clickSlot(param1:CloneSlot = null)
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            if (param1 == null)
            {
                param1 = this._slotArray[0];
            }
            if (Holder.item == null)
            {
                if (param1.item != null)
                {
                    _loc_3 = param1.item._drawer[param1.item._position];
                    _loc_3.unlock();
                    Config.ui._charUI.addproductbitmap(param1.item._position);
                    param1.item = null;
                    this.itemlock(false);
                    this.changePut(this.treesid);
                    this.closeWpanel();
                    this.washflag = 0;
                }
            }
            else if (Holder.item._drawer == Config.ui._charUI._slotArray)
            {
                trace(this.treesid, Holder.item._itemData.qual, Config._formula[this.treesid].remouldLevel, Holder.item._itemData.produceId, Config._formula[this.treesid].mainmater);
                if (int(Holder.item._itemData.qual) >= int((Config._formula[this.treesid].remouldLevel - 1)) && int(Holder.item._itemData.produceId) == int(Config._formula[this.treesid].mainmater))
                {
                    if (this.topbtn.selectpage == 4 || this.topbtn.selectpage == 5)
                    {
                        _loc_4 = 98;
                        if (int(Holder.item._itemData.qual) == int((Config._formula[this.treesid].remouldLevel - 1)))
                        {
                            _loc_4 = 99;
                        }
                        this.treesid = Config._ridewingid[Holder.item._itemData.baseID + ":" + Config._formula[this.treesid].remouldLevel + ":" + _loc_4].listid;
                        _loc_5 = 1;
                        while (_loc_5 < 6)
                        {
                            
                            if (int(Config._formula[this.treesid]["materialid" + _loc_5]) != 0)
                            {
                                _loc_6 = Item.newItem(Config._itemMap[int(Config._formula[this.treesid]["materialid" + _loc_5])], 0, 0, UNIT_TYPE_ENUM.TYPEID_ITEMCLONE, 0);
                                _loc_6.display();
                                _loc_7 = Config.ui._charUI.getItemAmountBag(int(Config._formula[this.treesid]["materialid" + _loc_5]));
                                _loc_8 = int(Config._formula[this.treesid]["materialnum" + _loc_5]);
                                _loc_6.numstr = _loc_7 + "/" + _loc_8;
                                if (_loc_7 >= _loc_8)
                                {
                                    _loc_6.numstrcolor = 2092116;
                                }
                                else
                                {
                                    _loc_6.numstrcolor = 16777215;
                                }
                                this._slotArray[_loc_5].item = _loc_6;
                            }
                            else if (this._slotArray[_loc_5].item != null)
                            {
                                if (_loc_5 != 0 && _loc_5 != 6)
                                {
                                    this._slotArray[_loc_5].item.destroy();
                                    this._slotArray[_loc_5].item = null;
                                }
                            }
                            _loc_5 = _loc_5 + 1;
                        }
                    }
                    if (int(Holder.item._itemData.qual) > int((Config._formula[this.treesid].remouldLevel - 1)))
                    {
                        this.itemlock();
                    }
                    else
                    {
                        this.itemlock(false);
                    }
                    if (param1.item != null)
                    {
                        _loc_3 = param1.item._drawer[param1.item._position];
                        _loc_3.unlock();
                        Config.ui._charUI.addproductbitmap(param1.item._position);
                        param1.item = null;
                    }
                    _loc_3 = Holder.item._drawer[Holder.item._position];
                    this.washflag = Holder.item._position;
                    _loc_3.lock();
                    _loc_3.item = Holder.item;
                    param1.item = Holder.item;
                    Holder.item = null;
                    this.changePut(this.treesid);
                    this.closeWpanel();
                }
                else
                {
                    Config.message(Config.language("ProducePanel", 82));
                }
            }
            this.pdOutShow();
            return;
        }// end function

        private function closeWpanel() : void
        {
            if (this.washPanel.parent != null)
            {
                this.washPanel.close();
                this.timer.stop();
                this.timer.removeEventListener(TimerEvent.TIMER, this.allwash);
            }
            if (this.pattrPanel.parent != null)
            {
                this.pattrPanel.close();
            }
            return;
        }// end function

        private function handleSlotUp2(param1)
        {
            var _loc_2:* = param1.currentTarget;
            if (Holder.item != null)
            {
                this.clickSlot2(_loc_2);
            }
            return;
        }// end function

        private function handleSlotClick2(param1)
        {
            var _loc_2:* = param1.currentTarget;
            this.clickSlot2(_loc_2);
            return;
        }// end function

        private function clickSlot2(param1:CloneSlot)
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (Holder.item == null)
            {
                if (param1.item != null)
                {
                    _loc_3 = param1.item._drawer[param1.item._position];
                    _loc_3.unlock();
                    param1.item = null;
                }
            }
            else if (Holder.item._drawer == Config.ui._charUI._slotArray)
            {
                if (int(Holder.item._itemData.skillId) == this.treesid)
                {
                    if (param1.item != null)
                    {
                        _loc_3 = param1.item._drawer[param1.item._position];
                        _loc_3.unlock();
                        param1.item = null;
                    }
                    if (Holder.item._itemData.addEffect.length > 0)
                    {
                        _loc_3 = Holder.item._drawer[Holder.item._position];
                        _loc_3.lock();
                        _loc_3.item = Holder.item;
                        param1.item = Holder.item;
                        Holder.item = null;
                    }
                    else
                    {
                        Config.message(Config.language("ProducePanel", 62));
                    }
                }
                else
                {
                    Config.message(Config.language("ProducePanel", 61) + Config._itemMap[Config._formula[this.treesid].materialid6].name);
                }
            }
            this.pdOutShow();
            return;
        }// end function

        public function refashpd() : void
        {
            if (this.treesid != -1 && this.parent != null)
            {
                this.showformid(this.treesid);
            }
            return;
        }// end function

        public function reFreshTree() : void
        {
            if (this.parent != null)
            {
                this.armmade(null, this.topbtn.selectpage);
                if (this.treesid != -1)
                {
                    this.itemtree.selectid(this.treesid);
                    this.showformid(this.treesid);
                }
            }
            return;
        }// end function

        public function getpdlevel(param1:int) : String
        {
            var _loc_2:* = "";
            if (this.pdobj["level" + int((int(Config._formula[param1].type) + 1))] >= int(Config._formula[param1].pdlevel))
            {
                _loc_2 = _loc_2 + (Config.language("ProducePanel", 63) + this.levelarr[Config._formula[param1].pdlevel]);
            }
            else
            {
                _loc_2 = _loc_2 + ("<font color=\'#ad1b2e\'>" + Config.language("ProducePanel", 63) + this.levelarr[Config._formula[param1].pdlevel] + "</font>");
            }
            return _loc_2;
        }// end function

        private function getColor(param1:int, param2:int = 0) : String
        {
            var _loc_3:* = Style.FONT_0_White;
            switch(param1)
            {
                case 0:
                {
                    _loc_3 = Style.FONT_0_White;
                    break;
                }
                case 1:
                {
                    _loc_3 = Style.FONT_1_Blue;
                    break;
                }
                case 2:
                {
                    _loc_3 = Style.FONT_2_Purple;
                    break;
                }
                case 3:
                {
                    _loc_3 = Style.FONT_3_Orange;
                    break;
                }
                case 4:
                {
                    _loc_3 = Style.FONT_4_Gold;
                    break;
                }
                case 5:
                case 6:
                {
                    if (param2 == 0)
                    {
                        _loc_3 = Style.FONT_5_Green;
                    }
                    else
                    {
                        _loc_3 = Style.FONT_S_Equip;
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_3;
        }// end function

        private function pdOutShow() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = null;
            if (this.madearr[0].item != null)
            {
                this.madearr[0].item.destroy();
                this.madearr[0].item = null;
            }
            if (this._slotArray[0].item != null)
            {
                if (int(this._slotArray[0].item._itemData.qual) >= int((Config._formula[this.treesid].remouldLevel - 1)) && int(this._slotArray[0].item._itemData.produceId) == int(Config._formula[this.treesid].mainmater))
                {
                }
                else
                {
                    _loc_1 = this._slotArray[0].item._position;
                    Config.ui._charUI.itemunlock(_loc_1);
                    this._slotArray[0].item = null;
                }
            }
            else if (this.washflag > 0)
            {
                this._slotArray[0].item = Config.ui._charUI._slotArray[this.washflag].item;
                Config.ui._charUI.itemlock(this.washflag);
                this.changePut(this.treesid);
                if (this.washPanel.parent != null)
                {
                    this.setWash();
                }
            }
            if (this._slotArray[6].item != null)
            {
                if (int(this._slotArray[6].item._itemData.skillId) != this.treesid)
                {
                    _loc_1 = this._slotArray[6].item._position;
                    Config.ui._charUI.itemunlock(_loc_1);
                    this._slotArray[6].item = null;
                }
            }
            if (this._slotArray[6].item != null && this._slotArray[0].item != null)
            {
                _loc_2 = Item.newItem(Config._itemMap[int(Config._formula[this.treesid].outmater)], 0, 0, UNIT_TYPE_ENUM.TYPEID_ITEMCLONE, 0);
                _loc_2._itemData.washgrade = this._slotArray[0].item._itemData.washgrade;
                _loc_2._itemData.washtime = this._slotArray[0].item._itemData.washtime;
                _loc_2._itemData.finegrade = this._slotArray[0].item._itemData.finegrade;
                _loc_2._itemData.timeout = this._slotArray[0].item._itemData.timeout;
                _loc_2._itemData.gem = this._slotArray[0].item._itemData.gem;
                _loc_2._itemData.suitID = this._slotArray[6].item._itemData.suitID;
                _loc_2._itemData.addEffect = this._slotArray[6].item._itemData.addEffect;
                _loc_2._itemData.effectId1 = this._slotArray[6].item._itemData.effectId1;
                _loc_2._itemData.effectValue1 = this._slotArray[6].item._itemData.effectValue1;
                _loc_2._itemData.effectId2 = this._slotArray[6].item._itemData.effectId2;
                _loc_2._itemData.effectValue2 = this._slotArray[6].item._itemData.effectValue2;
                _loc_2.display();
                this.madearr[0].item = _loc_2;
                if (int(this._slotArray[0].item._itemData.id) == int(Config._formula[this.treesid].outmater))
                {
                    this.itemlock();
                }
            }
            return;
        }// end function

        private function itemlock(param1:Boolean = true) : void
        {
            if (param1)
            {
                this.madebtn.enabled = true;
            }
            else if (this.treesid != -1)
            {
                if (this.pdobj["level" + int((this.topbtn.selectpage + 1))] >= Config._formula[this.treesid].pdlevel + 3)
                {
                    this.addexp.text = Config.language("ProducePanel", 27) + "0";
                }
                else
                {
                    this.addexp.text = Config.language("ProducePanel", 27) + Config._formula[this.treesid].exp;
                }
            }
            return;
        }// end function

        private function addfuc(event:TextEvent, param2:int) : void
        {
            if (param2 == 1)
            {
                Config.ui._bagUI.open();
                Config.ui._bagUI.selectPage(null, 1);
            }
            else if (param2 == 2)
            {
                Config.ui._charUI.open();
            }
            return;
        }// end function

        private function expChange(event:Event) : void
        {
            var _loc_2:* = 1;
            if (this.pdnum.value == 0)
            {
                _loc_2 = 1;
            }
            else
            {
                _loc_2 = this.pdnum.value;
            }
            this.addexp.text = Config.language("ProducePanel", 27) + this.addexpflag * _loc_2;
            this.needmoney.text = Config.language("ProducePanel", 28) + this.needmoneyflag * _loc_2;
            return;
        }// end function

        private function expChange2(event:Event) : void
        {
            var _loc_2:* = 1;
            if (this.pnumber.value == 0)
            {
                _loc_2 = 1;
            }
            else
            {
                _loc_2 = this.pnumber.value;
            }
            this.wt4.text = Config.language("ProducePanel", 27) + this.addexpflag * _loc_2;
            this.wt5.text = Config.language("ProducePanel", 28) + this.needmoneyflag * _loc_2;
            return;
        }// end function

        private function initPattrPanel() : void
        {
            var _loc_2:* = new Window(Config.ui._layer1);
            this.pattrPanel = new Window(Config.ui._layer1);
            Config.ui._windowStack.push(_loc_2);
            this.pattrPanel.title = Config.language("ProducePanel", 83);
            this.pattrPanel.resize(400, 350);
            this.menubar = new ButtonBar(this.pattrPanel, 15, 25, 390);
            this.menubar.addTab(Config.language("ProducePanel", 84), Config.create(this.changePattr, 0), 80);
            this.menubar.addTab(Config.language("ProducePanel", 85), Config.create(this.changePattr, 1), 80);
            this.pattrsp = new Sprite();
            this.pattrPanel.addChild(this.pattrsp);
            var _loc_1:* = new PushButton(this.pattrPanel, 160, 310, Config.language("ProducePanel", 86), this.closePattr);
            return;
        }// end function

        private function changePattr(event:MouseEvent = null, param2:int = 0) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = undefined;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            this.removeallchild(this.pattrsp);
            this.menubar.selectpage = param2;
            if (param2 == 0)
            {
                _loc_3 = new Label(this.pattrsp, 10, 60);
                _loc_3.html = true;
                _loc_3.text = Config.language("ProducePanel", 87);
                _loc_4 = [1, 2, 132, 133, 40, 128, 129, 138, 139, 134, 135, 125, 126, 127, 136, 137, 124, 11, 130, 131, 100, 101];
                _loc_5 = Config._produceAttr[this.pattrid];
                if (_loc_5 != null)
                {
                    _loc_6 = 0;
                    while (_loc_6 < _loc_4.length)
                    {
                        
                        _loc_7 = new Label(this.pattrsp, 20 + _loc_6 % 2 * 190, 80 + int(_loc_6 / 2) * 20);
                        _loc_7.text = Config._itemPropMap[_loc_4[_loc_6]].name + "  " + _loc_5["value" + int((_loc_6 + 1)) + "min"] + " - " + _loc_5["value" + int((_loc_6 + 1)) + "max"];
                        _loc_6 = _loc_6 + 1;
                    }
                }
            }
            else
            {
                _loc_3 = new Label(this.pattrsp, 10, 70, Config.language("ProducePanel", 88));
                _loc_8 = new Label(this.pattrsp, 10, 100, Config.language("ProducePanel", 89));
                _loc_9 = new Label(this.pattrsp, 10, 130, Config.language("ProducePanel", 90));
                _loc_10 = new Label(this.pattrsp, 10, 160, Config.language("ProducePanel", 91));
                _loc_11 = new Label(this.pattrsp, 10, 190, Config.language("ProducePanel", 112));
                _loc_10.html = true;
            }
            return;
        }// end function

        private function closePattr(event:MouseEvent) : void
        {
            this.pattrPanel.close();
            return;
        }// end function

        private function openWash(event:MouseEvent) : void
        {
            this.washPanel.x = this.x + 130;
            this.washPanel.y = this.y + 100;
            this.washPanel.switchOpen();
            if (this.stopbtn.parent != null)
            {
                this.washPanel.removeChild(this.stopbtn);
            }
            if (this.topbtn.selectpage == 4 || this.topbtn.selectpage == 5)
            {
                this.wt2.text = "";
                if (this.washPanel.parent != null)
                {
                    this.wt6.text = Config.language("ProducePanel", 108);
                    this.wt7.text = Config.language("ProducePanel", 109);
                    this.wt3.visible = false;
                    this.s3.visible = false;
                    this.s4.visible = false;
                    if (this.pnumber.parent == null)
                    {
                        this.washPanel.addChild(this.pnumber);
                    }
                    this.pnumber.value = 1;
                    this.timer.addEventListener(TimerEvent.TIMER, this.allwash);
                    if (this.stopbtn.parent == null)
                    {
                        this.washPanel.addChild(this.stopbtn);
                    }
                }
                else
                {
                    this.timer.stop();
                    this.timer.removeEventListener(TimerEvent.TIMER, this.allwash);
                }
            }
            else if (this.washPanel.parent != null)
            {
                this.wt3.visible = true;
                this.s3.visible = true;
                this.s4.visible = true;
                this.wt6.text = "";
                this.wt7.text = "";
                if (this.pnumber.parent != null)
                {
                    this.washPanel.removeChild(this.pnumber);
                }
            }
            this.pattrid = this._slotArray[0].item._itemData.quality2 * 10 + int(Config._formula[this.treesid].remouldLevel);
            this.setWash();
            this.wt3.selected = false;
            this.changeWT3();
            return;
        }// end function

        private function initWashPanel() : void
        {
            var _loc_4:* = null;
            var _loc_5:* = new Window(Config.ui._layer1);
            this.washPanel = new Window(Config.ui._layer1);
            Config.ui._windowStack.push(_loc_5);
            this.washPanel.title = Config.language("ProducePanel", 92);
            this.washPanel.resize(300, 270);
            var _loc_1:* = new Shape();
            this.washPanel.addChild(_loc_1);
            _loc_1.graphics.beginFill(16777215, 0.4);
            _loc_1.graphics.drawRect(5, 30, 290, 50);
            _loc_1.graphics.drawRect(5, 90, 290, 110);
            _loc_1.graphics.endFill();
            this.wt1 = new Label(this.washPanel, 10, 35);
            this.wt1.html = true;
            this.wt2 = new Label(this.washPanel, 150, 35);
            this.wt2.html = true;
            this.wt3 = new CheckBox(this.washPanel, 10, 65, Config.language("ProducePanel", 93));
            this.wt3.addEventListener(MouseEvent.CLICK, this.changeWT3);
            var _loc_2:* = new Label(this.washPanel, 10, 95, Config.language("ProducePanel", 94));
            this.wts2 = new Label(this.washPanel, 230, 95, Config.language("ProducePanel", 95));
            this.washarr = new Array();
            var _loc_3:* = 0;
            while (_loc_3 < 6)
            {
                
                _loc_4 = new CloneSlot(0, 32);
                _loc_4.iconsp.removeEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver4);
                _loc_4.iconsp.removeEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
                _loc_4.iconsp.addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver4);
                _loc_4.iconsp.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
                this.washPanel.addChild(_loc_4);
                if (_loc_3 < 5)
                {
                    _loc_4.x = 10 + 40 * _loc_3;
                    _loc_4.nameshow = true;
                }
                else
                {
                    _loc_4.x = 10 + 40 * _loc_3 + 30;
                }
                _loc_4.y = 120;
                this.washarr.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            this.wt4 = new Label(this.washPanel, 130, 180);
            this.wt5 = new Label(this.washPanel, 10, 180);
            this.btn = new PushButton(this.washPanel, 130, 210, Config.language("ProducePanel", 92), this.sendWash);
            this.btn.width = 60;
            this.stopbtn = new PushButton(null, 220, 210, Config.language("ProducePanel", 55), this.setstopflag);
            this.stopbtn.width = 60;
            this.s3 = new Label(this.washPanel, 10, 240, Config.language("ProducePanel", 96));
            this.s4 = new ClickLabel(this.washPanel, 230, 240, Config.language("ProducePanel", 97), this.pattr2, true);
            this.s4.clickColor([39423, 16544]);
            Config.ui._charUI.addEventListener("itemchange", this.reWash);
            this.pnumber = new NumericStepper(null, 218, 120);
            this.pnumber.maxVisible = false;
            this.pnumber.width = 100;
            this.pnumber.percent = false;
            this.pnumber.minimum = 1;
            this.pnumber.maximum = 999;
            this.pnumber.addEventListener(Event.CHANGE, this.expChange2);
            this.wt6 = new Label(this.washPanel, 218, 95);
            this.wt7 = new Label(this.washPanel, 218, 150);
            this.wt7.html = true;
            this.timer = new Timer(600);
            return;
        }// end function

        private function pattr2(event:TextEvent) : void
        {
            this.pattrid = this._slotArray[0].item._itemData.quality2 * 10 + int(Config._formula[this.treesid].remouldLevel);
            this.changePattr(null, 1);
            this.pattrPanel.open();
            return;
        }// end function

        private function handleSlotOver4(param1)
        {
            var _loc_3:* = null;
            var _loc_2:* = param1.currentTarget.parent;
            if (_loc_2.item != null)
            {
                _loc_3 = _loc_2.parent.localToGlobal(new Point(_loc_2.x, _loc_2.y));
                Holder.showInfo(_loc_2.item.outputInfo(), new Rectangle(_loc_3.x, _loc_3.y, _loc_2._size, _loc_2._size));
                if (int(_loc_2.item._itemData.suitID) > 0)
                {
                    _loc_3 = _loc_2.parent.localToGlobal(new Point(_loc_2.x, _loc_2.y));
                    Holder.showRightInfo(_loc_2.item.outfitInfo(1), new Rectangle(_loc_3.x, _loc_3.y, _loc_2._size, _loc_2._size));
                }
            }
            return;
        }// end function

        private function reWash(event:Event = null) : void
        {
            if (this.washPanel.parent != null)
            {
                this.setWash();
            }
            return;
        }// end function

        private function setWash() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = undefined;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = undefined;
            var _loc_11:* = undefined;
            var _loc_12:* = NaN;
            var _loc_13:* = null;
            var _loc_14:* = NaN;
            if (this._slotArray[0].item != null)
            {
                _loc_1 = [" ", "D", "C", "B", "A", "S", "S2"];
                _loc_2 = Style.FONT_Blue;
                if (this.washmax.id == this._slotArray[0].item._itemData.addEffect[(Config._formula[this.treesid].remouldLevel - 1)].id)
                {
                    if (this.washmax.value > this._slotArray[0].item._itemData.addEffect[(Config._formula[this.treesid].remouldLevel - 1)].value)
                    {
                        _loc_2 = Style.FONT_Red;
                    }
                    else
                    {
                        _loc_2 = Style.FONT_Green;
                    }
                }
                if (Config._formula[this.treesid].remouldLevel == 6 && int(this._slotArray[0].item._itemData.qual) >= int((Config._formula[this.treesid].remouldLevel - 1)))
                {
                    this.washPanel.title = Config.language("ProducePanel", 114);
                    this.btn.label = Config.language("ProducePanel", 114);
                    if (int(this._slotArray[0].item._itemData.addEffect[5].value) >= 30)
                    {
                        this.wt1.text = "<font color=\'#00aeff\'>" + Config.language("ProducePanel", 116) + "</font>";
                    }
                    else
                    {
                        _loc_10 = Config._bIAttribute[this._slotArray[0].item._itemData.quality2 * 1000 + this._slotArray[0].item._itemData.subType * 10 + this._slotArray[0].item._itemData.qual];
                        _loc_11 = Config._bIAttribute[this._slotArray[0].item._itemData.quality2 * 1000 + this._slotArray[0].item._itemData.subType * 10 + 5];
                        trace(this._slotArray[0].item._itemData.qual);
                        _loc_13 = "";
                        if (int(_loc_11.atk) != 0 || int(_loc_11.atkRanged) != 0 || int(_loc_11.atkMagic) != 0)
                        {
                            _loc_13 = Config.language("ProducePanel", 65);
                            _loc_12 = Math.max(_loc_11.atk, _loc_11.atkRanged, _loc_11.atkMagic);
                        }
                        if (int(_loc_11.def) != 0 || int(_loc_11.defRanged) != 0 || int(_loc_11.defMagic) != 0)
                        {
                            _loc_13 = Config.language("ProducePanel", 66);
                            _loc_12 = Math.max(_loc_11.def, _loc_11.defRanged, _loc_11.defMagic);
                        }
                        _loc_14 = _loc_10.effectValue1 + int(this._slotArray[0].item._itemData.addEffect[5].value) * int(Config._produceAttr[this._slotArray[0].item._itemData.quality2 * 10 + 6].value3min);
                        this.wt1.text = _loc_13 + int((int(this._slotArray[0].item._itemData.addEffect[5].value) * int(Config._produceAttr[this._slotArray[0].item._itemData.quality2 * 10 + 6].value2max) / 100 + 1) * _loc_12) + "  <b><font size=\'14\' color=\'#666666\'>" + "»" + "</font></b>  <font size=\'12\' color=\'#00aeff\'>" + int((int((this._slotArray[0].item._itemData.addEffect[5].value + 1)) * int(Config._produceAttr[this._slotArray[0].item._itemData.quality2 * 10 + 6].value2max) / 100 + 1) * _loc_12) + "</font>                " + Config._itemPropMap[_loc_10.effectId1].name + "  " + _loc_14 + "  <b><font size=\'14\' color=\'#666666\'>" + "»" + "</font></b>  <font size=\'12\' color=\'#00aeff\'>" + (int((this._slotArray[0].item._itemData.addEffect[5].value + 1)) * int(Config._produceAttr[this._slotArray[0].item._itemData.quality2 * 10 + 6].value3min) + _loc_10.effectValue1) + "</font>" + "\n" + Config.language("ProducePanel", 115) + int(this._slotArray[0].item._itemData.addEffect[5].value) + "%  <b><font size=\'14\' color=\'#666666\'>" + "»" + "</font></b>  <font size=\'12\' color=\'#00aeff\'>" + (int(this._slotArray[0].item._itemData.addEffect[5].value) + int(Config._produceAttr[this._slotArray[0].item._itemData.quality2 * 10 + 6].value2min)) + "%</font>";
                    }
                    this.s3.text = Config.language("ProducePanel", 117);
                    this.wt2.text = "";
                    this.wt3.visible = false;
                }
                else
                {
                    this.washPanel.title = Config.language("ProducePanel", 92);
                    this.btn.label = Config.language("ProducePanel", 92);
                    this.s3.text = Config.language("ProducePanel", 96);
                    this.wt1.text = "<font size=\'12\' color=\'#00aeff\'>" + "[" + _loc_1[Config._formula[this.treesid].remouldLevel] + "]" + Config._itemPropMap[this._slotArray[0].item._itemData.addEffect[(Config._formula[this.treesid].remouldLevel - 1)].id].name + "     " + "</font>" + "<font size=\'12\' color=\'" + _loc_2 + "\'>" + this._slotArray[0].item._itemData.addEffect[(Config._formula[this.treesid].remouldLevel - 1)].value + "</font>";
                    this.wt3.visible = true;
                }
                _loc_3 = [1, 2, 132, 133, 40, 128, 129, 138, 139, 134, 135, 125, 126, 127, 136, 137, 124, 11, 130, 131, 100, 101];
                _loc_4 = Config._produceAttr[this.pattrid];
                if (_loc_4 != null)
                {
                    _loc_5 = 0;
                    while (_loc_5 < _loc_3.length)
                    {
                        
                        if (_loc_3[_loc_5] == this._slotArray[0].item._itemData.addEffect[(Config._formula[this.treesid].remouldLevel - 1)].id)
                        {
                            this.wt2.text = Config.language("ProducePanel", 98) + _loc_4["value" + int((_loc_5 + 1)) + "min"] + " - " + _loc_4["value" + int((_loc_5 + 1)) + "max"] + ")";
                            this.tvalue = this._slotArray[0].item._itemData.addEffect[(Config._formula[this.treesid].remouldLevel - 1)].value;
                            this.maxvalue = _loc_4["value" + int((_loc_5 + 1)) + "max"];
                            break;
                        }
                        _loc_5 = _loc_5 + 1;
                    }
                }
                _loc_5 = 1;
                while (_loc_5 < 6)
                {
                    
                    if (this.washarr[(_loc_5 - 1)].item != null)
                    {
                        this.washarr[(_loc_5 - 1)].item.destroy();
                        this.washarr[(_loc_5 - 1)].item = null;
                    }
                    if (int(Config._formula[this.treesid]["materialid" + _loc_5]) != 0)
                    {
                        _loc_6 = Item.newItem(Config._itemMap[int(Config._formula[this.treesid]["materialid" + _loc_5])], 0, 0, UNIT_TYPE_ENUM.TYPEID_ITEMCLONE, 0);
                        _loc_6.display();
                        _loc_7 = Config.ui._charUI.getItemAmountBag(int(Config._formula[this.treesid]["materialid" + _loc_5]));
                        _loc_8 = int(Config._formula[this.treesid]["materialnum" + _loc_5]);
                        _loc_6.numstr = _loc_7 + "/" + _loc_8;
                        if (_loc_7 >= _loc_8)
                        {
                            _loc_6.numstrcolor = 2092116;
                        }
                        else
                        {
                            _loc_6.numstrcolor = 16777215;
                        }
                        this.washarr[(_loc_5 - 1)].item = _loc_6;
                        if (this.pnumber.parent != null)
                        {
                            if (_loc_7 < 99)
                            {
                                this.pnumber.maximum = _loc_7;
                            }
                            else
                            {
                                this.pnumber.maximum = 999;
                            }
                        }
                    }
                    _loc_5 = _loc_5 + 1;
                }
                if (this.washarr[5].item != null)
                {
                    this.washarr[5].item.destroy();
                    this.washarr[5].item = null;
                }
                _loc_6 = Item.newItem(Config._itemMap[896102], 0, 0, UNIT_TYPE_ENUM.TYPEID_ITEMCLONE, 0);
                _loc_6.display();
                _loc_7 = Config.ui._charUI.getItemAmountBag(896102);
                _loc_8 = 1;
                _loc_6.numstr = _loc_7 + "/" + _loc_8;
                if (_loc_7 >= _loc_8)
                {
                    _loc_6.numstrcolor = 2092116;
                }
                else
                {
                    _loc_6.numstrcolor = 16777215;
                }
                this.washarr[5].item = _loc_6;
                _loc_9 = 1;
                if (this.pnumber.parent != null)
                {
                    _loc_9 = this.pnumber.value;
                }
                if (this.pdobj["level" + int((this.topbtn.selectpage + 1))] >= Config._formula[this.treesid].pdlevel + 3)
                {
                    this.wt4.text = Config.language("ProducePanel", 27) + "0";
                }
                else
                {
                    this.wt4.text = Config.language("ProducePanel", 27) + Number(Config._formula[this.treesid].exp) * _loc_9;
                }
                this.wt5.text = Config.language("ProducePanel", 28) + Number(Config._formula[this.treesid].money) * _loc_9;
                this.washflag = this._slotArray[0].item._position;
            }
            return;
        }// end function

        private function sendWash(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            if (this._slotArray[0].item != null)
            {
                if (this._slotArray[0].item._itemData.subType == 11 || this._slotArray[0].item._itemData.subType == 13)
                {
                    this._setstopflag = false;
                    _loc_2 = new DataSet();
                    _loc_2.addHead(CONST_ENUM.C2G_IMPROVE_ITEM);
                    _loc_2.add32(this.treesid);
                    _loc_2.add16(this._slotArray[0].item._position);
                    ClientSocket.send(_loc_2);
                }
                else
                {
                    this.washmax.id = this._slotArray[0].item._itemData.addEffect[(Config._formula[this.treesid].remouldLevel - 1)].id;
                    this.washmax.value = this._slotArray[0].item._itemData.addEffect[(Config._formula[this.treesid].remouldLevel - 1)].value;
                    if (this.wt3.selected)
                    {
                        if (this.tvalue >= this.maxvalue)
                        {
                            AlertUI.alert(Config.language("ProducePanel", 46), Config.language("ProducePanel", 78), [Config.language("ProducePanel", 100)]);
                            return;
                        }
                    }
                    _loc_2 = new DataSet();
                    _loc_2.addHead(CONST_ENUM.CMSG_PRODUCE_ITEM);
                    _loc_2.add32(this.treesid);
                    _loc_2.add16(this.washflag);
                    if (this.wt3.selected)
                    {
                        _loc_2.add8(1);
                    }
                    else
                    {
                        _loc_2.add8(0);
                    }
                    ClientSocket.send(_loc_2);
                }
            }
            return;
        }// end function

        private function changeWT3(event:MouseEvent = null) : void
        {
            if (this.wt3.selected)
            {
                this.wts2.visible = true;
                this.washarr[5].visible = true;
            }
            else
            {
                this.wts2.visible = false;
                this.washarr[5].visible = false;
            }
            return;
        }// end function

        private function backwashvalue(event:SocketEvent)
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readInt();
            var _loc_4:* = _loc_2.readInt();
            var _loc_5:* = _loc_2.readInt() - _loc_3;
            var _loc_6:* = Style.FONT_Green;
            if (this._slotArray[0].item != null)
            {
                if (this._slotArray[0].item._itemData.type == 4 && (this._slotArray[0].item._itemData.subType == 11 || this._slotArray[0].item._itemData.subType == 13))
                {
                    if (_loc_5 < 0)
                    {
                        _loc_6 = Style.FONT_Red;
                    }
                    if (this.washPanel.parent != null)
                    {
                        this.wt2.text = Config.language("ProducePanel", 107, _loc_6, _loc_5);
                        if (!this._setstopflag)
                        {
                            this.timer.start();
                        }
                    }
                }
            }
            return;
        }// end function

        private function setstopflag(event:MouseEvent) : void
        {
            this._setstopflag = true;
            this.timer.stop();
            return;
        }// end function

        private function allwash(event:TimerEvent)
        {
            var _loc_2:* = null;
            if (this.washPanel.parent == null)
            {
                this.timer.stop();
                this.timer.removeEventListener(TimerEvent.TIMER, this.allwash);
                return;
            }
            if (this.pnumber.value > 1 && this._slotArray[0].item != null)
            {
                (this.pnumber.value - 1);
                _loc_2 = new DataSet();
                _loc_2.addHead(CONST_ENUM.C2G_IMPROVE_ITEM);
                _loc_2.add32(this.treesid);
                _loc_2.add16(this._slotArray[0].item._position);
                ClientSocket.send(_loc_2);
            }
            else
            {
                this.timer.stop();
            }
            return;
        }// end function

        public function stoptimer() : void
        {
            this.timer.stop();
            return;
        }// end function

        public function openproduce(param1:Item, param2:int)
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            super.switchOpen();
            if (this.parent != null)
            {
                _loc_3 = 0;
                switch(param1._itemData.reqJob)
                {
                    case 1:
                    {
                        break;
                    }
                    case 4:
                    {
                        break;
                    }
                    case 10:
                    {
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                if (param2 == 1012)
                {
                }
                else if (param2 == 1014)
                {
                }
                else if (param2 == 1007 || param2 == 1008 || param2 == 1009 || param2 == 1027 || param2 == 1028 || param2 == 1029)
                {
                }
                else
                {
                }
                _loc_4 = int(param1._itemData.quality);
                if (_loc_4 == 0)
                {
                    _loc_4 = 1;
                }
                else if (_loc_4 >= 10)
                {
                    _loc_4 = 9;
                }
                if (param1._itemData.quality2 == 95)
                {
                    _loc_4 = 10;
                }
                this.armmade1(param1, _loc_4, _loc_3);
                Config.ui._charUI.removebitma(param2);
            }
            return;
        }// end function

        private function armmade1(param1:Item, param2:int, param3:int)
        {
            var _loc_6:* = 0;
            this.smflag = true;
            this.stoploops();
            this.removeallchild(this.mainpanel);
            if (param3 == 0)
            {
                this.levelcombox.enabled = true;
                this.levelcombox.selectedItem = this.levelcombox.itemArray[param2];
            }
            else
            {
                this.levelcombox.selectedItem = this.levelcombox.itemArray[0];
                this.levelcombox.enabled = false;
            }
            this.rememberid = -1;
            this.treesid = -1;
            this.reshowtree();
            this.reshowlevel();
            if (this.topbtn.selectpage == 0)
            {
                this.addChild(this.jobcombox);
            }
            else if (this.jobcombox.parent != null)
            {
                this.removeChild(this.jobcombox);
            }
            var _loc_4:* = int((param1._itemData.qual + 1));
            var _loc_5:* = 99;
            if (_loc_4 > 4)
            {
                _loc_4 = 4;
                if (param1._itemData.quality >= 10)
                {
                    _loc_6 = 0;
                    while (_loc_6 < this.learnarr.length)
                    {
                        
                        if (int(Config._equproduceid[param1._itemData.id + ":" + 5].id) == this.learnarr[_loc_6])
                        {
                            _loc_4 = 5;
                            break;
                        }
                        _loc_6 = _loc_6 + 1;
                    }
                }
                _loc_5 = 98;
            }
            if (param3 == 0)
            {
                this.treesid = Config._equproduceid[param1._itemData.id + ":" + _loc_4].id;
            }
            else
            {
                this.treesid = Config._ridewingid[param1._itemData.id + ":" + _loc_4 + ":" + _loc_5].opid;
            }
            this.rememberid = this.treesid;
            this.itemtree.selectid(this.treesid);
            this.showformid(this.treesid);
            if (this.smflag)
            {
                this.rememberid = this.treesid;
                this.smflag = false;
            }
            Holder.item = param1;
            this.clickSlot();
            return;
        }// end function

        private function adddrag(param1:int) : Boolean
        {
            var _loc_4:* = 0;
            this.tomadename.text = Config.language("ProducePanel", 33) + "<font color=\'#104ac1\'>" + Config._formula[param1].name + "</font>";
            var _loc_2:* = false;
            var _loc_3:* = 0;
            while (_loc_3 < this.learnarr.length)
            {
                
                if (param1 == this.learnarr[_loc_3])
                {
                    _loc_2 = true;
                    break;
                }
                _loc_3 = _loc_3 + 1;
            }
            if (!_loc_2)
            {
                this.addexp.text = "";
                this.needmoney.text = "";
                this.needlevel.text = "";
                this.alabel.text = "";
                this.blabel.text = "";
                this.clabel.text = "";
                this.flabel.text = "";
                this.overtext.visible = false;
                this.madebtn.visible = false;
                this.pdnum.visible = false;
                if (this.add1.parent != null)
                {
                    this.mainpanel.removeChild(this.add1);
                }
                if (this.add2.parent != null)
                {
                    this.mainpanel.removeChild(this.add2);
                }
                if (this.consp.parent != null)
                {
                    this.mainpanel.removeChild(this.consp);
                }
                _loc_4 = 0;
                while (_loc_4 < (this._slotArray.length - 1))
                {
                    
                    this._slotArray[_loc_4].visible = false;
                    _loc_4 = _loc_4 + 1;
                }
                if (this.madearr[0].parent != null)
                {
                    this.madearr[0].visible = false;
                }
                AlertUI.alert(Config.language("ProducePanel", 46), Config.language("ProducePanel", 110), [Config.language("ProducePanel", 48)]);
            }
            return _loc_2;
        }// end function

    }
}
