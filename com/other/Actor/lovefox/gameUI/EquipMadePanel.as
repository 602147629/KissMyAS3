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

    public class EquipMadePanel extends Window
    {
        private var topbtn:ButtonBar;
        private var mainPan:Sprite;
        private var mainpane1:Sprite;
        private var mainpane2:Sprite;
        private var mainpane3:Sprite;
        private var slotarr:Array;
        private var moneynum:Label;
        private var moneyarr:Array;
        private var tlabel0:Label;
        private var tlabel1:Label;
        private var tlabel2:Label;
        private var tlabel3:Label;
        private var tlabel4:Label;
        private var tlabel5:Label;
        private var clicklab1:ClickLabel;
        private var clicklab2:ClickLabel;
        private var checkb:CheckBox;
        private var washBar:ProgressBar;
        private var washIcon:CloneSlot;
        private var atkdef:Boolean;
        private var diflag:Boolean;
        private var tlabel02:Label;
        private var tlabel12:Label;
        private var tlabel22:Label;
        private var tlabel32:Label;
        private var washinitprop:Number;
        private var washmaxnum:Number;
        private var forewashgrade:int;
        private var npcId:int;
        public var _equipfinelucky:Number = 0;
        private var str:Object;
        private var flag:Boolean;
        private var fg1:int;
        private var fg:int;
        private var fortunately:int;
        private var finemoney:Object;
        private var washmoney:Object;
        private var flagalert:Boolean = true;
        private var washfort:int;
        private var qty:int;
        private var equitempos1:int;
        private var equitempos2:int;
        private var equitempos3:int;
        private var ifUseLock:CheckBox;
        private var pdnum:NumericStepper;
        private var fineprecent:Number = 0;
        private var moneyBmp:Bitmap;
        private var eqBmp:Bitmap;
        private var jewslotarr:Array;
        private var pos:int;
        private var vb:Number;
        private var _startFinePb:PushButton;
        private var washRb:RadioButton;
        private var fineRb:RadioButton;
        private var holeRb:RadioButton;
        private var rideFinePrecent:Number;
        private var wingFineprecent:Number;
        private var startbtn1:PushButton;
        private var startbtn2:PushButton;
        private var takeJewbtn:Array;
        private var castMoney:Array;
        private var equipposition:int;
        private var _alertIndex:int = -1;
        private var equpstoneNum:int = 0;
        private var wingstoneNum:int = 0;
        private var ridestoneNum:int = 0;
        private var wingst:int = 0;
        private var activeType:uint = 0;
        private var actName:String;
        private var straTime:String;
        private var endTime:String;
        private var actDescript1:String = "";
        private var actDescript2:String = "";
        private var closeflag1:Boolean = false;
        private var closeflag2:Boolean = false;
        private var tableStoneNum:Label;
        private var tlabel01:ClickLabel;
        private var fastBuy:ClickLabel;
        private var tlb:Label;
        private var clkl:ClickLabel;
        private var _shengXingChengGongStack:Array;
        private var _tol:Number = 0;

        public function EquipMadePanel(param1:DisplayObjectContainer)
        {
            this.str = [Config.language("EquipMadePanel", 1), Config.language("EquipMadePanel", 2), Config.language("EquipMadePanel", 3), Config.language("EquipMadePanel", 4), Config.language("EquipMadePanel", 5), Config.language("EquipMadePanel", 6)];
            this.finemoney = [1000, 10000, 60000];
            this.washmoney = [500, 5000, 10000];
            this.castMoney = [7365, 12525, 21300, 36210, 61545, 104104, 177012, 300872];
            this._shengXingChengGongStack = [];
            super(param1);
            this.initpanel();
            return;
        }// end function

        private function initpanel() : void
        {
            super.resize(250, 300);
            this.x = 200;
            this.y = 100;
            this.title = Config.language("EquipMadePanel", 7);
            this.moneyarr = [1000, 1000, 10000, 100000];
            this.topbtn = new ButtonBar(this, 15, 25, 0);
            this.topbtn.addTab(Config.language("EquipMadePanel", 17), this.equipmade);
            this.topbtn.addTab(Config.language("EquipMadePanel", 89), this.wingmade);
            this.topbtn.addTab(Config.language("EquipMadePanel", 90), this.ridemade);
            this.mainPan = new Sprite();
            this.addChild(this.mainPan);
            var _loc_1:* = new Sprite();
            _loc_1.graphics.beginFill(15915428);
            _loc_1.graphics.drawRoundRect(5, 47, 240, 25, 0);
            _loc_1.graphics.endFill();
            _loc_1.graphics.lineStyle(1, 10975316);
            _loc_1.graphics.moveTo(4, 73);
            _loc_1.graphics.lineTo(246, 73);
            this.addChild(_loc_1);
            this.washRb = new RadioButton(this, 9, 55, "", false, Config.create(this.equsortfuc, 0));
            this.fineRb = new RadioButton(this, 90, 55, "", false, Config.create(this.equsortfuc, 1));
            this.holeRb = new RadioButton(this, 160, 55, "", false, Config.create(this.equsortfuc, 2));
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_EQUIP_UPGRADE_ACTIVITY_OPEN, this.updateactive);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_EQUIP_UPGRADE_ACTIVITY_CLOSE, this.closeactive);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_EQUIP_UPGRADE_ACTIVITY_PROBABILITY, this.activeproble);
            return;
        }// end function

        override public function open(event:MouseEvent = null)
        {
            super.open();
            this.topbtn.selectpage = 0;
            this.forewashgrade = 0;
            this.equipmade();
            return;
        }// end function

        private function equsortfuc(event:MouseEvent, param2:uint)
        {
            if (this.topbtn.selectpage == 0)
            {
                if (param2 == 0)
                {
                    this.initequipfinepanel();
                }
                else if (param2 == 1)
                {
                    this.initremovefinepanel();
                }
                else if (param2 == 2)
                {
                    this.cardin();
                }
            }
            else if (this.topbtn.selectpage == 1)
            {
                if (param2 == 0)
                {
                    this.initwingfinepanel();
                }
                else if (param2 == 1)
                {
                    this.initremovefinepanel();
                }
            }
            else if (this.topbtn.selectpage == 2)
            {
                if (param2 == 0)
                {
                    this.initridefinepanel();
                }
                else if (param2 == 1)
                {
                    this.initremovefinepanel();
                }
                else if (param2 == 2)
                {
                    this.ridechangecolor();
                }
            }
            return;
        }// end function

        override public function close()
        {
            Config.ui._charUI.removeEventListener("itemchange", this.sussespercent);
            super.close();
            return;
        }// end function

        public function getnpcid(param1:int)
        {
            this.npcId = param1;
            return;
        }// end function

        private function initequipfinepanel()
        {
            var _loc_1:* = undefined;
            this.initeqfine();
            if (GuideUI.testId(66))
            {
                _loc_1 = [];
            }
            this.startbtn1 = new PushButton(this.mainPan, 140, 255, Config.language("EquipMadePanel", 16), this.sendequipfine);
            this.startbtn1.width = 80;
            this._startFinePb = this.startbtn1;
            if (_loc_1 != null)
            {
                _loc_1.push(this.slotarr[0]);
            }
            if (_loc_1 != null)
            {
                _loc_1.push(this.startbtn1);
                GuideUI.doId(66, null, _loc_1);
            }
            GuideUI.testDoId(188, this.slotarr[0]);
            return;
        }// end function

        private function initfine(param1:String)
        {
            this.removeallchild(this.mainPan);
            Config.ui._charUI.removeEventListener("itemchange", this.sussespercent);
            Config.ui._charUI.addEventListener("itemchange", this.sussespercent);
            this.slotarr = [];
            var _loc_2:* = new CloneSlot(0, 32);
            this.mainPan.addChild(_loc_2);
            _loc_2.x = 50;
            _loc_2.y = 140;
            this.slotarr.push(_loc_2);
            _loc_2.addEventListener("sglClick", this.handleSlotClick);
            _loc_2.addEventListener("up", this.handleSlotClick);
            _loc_2.addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
            _loc_2.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
            this.mainpane2 = new Sprite();
            this.mainpane2.x = 85;
            this.mainpane2.y = 140;
            this.mainPan.addChild(this.mainpane2);
            var _loc_3:* = GradientType.LINEAR;
            var _loc_4:* = [14463830, 14463830];
            var _loc_5:* = [1, 0];
            var _loc_6:* = [0, 255];
            var _loc_7:* = new Matrix();
            new Matrix().createGradientBox(100, 50, 0, 0, 0);
            var _loc_8:* = SpreadMethod.PAD;
            this.mainpane2.graphics.beginGradientFill(_loc_3, _loc_4, _loc_5, _loc_6, _loc_7, _loc_8);
            this.mainpane2.graphics.drawRect(0, 0, 100, 32);
            this.mainpane1 = new Sprite();
            this.mainpane1.graphics.beginFill(14463830);
            this.mainpane1.graphics.drawRect(20, 215, 210, 30);
            this.mainPan.addChild(this.mainpane1);
            this.mainpane3 = new Sprite();
            this.mainpane3.x = 20;
            this.mainpane3.y = 245;
            this.mainPan.addChild(this.mainpane3);
            this.mainpane3.graphics.lineStyle(1, 14463830);
            this.mainpane3.graphics.moveTo(0, 0);
            this.mainpane3.graphics.lineTo(0, 40);
            this.mainpane3.graphics.lineTo(209, 40);
            this.mainpane3.graphics.lineTo(209, 0);
            this.mainpane3.graphics.lineTo(0, 0);
            this.moneyBmp = new Bitmap();
            this.moneyBmp.bitmapData = Config.findIcon(param1);
            this.moneyBmp.x = 100;
            this.moneyBmp.y = 75;
            this.mainPan.addChild(this.moneyBmp);
            this.moneyBmp.visible = false;
            this.tlabel02 = new Label(this.mainPan, 30, 85, Config.language("EquipMadePanel", 24));
            this.tlabel02.html = true;
            var _loc_9:* = "";
            if (param1 == "mi0033")
            {
                _loc_9 = Config.language("EquipMadePanel", 155);
            }
            else if (param1 == "mi0032")
            {
                _loc_9 = Config.language("EquipMadePanel", 156);
            }
            this.ifUseLock = new CheckBox(this.mainPan, 30, 115, _loc_9, this.sussespercent);
            this.tlabel12 = new Label(this.mainPan, 90, 148, Config.language("EquipMadePanel", 13));
            this.tlabel12.html = true;
            this.tlabel32 = new Label(this.mainPan, 50, 220, Config.language("EquipMadePanel", 15));
            this.pdnum = new NumericStepper(this.mainPan, 30, 255, this.sussespercent);
            this.pdnum.width = 110;
            this.pdnum.percent = false;
            this.pdnum.maximum = 999;
            return;
        }// end function

        private function initeqfine()
        {
            this.removeallchild(this.mainPan);
            Config.ui._charUI.removeEventListener("itemchange", this.sussespercent);
            Config.ui._charUI.addEventListener("itemchange", this.sussespercent);
            this.slotarr = [];
            var _loc_1:* = new CloneSlot(0, 32);
            this.mainPan.addChild(_loc_1);
            _loc_1.x = 10;
            _loc_1.y = 110;
            this.slotarr.push(_loc_1);
            _loc_1.addEventListener("sglClick", this.handleSlotClick);
            _loc_1.addEventListener("up", this.handleSlotClick);
            _loc_1.addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
            _loc_1.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
            this.mainpane2 = new Sprite();
            this.mainpane2.x = 45;
            this.mainpane2.y = 110;
            this.mainPan.addChild(this.mainpane2);
            var _loc_2:* = GradientType.LINEAR;
            var _loc_3:* = [14463830, 14463830];
            var _loc_4:* = [1, 0];
            var _loc_5:* = [0, 255];
            var _loc_6:* = new Matrix();
            new Matrix().createGradientBox(100, 50, 0, 0, 0);
            var _loc_7:* = SpreadMethod.PAD;
            this.mainpane2.graphics.beginGradientFill(_loc_2, _loc_3, _loc_4, _loc_5, _loc_6, _loc_7);
            this.mainpane2.graphics.drawRect(0, 0, 100, 32);
            this.mainpane1 = new Sprite();
            this.mainpane1.graphics.beginFill(14463830);
            this.mainpane1.graphics.drawRect(20, 215, 210, 30);
            this.mainPan.addChild(this.mainpane1);
            this.mainpane3 = new Sprite();
            this.mainpane3.x = 20;
            this.mainpane3.y = 245;
            this.mainPan.addChild(this.mainpane3);
            this.mainpane3.graphics.lineStyle(1, 14463830);
            this.mainpane3.graphics.moveTo(0, 0);
            this.mainpane3.graphics.lineTo(0, 40);
            this.mainpane3.graphics.lineTo(209, 40);
            this.mainpane3.graphics.lineTo(209, 0);
            this.mainpane3.graphics.lineTo(0, 0);
            if (this.closeflag2)
            {
                this.tlabel01 = new ClickLabel(this.mainPan, 100, 82, Config.language("EquipMadePanel", 123), this.openwwwgift, true);
                this.tlabel01.clickColor([11344686, 11344686]);
            }
            if (this.closeflag1)
            {
                this.tlb = new Label(this.mainPan, 130, 118);
                this.tlb.html = true;
                this.clkl = new ClickLabel(this.mainPan, 135, 118, Config.language("EquipMadePanel", 124), this.openwwwpro, true);
                this.clkl.clickColor([11344686, 11344686]);
            }
            this.tlabel02 = new Label(this.mainPan, 10, 160, Config.language("EquipMadePanel", 11));
            this.tlabel02.html = true;
            this.ifUseLock = new CheckBox(this.mainPan, 30, 195, Config.language("EquipMadePanel", 12), this.sussespercent);
            this.tlabel12 = new Label(this.mainPan, 50, 118, Config.language("EquipMadePanel", 13));
            this.tlabel12.html = true;
            this.tlabel32 = new Label(this.mainPan, 80, 220, Config.language("EquipMadePanel", 15));
            this.pdnum = new NumericStepper(this.mainPan, 30, 255, this.sussespercent);
            this.pdnum.width = 110;
            this.pdnum.percent = false;
            this.pdnum.maximum = 999;
            this.tableStoneNum = new Label(this.mainPan, 60, 228);
            this.fastBuy = new ClickLabel(this.mainPan, 200, 160, Config.language("EquipMadePanel", 125), this.openshoppanel, true);
            this.fastBuy.visible = false;
            this.fastBuy.clickColor([3295734, 3295734]);
            return;
        }// end function

        private function openwwwgift(event:TextEvent)
        {
            var _loc_2:* = null;
            if (this.actDescript2 != "")
            {
                _loc_2 = new URLRequest(this.actDescript2);
                navigateToURL(_loc_2);
            }
            return;
        }// end function

        private function openwwwpro(event:TextEvent)
        {
            var _loc_2:* = null;
            if (this.actDescript1 != "")
            {
                _loc_2 = new URLRequest(this.actDescript1);
                navigateToURL(_loc_2);
            }
            return;
        }// end function

        private function initequipwashpanel()
        {
            var _loc_1:* = undefined;
            this.removeallchild(this.mainPan);
            this.slotarr = [];
            var _loc_2:* = new Shape();
            _loc_2.graphics.beginFill(6710886, 0.2);
            _loc_2.graphics.drawRoundRect(10, 135, 230, 35, 5);
            _loc_2.graphics.drawRoundRect(10, 193, 230, 57, 5);
            _loc_2.graphics.endFill();
            this.mainPan.addChild(_loc_2);
            _loc_1 = new CloneSlot(0, 30);
            this.mainPan.addChild(_loc_1);
            _loc_1.x = 30;
            _loc_1.y = 82;
            this.slotarr.push(_loc_1);
            _loc_1.addEventListener("sglClick", this.handleSlotClick);
            _loc_1.addEventListener("up", this.handleSlotClick);
            _loc_1.addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
            _loc_1.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
            this.washIcon = new CloneSlot(0, 30);
            this.mainPan.addChild(this.washIcon);
            this.washIcon.x = 100;
            this.washIcon.y = 200;
            this.washIcon.addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
            this.washIcon.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
            this.washBar = new ProgressBar(this.mainPan, 145, 98);
            this.washBar.visible = false;
            this.washBar.width = 80;
            this.washBar.height = 15;
            this.washBar.color = 15981107;
            this.washBar.subColor = 16750899;
            this.checkb = new CheckBox(this.mainPan, 10, 176, Config.language("EquipMadePanel", 91), this.showashstone);
            this.clicklab1 = new ClickLabel(this.mainPan, 31, 114, Config.language("EquipMadePanel", 92), this.openbag, true);
            this.clicklab2 = new ClickLabel(this.mainPan, 25, 215, Config.language("EquipMadePanel", 93), this.openshoppanel, true);
            this.clicklab2.visible = false;
            this.tlabel0 = new Label(this.mainPan, 80, 78);
            this.tlabel1 = new Label(this.mainPan, 80, 96);
            this.tlabel2 = new Label(this.mainPan, 80, 114);
            this.tlabel3 = new Label(this.mainPan, 20, 252, Config.language("EquipMadePanel", 94));
            this.tlabel4 = new Label(this.mainPan, 25, 137);
            this.tlabel5 = new Label(this.mainPan, 25, 200, Config.language("EquipMadePanel", 45));
            this.tlabel0.html = true;
            this.tlabel1.html = true;
            this.tlabel2.html = true;
            this.tlabel3.html = true;
            this.tlabel4.html = true;
            this.tlabel5.html = true;
            this.tlabel3.textColor = 5987163;
            this.clicklab1.clickColor([39423, 16544]);
            this.clicklab2.clickColor([39423, 16544]);
            this.startbtn1 = new PushButton(this.mainPan, 100, 270, Config.language("EquipMadePanel", 23), this.sendequipwash);
            this.startbtn1.width = 80;
            return;
        }// end function

        private function openbag(event:TextEvent)
        {
            Config.ui._bagUI.open();
            Config.ui._bagUI.selectPage(null, 1);
            return;
        }// end function

        private function openshoppanel(event:TextEvent) : void
        {
            Config.ui._shopmail.openListPanel(1);
            return;
        }// end function

        private function equipmade(event:MouseEvent = null)
        {
            this.washRb.label = Config.language("EquipMadePanel", 16);
            this.fineRb.label = Config.language("EquipMadePanel", 112);
            this.holeRb.label = Config.language("EquipMadePanel", 10);
            this.washRb.selected = true;
            this.holeRb.visible = true;
            this.initequipfinepanel();
            return;
        }// end function

        private function closeAlert(param1)
        {
            this.flagalert = true;
            this.startbtn1.enabled = true;
            return;
        }// end function

        private function sussespercent(param1 = null)
        {
            var _loc_2:* = NaN;
            var _loc_3:* = NaN;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_11:* = 0;
            var _loc_12:* = NaN;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = 0;
            var _loc_16:* = 0;
            var _loc_17:* = 0;
            var _loc_18:* = undefined;
            if (this.slotarr[0].item != null)
            {
                this._tol = 0;
                if (int(this.slotarr[0].item._itemData.type) == 4)
                {
                    if (this.slotarr[0].item._itemData.subType == 11)
                    {
                        if (this.topbtn.selectpage == 2 && this.washRb.selected)
                        {
                            _loc_2 = Config.ui._charUI.getItemAmount(806000);
                            _loc_3 = Config.ui._charUI.getItemAmount(94400);
                            _loc_4 = int(this.slotarr[0].item._itemData.finegrade);
                            if (_loc_4 >= 30)
                            {
                                _loc_2 = Config.ui._charUI.getItemAmount(893102);
                                _loc_3 = Config.ui._charUI.getItemAmount(93102);
                                if (this.moneyBmp != null)
                                {
                                    if (this.moneyBmp.hasOwnProperty("bitmapData"))
                                    {
                                        this.moneyBmp.bitmapData.dispose();
                                        this.moneyBmp = null;
                                    }
                                }
                                _loc_5 = Config._itemMap[893102].icon;
                                this.moneyBmp = new Bitmap();
                                this.moneyBmp.bitmapData = Config.findIcon(_loc_5);
                                this.moneyBmp.x = 100;
                                this.moneyBmp.y = 75;
                                this.mainPan.addChild(this.moneyBmp);
                            }
                            if (this.ifUseLock.selected)
                            {
                                this._tol = _loc_2;
                            }
                            else
                            {
                                this._tol = _loc_2 + _loc_3;
                            }
                            if (Math.ceil(100 / this.rideFinePrecent) > this._tol)
                            {
                                this.pdnum.maximum = this._tol;
                            }
                            else
                            {
                                this.pdnum.maximum = Math.ceil(100 / this.rideFinePrecent);
                            }
                            this.tlabel02.text = Config.language("EquipMadePanel", 24) + this._tol;
                            if (this.rideFinePrecent * this.pdnum.value >= 100)
                            {
                                this.tlabel12.text = Config.language("EquipMadePanel", 25) + "<font color=\'#399765\'>" + "100%" + "</font>";
                            }
                            else
                            {
                                _loc_6 = int(this.rideFinePrecent * this.pdnum.value * 100) / 100;
                                this.tlabel12.text = Config.language("EquipMadePanel", 25) + _loc_6 + "%";
                            }
                        }
                        else if (this.slotarr[1].item != null && this.topbtn.selectpage == 2 && this.fineRb.selected)
                        {
                        }
                    }
                    else if (this.slotarr[0].item._itemData.subType == 13)
                    {
                        if (this.topbtn.selectpage == 1 && this.washRb.selected)
                        {
                            _loc_7 = Config.ui._charUI.getItemAmount(802000);
                            _loc_8 = Config.ui._charUI.getItemAmount(94500);
                            _loc_4 = int(this.slotarr[0].item._itemData.finegrade);
                            if (_loc_4 >= 30)
                            {
                                _loc_7 = Config.ui._charUI.getItemAmount(893101);
                                _loc_8 = Config.ui._charUI.getItemAmount(93101);
                                if (this.moneyBmp != null)
                                {
                                    if (this.moneyBmp.hasOwnProperty("bitmapData"))
                                    {
                                        this.moneyBmp.bitmapData.dispose();
                                        this.moneyBmp = null;
                                    }
                                }
                                _loc_5 = Config._itemMap[893101].icon;
                                this.moneyBmp = new Bitmap();
                                this.moneyBmp.bitmapData = Config.findIcon(_loc_5);
                                this.moneyBmp.x = 100;
                                this.moneyBmp.y = 75;
                                this.mainPan.addChild(this.moneyBmp);
                            }
                            this._tol = 0;
                            if (this.ifUseLock.selected)
                            {
                                this._tol = _loc_7;
                            }
                            else
                            {
                                this._tol = _loc_7 + _loc_8;
                            }
                            if (Math.ceil(100 / this.wingFineprecent) > this._tol)
                            {
                                this.pdnum.maximum = this._tol;
                            }
                            else
                            {
                                this.pdnum.maximum = Math.ceil(100 / this.wingFineprecent);
                            }
                            this.tlabel02.text = Config.language("EquipMadePanel", 24) + this._tol;
                            if (this.wingFineprecent * this.pdnum.value >= 100)
                            {
                                this.tlabel12.text = Config.language("EquipMadePanel", 25) + "<font color=\'#399765\'>" + "100%" + "</font>";
                            }
                            else
                            {
                                _loc_6 = int(this.wingFineprecent * this.pdnum.value * 100) / 100;
                                this.tlabel12.text = Config.language("EquipMadePanel", 25) + _loc_6 + "%";
                            }
                        }
                        else if (this.slotarr[1].item != null && this.topbtn.selectpage == 1 && this.fineRb.selected)
                        {
                        }
                    }
                    else
                    {
                        if (this.slotarr[0].item != null)
                        {
                            if (this.topbtn.selectpage == 0 && this.washRb.selected)
                            {
                                _loc_9 = 893000;
                                _loc_10 = 93001;
                                if (this.slotarr[0].item._itemData.finegrade >= 15)
                                {
                                    _loc_9 = 893007;
                                    _loc_10 = 93024;
                                }
                                _loc_11 = int(this.slotarr[0].item._itemData.quality2) / 10;
                                if (_loc_11 == 0 || _loc_11 == 1 || _loc_11 == 2 || _loc_11 == 3)
                                {
                                    _loc_9 = _loc_9 + 1;
                                    _loc_10 = _loc_10 + 1;
                                }
                                else if (_loc_11 == 4 || _loc_11 == 5 || _loc_11 == 6)
                                {
                                    _loc_9 = _loc_9 + (_loc_11 - 2);
                                    _loc_10 = _loc_10 + (_loc_11 - 2);
                                }
                                else
                                {
                                    _loc_9 = _loc_9 + 5;
                                    _loc_10 = _loc_10 + 5;
                                }
                                _loc_12 = Config.ui._charUI.getItemAmount(_loc_9);
                                this.vb = Config.ui._charUI.getItemAmount(_loc_10);
                                this._tol = 0;
                                if (this.ifUseLock.selected)
                                {
                                    this._tol = _loc_12;
                                }
                                else
                                {
                                    this._tol = _loc_12 + this.vb;
                                }
                                if (Math.ceil(100 / this.fineprecent) > this._tol)
                                {
                                    this.pdnum.maximum = this._tol;
                                }
                                else
                                {
                                    this.pdnum.maximum = Math.ceil(100 / this.fineprecent);
                                }
                                this.tableStoneNum.text = String(this._tol);
                                if (this.fineprecent * this.pdnum.value >= 100)
                                {
                                    this.tlabel12.text = Config.language("EquipMadePanel", 25) + "<font color=\'#006600\'>" + "100%" + "</font>";
                                }
                                else
                                {
                                    _loc_6 = int(this.fineprecent * this.pdnum.value * 100) / 100;
                                    this.tlabel12.text = Config.language("EquipMadePanel", 25) + _loc_6 + "%";
                                }
                                if (this.slotarr[0].item._itemData.finegrade == 15 && param1 == null)
                                {
                                    _loc_13 = "";
                                    _loc_14 = "";
                                    _loc_13 = Config.language("EquipMadePanel", 160);
                                    if (_loc_11 == 0 || _loc_11 == 1 || _loc_11 == 2 || _loc_11 == 3)
                                    {
                                        _loc_13 = _loc_13 + Config.language("EquipMadePanel", 126);
                                    }
                                    else if (_loc_11 == 4 || _loc_11 == 5 || _loc_11 == 6)
                                    {
                                        _loc_13 = _loc_13 + Config.language("EquipMadePanel", 127, _loc_11 * 10);
                                    }
                                    else
                                    {
                                        _loc_13 = _loc_13 + Config.language("EquipMadePanel", 153);
                                    }
                                    this.tlabel02.text = Config.language("EquipMadePanel", 128, _loc_13);
                                    _loc_14 = Config._itemMap[_loc_9].icon;
                                    if (this.eqBmp != null)
                                    {
                                        if (this.eqBmp.hasOwnProperty("bitmapData"))
                                        {
                                            this.eqBmp.bitmapData.dispose();
                                            this.eqBmp = null;
                                        }
                                    }
                                    this.eqBmp = new Bitmap();
                                    this.eqBmp.bitmapData = Config.findIcon(_loc_14);
                                    this.eqBmp.x = 32;
                                    this.eqBmp.y = 216;
                                    this.mainPan.addChild(this.eqBmp);
                                }
                            }
                            else if (this.slotarr[1].item != null && this.topbtn.selectpage == 0 && this.fineRb.selected)
                            {
                                _loc_15 = 0;
                                _loc_16 = 0;
                                _loc_17 = 0;
                                if (this.slotarr[0].item._itemData.quality == 6)
                                {
                                    _loc_15 = 94506;
                                    _loc_16 = 802050;
                                }
                                else if (this.slotarr[0].item._itemData.quality == 7 || this.slotarr[0].item._itemData.quality == 8 || this.slotarr[0].item._itemData.quality == 9 || this.slotarr[0].item._itemData.quality == 10)
                                {
                                    _loc_15 = 94507;
                                    _loc_16 = 802051;
                                }
                                if (!this.checkb.selected)
                                {
                                    _loc_17 = Config.ui._charUI.getItemAmount(_loc_15) + Config.ui._charUI.getItemAmount(_loc_16);
                                }
                                else
                                {
                                    _loc_17 = Config.ui._charUI.getItemAmount(_loc_16);
                                }
                                if (_loc_17 >= this.wingst)
                                {
                                    _loc_18 = "#399765";
                                }
                                else
                                {
                                    _loc_18 = "#ad1b2e";
                                }
                                this.tlabel22.text = Config.language("EquipMadePanel", 142) + "<font color=\'" + _loc_18 + "\'>" + _loc_17 + "/" + this.wingst + "</font>";
                            }
                        }
                        if (this.pdnum.value >= 1)
                        {
                            GuideUI.testDoId(191, this.eqBmp, null, [this._startFinePb]);
                        }
                    }
                }
            }
            return;
        }// end function

        private function sendequipfine(event:MouseEvent) : void
        {
            if (this.startbtn1.enabled)
            {
                if (this.slotarr[0].item != null)
                {
                    if (this.pdnum.value > 0)
                    {
                        if (this.ifUseLock.selected || this.slotarr[0].item._itemData.binding == 1 || this.vb == 0)
                        {
                            this.senddata();
                        }
                        else
                        {
                            this.startbtn1.enabled = false;
                            AlertUI.alert(Config.language("EquipMadePanel", 26), Config.language("EquipMadePanel", 27), [Config.language("EquipMadePanel", 28), Config.language("EquipMadePanel", 29)], [this.senddata, this.finecansel]);
                        }
                    }
                    else
                    {
                        Config.message(Config.language("EquipMadePanel", 30));
                    }
                }
                else
                {
                    Config.message(Config.language("EquipMadePanel", 31));
                }
            }
            return;
        }// end function

        private function senddata(param1 = null)
        {
            this.startbtn1.enabled = false;
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.CMSG_EQUIP_UPGRADE);
            _loc_2.add16(this.slotarr[0].item._position);
            _loc_2.add16(this.pdnum.value);
            if (this.ifUseLock.selected)
            {
                _loc_2.add8(1);
            }
            else
            {
                _loc_2.add8(0);
            }
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function sendequipwash(event:MouseEvent) : void
        {
            var _loc_2:* = undefined;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            if (this.startbtn1.enabled)
            {
                if (this.slotarr[0].item != null)
                {
                    _loc_2 = int(this.slotarr[0].item._itemData.quality);
                    _loc_3 = 0;
                    _loc_4 = 0;
                    if (_loc_2 == 0 || _loc_2 == 1 || _loc_2 == 2 || _loc_2 == 3 || _loc_2 == 4)
                    {
                        _loc_4 = Config.ui._charUI.getItemAmount(92011);
                        _loc_3 = this.washmoney[0];
                    }
                    else if (_loc_2 == 5 || _loc_2 == 6)
                    {
                        _loc_4 = Config.ui._charUI.getItemAmount(92012);
                        _loc_3 = this.washmoney[1];
                    }
                    else if (_loc_2 == 7 || _loc_2 == 8 || _loc_2 == 9 || _loc_2 == 10)
                    {
                        _loc_4 = Config.ui._charUI.getItemAmount(92013);
                        _loc_3 = this.washmoney[2];
                    }
                    if (int(this.slotarr[0].item._itemData.washgrade) == int(this.washmaxnum))
                    {
                        Config.message(Config.language("EquipMadePanel", 33));
                    }
                    else if (this.slotarr[0].item._itemData.binding != 1 && !this.checkb.selected && _loc_4 > 0)
                    {
                        this.startbtn1.enabled = false;
                        AlertUI.alert(Config.language("EquipMadePanel", 26), Config.language("EquipMadePanel", 95), [Config.language("EquipMadePanel", 28), Config.language("EquipMadePanel", 29)], [this.surebang, this.finecansel]);
                    }
                    else
                    {
                        this.surebang();
                    }
                }
                else
                {
                    Config.message(Config.language("EquipMadePanel", 36));
                }
            }
            return;
        }// end function

        private function surebang(event:MouseEvent = null)
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.CMSG_EQUIP_POLISH);
            _loc_2.add16(this.slotarr[0].item._position);
            if (this.checkb.selected)
            {
                _loc_2.add8(0);
            }
            else
            {
                _loc_2.add8(1);
            }
            ClientSocket.send(_loc_2);
            this.startbtn1.enabled = false;
            if (this.forewashgrade < int(this.slotarr[0].item._itemData.washgrade + this.washinitprop))
            {
                this.forewashgrade = int(this.slotarr[0].item._itemData.washgrade + this.washinitprop);
            }
            this.equitempos1 = this.slotarr[0].item._position;
            return;
        }// end function

        private function handleSlotClick(event:Event = null) : void
        {
            var _loc_2:* = undefined;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = NaN;
            var _loc_10:* = null;
            var _loc_11:* = 0;
            var _loc_12:* = 0;
            var _loc_13:* = undefined;
            var _loc_14:* = 0;
            var _loc_15:* = undefined;
            var _loc_16:* = 0;
            var _loc_17:* = null;
            var _loc_18:* = 0;
            var _loc_19:* = 0;
            var _loc_20:* = null;
            var _loc_21:* = null;
            var _loc_22:* = null;
            var _loc_23:* = NaN;
            var _loc_24:* = null;
            var _loc_25:* = NaN;
            var _loc_26:* = null;
            var _loc_27:* = 0;
            var _loc_28:* = null;
            var _loc_29:* = 0;
            var _loc_30:* = 0;
            var _loc_31:* = 0;
            var _loc_32:* = undefined;
            var _loc_33:* = null;
            if (event != null)
            {
                _loc_2 = event.currentTarget;
            }
            else
            {
                _loc_2 = this.slotarr[0];
                Holder.item = this.slotarr[0].item;
            }
            if (this.topbtn.selectpage == 0)
            {
                if (this.washRb.selected)
                {
                    if (Holder.item == null)
                    {
                        if (_loc_2.item != null)
                        {
                            if (this.slotarr[0] == _loc_2)
                            {
                                if (this.eqBmp != null)
                                {
                                    if (this.eqBmp.hasOwnProperty("bitmapData"))
                                    {
                                        this.eqBmp.bitmapData.dispose();
                                        this.eqBmp = null;
                                    }
                                }
                                this.fastBuy.visible = false;
                                this.tlabel02.text = Config.language("EquipMadePanel", 11);
                                this.tlabel12.text = Config.language("EquipMadePanel", 25);
                                this.tableStoneNum.text = "";
                            }
                            _loc_2.item = null;
                            this.pdnum.maximum = 999;
                        }
                    }
                    else if (Holder.item._drawer == Config.ui._charUI._slotArray)
                    {
                        if (this.slotarr[0] == _loc_2)
                        {
                            if (Config.ui._charUI.getPosite(int(Holder.item._position)) == 2)
                            {
                                Config.message(Config.language("EquipMadePanel", 39));
                                return;
                            }
                            if (int(Holder.item._itemData.type) == 4)
                            {
                                if (int(Holder.item._itemData.subType) == 11 || int(Holder.item._itemData.subType) == 13)
                                {
                                    Config.message(Config.language("EquipMadePanel", 40));
                                    return;
                                }
                                this.equitempos1 = Holder.item._position;
                                _loc_3 = int(Holder.item._itemData.finegrade);
                                _loc_4 = int(Holder.item._itemData.quality);
                                if (_loc_3 < 30)
                                {
                                    if (this.closeflag1)
                                    {
                                        _loc_10 = new DataSet();
                                        _loc_10.addHead(CONST_ENUM.C2G_EQUIP_UPGRADE_ACTIVITY_PROBABILITY);
                                        _loc_10.add8(_loc_4);
                                        _loc_10.add8((_loc_3 + 1));
                                        ClientSocket.send(_loc_10);
                                    }
                                    this.fineprecent = Number(Config._equipfineprobability[(_loc_3 + 1)].rate) / 100;
                                }
                                else
                                {
                                    this.fineprecent = 1;
                                }
                                _loc_2.item = Holder.item;
                                _loc_2.item._position = Holder.item._position;
                                Holder.item._drawer[Holder.item._position].item = Holder.item;
                                _loc_5 = 893000;
                                _loc_6 = 93001;
                                if (_loc_2.item._itemData.finegrade >= 15)
                                {
                                    _loc_5 = 893007;
                                    _loc_6 = 93024;
                                }
                                _loc_7 = "";
                                _loc_8 = "";
                                if (_loc_3 < 15)
                                {
                                    _loc_7 = Config.language("EquipMadePanel", 159);
                                }
                                else
                                {
                                    _loc_7 = Config.language("EquipMadePanel", 160);
                                }
                                if (_loc_4 == 0 || _loc_4 == 1 || _loc_4 == 2 || _loc_4 == 3)
                                {
                                    _loc_5 = _loc_5 + 1;
                                    _loc_6 = _loc_6 + 1;
                                    _loc_7 = _loc_7 + Config.language("EquipMadePanel", 126);
                                }
                                else if (_loc_4 == 4 || _loc_4 == 5 || _loc_4 == 6)
                                {
                                    _loc_5 = _loc_5 + (_loc_4 - 2);
                                    _loc_6 = _loc_6 + (_loc_4 - 2);
                                    _loc_7 = _loc_7 + Config.language("EquipMadePanel", 127, _loc_4 * 10);
                                }
                                else
                                {
                                    _loc_5 = _loc_5 + 5;
                                    _loc_6 = _loc_6 + 5;
                                    _loc_7 = _loc_7 + Config.language("EquipMadePanel", 153);
                                }
                                _loc_8 = Config._itemMap[_loc_5].icon;
                                _loc_9 = Config.ui._charUI.getItemAmount(_loc_5);
                                this.vb = Config.ui._charUI.getItemAmount(_loc_6);
                                if (this.ifUseLock.selected)
                                {
                                    this._tol = _loc_9;
                                }
                                else
                                {
                                    this._tol = _loc_9 + this.vb;
                                }
                                if (this.eqBmp != null)
                                {
                                    if (this.eqBmp.hasOwnProperty("bitmapData"))
                                    {
                                        this.eqBmp.bitmapData.dispose();
                                        this.eqBmp = null;
                                    }
                                }
                                this.eqBmp = new Bitmap();
                                this.eqBmp.bitmapData = Config.findIcon(_loc_8);
                                this.eqBmp.x = 32;
                                this.eqBmp.y = 216;
                                this.mainPan.addChild(this.eqBmp);
                                this.fastBuy.visible = true;
                                this.tlabel02.text = Config.language("EquipMadePanel", 128, _loc_7);
                                this.tableStoneNum.text = String(this._tol);
                                if (!this.closeflag1)
                                {
                                    this.showproblity();
                                }
                                Holder.item = null;
                                GuideUI.testDoId(189, this.eqBmp, null, [this.pdnum._addPB]);
                            }
                            else
                            {
                                Config.message(Config.language("EquipMadePanel", 40));
                                return;
                            }
                        }
                    }
                }
                else if (this.fineRb.selected)
                {
                    if (Holder.item == null)
                    {
                        if (_loc_2.item != null)
                        {
                            if (this.slotarr[0] == _loc_2)
                            {
                                this.slotarr[0].item = null;
                            }
                            else if (this.slotarr[1] == _loc_2)
                            {
                                this.slotarr[1].item = null;
                            }
                            if (this.slotarr[2].item != null)
                            {
                                this.slotarr[2].item.destroy();
                                this.slotarr[2].item = null;
                                this.tlabel22.text = Config.language("EquipMadePanel", 142);
                            }
                        }
                    }
                    else if (Holder.item._drawer == Config.ui._charUI._slotArray)
                    {
                        if (Holder.item._itemData.type == 4 && Holder.item._itemData.subType >= 1 && Holder.item._itemData.subType <= 9 && Holder.item._itemData.quality >= 6)
                        {
                            if (Config.ui._charUI.getPosite(int(Holder.item._position)) == 2)
                            {
                                Config.message(Config.language("EquipMadePanel", 39));
                                return;
                            }
                            if (this.slotarr[0] == _loc_2)
                            {
                                if (Holder.item._itemData.finegrade == 30)
                                {
                                    Config.message(Config.language("EquipMadePanel", 99));
                                    return;
                                }
                                if (this.slotarr[1].item != null)
                                {
                                    if (this.slotarr[1].item._itemData.quality == 6 && Holder.item._itemData.quality != this.slotarr[1].item._itemData.quality)
                                    {
                                        Config.message(Config.language("EquipMadePanel", 143));
                                        return;
                                    }
                                    if (this.slotarr[1].item._itemData.quality > 6 && Holder.item._itemData.quality <= 6)
                                    {
                                        Config.message(Config.language("EquipMadePanel", 144));
                                        return;
                                    }
                                }
                                if (this.slotarr[1].item != null && Holder.item._itemData.finegrade >= this.slotarr[1].item._itemData.finegrade)
                                {
                                    Config.message(Config.language("EquipMadePanel", 145));
                                    return;
                                }
                            }
                            else if (this.slotarr[1] == _loc_2)
                            {
                                if (this.slotarr[0].item != null)
                                {
                                    if (this.slotarr[0].item._itemData.quality == 6 && Holder.item._itemData.quality != this.slotarr[0].item._itemData.quality)
                                    {
                                        Config.message(Config.language("EquipMadePanel", 143));
                                        return;
                                    }
                                    if (this.slotarr[0].item._itemData.quality > 6 && Holder.item._itemData.quality <= 6)
                                    {
                                        Config.message(Config.language("EquipMadePanel", 144));
                                        return;
                                    }
                                }
                                if (this.slotarr[0].item != null && this.slotarr[0].item._itemData.finegrade >= Holder.item._itemData.finegrade)
                                {
                                    Config.message(Config.language("EquipMadePanel", 145));
                                    return;
                                }
                            }
                            _loc_2.item = Holder.item;
                            _loc_2.item._position = Holder.item._position;
                            Holder.item._drawer[Holder.item._position].item = Holder.item;
                            Holder.item = null;
                            if (this.slotarr[0].item != null && this.slotarr[1].item != null)
                            {
                                if (this.slotarr[2].item != null)
                                {
                                    this.slotarr[2].item.destroy();
                                    this.slotarr[2].item = null;
                                    this.tlabel22.text = Config.language("EquipMadePanel", 142);
                                }
                                _loc_11 = 0;
                                _loc_12 = 0;
                                if (this.slotarr[0].item._itemData.quality == 6)
                                {
                                    _loc_11 = 94506;
                                    _loc_12 = 802050;
                                }
                                else if (this.slotarr[0].item._itemData.quality == 7 || this.slotarr[0].item._itemData.quality == 8 || this.slotarr[0].item._itemData.quality == 9 || this.slotarr[0].item._itemData.quality == 10)
                                {
                                    _loc_11 = 94507;
                                    _loc_12 = 802051;
                                }
                                if (!this.checkb.selected)
                                {
                                    this.equpstoneNum = Config.ui._charUI.getItemAmount(_loc_11) + Config.ui._charUI.getItemAmount(_loc_12);
                                }
                                else
                                {
                                    this.equpstoneNum = Config.ui._charUI.getItemAmount(_loc_12);
                                }
                                _loc_13 = Item.newItem(Config._itemMap[this.slotarr[0].item._itemData.id], 0, 0, UNIT_TYPE_ENUM.TYPEID_ITEMCLONE, 0);
                                if (this.slotarr[0].item._itemData.gem != null)
                                {
                                    _loc_13._itemData.gem = this.slotarr[0].item._itemData.gem;
                                }
                                _loc_13._itemData.suitID = this.slotarr[0].item._itemData.suitID;
                                _loc_13._itemData.qual = this.slotarr[0].item._itemData.qual;
                                _loc_13._itemData.addEffect = this.slotarr[0].item._itemData.addEffect;
                                _loc_14 = this.slotarr[1].item._itemData.finegrade;
                                _loc_13.star = _loc_14;
                                if (this.slotarr[0].item._itemData.binding == 1 || this.slotarr[1].item._itemData.binding == 1)
                                {
                                    _loc_13._itemData.binding = 1;
                                }
                                _loc_13.display();
                                this.slotarr[2].item = _loc_13;
                                if (this.slotarr[0].item._itemData.quality == 6)
                                {
                                    this.wingst = Config._equipfineprobability[_loc_14].amount6;
                                }
                                else if (this.slotarr[0].item._itemData.quality == 7)
                                {
                                    this.wingst = Config._equipfineprobability[_loc_14].amount7;
                                }
                                else if (this.slotarr[0].item._itemData.quality == 8)
                                {
                                    this.wingst = Config._equipfineprobability[_loc_14].amount8;
                                }
                                else if (this.slotarr[0].item._itemData.quality == 9)
                                {
                                    this.wingst = Config._equipfineprobability[_loc_14].amount9;
                                }
                                else if (this.slotarr[0].item._itemData.quality == 10)
                                {
                                    this.wingst = Config._equipfineprobability[_loc_14].amount10;
                                }
                                if (this.equpstoneNum >= this.wingst)
                                {
                                    _loc_15 = "#399765";
                                }
                                else
                                {
                                    _loc_15 = "#ad1b2e";
                                }
                                this.tlabel22.text = Config.language("EquipMadePanel", 142) + "<font color=\'" + _loc_15 + "\'>" + this.equpstoneNum + "/" + this.wingst + "</font>";
                            }
                        }
                        else if (this.slotarr[0] == _loc_2)
                        {
                            if (this.slotarr[1].item != null)
                            {
                                if (this.slotarr[1].item._itemData.quality == 6)
                                {
                                    Config.message(Config.language("EquipMadePanel", 143));
                                }
                                else
                                {
                                    Config.message(Config.language("EquipMadePanel", 144));
                                }
                            }
                            else
                            {
                                Config.message(Config.language("EquipMadePanel", 146));
                            }
                        }
                        else if (this.slotarr[1] == _loc_2)
                        {
                            if (this.slotarr[0].item != null)
                            {
                                if (this.slotarr[0].item._itemData.quality == 6)
                                {
                                    Config.message(Config.language("EquipMadePanel", 143));
                                }
                                else
                                {
                                    Config.message(Config.language("EquipMadePanel", 144));
                                }
                            }
                            else
                            {
                                Config.message(Config.language("EquipMadePanel", 146));
                            }
                        }
                    }
                }
                else if (this.holeRb.selected)
                {
                    if (Holder.item == null)
                    {
                        if (_loc_2.item != null)
                        {
                            if (this.slotarr[0] == _loc_2)
                            {
                                _loc_2.item = null;
                                _loc_16 = 0;
                                while (_loc_16 < this.jewslotarr.length)
                                {
                                    
                                    this.jewslotarr[_loc_16].removeEventListener("sglClick", Config.create(this.jewelslotclick, _loc_16, _loc_18));
                                    this.jewslotarr[_loc_16].removeEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
                                    this.jewslotarr[_loc_16].removeEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
                                    this.mainPan.removeChild(this.jewslotarr[_loc_16]);
                                    this.takeJewbtn[_loc_16].visible = false;
                                    _loc_16 = _loc_16 + 1;
                                }
                                this.jewslotarr = [];
                            }
                        }
                    }
                    else if (Holder.item._drawer == Config.ui._charUI._slotArray)
                    {
                        if (this.slotarr[0] == _loc_2)
                        {
                            if (Config.ui._charUI.getPosite(int(Holder.item._position)) == 2)
                            {
                                Config.message(Config.language("EquipMadePanel", 39));
                                return;
                            }
                            if (Holder.item._itemData.gem.length > 0)
                            {
                                _loc_2.item = Holder.item;
                                _loc_2.item._position = Holder.item._position;
                                Holder.item._drawer[Holder.item._position].item = Holder.item;
                                Holder.item = null;
                                _loc_19 = _loc_2.item._itemData.gem.length;
                                _loc_16 = 0;
                                while (_loc_16 < this.jewslotarr.length)
                                {
                                    
                                    this.jewslotarr[_loc_16].removeEventListener("sglClick", Config.create(this.jewelslotclick, _loc_16, _loc_18));
                                    this.jewslotarr[_loc_16].removeEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
                                    this.jewslotarr[_loc_16].removeEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
                                    this.mainPan.removeChild(this.jewslotarr[_loc_16]);
                                    _loc_16 = _loc_16 + 1;
                                }
                                this.jewslotarr = [];
                                _loc_20 = int(_loc_2.item._itemData.relatedId).toString(2);
                                _loc_20 = "000000" + _loc_20;
                                _loc_20 = ("000000" + _loc_20).substring(_loc_20.length - 6, _loc_20.length);
                                _loc_16 = 0;
                                while (_loc_16 < _loc_19)
                                {
                                    
                                    if (_loc_20.substr(_loc_16 * 2, 2) == "00")
                                    {
                                        if (_loc_20.substr((_loc_16 + 1) * 2, 2) == "00")
                                        {
                                            _loc_17 = _loc_20.substr((_loc_16 + 2) * 2, 2);
                                        }
                                        else
                                        {
                                            _loc_17 = _loc_20.substr((_loc_16 + 1) * 2, 2);
                                        }
                                    }
                                    else
                                    {
                                        _loc_17 = _loc_20.substr(_loc_16 * 2, 2);
                                    }
                                    if (_loc_17 == "01")
                                    {
                                        _loc_18 = 1;
                                    }
                                    else if (_loc_17 == "10")
                                    {
                                        _loc_18 = 2;
                                    }
                                    else if (_loc_17 == "11")
                                    {
                                        _loc_18 = 0;
                                    }
                                    _loc_21 = new CloneSlot(0, 32);
                                    _loc_21.x = 35 * (4 - _loc_19) + 70 * _loc_16 + 5;
                                    _loc_21.y = 165;
                                    if (_loc_2.item._itemData.gem[_loc_16].open)
                                    {
                                        _loc_21.bg = Config.findUI("charui")["icon100"];
                                    }
                                    else
                                    {
                                        _loc_21.bg = Config.findUI("charui")["icon101"];
                                    }
                                    if (_loc_18 == 1)
                                    {
                                        if (_loc_2.item._itemData.gem[_loc_16].id > 0)
                                        {
                                            _loc_21._bgTable.setTable("table27");
                                        }
                                        else
                                        {
                                            _loc_21._bgTable.setTable("table26");
                                        }
                                    }
                                    else if (_loc_18 == 2)
                                    {
                                        if (_loc_2.item._itemData.gem[_loc_16].id > 0)
                                        {
                                            _loc_21._bgTable.setTable("table28");
                                        }
                                        else
                                        {
                                            _loc_21._bgTable.setTable("table25");
                                        }
                                    }
                                    else if (_loc_2.item._itemData.gem[_loc_16].id > 0)
                                    {
                                        _loc_21._bgTable.setTable("table30");
                                    }
                                    else
                                    {
                                        _loc_21._bgTable.setTable("table29");
                                    }
                                    if (_loc_2.item._itemData.gem[_loc_16].id != 0)
                                    {
                                        _loc_22 = Item.newItem(Config._itemMap[_loc_2.item._itemData.gem[_loc_16].id], 0, 0, UNIT_TYPE_ENUM.TYPEID_ITEMCLONE, 0);
                                        _loc_22.display();
                                        _loc_21.item = _loc_22;
                                        this.takeJewbtn[_loc_16].visible = true;
                                    }
                                    else
                                    {
                                        this.takeJewbtn[_loc_16].visible = false;
                                    }
                                    this.jewslotarr.push(_loc_21);
                                    this.jewslotarr[_loc_16].addEventListener("sglClick", Config.create(this.jewelslotclick, _loc_16, _loc_18));
                                    this.jewslotarr[_loc_16].addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
                                    this.jewslotarr[_loc_16].addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
                                    this.mainPan.addChild(this.jewslotarr[_loc_16]);
                                    _loc_16 = _loc_16 + 1;
                                }
                            }
                            else
                            {
                                Config.message(Config.language("EquipMadePanel", 61));
                            }
                        }
                    }
                }
            }
            else if (this.topbtn.selectpage == 1)
            {
                if (this.washRb.selected)
                {
                    if (Holder.item == null)
                    {
                        if (_loc_2.item != null)
                        {
                            if (this.slotarr[0] == _loc_2)
                            {
                                this.moneyBmp.visible = false;
                                this.tlabel02.text = Config.language("EquipMadePanel", 24);
                                this.tlabel12.text = Config.language("EquipMadePanel", 25);
                            }
                            _loc_2.item = null;
                            this.pdnum.maximum = 999;
                        }
                    }
                    else if (Holder.item._drawer == Config.ui._charUI._slotArray)
                    {
                        if (this.slotarr[0] == _loc_2)
                        {
                            if (Config.ui._charUI.getPosite(int(Holder.item._position)) == 2)
                            {
                                Config.message(Config.language("EquipMadePanel", 39));
                                return;
                            }
                            if (Holder.item._itemData.type == 4 && Holder.item._itemData.subType == 13)
                            {
                                this.equitempos1 = Holder.item._position;
                                _loc_3 = int(Holder.item._itemData.finegrade);
                                if (_loc_3 < 60)
                                {
                                    this.wingFineprecent = Number(Config._wingRidelucky[(_loc_3 + 1)].sussesion1) / 100;
                                }
                                else
                                {
                                    this.wingFineprecent = 1;
                                }
                                _loc_2.item = Holder.item;
                                _loc_2.item._position = Holder.item._position;
                                Holder.item._drawer[Holder.item._position].item = Holder.item;
                                Holder.item = null;
                                _loc_9 = Config.ui._charUI.getItemAmount(802000);
                                _loc_23 = Config.ui._charUI.getItemAmount(94500);
                                if (_loc_3 >= 30)
                                {
                                    _loc_9 = Config.ui._charUI.getItemAmount(893101);
                                    _loc_23 = Config.ui._charUI.getItemAmount(93101);
                                    if (this.moneyBmp != null)
                                    {
                                        if (this.moneyBmp.hasOwnProperty("bitmapData"))
                                        {
                                            this.moneyBmp.bitmapData.dispose();
                                            this.moneyBmp = null;
                                        }
                                    }
                                    _loc_24 = Config._itemMap[893101].icon;
                                    this.moneyBmp = new Bitmap();
                                    this.moneyBmp.bitmapData = Config.findIcon(_loc_24);
                                    this.moneyBmp.x = 100;
                                    this.moneyBmp.y = 75;
                                    this.mainPan.addChild(this.moneyBmp);
                                }
                                if (this.ifUseLock.selected)
                                {
                                    this._tol = _loc_9;
                                }
                                else
                                {
                                    this._tol = _loc_9 + _loc_23;
                                }
                                this.moneyBmp.visible = true;
                                this.tlabel02.text = Config.language("EquipMadePanel", 24) + this._tol;
                                if (this.wingFineprecent > 0)
                                {
                                    if (100 / this.wingFineprecent == 1 && this._tol > 0)
                                    {
                                        this.pdnum.value = 1;
                                    }
                                    else if (this._tol > Math.ceil(100 / this.wingFineprecent))
                                    {
                                        this.pdnum.value = Math.ceil(100 / this.wingFineprecent);
                                    }
                                    else
                                    {
                                        this.pdnum.value = this._tol;
                                    }
                                }
                                if (_loc_3 >= 60)
                                {
                                    this.tlabel12.text = Config.language("EquipMadePanel", 25);
                                }
                                else if (this.wingFineprecent * this.pdnum.value >= 100)
                                {
                                    this.tlabel12.text = Config.language("EquipMadePanel", 25) + "<font color=\'#399765\'>" + "100%" + "</font>";
                                }
                                else
                                {
                                    _loc_25 = int(this.wingFineprecent * this.pdnum.value * 100) / 100;
                                    this.tlabel12.text = Config.language("EquipMadePanel", 25) + _loc_25 + "%";
                                }
                            }
                            else
                            {
                                Config.message(Config.language("EquipMadePanel", 97));
                                return;
                            }
                        }
                    }
                }
                if (this.fineRb.selected)
                {
                    if (Holder.item == null)
                    {
                        if (_loc_2.item != null)
                        {
                            if (this.slotarr[0] == _loc_2)
                            {
                                this.slotarr[0].item = null;
                            }
                            else if (this.slotarr[1] == _loc_2)
                            {
                                this.slotarr[1].item = null;
                            }
                            if (this.slotarr[2].item != null)
                            {
                                this.slotarr[2].item.destroy();
                                this.slotarr[2].item = null;
                                this.tlabel22.text = Config.language("EquipMadePanel", 98);
                            }
                        }
                    }
                    else if (Holder.item._drawer == Config.ui._charUI._slotArray)
                    {
                        if (Holder.item._itemData.type == 4 && Holder.item._itemData.subType == 13)
                        {
                            if (Config.ui._charUI.getPosite(int(Holder.item._position)) == 2)
                            {
                                Config.message(Config.language("EquipMadePanel", 39));
                                return;
                            }
                            if (this.slotarr[0] == _loc_2)
                            {
                                if (Holder.item._itemData.finegrade == Config._itemMap[Holder.item._itemData.id].relatedId)
                                {
                                    Config.message(Config.language("EquipMadePanel", 99));
                                    return;
                                }
                                if (this.slotarr[1].item != null && Holder.item._itemData.finegrade >= this.slotarr[1].item._itemData.finegrade)
                                {
                                    Config.message(Config.language("EquipMadePanel", 100));
                                    return;
                                }
                            }
                            if (this.slotarr[1] == _loc_2)
                            {
                                if (this.slotarr[0].item != null && this.slotarr[0].item._itemData.finegrade >= Holder.item._itemData.finegrade)
                                {
                                    Config.message(Config.language("EquipMadePanel", 101));
                                    return;
                                }
                            }
                            _loc_2.item = Holder.item;
                            _loc_2.item._position = Holder.item._position;
                            Holder.item._drawer[Holder.item._position].item = Holder.item;
                            Holder.item = null;
                            if (this.slotarr[0].item != null && this.slotarr[1].item != null)
                            {
                                if (this.slotarr[2].item != null)
                                {
                                    this.slotarr[2].item.destroy();
                                    this.slotarr[2].item = null;
                                    this.tlabel22.text = Config.language("EquipMadePanel", 98);
                                }
                                if (!this.checkb.selected)
                                {
                                    this.wingstoneNum = Config.ui._charUI.getItemAmount(94501) + Config.ui._charUI.getItemAmount(802001);
                                }
                                else
                                {
                                    this.wingstoneNum = Config.ui._charUI.getItemAmount(802001);
                                }
                                _loc_13 = Item.newItem(Config._itemMap[this.slotarr[0].item._itemData.id], 0, 0, UNIT_TYPE_ENUM.TYPEID_ITEMCLONE, 0);
                                if (this.slotarr[1].item._itemData.finegrade > Config._itemMap[this.slotarr[0].item._itemData.id].relatedId)
                                {
                                    _loc_14 = Config._itemMap[this.slotarr[0].item._itemData.id].relatedId;
                                }
                                else
                                {
                                    _loc_14 = this.slotarr[1].item._itemData.finegrade;
                                }
                                _loc_13.star = _loc_14;
                                if (this.slotarr[0].item._itemData.binding == 1 || this.slotarr[1].item._itemData.binding == 1)
                                {
                                    _loc_13._itemData.binding = 1;
                                }
                                if (this.slotarr[0].item._itemData.addEffect.length > 0 || this.slotarr[1].item._itemData.addEffect.length > 0)
                                {
                                    _loc_26 = [];
                                    _loc_27 = 0;
                                    if (this.slotarr[0].item._itemData.addEffect.length >= this.slotarr[1].item._itemData.addEffect.length)
                                    {
                                        _loc_27 = 0;
                                        while (_loc_27 < this.slotarr[0].item._itemData.addEffect.length)
                                        {
                                            
                                            _loc_28 = {};
                                            _loc_28.id = this.slotarr[0].item._itemData.addEffect[_loc_27].id;
                                            _loc_28.value = this.slotarr[0].item._itemData.addEffect[_loc_27].value;
                                            _loc_28.state = this.slotarr[0].item._itemData.addEffect[_loc_27].state;
                                            _loc_26.push(_loc_28);
                                            _loc_27++;
                                        }
                                        _loc_27 = 0;
                                        while (_loc_27 < this.slotarr[1].item._itemData.addEffect.length)
                                        {
                                            
                                            if (this.slotarr[1].item._itemData.addEffect[_loc_27].value > this.slotarr[0].item._itemData.addEffect[_loc_27].value)
                                            {
                                                _loc_28 = {};
                                                _loc_28.id = this.slotarr[1].item._itemData.addEffect[_loc_27].id;
                                                _loc_28.value = this.slotarr[1].item._itemData.addEffect[_loc_27].value;
                                                _loc_28.state = this.slotarr[1].item._itemData.addEffect[_loc_27].state;
                                                _loc_26[_loc_27] = _loc_28;
                                            }
                                            _loc_27++;
                                        }
                                    }
                                    else
                                    {
                                        _loc_27 = 0;
                                        while (_loc_27 < this.slotarr[1].item._itemData.addEffect.length)
                                        {
                                            
                                            _loc_28 = {};
                                            _loc_28.id = this.slotarr[1].item._itemData.addEffect[_loc_27].id;
                                            _loc_28.value = this.slotarr[1].item._itemData.addEffect[_loc_27].value;
                                            _loc_28.state = this.slotarr[1].item._itemData.addEffect[_loc_27].state;
                                            _loc_26.push(_loc_28);
                                            _loc_27++;
                                        }
                                        _loc_27 = 0;
                                        while (_loc_27 < this.slotarr[0].item._itemData.addEffect.length)
                                        {
                                            
                                            if (this.slotarr[0].item._itemData.addEffect[_loc_27].value > this.slotarr[1].item._itemData.addEffect[_loc_27].value)
                                            {
                                                _loc_28 = {};
                                                _loc_28.id = this.slotarr[0].item._itemData.addEffect[_loc_27].id;
                                                _loc_28.value = this.slotarr[0].item._itemData.addEffect[_loc_27].value;
                                                _loc_28.state = this.slotarr[0].item._itemData.addEffect[_loc_27].state;
                                                _loc_26[_loc_27] = _loc_28;
                                            }
                                            _loc_27++;
                                        }
                                    }
                                    _loc_13._itemData.addEffect = _loc_26;
                                }
                                _loc_13.display();
                                this.slotarr[2].item = _loc_13;
                                if (Config._itemMap[this.slotarr[0].item._itemData.id].relatedId == 20 && this.slotarr[1].item._itemData.finegrade > 20)
                                {
                                    this.wingst = Config._wingRidelucky[20].wingmoney;
                                }
                                else
                                {
                                    this.wingst = Config._wingRidelucky[_loc_14].wingmoney;
                                }
                                if (this.wingstoneNum >= this.wingst)
                                {
                                    _loc_15 = "#399765";
                                }
                                else
                                {
                                    _loc_15 = "#ad1b2e";
                                }
                                this.tlabel22.text = Config.language("EquipMadePanel", 98) + "<font color=\'" + _loc_15 + "\'>" + this.wingstoneNum + "/" + this.wingst + "</font>";
                            }
                        }
                        else
                        {
                            Config.message(Config.language("EquipMadePanel", 102));
                        }
                    }
                }
            }
            else if (this.topbtn.selectpage == 2)
            {
                if (this.washRb.selected)
                {
                    if (Holder.item == null)
                    {
                        if (_loc_2.item != null)
                        {
                            if (this.slotarr[0] == _loc_2)
                            {
                                this.moneyBmp.visible = false;
                                this.tlabel02.text = Config.language("EquipMadePanel", 24);
                                this.tlabel12.text = Config.language("EquipMadePanel", 25);
                            }
                            _loc_2.item = null;
                            this.pdnum.maximum = 999;
                        }
                    }
                    else if (Holder.item._drawer == Config.ui._charUI._slotArray)
                    {
                        if (this.slotarr[0] == _loc_2)
                        {
                            if (Config.ui._charUI.getPosite(int(Holder.item._position)) == 2)
                            {
                                Config.message(Config.language("RideMadePanel", 29));
                                return;
                            }
                            if (Holder.item._itemData.type == 4 && Holder.item._itemData.subType == 11)
                            {
                                this.equitempos1 = Holder.item._position;
                                _loc_3 = int(Holder.item._itemData.finegrade);
                                if (_loc_3 < 60)
                                {
                                    this.rideFinePrecent = Number(Config._wingRidelucky[(_loc_3 + 1)].sussesion1) / 100;
                                }
                                else
                                {
                                    this.rideFinePrecent = 1;
                                }
                                _loc_2.item = Holder.item;
                                _loc_2.item._position = Holder.item._position;
                                Holder.item._drawer[Holder.item._position].item = Holder.item;
                                _loc_29 = Config.ui._charUI.getItemAmount(806000);
                                _loc_30 = Config.ui._charUI.getItemAmount(94400);
                                if (_loc_3 >= 30)
                                {
                                    _loc_29 = Config.ui._charUI.getItemAmount(893102);
                                    _loc_30 = Config.ui._charUI.getItemAmount(93102);
                                    _loc_9 = Config.ui._charUI.getItemAmount(893101);
                                    _loc_23 = Config.ui._charUI.getItemAmount(93101);
                                    if (this.moneyBmp != null)
                                    {
                                        if (this.moneyBmp.hasOwnProperty("bitmapData"))
                                        {
                                            this.moneyBmp.bitmapData.dispose();
                                            this.moneyBmp = null;
                                        }
                                    }
                                    _loc_24 = Config._itemMap[893102].icon;
                                    this.moneyBmp = new Bitmap();
                                    this.moneyBmp.bitmapData = Config.findIcon(_loc_24);
                                    this.moneyBmp.x = 100;
                                    this.moneyBmp.y = 75;
                                    this.mainPan.addChild(this.moneyBmp);
                                }
                                if (this.ifUseLock.selected)
                                {
                                    this._tol = _loc_29;
                                }
                                else
                                {
                                    this._tol = _loc_29 + _loc_30;
                                }
                                this.moneyBmp.visible = true;
                                this.tlabel02.text = Config.language("RideMadePanel", 5) + this._tol;
                                if (this.rideFinePrecent > 0)
                                {
                                    if (100 / this.rideFinePrecent == 1 && this._tol > 0)
                                    {
                                        this.pdnum.value = 1;
                                    }
                                    else if (this._tol > Math.ceil(100 / this.rideFinePrecent))
                                    {
                                        this.pdnum.value = Math.ceil(100 / this.rideFinePrecent);
                                    }
                                    else
                                    {
                                        this.pdnum.value = this._tol;
                                    }
                                }
                                if (_loc_3 >= 60)
                                {
                                    this.tlabel12.text = Config.language("RideMadePanel", 7);
                                }
                                else
                                {
                                    if (this.rideFinePrecent * this.pdnum.value >= 100)
                                    {
                                        this.tlabel12.text = Config.language("RideMadePanel", 7) + "<font color=\'#399765\'>" + "100%" + "</font>";
                                    }
                                    else
                                    {
                                        _loc_25 = int(this.rideFinePrecent * this.pdnum.value * 100) / 100;
                                        this.tlabel12.text = Config.language("RideMadePanel", 7) + _loc_25 + "%";
                                    }
                                    Holder.item = null;
                                }
                            }
                            else
                            {
                                Config.message(Config.language("RideMadePanel", 31));
                                return;
                            }
                        }
                    }
                }
                if (this.fineRb.selected)
                {
                    if (Holder.item == null)
                    {
                        if (_loc_2.item != null)
                        {
                            if (this.slotarr[0] == _loc_2)
                            {
                                this.slotarr[0].item = null;
                            }
                            else if (this.slotarr[1] == _loc_2)
                            {
                                this.slotarr[1].item = null;
                            }
                            if (this.slotarr[2].item != null)
                            {
                                this.slotarr[2].item.destroy();
                                this.slotarr[2].item = null;
                                this.tlabel22.text = Config.language("RideMadePanel", 20);
                            }
                        }
                    }
                    else if (Holder.item._drawer == Config.ui._charUI._slotArray)
                    {
                        if (Config.ui._charUI.getPosite(int(Holder.item._position)) == 2)
                        {
                            Config.message(Config.language("RideMadePanel", 29));
                            return;
                        }
                        if (Holder.item._itemData.type == 4 && Holder.item._itemData.subType == 11)
                        {
                            if (this.slotarr[0] == _loc_2)
                            {
                                if (Holder.item._itemData.finegrade == Config._itemMap[Holder.item._itemData.id].relatedId)
                                {
                                    Config.message(Config.language("RideMadePanel", 32));
                                    return;
                                }
                                if (this.slotarr[1].item != null && Holder.item._itemData.finegrade >= this.slotarr[1].item._itemData.finegrade)
                                {
                                    Config.message(Config.language("RideMadePanel", 33));
                                    return;
                                }
                            }
                            if (this.slotarr[1] == _loc_2)
                            {
                                if (this.slotarr[0].item != null && this.slotarr[0].item._itemData.finegrade >= Holder.item._itemData.finegrade)
                                {
                                    Config.message(Config.language("RideMadePanel", 33));
                                    return;
                                }
                            }
                            _loc_2.item = Holder.item;
                            _loc_2.item._position = Holder.item._position;
                            Holder.item._drawer[Holder.item._position].item = Holder.item;
                            Holder.item = null;
                            if (this.slotarr[0].item != null && this.slotarr[1].item != null)
                            {
                                if (this.slotarr[2].item != null)
                                {
                                    this.slotarr[2].item.destroy();
                                    this.slotarr[2].item = null;
                                    this.tlabel22.text = Config.language("RideMadePanel", 20);
                                }
                                if (!this.checkb.selected)
                                {
                                    this.ridestoneNum = Config.ui._charUI.getItemAmount(94398) + Config.ui._charUI.getItemAmount(806001);
                                }
                                else
                                {
                                    this.ridestoneNum = Config.ui._charUI.getItemAmount(806001);
                                }
                                _loc_13 = new Item(Config._itemMap[this.slotarr[0].item._itemData.id], 0, 0, UNIT_TYPE_ENUM.TYPEID_ITEMCLONE, 0);
                                if (this.slotarr[1].item._itemData.finegrade > Config._itemMap[this.slotarr[0].item._itemData.id].relatedId)
                                {
                                    _loc_14 = Config._itemMap[this.slotarr[0].item._itemData.id].relatedId;
                                }
                                else
                                {
                                    _loc_14 = this.slotarr[1].item._itemData.finegrade;
                                }
                                _loc_13.star = _loc_14;
                                if (this.slotarr[0].item._itemData.binding == 1 || this.slotarr[1].item._itemData.binding == 1)
                                {
                                    _loc_13._itemData.binding = 1;
                                }
                                if (this.slotarr[0].item._itemData.addEffect.length > 0 || this.slotarr[1].item._itemData.addEffect.length > 0)
                                {
                                    _loc_26 = [];
                                    _loc_27 = 0;
                                    if (this.slotarr[0].item._itemData.addEffect.length >= this.slotarr[1].item._itemData.addEffect.length)
                                    {
                                        _loc_27 = 0;
                                        while (_loc_27 < this.slotarr[0].item._itemData.addEffect.length)
                                        {
                                            
                                            _loc_28 = {};
                                            _loc_28.id = this.slotarr[0].item._itemData.addEffect[_loc_27].id;
                                            _loc_28.value = this.slotarr[0].item._itemData.addEffect[_loc_27].value;
                                            _loc_28.state = this.slotarr[0].item._itemData.addEffect[_loc_27].state;
                                            _loc_26.push(_loc_28);
                                            _loc_27++;
                                        }
                                        _loc_27 = 0;
                                        while (_loc_27 < this.slotarr[1].item._itemData.addEffect.length)
                                        {
                                            
                                            if (this.slotarr[1].item._itemData.addEffect[_loc_27].value > this.slotarr[0].item._itemData.addEffect[_loc_27].value)
                                            {
                                                _loc_28 = {};
                                                _loc_28.id = this.slotarr[1].item._itemData.addEffect[_loc_27].id;
                                                _loc_28.value = this.slotarr[1].item._itemData.addEffect[_loc_27].value;
                                                _loc_28.state = this.slotarr[1].item._itemData.addEffect[_loc_27].state;
                                                _loc_26[_loc_27] = _loc_28;
                                            }
                                            _loc_27++;
                                        }
                                    }
                                    else
                                    {
                                        _loc_27 = 0;
                                        while (_loc_27 < this.slotarr[1].item._itemData.addEffect.length)
                                        {
                                            
                                            _loc_28 = {};
                                            _loc_28.id = this.slotarr[1].item._itemData.addEffect[_loc_27].id;
                                            _loc_28.value = this.slotarr[1].item._itemData.addEffect[_loc_27].value;
                                            _loc_28.state = this.slotarr[1].item._itemData.addEffect[_loc_27].state;
                                            _loc_26.push(_loc_28);
                                            _loc_27++;
                                        }
                                        _loc_27 = 0;
                                        while (_loc_27 < this.slotarr[0].item._itemData.addEffect.length)
                                        {
                                            
                                            if (this.slotarr[0].item._itemData.addEffect[_loc_27].value > this.slotarr[1].item._itemData.addEffect[_loc_27].value)
                                            {
                                                _loc_28 = {};
                                                _loc_28.id = this.slotarr[0].item._itemData.addEffect[_loc_27].id;
                                                _loc_28.value = this.slotarr[0].item._itemData.addEffect[_loc_27].value;
                                                _loc_28.state = this.slotarr[0].item._itemData.addEffect[_loc_27].state;
                                                _loc_26[_loc_27] = _loc_28;
                                            }
                                            _loc_27++;
                                        }
                                    }
                                    _loc_13._itemData.addEffect = _loc_26;
                                }
                                _loc_13.display();
                                this.slotarr[2].item = _loc_13;
                                if (Config._itemMap[this.slotarr[0].item._itemData.id].relatedId == 20 && this.slotarr[1].item._itemData.finegrade > 20)
                                {
                                    this.wingst = Config._wingRidelucky[20].ridemoney;
                                }
                                else
                                {
                                    this.wingst = Config._wingRidelucky[_loc_14].ridemoney;
                                }
                                if (this.ridestoneNum >= this.wingst)
                                {
                                    _loc_15 = "#399765";
                                }
                                else
                                {
                                    _loc_15 = "#ad1b2e";
                                }
                                this.tlabel22.text = Config.language("RideMadePanel", 20) + "<font color=\'" + _loc_15 + "\'>" + this.ridestoneNum + "/" + this.wingst + "</font>";
                            }
                        }
                        else
                        {
                            Config.message(Config.language("RideMadePanel", 34));
                        }
                    }
                }
                if (this.holeRb.selected)
                {
                    _loc_31 = 10000;
                    if (Holder.item == null)
                    {
                        if (_loc_2.item != null)
                        {
                            if (this.slotarr[0] == _loc_2)
                            {
                                this.slotarr[0].item = null;
                                this.tlabel32.text = "";
                            }
                            else if (this.slotarr[1] == _loc_2)
                            {
                                this.slotarr[1].item = null;
                            }
                        }
                    }
                    else if (Holder.item._drawer == Config.ui._charUI._slotArray)
                    {
                        if (Config.ui._charUI.getPosite(int(Holder.item._position)) == 2)
                        {
                            Config.message(Config.language("RideMadePanel", 29));
                            return;
                        }
                        if (this.slotarr[0] == _loc_2)
                        {
                            if (Holder.item._itemData.type == 4 && Holder.item._itemData.subType == 11)
                            {
                                this.startbtn2.enabled = true;
                                _loc_2.item = Holder.item;
                                _loc_2.item._position = Holder.item._position;
                                Holder.item._drawer[Holder.item._position].item = Holder.item;
                                Holder.item = null;
                                for (_loc_32 in Config._mounts)
                                {
                                    
                                    _loc_33 = Config._mounts[_loc_32].mounts_s.split("|");
                                    _loc_16 = 0;
                                    while (_loc_16 < _loc_33.length)
                                    {
                                        
                                        if (_loc_2.item._itemData.id == _loc_33[_loc_16])
                                        {
                                            if (_loc_33.length == 1)
                                            {
                                                this.tlabel32.text = "<font color=\'" + Style.FONT_Red + "\'>" + Config.language("RideMadePanel", 35) + "</font>";
                                                this.startbtn2.enabled = false;
                                                _loc_31 = 0;
                                            }
                                            else
                                            {
                                                this.tlabel32.text = Config.language("RideMadePanel", 36, Style.FONT_Red, _loc_33.length);
                                            }
                                        }
                                        _loc_16 = _loc_16 + 1;
                                    }
                                }
                            }
                            else
                            {
                                Config.message(Config.language("RideMadePanel", 38));
                            }
                        }
                        if (this.slotarr[1] == _loc_2)
                        {
                            if (Holder.item._itemData.type == 8 && Holder.item._itemData.subType == 11)
                            {
                                _loc_2.item = Holder.item;
                                _loc_2.item._position = Holder.item._position;
                                Holder.item._drawer[Holder.item._position].item = Holder.item;
                                Holder.item = null;
                            }
                            else
                            {
                                Config.message(Config.language("RideMadePanel", 28));
                            }
                        }
                    }
                }
            }
            return;
        }// end function

        private function handleSlotOver(event:Event) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = event.currentTarget;
            if (_loc_2.item != null)
            {
                Holder.showInfo(_loc_2.item.outputInfo(), new Rectangle(_loc_2.x + this.x, _loc_2.y + this.y, _loc_2._size, _loc_2._size), false, 0, 250, _loc_2.item.star);
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

        private function removeallchild(param1:Sprite) : void
        {
            if (this.holeRb.selected)
            {
                Config.ui._charUI.removeEventListener("itemchange", this.sussespercent);
            }
            while (param1.numChildren > 0)
            {
                
                param1.removeChildAt((param1.numChildren - 1));
            }
            if (this.washIcon != null)
            {
                if (this.washIcon.item != null)
                {
                    this.washIcon.item.destroy();
                }
            }
            return;
        }// end function

        public function get equipfinelucky()
        {
            return this._equipfinelucky;
        }// end function

        public function set equipfinelucky(param1:Number)
        {
            this._equipfinelucky = param1;
            return;
        }// end function

        private function getShengXingChengGongTf()
        {
            var _loc_1:* = Config.getSimpleTextField();
            _loc_1.defaultTextFormat = new TextFormat(null, 18, 16711680, true);
            _loc_1.text = Config.language("EquipMadePanel", 129);
            _loc_1.alpha = 0;
            addChild(_loc_1);
            return _loc_1;
        }// end function

        public function shengXingChengGong(param1 = 0)
        {
            var _loc_2:* = this.getShengXingChengGongTf();
            var _loc_3:* = {};
            if (param1 == 0)
            {
                _loc_2.x = 10;
                _loc_2.y = 120;
                _loc_3.y = 80;
            }
            else
            {
                _loc_2.x = 80;
                _loc_2.y = 220;
                _loc_3.y = 180;
            }
            _loc_3.count = 0;
            _loc_3.tf = _loc_2;
            this._shengXingChengGongStack.push(_loc_3);
            if (this._shengXingChengGongStack.length == 1)
            {
                Config.startLoop(this.shengXingChengGongLoop);
            }
            return;
        }// end function

        private function shengXingChengGongLoop(param1)
        {
            var _loc_3:* = undefined;
            var _loc_2:* = 0;
            while (_loc_2 < this._shengXingChengGongStack.length)
            {
                
                _loc_3 = this._shengXingChengGongStack[_loc_2];
                if (_loc_2 == (this._shengXingChengGongStack.length - 1))
                {
                    if (_loc_3.count <= 30)
                    {
                        if (_loc_3.tf.alpha < 1)
                        {
                            _loc_3.tf.alpha = _loc_3.tf.alpha + 0.1;
                        }
                        _loc_3.tf.y = _loc_3.tf.y + (_loc_3.y - _loc_3.tf.y) / 2;
                        var _loc_4:* = _loc_3;
                        var _loc_5:* = _loc_3.count + 1;
                        _loc_4.count = _loc_5;
                    }
                    else if (_loc_3.count <= 90)
                    {
                        var _loc_4:* = _loc_3;
                        var _loc_5:* = _loc_3.count + 1;
                        _loc_4.count = _loc_5;
                    }
                    else
                    {
                        _loc_3.tf.y = _loc_3.tf.y - 5 / _loc_3.tf.alpha;
                        _loc_3.tf.alpha = _loc_3.tf.alpha - 0.1;
                        if (_loc_3.tf.alpha <= 0)
                        {
                            removeChild(_loc_3.tf);
                            this._shengXingChengGongStack.splice(_loc_2, 1);
                            _loc_2 = _loc_2 - 1;
                        }
                    }
                }
                else
                {
                    _loc_3.tf.y = _loc_3.tf.y - 5 / _loc_3.tf.alpha;
                    _loc_3.tf.alpha = _loc_3.tf.alpha - 0.1;
                    if (_loc_3.tf.alpha <= 0)
                    {
                        removeChild(_loc_3.tf);
                        this._shengXingChengGongStack.splice(_loc_2, 1);
                        _loc_2 = _loc_2 - 1;
                    }
                }
                _loc_2 = _loc_2 + 1;
            }
            if (this._shengXingChengGongStack.length == 0)
            {
                Config.stopLoop(this.shengXingChengGongLoop);
            }
            return;
        }// end function

        public function backequperr(param1:int)
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            this.startbtn1.enabled = true;
            switch(param1)
            {
                case 0:
                {
                    if (Config.ui._charUI._slotArray[this.equitempos1].item != null)
                    {
                        this.slotarr[0].item = Config.ui._charUI._slotArray[this.equitempos1].item;
                        _loc_2 = int(this.slotarr[0].item._itemData.finegrade);
                        if (this.topbtn.selectpage == 0)
                        {
                            this.shengXingChengGong(0);
                            if (_loc_2 < 30)
                            {
                                if (this.closeflag1)
                                {
                                    _loc_3 = new DataSet();
                                    _loc_3.addHead(CONST_ENUM.C2G_EQUIP_UPGRADE_ACTIVITY_PROBABILITY);
                                    _loc_3.add8(int(this.slotarr[0].item._itemData.quality));
                                    _loc_3.add8((_loc_2 + 1));
                                    ClientSocket.send(_loc_3);
                                }
                                this.fineprecent = Number(Config._equipfineprobability[(_loc_2 + 1)].rate) / 100;
                            }
                            else
                            {
                                this.fineprecent = 1;
                            }
                            if (!this.closeflag1)
                            {
                                if (this.fineprecent > 0)
                                {
                                    if (100 / this.fineprecent == 1 && this._tol > 0)
                                    {
                                        this.pdnum.value = 1;
                                    }
                                    else if (this._tol > Math.ceil(100 / this.fineprecent))
                                    {
                                        this.pdnum.maximum = Math.ceil(100 / this.fineprecent);
                                        this.pdnum.value = Math.ceil(100 / this.fineprecent);
                                    }
                                    else
                                    {
                                        this.pdnum.maximum = this._tol;
                                        this.pdnum.value = this._tol;
                                    }
                                }
                            }
                            GuideUI.testDoId(192);
                        }
                        else if (this.topbtn.selectpage == 1)
                        {
                            this.shengXingChengGong(1);
                            if (_loc_2 < 60)
                            {
                                this.wingFineprecent = Number(Config._wingRidelucky[(_loc_2 + 1)].sussesion1) / 100;
                            }
                            else
                            {
                                this.wingFineprecent = 1;
                            }
                            if (this.wingFineprecent > 0)
                            {
                                if (100 / this.wingFineprecent == 1 && this._tol > 0)
                                {
                                    this.pdnum.value = 1;
                                }
                                else if (this._tol > Math.ceil(100 / this.wingFineprecent))
                                {
                                    this.pdnum.maximum = Math.ceil(100 / this.wingFineprecent);
                                    this.pdnum.value = Math.ceil(100 / this.wingFineprecent);
                                }
                                else
                                {
                                    this.pdnum.maximum = this._tol;
                                    this.pdnum.value = this._tol;
                                }
                            }
                        }
                        else if (this.topbtn.selectpage == 2)
                        {
                            this.shengXingChengGong(2);
                            if (_loc_2 < 60)
                            {
                                this.rideFinePrecent = Number(Config._wingRidelucky[(_loc_2 + 1)].sussesion1) / 100;
                            }
                            else
                            {
                                this.rideFinePrecent = 1;
                            }
                            if (this.rideFinePrecent > 0)
                            {
                                if (100 / this.rideFinePrecent == 1 && this._tol > 0)
                                {
                                    this.pdnum.value = 1;
                                }
                                else if (this._tol > Math.ceil(100 / this.rideFinePrecent))
                                {
                                    this.pdnum.maximum = Math.ceil(100 / this.rideFinePrecent);
                                    this.pdnum.value = Math.ceil(100 / this.rideFinePrecent);
                                }
                                else
                                {
                                    this.pdnum.maximum = this._tol;
                                    this.pdnum.value = this._tol;
                                }
                            }
                        }
                    }
                    this.sussespercent();
                    Config.message(Config.language("EquipMadePanel", 62));
                    break;
                }
                case 409:
                {
                    Config.message(Config.language("EquipMadePanel", 63));
                    break;
                }
                case 413:
                {
                    Config.message(Config.language("EquipMadePanel", 64));
                    break;
                }
                case 414:
                {
                    Config.message(Config.language("EquipMadePanel", 65));
                    break;
                }
                case 415:
                {
                    Config.message(Config.language("EquipMadePanel", 66));
                    break;
                }
                case 416:
                {
                    Config.message(Config.language("EquipMadePanel", 67));
                    break;
                }
                case 419:
                {
                    Config.message(Config.language("EquipMadePanel", 68));
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function backwasherr(param1:int)
        {
            this.startbtn1.enabled = true;
            switch(param1)
            {
                case 0:
                {
                    if (int(Config.ui._charUI._slotArray[this.equitempos1].item._itemData.washgrade + this.washinitprop) > this.forewashgrade && this.flagalert)
                    {
                        this.flagalert = false;
                        AlertUI.alert(Config.language("EquipMadePanel", 70), Config.language("EquipMadePanel", 71), [Config.language("EquipMadePanel", 28)], [this.closeAlert]);
                        this.startbtn1.enabled = false;
                    }
                    if (Config.ui._charUI._slotArray[this.equitempos1].item != null)
                    {
                        this.slotarr[0].item = Config.ui._charUI._slotArray[this.equitempos1].item;
                        this.showashstone(1);
                    }
                    break;
                }
                case 409:
                {
                    Config.message(Config.language("EquipMadePanel", 72));
                    break;
                }
                case 410:
                {
                    Config.message(Config.language("EquipMadePanel", 73));
                    break;
                }
                case 411:
                {
                    Config.message(Config.language("EquipMadePanel", 74));
                    break;
                }
                case 412:
                {
                    Config.message(Config.language("EquipMadePanel", 75));
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function cardin(event:MouseEvent = null) : void
        {
            var _loc_6:* = 0;
            this.removeallchild(this.mainPan);
            this.takeJewbtn = [];
            this.jewslotarr = [];
            this.slotarr = [];
            var _loc_2:* = new CloneSlot(0, 32);
            this.mainPan.addChild(_loc_2);
            _loc_2.x = 110;
            _loc_2.y = 95;
            _loc_2.addEventListener("sglClick", this.handleSlotClick);
            _loc_2.addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
            _loc_2.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
            var _loc_3:* = new Label(this.mainPan, 113, 130);
            _loc_3.text = Config.language("EquipMadePanel", 76);
            this.slotarr.push(_loc_2);
            var _loc_4:* = 0;
            while (_loc_4 < 3)
            {
                
                _loc_6 = 70 * _loc_4 + 35;
                this.takeJewbtn[_loc_4] = new PushButton(this.mainPan, _loc_6, 215, Config.language("EquipMadePanel", 130), Config.create(this.clicktakejew, _loc_4));
                this.takeJewbtn[_loc_4].name = String(_loc_4);
                this.takeJewbtn[_loc_4].width = 40;
                this.takeJewbtn[_loc_4].visible = false;
                _loc_4 = _loc_4 + 1;
            }
            var _loc_5:* = new PushButton(this.mainPan, 105, 260, Config.language("EquipMadePanel", 77), this.sendmosaic);
            new PushButton(this.mainPan, 105, 260, Config.language("EquipMadePanel", 77), this.sendmosaic).width = 50;
            return;
        }// end function

        private function clicktakejew(event:MouseEvent, param2:uint)
        {
            var _loc_3:* = 0;
            if (this.slotarr[0].item != null)
            {
                _loc_3 = int(Config._itemMap[this.slotarr[0].item._itemData.gem[param2].id].quality) - 1;
                if (this._alertIndex >= 0)
                {
                    AlertUI.remove(this._alertIndex);
                }
                this._alertIndex = AlertUI.alert(Config.language("EquipMadePanel", 131), Config.language("EquipMadePanel", 132, this.castMoney[_loc_3]), [Config.language("EquipMadePanel", 28), Config.language("EquipMadePanel", 29)], [Config.create(this.sendtakejew, param2)]);
            }
            return;
        }// end function

        private function sendtakejew(param1, param2)
        {
            var _loc_3:* = null;
            if (this.slotarr[0].item != null)
            {
                this.equipposition = this.slotarr[0].item._position;
                _loc_3 = new DataSet();
                _loc_3.addHead(CONST_ENUM.C2G_STONE_DISMOUNT);
                _loc_3.add16(this.equipposition);
                _loc_3.add8((param2 + 1));
                ClientSocket.send(_loc_3);
            }
            return;
        }// end function

        private function sendmosaic(event:MouseEvent) : void
        {
            if (this.slotarr[0].item != null)
            {
                if (this.slotarr[0].item._itemData.binding != 1)
                {
                    AlertUI.alert(Config.language("EquipMadePanel", 26), Config.language("EquipMadePanel", 133), [Config.language("EquipMadePanel", 28), Config.language("EquipMadePanel", 29)], [this.sureorbing]);
                }
                else
                {
                    this.sureorbing();
                }
            }
            return;
        }// end function

        private function sureorbing(event:MouseEvent = null) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = undefined;
            if (this.slotarr[0].item != null)
            {
                _loc_2 = 0;
                _loc_3 = 0;
                _loc_4 = new Array();
                _loc_5 = new DataSet();
                _loc_3 = 0;
                while (_loc_3 < this.jewslotarr.length)
                {
                    
                    if (this.jewslotarr[_loc_3].item != null && this.jewslotarr[_loc_3].item._data.id != this.slotarr[0].item._itemData.gem[_loc_3].id)
                    {
                        _loc_6 = new Object();
                        _loc_6.holepos = _loc_3 + 1;
                        _loc_6.holeId = this.jewslotarr[_loc_3].item._data.id;
                        _loc_4.push(_loc_6);
                        _loc_2 = _loc_2 + 1;
                    }
                    _loc_3 = _loc_3 + 1;
                }
                if (_loc_2 > 0)
                {
                    _loc_5.addHead(CONST_ENUM.CMSG_STONE_ENCHASE);
                    _loc_5.add16(this.slotarr[0].item._position);
                    _loc_5.add8(_loc_2);
                    _loc_3 = 0;
                    while (_loc_3 < _loc_2)
                    {
                        
                        _loc_5.add8(_loc_4[_loc_3].holepos);
                        _loc_5.add32(_loc_4[_loc_3].holeId);
                        _loc_3 = _loc_3 + 1;
                    }
                    ClientSocket.send(_loc_5);
                    this.pos = this.slotarr[0].item._position;
                }
                else
                {
                    Config.message(Config.language("EquipMadePanel", 78));
                }
            }
            return;
        }// end function

        private function jewelslotclick(event:MouseEvent, param2:uint, param3:uint)
        {
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = undefined;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            if (this.slotarr[0].item != null)
            {
                if (!this.slotarr[0].item._itemData.gem[param2].open)
                {
                    AlertUI.alert(Config.language("EquipMadePanel", 79), Config.language("EquipMadePanel", 80), [Config.language("EquipMadePanel", 28), Config.language("EquipMadePanel", 29)], [Config.create(this.sendopenhole, param2)]);
                }
                else if (Holder.item != null)
                {
                    if (int(Holder.item._itemData.type) == 3)
                    {
                        if (this.slotarr[0].item._itemData.gem[param2].id > 0)
                        {
                            Config.message(Config.language("EquipMadePanel", 134));
                            return;
                        }
                        if (int(this.slotarr[0].item._itemData.reqLevel) >= int(Holder.item._itemData.reqLevel))
                        {
                            if (Config.ui._charUI.getItemAmount(Holder.item._itemData.id) < 3)
                            {
                                _loc_7 = 0;
                                _loc_8 = 0;
                                while (_loc_8 < this.slotarr[0].item._itemData.gem.length)
                                {
                                    
                                    if (this.jewslotarr[_loc_8].item != null)
                                    {
                                        if (this.jewslotarr[_loc_8].item._itemData.id == Holder.item._itemData.id)
                                        {
                                            _loc_7 = _loc_7 + 1;
                                        }
                                    }
                                    _loc_8 = _loc_8 + 1;
                                }
                                if (Config.ui._charUI.getItemAmount(Holder.item._itemData.id) <= _loc_7)
                                {
                                    _loc_8 = 0;
                                    while (_loc_8 < this.slotarr[0].item._itemData.gem.length)
                                    {
                                        
                                        if (this.jewslotarr[_loc_8].item != null)
                                        {
                                            if (this.jewslotarr[_loc_8].item._itemData.id == Holder.item._itemData.id)
                                            {
                                                if (this.slotarr[0].item._itemData.gem[_loc_8].id > 0 && this.slotarr[0].item._itemData.gem[_loc_8].id == this.jewslotarr[_loc_8].item._itemData.id)
                                                {
                                                }
                                                else
                                                {
                                                    this.jewslotarr[_loc_8].item.destroy();
                                                    if (this.slotarr[0].item._itemData.gem[_loc_8].id > 0)
                                                    {
                                                        _loc_4 = new Item(Config._itemMap[this.slotarr[0].item._itemData.gem[_loc_8].id], 0, 0, UNIT_TYPE_ENUM.TYPEID_ITEMCLONE, 0);
                                                        _loc_4.display();
                                                        this.jewslotarr[_loc_8].item = _loc_4;
                                                        if (param3 == 1)
                                                        {
                                                            this.jewslotarr[_loc_8]._bgTable.setTable("table27");
                                                        }
                                                        else if (param3 == 2)
                                                        {
                                                            this.jewslotarr[_loc_8]._bgTable.setTable("table28");
                                                        }
                                                        else
                                                        {
                                                            this.jewslotarr[_loc_8]._bgTable.setTable("table30");
                                                        }
                                                    }
                                                    break;
                                                }
                                            }
                                        }
                                        _loc_8 = _loc_8 + 1;
                                    }
                                }
                            }
                            if (param3 == 1)
                            {
                                if (int(Holder.item._itemData.subType) != 1)
                                {
                                    Config.message(Config.language("EquipMadePanel", 82));
                                    return;
                                }
                                this.jewslotarr[param2]._bgTable.setTable("table26");
                            }
                            else if (param3 == 2)
                            {
                                if (int(Holder.item._itemData.subType) != 2)
                                {
                                    Config.message(Config.language("EquipMadePanel", 83));
                                    return;
                                }
                                this.jewslotarr[param2]._bgTable.setTable("table25");
                            }
                            else
                            {
                                this.jewslotarr[param2]._bgTable.setTable("table29");
                            }
                            _loc_4 = Item.newItem(Config._itemMap[Holder.item._itemData.baseID], 0, 0, UNIT_TYPE_ENUM.TYPEID_ITEMCLONE, 0);
                            _loc_4.display();
                            if (this.jewslotarr[param2].item != null)
                            {
                                this.jewslotarr[param2].item.destroy();
                            }
                            _loc_4._position = Holder.item._position;
                            this.jewslotarr[param2].item = _loc_4;
                            Holder.item._drawer[Holder.item._position].item = Holder.item;
                            Holder.item = null;
                            _loc_6 = 0;
                            while (_loc_6 < this.jewslotarr.length)
                            {
                                
                                if (this.jewslotarr[_loc_6].item != null)
                                {
                                    if (this.jewslotarr[_loc_6].item._data.id != this.slotarr[0].item._itemData.gem[_loc_6].id)
                                    {
                                        _loc_5 = _loc_5 + 1;
                                    }
                                }
                                _loc_6 = _loc_6 + 1;
                            }
                        }
                        else
                        {
                            Config.message(Config.language("EquipMadePanel", 85));
                        }
                    }
                    else
                    {
                        Config.message(Config.language("EquipMadePanel", 86));
                    }
                }
                else if (this.jewslotarr[param2].item != null)
                {
                    if (this.jewslotarr[param2].item._data.id != this.slotarr[0].item._itemData.gem[param2].id)
                    {
                        this.jewslotarr[param2].item.destroy();
                        if (this.slotarr[0].item._itemData.gem[param2].id != 0)
                        {
                            _loc_4 = new Item(Config._itemMap[this.slotarr[0].item._itemData.gem[param2].id], 0, 0, UNIT_TYPE_ENUM.TYPEID_ITEMCLONE, 0);
                            _loc_4.display();
                            this.jewslotarr[param2].item = _loc_4;
                            if (param3 == 1)
                            {
                                this.jewslotarr[param2]._bgTable.setTable("table27");
                            }
                            else if (param3 == 2)
                            {
                                this.jewslotarr[param2]._bgTable.setTable("table28");
                            }
                            else
                            {
                                this.jewslotarr[param2]._bgTable.setTable("table30");
                            }
                        }
                    }
                    _loc_6 = 0;
                    while (_loc_6 < this.jewslotarr.length)
                    {
                        
                        if (this.jewslotarr[_loc_6].item != null)
                        {
                            if (this.jewslotarr[_loc_6].item._data.id != this.slotarr[0].item._itemData.gem[_loc_6].id)
                            {
                                _loc_5 = _loc_5 + 1;
                            }
                        }
                        _loc_6 = _loc_6 + 1;
                    }
                }
                else
                {
                    Config.message(Config.language("EquipMadePanel", 88));
                }
            }
            return;
        }// end function

        private function sendopenhole(param1, param2:int)
        {
            var _loc_3:* = null;
            if (this.slotarr[0].item != null)
            {
                _loc_3 = new DataSet();
                _loc_3.addHead(CONST_ENUM.CMSG_STONE_PUNCH);
                _loc_3.add16(this.slotarr[0].item._position);
                this.pos = this.slotarr[0].item._position;
                _loc_3.add8((param2 + 1));
                ClientSocket.send(_loc_3);
            }
            return;
        }// end function

        public function backjewelopenerr(param1:int)
        {
            switch(param1)
            {
                case 0:
                {
                    this.slotarr[0].item = Config.ui._charUI._slotArray[this.pos].item;
                    this.handleSlotClick();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function backjewelcaserr(param1:int)
        {
            switch(param1)
            {
                case 0:
                {
                    this.slotarr[0].item = Config.ui._charUI._slotArray[this.pos].item;
                    this.handleSlotClick();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function ridemade(event:MouseEvent)
        {
            this.washRb.label = Config.language("EquipMadePanel", 16);
            this.fineRb.label = Config.language("EquipMadePanel", 107);
            this.holeRb.label = Config.language("EquipMadePanel", 108);
            this.washRb.selected = true;
            this.holeRb.visible = true;
            this.initridefinepanel();
            return;
        }// end function

        private function initridefinepanel()
        {
            var _loc_1:* = "mi0033";
            this.initfine(_loc_1);
            this.startbtn1 = new PushButton(this.mainPan, 140, 255, Config.language("EquipMadePanel", 16), this.sendridefine);
            this.startbtn1.width = 80;
            return;
        }// end function

        private function sendridefine(event:MouseEvent)
        {
            if (this.startbtn1.enabled)
            {
                if (this.slotarr[0].item != null)
                {
                    if (this.pdnum.value > 0)
                    {
                        if (this.ifUseLock.selected || this.slotarr[0].item._itemData.binding == 1 || int(Config.ui._charUI.getItemAmount(94400)) == 0)
                        {
                            this.senddata();
                        }
                        else
                        {
                            this.startbtn1.enabled = false;
                            AlertUI.alert(Config.language("RideMadePanel", 11), Config.language("RideMadePanel", 12), [Config.language("RideMadePanel", 13), Config.language("RideMadePanel", 14)], [this.senddata, this.finecansel]);
                        }
                    }
                    else
                    {
                        Config.message(Config.language("RideMadePanel", 15));
                    }
                }
                else
                {
                    Config.message(Config.language("RideMadePanel", 16));
                }
            }
            return;
        }// end function

        private function finecansel(event:MouseEvent)
        {
            this.startbtn1.enabled = true;
            return;
        }// end function

        private function initremovefinepanel()
        {
            var _loc_1:* = null;
            var _loc_3:* = undefined;
            this.removeallchild(this.mainPan);
            this.slotarr = new Array();
            if (this.topbtn.selectpage == 0)
            {
                _loc_1 = new Label(this.mainPan, 57, 85, Config.language("EquipMadePanel", 147));
                _loc_1 = new Label(this.mainPan, 150, 85);
                _loc_1.html = true;
                _loc_1.text = Config.language("EquipMadePanel", 148);
                _loc_1 = new Label(this.mainPan, 100, 150, Config.language("EquipMadePanel", 111));
                _loc_1 = new Label(this.mainPan, 10, 262);
                _loc_1.html = true;
                _loc_1.text = "<font color=\'#ad1b2e\'>" + Config.language("EquipMadePanel", 149) + "<font>";
                this.tlabel22 = new Label(this.mainPan, 10, 235, Config.language("EquipMadePanel", 142));
                this.tlabel22.html = true;
                this.startbtn2 = new PushButton(this.mainPan, 160, 260, Config.language("EquipMadePanel", 112), this.sendremovequp);
                this.startbtn2.width = 40;
                this.checkb = new CheckBox(this.mainPan, 50, 212, Config.language("EquipMadePanel", 154), this.equpmovestone);
                this.checkb.selected = false;
            }
            else if (this.topbtn.selectpage == 1)
            {
                _loc_1 = new Label(this.mainPan, 57, 85, Config.language("EquipMadePanel", 109));
                _loc_1 = new Label(this.mainPan, 150, 85, Config.language("EquipMadePanel", 110));
                _loc_1 = new Label(this.mainPan, 100, 150, Config.language("EquipMadePanel", 111));
                _loc_1 = new Label(this.mainPan, 10, 262);
                _loc_1.html = true;
                _loc_1.text = "<font color=\'#ad1b2e\'>" + Config.language("EquipMadePanel", 158) + "<font>";
                this.tlabel22 = new Label(this.mainPan, 10, 235, Config.language("EquipMadePanel", 98));
                this.tlabel22.html = true;
                this.startbtn2 = new PushButton(this.mainPan, 160, 260, Config.language("EquipMadePanel", 112), this.sendremovewing);
                this.startbtn2.width = 40;
                this.checkb = new CheckBox(this.mainPan, 50, 212, Config.language("EquipMadePanel", 120), this.wingmovestone);
                this.checkb.selected = false;
            }
            else if (this.topbtn.selectpage == 2)
            {
                _loc_1 = new Label(this.mainPan, 57, 85, Config.language("RideMadePanel", 17));
                _loc_1 = new Label(this.mainPan, 150, 85, Config.language("RideMadePanel", 18));
                _loc_1 = new Label(this.mainPan, 100, 150, Config.language("RideMadePanel", 19));
                _loc_1 = new Label(this.mainPan, 10, 262);
                _loc_1.html = true;
                _loc_1.text = "<font color=\'#ad1b2e\'>" + Config.language("EquipMadePanel", 158) + "<font>";
                this.tlabel22 = new Label(this.mainPan, 10, 235, Config.language("RideMadePanel", 20));
                this.tlabel22.html = true;
                this.startbtn2 = new PushButton(this.mainPan, 160, 260, Config.language("RideMadePanel", 21), this.clickmovefine);
                this.startbtn2.width = 40;
                this.checkb = new CheckBox(this.mainPan, 50, 212, Config.language("EquipMadePanel", 121), this.ridemovestone);
                this.checkb.selected = false;
            }
            this.clicklab2 = new ClickLabel(this.mainPan, 180, 235, Config.language("EquipMadePanel", 122), this.openshoppanel, true);
            this.clicklab2.clickColor([3295734, 44799]);
            var _loc_2:* = 0;
            while (_loc_2 < 3)
            {
                
                _loc_3 = new CloneSlot(0, 32);
                this.mainPan.addChild(_loc_3);
                if (_loc_2 < 2)
                {
                    _loc_3.x = _loc_2 * 100 + 60;
                    _loc_3.y = 105;
                    _loc_3.addEventListener("sglClick", this.handleSlotClick);
                }
                else
                {
                    _loc_3.x = 110;
                    _loc_3.y = 170;
                }
                _loc_3.addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
                _loc_3.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
                this.slotarr.push(_loc_3);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        private function equpmovestone(param1)
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = undefined;
            if (this.topbtn.selectpage == 0 && this.fineRb.selected)
            {
                if (this.slotarr[0].item != null && this.slotarr[1].item != null)
                {
                    _loc_2 = 0;
                    _loc_3 = 0;
                    if (this.slotarr[0].item._itemData.quality == 6)
                    {
                        _loc_2 = 94506;
                        _loc_3 = 802050;
                    }
                    else if (this.slotarr[0].item._itemData.quality == 7 || this.slotarr[0].item._itemData.quality == 8 || this.slotarr[0].item._itemData.quality == 9 || this.slotarr[0].item._itemData.quality == 10)
                    {
                        _loc_2 = 94507;
                        _loc_3 = 802051;
                    }
                    if (!this.checkb.selected)
                    {
                        this.equpstoneNum = Config.ui._charUI.getItemAmount(_loc_2) + Config.ui._charUI.getItemAmount(_loc_3);
                    }
                    else
                    {
                        this.equpstoneNum = Config.ui._charUI.getItemAmount(_loc_3);
                    }
                    if (this.equpstoneNum >= this.wingst)
                    {
                        _loc_4 = "#399765";
                    }
                    else
                    {
                        _loc_4 = "#ad1b2e";
                    }
                    this.tlabel22.text = Config.language("EquipMadePanel", 142) + "<font color=\'" + _loc_4 + "\'>" + this.equpstoneNum + "/" + this.wingst + "</font>";
                }
            }
            return;
        }// end function

        private function wingmovestone(param1)
        {
            var _loc_2:* = undefined;
            if (this.topbtn.selectpage == 1 && this.fineRb.selected)
            {
                if (this.slotarr[0].item != null && this.slotarr[1].item != null)
                {
                    if (!this.checkb.selected)
                    {
                        this.wingstoneNum = Config.ui._charUI.getItemAmount(94501) + Config.ui._charUI.getItemAmount(802001);
                    }
                    else
                    {
                        this.wingstoneNum = Config.ui._charUI.getItemAmount(802001);
                    }
                    if (this.wingstoneNum >= this.wingst)
                    {
                        _loc_2 = "#399765";
                    }
                    else
                    {
                        _loc_2 = "#ad1b2e";
                    }
                    this.tlabel22.text = Config.language("EquipMadePanel", 98) + "<font color=\'" + _loc_2 + "\'>" + this.wingstoneNum + "/" + this.wingst + "</font>";
                }
            }
            return;
        }// end function

        private function ridemovestone(param1)
        {
            var _loc_2:* = undefined;
            if (this.topbtn.selectpage == 2 && this.fineRb.selected)
            {
                if (this.slotarr[0].item != null && this.slotarr[1].item != null)
                {
                    if (!this.checkb.selected)
                    {
                        this.ridestoneNum = Config.ui._charUI.getItemAmount(94398) + Config.ui._charUI.getItemAmount(806001);
                    }
                    else
                    {
                        this.ridestoneNum = Config.ui._charUI.getItemAmount(806001);
                    }
                    if (this.ridestoneNum >= this.wingst)
                    {
                        _loc_2 = "#399765";
                    }
                    else
                    {
                        _loc_2 = "#ad1b2e";
                    }
                    this.tlabel22.text = Config.language("RideMadePanel", 20) + "<font color=\'" + _loc_2 + "\'>" + this.ridestoneNum + "/" + this.wingst + "</font>";
                }
            }
            return;
        }// end function

        private function clickmovefine(event:MouseEvent)
        {
            if (this.startbtn2.enabled)
            {
                if (this.slotarr[0].item != null && this.slotarr[1].item != null)
                {
                    if (this.ridestoneNum >= this.wingst)
                    {
                        if (Config._itemMap[this.slotarr[0].item._itemData.id].relatedId == 20 && this.slotarr[1].item._itemData.finegrade > 20)
                        {
                            this.startbtn2.enabled = false;
                            AlertUI.alert(Config.language("RideMadePanel", 22), Config.language("RideMadePanel", 23), [Config.language("EquipMadePanel", 28), Config.language("EquipMadePanel", 29)], [this.okmovefine1, this.movecansel]);
                            return;
                        }
                        this.okmovefine1();
                    }
                    else
                    {
                        Config.message(Config.language("RideMadePanel", 135));
                    }
                }
                else
                {
                    Config.message(Config.language("EquipMadePanel", 113));
                }
            }
            return;
        }// end function

        private function okmovefine1(event:MouseEvent = null)
        {
            if (this.slotarr[0].item._itemData.binding == 1 || this.slotarr[1].item._itemData.binding == 1)
            {
                this.startbtn2.enabled = false;
                AlertUI.alert(Config.language("EquipMadePanel", 131), Config.language("EquipMadePanel", 136), [Config.language("EquipMadePanel", 28), Config.language("EquipMadePanel", 29)], [this.sendwingmovefine, this.movecansel]);
            }
            else if (!this.checkb.selected && Config.ui._charUI.getItemAmount(94501) > 0)
            {
                this.startbtn2.enabled = false;
                AlertUI.alert(Config.language("EquipMadePanel", 131), Config.language("EquipMadePanel", 137), [Config.language("EquipMadePanel", 28), Config.language("EquipMadePanel", 29)], [this.sendwingmovefine, this.movecansel]);
            }
            else
            {
                this.sendwingmovefine();
            }
            return;
        }// end function

        private function okmovefine(event:MouseEvent = null)
        {
            if (this.slotarr[0].item._itemData.binding == 1 || this.slotarr[1].item._itemData.binding == 1)
            {
                this.startbtn2.enabled = false;
                AlertUI.alert(Config.language("EquipMadePanel", 131), Config.language("EquipMadePanel", 138), [Config.language("EquipMadePanel", 28), Config.language("EquipMadePanel", 29)], [this.sendwingmovefine, this.movecansel]);
            }
            else if (!this.checkb.selected && Config.ui._charUI.getItemAmount(94501) > 0)
            {
                this.startbtn2.enabled = false;
                AlertUI.alert(Config.language("EquipMadePanel", 131), Config.language("EquipMadePanel", 139), [Config.language("EquipMadePanel", 28), Config.language("EquipMadePanel", 29)], [this.sendwingmovefine, this.movecansel]);
            }
            else
            {
                this.sendwingmovefine();
            }
            return;
        }// end function

        private function sendwingmovefine(event:MouseEvent = null)
        {
            this.startbtn2.enabled = true;
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.CMSG_EQUIP_TRANSFER);
            _loc_2.add16(this.slotarr[0].item._position);
            _loc_2.add16(this.slotarr[1].item._position);
            if (!this.checkb.selected)
            {
                _loc_2.add8(0);
            }
            else
            {
                _loc_2.add8(1);
            }
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function movecansel(event:MouseEvent)
        {
            this.startbtn2.enabled = true;
            return;
        }// end function

        public function backrideremovefine(param1:int)
        {
            if (param1 == 0 && this.slotarr[2].item != null)
            {
                this.slotarr[2].item.destroy();
                this.slotarr[2].item = null;
            }
            return;
        }// end function

        private function ridechangecolor()
        {
            var _loc_1:* = null;
            var _loc_3:* = null;
            this.removeallchild(this.mainPan);
            this.slotarr = [];
            _loc_1 = new Label(this.mainPan, 62, 100, Config.language("RideMadePanel", 24));
            _loc_1 = new Label(this.mainPan, 146, 100, Config.language("RideMadePanel", 25));
            this.tlabel32 = new Label(this.mainPan, 50, 180);
            this.tlabel32.html = true;
            this.startbtn2 = new PushButton(this.mainPan, 100, 255, Config.language("RideMadePanel", 27), this.sendchangecolor);
            this.startbtn2.width = 40;
            var _loc_2:* = 0;
            while (_loc_2 < 2)
            {
                
                _loc_3 = new CloneSlot(0, 32);
                this.mainPan.addChild(_loc_3);
                _loc_3.x = _loc_2 * 100 + 60;
                _loc_3.y = 120;
                _loc_3.addEventListener("sglClick", this.handleSlotClick);
                _loc_3.addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
                _loc_3.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
                this.slotarr.push(_loc_3);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        private function sendchangecolor(event:MouseEvent)
        {
            if (this.slotarr[0].item == null)
            {
                Config.message(Config.language("RideMadePanel", 16));
            }
            else if (this.slotarr[1].item == null)
            {
                Config.message(Config.language("RideMadePanel", 28));
            }
            else if (this.slotarr[0].item._itemData.binding != 1 && this.slotarr[1].item._itemData.binding == 1)
            {
                AlertUI.alert(Config.language("EquipMadePanel", 131), Config.language("EquipMadePanel", 157), [Config.language("EquipMadePanel", 28), Config.language("EquipMadePanel", 29)], [this.surechangecolor], {pos0:this.slotarr[0].item._position, pos1:this.slotarr[1].item._position});
            }
            else
            {
                this.surechangecolor({pos0:this.slotarr[0].item._position, pos1:this.slotarr[1].item._position});
            }
            return;
        }// end function

        private function surechangecolor(param1)
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_MOUNT_TRANSFERCOLOR);
            _loc_2.add16(param1.pos0);
            _loc_2.add16(param1.pos1);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function wingmade(event:MouseEvent)
        {
            this.washRb.label = Config.language("EquipMadePanel", 16);
            this.fineRb.label = Config.language("EquipMadePanel", 112);
            this.washRb.selected = true;
            this.holeRb.visible = false;
            this.initwingfinepanel();
            return;
        }// end function

        private function initwingfinepanel()
        {
            var _loc_1:* = "mi0032";
            this.initfine(_loc_1);
            this.startbtn1 = new PushButton(this.mainPan, 140, 255, Config.language("EquipMadePanel", 16), this.sendwingfine);
            this.startbtn1.width = 80;
            return;
        }// end function

        private function sendwingfine(event:MouseEvent)
        {
            if (this.startbtn1.enabled)
            {
                if (this.slotarr[0].item != null)
                {
                    if (this.pdnum.value > 0)
                    {
                        if (this.ifUseLock.selected || this.slotarr[0].item._itemData.binding == 1 || int(Config.ui._charUI.getItemAmount(94500)) == 0)
                        {
                            this.senddata();
                        }
                        else
                        {
                            this.startbtn1.enabled = false;
                            AlertUI.alert(Config.language("EquipMadePanel", 26), Config.language("EquipMadePanel", 27), [Config.language("EquipMadePanel", 28), Config.language("EquipMadePanel", 29)], [this.senddata, this.finecansel]);
                        }
                    }
                    else
                    {
                        Config.message(Config.language("EquipMadePanel", 30));
                    }
                }
                else
                {
                    Config.message(Config.language("EquipMadePanel", 114));
                }
            }
            return;
        }// end function

        private function sendremovewing(event:Event)
        {
            if (this.startbtn2.enabled)
            {
                if (this.slotarr[0].item != null && this.slotarr[1].item != null)
                {
                    if (this.wingstoneNum >= this.wingst)
                    {
                        if (Config._itemMap[this.slotarr[0].item._itemData.id].relatedId == 20 && this.slotarr[1].item._itemData.finegrade > 20)
                        {
                            this.startbtn2.enabled = false;
                            AlertUI.alert(Config.language("EquipMadePanel", 26), Config.language("EquipMadePanel", 115), [Config.language("EquipMadePanel", 28), Config.language("EquipMadePanel", 29)], [this.okmovefine, this.movecansel]);
                            return;
                        }
                        this.okmovefine();
                    }
                    else
                    {
                        Config.message(Config.language("EquipMadePanel", 140));
                    }
                }
                else
                {
                    Config.message(Config.language("EquipMadePanel", 114));
                }
            }
            return;
        }// end function

        private function reshowCL(event:Event)
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = NaN;
            var _loc_7:* = undefined;
            if (this.topbtn.selectpage == 0 && this.washRb.selected)
            {
                if (this.slotarr[0].item != null)
                {
                    if (this.qty == 1)
                    {
                        _loc_2 = 92011;
                        _loc_3 = 892001;
                        _loc_4 = 92001;
                    }
                    else if (this.qty == 2)
                    {
                        _loc_2 = 92012;
                        _loc_3 = 892002;
                        _loc_4 = 92002;
                    }
                    else if (this.qty == 3)
                    {
                        _loc_2 = 92013;
                        _loc_3 = 892003;
                        _loc_4 = 92003;
                    }
                    _loc_5 = Config.ui._charUI.getItemAmount(_loc_3) + Config.ui._charUI.getItemAmount(_loc_4);
                    if (Config.ui._charUI.getItemAmount(10136) > 0 && (int(this.slotarr[0].item._itemData.baseID) == 21101 || int(this.slotarr[0].item._itemData.baseID) == 21201 || int(this.slotarr[0].item._itemData.baseID) == 21401))
                    {
                        _loc_5 = Config.ui._charUI.getItemAmount(10136);
                        _loc_7 = Item.newItem(Config._itemMap[10136], 0, 0, UNIT_TYPE_ENUM.TYPEID_ITEMCLONE, 0);
                        _loc_7.display();
                        if (this.washIcon.item != null)
                        {
                            this.washIcon.item.destroy();
                        }
                        this.washIcon.item = _loc_7;
                        this.washIcon.item._itemData.binding = 1;
                        _loc_5 = Config.ui._charUI.getItemAmount(10136);
                        this.diflag = true;
                    }
                    else if (!this.checkb.selected)
                    {
                        _loc_5 = _loc_5 + Config.ui._charUI.getItemAmount(_loc_2);
                        if (Config.ui._charUI.getItemAmount(_loc_2) > 0)
                        {
                            _loc_7 = Item.newItem(Config._itemMap[_loc_2], 0, 0, UNIT_TYPE_ENUM.TYPEID_ITEMCLONE, 0);
                            _loc_7.display();
                            if (this.washIcon.item != null)
                            {
                                this.washIcon.item.destroy();
                            }
                            this.washIcon.item = _loc_7;
                            this.washIcon.item._itemData.binding = 1;
                        }
                        else
                        {
                            _loc_7 = Item.newItem(Config._itemMap[_loc_3], 0, 0, UNIT_TYPE_ENUM.TYPEID_ITEMCLONE, 0);
                            _loc_7.display();
                            if (this.washIcon.item != null)
                            {
                                this.washIcon.item.destroy();
                            }
                            this.washIcon.item = _loc_7;
                            this.washIcon.item._itemData.binding = 0;
                            this.washIcon.item._itemData.bindType = 3;
                        }
                    }
                    else
                    {
                        _loc_7 = Item.newItem(Config._itemMap[_loc_3], 0, 0, UNIT_TYPE_ENUM.TYPEID_ITEMCLONE, 0);
                        _loc_7.display();
                        if (this.washIcon.item != null)
                        {
                            this.washIcon.item.destroy();
                        }
                        this.washIcon.item = _loc_7;
                        this.washIcon.item._itemData.binding = 0;
                        this.washIcon.item._itemData.bindType = 3;
                    }
                    _loc_6 = 1;
                    if (_loc_5 >= _loc_6)
                    {
                        this.washIcon.item.numstrcolor = 2092116;
                        this.clicklab2.visible = false;
                    }
                    else
                    {
                        this.washIcon.item.numstrcolor = 16777215;
                        this.clicklab2.visible = true;
                    }
                    this.washIcon.item.numstr = _loc_5 + "/" + _loc_6;
                }
            }
            return;
        }// end function

        private function showashstone(param1) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = NaN;
            var _loc_9:* = null;
            var _loc_10:* = 0;
            if (this.topbtn.selectpage == 0 && this.washRb.selected)
            {
                if (this.slotarr[0].item != null)
                {
                    _loc_6 = 0;
                    if (this.qty == 1)
                    {
                        _loc_2 = 92011;
                        _loc_3 = 892001;
                        _loc_4 = 92001;
                    }
                    else if (this.qty == 2)
                    {
                        _loc_2 = 92012;
                        _loc_3 = 892002;
                        _loc_4 = 92002;
                    }
                    else if (this.qty == 3)
                    {
                        _loc_2 = 92013;
                        _loc_3 = 892003;
                        _loc_4 = 92003;
                    }
                    if (param1 == 0)
                    {
                        if (int(this.slotarr[0].item._itemData.baseID) == 21101 || int(this.slotarr[0].item._itemData.baseID) == 21201 || int(this.slotarr[0].item._itemData.baseID) == 21401)
                        {
                            if (Config.ui._charUI.getItemAmount(10136) > 0)
                            {
                                _loc_2 = 10136;
                                this.diflag = true;
                            }
                        }
                        if (!this.checkb.selected)
                        {
                            _loc_6 = _loc_6 + Config.ui._charUI.getItemAmount(_loc_2);
                            if (Config.ui._charUI.getItemAmount(_loc_2) > 0)
                            {
                                _loc_7 = _loc_2;
                            }
                            else
                            {
                                _loc_7 = _loc_3;
                            }
                        }
                        else
                        {
                            _loc_7 = _loc_3;
                        }
                        _loc_5 = Item.newItem(Config._itemMap[_loc_7], 0, 0, UNIT_TYPE_ENUM.TYPEID_ITEMCLONE, 0);
                        _loc_5.display();
                        if (this.washIcon.item != null)
                        {
                            this.washIcon.item.destroy();
                        }
                        this.washIcon.item = _loc_5;
                        if (_loc_7 == _loc_3)
                        {
                            this.washIcon.item._itemData.binding = 0;
                            this.washIcon.item._itemData.bindType = 3;
                        }
                        else
                        {
                            this.washIcon.item._itemData.binding = 1;
                        }
                    }
                    else if (Config.ui._charUI.getItemAmount(10136) > 0 && (int(this.slotarr[0].item._itemData.baseID) == 21101 || int(this.slotarr[0].item._itemData.baseID) == 21201 || int(this.slotarr[0].item._itemData.baseID) == 21401))
                    {
                    }
                    else if (!this.checkb.selected)
                    {
                        _loc_6 = _loc_6 + Config.ui._charUI.getItemAmount(_loc_2);
                        if (Config.ui._charUI.getItemAmount(_loc_2) > 0 && this.washIcon.item._itemData.id == _loc_2)
                        {
                            _loc_5 = Item.newItem(Config._itemMap[_loc_2], 0, 0, UNIT_TYPE_ENUM.TYPEID_ITEMCLONE, 0);
                            _loc_5.display();
                            if (this.washIcon.item != null)
                            {
                                this.washIcon.item.destroy();
                            }
                            this.washIcon.item = _loc_5;
                            this.washIcon.item._itemData.binding = 1;
                        }
                        else
                        {
                            _loc_5 = Item.newItem(Config._itemMap[_loc_3], 0, 0, UNIT_TYPE_ENUM.TYPEID_ITEMCLONE, 0);
                            _loc_5.display();
                            if (this.washIcon.item != null)
                            {
                                this.washIcon.item.destroy();
                            }
                            this.washIcon.item = _loc_5;
                            this.washIcon.item._itemData.binding = 0;
                            this.washIcon.item._itemData.bindType = 3;
                        }
                    }
                    else
                    {
                        _loc_5 = Item.newItem(Config._itemMap[_loc_3], 0, 0, UNIT_TYPE_ENUM.TYPEID_ITEMCLONE, 0);
                        _loc_5.display();
                        if (this.washIcon.item != null)
                        {
                            this.washIcon.item.destroy();
                        }
                        this.washIcon.item = _loc_5;
                        this.washIcon.item._itemData.binding = 0;
                        this.washIcon.item._itemData.bindType = 3;
                    }
                    _loc_6 = _loc_6 + (Config.ui._charUI.getItemAmount(_loc_3) + Config.ui._charUI.getItemAmount(_loc_4));
                    if (int(this.slotarr[0].item._itemData.baseID) == 21101 || int(this.slotarr[0].item._itemData.baseID) == 21201 || int(this.slotarr[0].item._itemData.baseID) == 21401)
                    {
                        if (Config.ui._charUI.getItemAmount(10136) > 0)
                        {
                            this.diflag = true;
                            _loc_6 = Config.ui._charUI.getItemAmount(10136);
                        }
                        else if (this.diflag)
                        {
                            this.diflag = false;
                            _loc_10 = Config.ui._charUI.getItemAmount(_loc_2) + Config.ui._charUI.getItemAmount(_loc_3) + Config.ui._charUI.getItemAmount(_loc_4);
                            if (_loc_10 > 0)
                            {
                                _loc_5 = Item.newItem(Config._itemMap[_loc_2], 0, 0, UNIT_TYPE_ENUM.TYPEID_ITEMCLONE, 0);
                                _loc_5.display();
                                if (this.washIcon.item != null)
                                {
                                    this.washIcon.item.destroy();
                                }
                                this.washIcon.item = _loc_5;
                                this.washIcon.item._itemData.binding = 1;
                            }
                        }
                    }
                    _loc_8 = 1;
                    if (_loc_6 >= _loc_8)
                    {
                        this.washIcon.item.numstrcolor = 2092116;
                        this.clicklab2.visible = false;
                    }
                    else
                    {
                        this.washIcon.item.numstrcolor = 16777215;
                        this.clicklab2.visible = true;
                    }
                    this.washIcon.item.numstr = _loc_6 + "/" + _loc_8;
                    this.washBar.maximum = this.washmaxnum;
                    this.washBar.value = int(this.slotarr[0].item._itemData.washgrade);
                    _loc_9 = "";
                    if (this.atkdef)
                    {
                        _loc_9 = Config.language("EquipMadePanel", 103);
                    }
                    else
                    {
                        _loc_9 = Config.language("EquipMadePanel", 104);
                    }
                    this.tlabel0.text = Config.language("EquipMadePanel", 116, _loc_9) + " : <font color=\'#399765\'> " + this.washBar.value + "</font>";
                    this.tlabel1.text = Config.language("EquipMadePanel", 117) + "           <font color=\'#399765\'>" + this.washBar.value + "</font>/" + this.washmaxnum;
                    this.tlabel2.text = Config.language("EquipMadePanel", 118) + this.slotarr[0].item._itemData.washtime + Config.language("EquipMadePanel", 119);
                }
            }
            return;
        }// end function

        public function backjewerr()
        {
            Config.message(Config.language("EquipMadePanel", 141));
            this.slotarr[0].item = Config.ui._charUI._slotArray[this.equipposition].item;
            this.handleSlotClick();
            return;
        }// end function

        private function updateactive(event:SocketEvent)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = event.data;
            this.activeType = _loc_3.readByte();
            if (this.activeType == 1)
            {
                this.closeflag1 = true;
            }
            else if (this.activeType == 2)
            {
                this.closeflag2 = true;
            }
            _loc_2 = _loc_3.readUnsignedShort();
            this.actName = _loc_3.readUTFBytes(_loc_2);
            _loc_2 = _loc_3.readUnsignedShort();
            this.straTime = _loc_3.readUTFBytes(_loc_2);
            _loc_2 = _loc_3.readUnsignedShort();
            this.endTime = _loc_3.readUTFBytes(_loc_2);
            _loc_2 = _loc_3.readUnsignedShort();
            if (this.activeType == 1)
            {
                this.actDescript1 = _loc_3.readUTFBytes(_loc_2);
            }
            else if (this.activeType == 2)
            {
                this.actDescript2 = _loc_3.readUTFBytes(_loc_2);
            }
            return;
        }// end function

        private function closeactive(event:SocketEvent)
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readByte();
            if (_loc_3 == 1)
            {
                this.closeflag1 = false;
                if (this.tlb != null)
                {
                    this.tlb.text = "";
                }
                if (this.clkl != null)
                {
                    this.clkl.text = "";
                }
            }
            else if (_loc_3 == 2)
            {
                this.closeflag2 = false;
                if (this.tlabel01 != null)
                {
                    this.tlabel01.text = "";
                }
            }
            return;
        }// end function

        private function activeproble(event:SocketEvent)
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            this.fineprecent = _loc_3 / 100 * this.fineprecent;
            if (this.tlb != null)
            {
                this.tlb.text = "<font color=\'#ad1b2e\'>(                          </font><font color=\'#006600\'>" + _loc_3 + "%</font><font color=\'#ad1b2e\'>)</font>";
            }
            this.showproblity();
            return;
        }// end function

        private function showproblity()
        {
            var _loc_1:* = NaN;
            if (this.fineprecent > 0)
            {
                if (100 / this.fineprecent == 1 && this._tol > 0)
                {
                    this.pdnum.value = 1;
                }
                else if (this._tol > Math.ceil(100 / this.fineprecent))
                {
                    this.pdnum.maximum = Math.ceil(100 / this.fineprecent);
                    this.pdnum.value = Math.ceil(100 / this.fineprecent);
                }
                else
                {
                    this.pdnum.maximum = this._tol;
                    this.pdnum.value = this._tol;
                }
            }
            if (this.fineprecent * this.pdnum.value >= 100)
            {
                this.tlabel12.text = Config.language("EquipMadePanel", 25) + "<font color=\'#006600\'>" + "100%" + "</font>";
            }
            else
            {
                _loc_1 = int(this.fineprecent * this.pdnum.value * 100) / 100;
                this.tlabel12.text = Config.language("EquipMadePanel", 25) + _loc_1 + "%";
            }
            return;
        }// end function

        private function sendremovequp(param1)
        {
            var _loc_2:* = 0;
            if (this.slotarr[0].item != null && this.slotarr[1].item != null)
            {
                if (this.slotarr[0].item._itemData.binding == 1)
                {
                    this.surebinding();
                }
                else if (this.slotarr[1].item._itemData.binding == 1)
                {
                    AlertUI.alert(Config.language("EquipMadePanel", 26), Config.language("EquipMadePanel", 150), [Config.language("EquipMadePanel", 28), Config.language("EquipMadePanel", 29)], [this.surebinding]);
                }
                else if (!this.checkb.selected)
                {
                    _loc_2 = 0;
                    if (this.slotarr[0].item._itemData.quality == 6)
                    {
                        _loc_2 = 94506;
                    }
                    else if (this.slotarr[0].item._itemData.quality == 7 || this.slotarr[0].item._itemData.quality == 8 || this.slotarr[0].item._itemData.quality == 9 || this.slotarr[0].item._itemData.quality == 10)
                    {
                        _loc_2 = 94507;
                    }
                    if (Config.ui._charUI.getItemAmount(_loc_2) > 0)
                    {
                        AlertUI.alert(Config.language("EquipMadePanel", 26), Config.language("EquipMadePanel", 150), [Config.language("EquipMadePanel", 28), Config.language("EquipMadePanel", 29)], [this.surebinding]);
                    }
                    else
                    {
                        this.surebinding();
                    }
                }
                else
                {
                    this.surebinding();
                }
            }
            return;
        }// end function

        private function surebinding(param1 = null)
        {
            var _loc_2:* = 0;
            if (this.slotarr[0].item != null && this.slotarr[1].item != null)
            {
                _loc_2 = 0;
                while (_loc_2 < 3)
                {
                    
                    if (this.slotarr[1].item._itemData.gem[_loc_2].id > 0)
                    {
                        AlertUI.alert(Config.language("EquipMadePanel", 26), Config.language("EquipMadePanel", 151), [Config.language("EquipMadePanel", 28), Config.language("EquipMadePanel", 29)], [this.suresendremovequp]);
                        return;
                    }
                    _loc_2 = _loc_2 + 1;
                }
                this.suresendremovequp();
            }
            return;
        }// end function

        private function suresendremovequp(param1 = null)
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_REAL_EQUIP_TRANSFER);
            _loc_2.add16(this.slotarr[0].item._position);
            _loc_2.add16(this.slotarr[1].item._position);
            if (!this.checkb.selected)
            {
                _loc_2.add8(0);
            }
            else
            {
                _loc_2.add8(1);
            }
            ClientSocket.send(_loc_2);
            return;
        }// end function

        public function removequpback()
        {
            Config.message(Config.language("EquipMadePanel", 152));
            if (this.slotarr[2].item != null)
            {
                this.slotarr[2].item.destroy();
            }
            if (this.tlabel22 != null)
            {
                this.tlabel22.text = Config.language("EquipMadePanel", 142);
            }
            return;
        }// end function

    }
}
