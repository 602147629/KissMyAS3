package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import lovefox.socket.*;

    public class Blessings extends Sprite
    {
        private var aktxt:Label;
        private var deftxt:Label;
        private var blotxt:Label;
        private var godaktxt:Label;
        private var bgpanel:Sprite;
        private var defbar:ProgressBar;
        private var blobar:ProgressBar;
        private var godaktbar:ProgressBar;
        private var picArr:Array;
        private var btnArr:Array;
        private var progArr:Array;
        private var lvtxtArr:Array;
        private var picupdateArr:Array;
        private var colorArr:Array;
        private var strTypeArr:Array;
        private var strNameArr:Array;
        private var allgradeArr:Array;
        private var rightPanel:Panel;

        public function Blessings()
        {
            this.picArr = [];
            this.btnArr = [];
            this.progArr = [];
            this.lvtxtArr = [];
            this.colorArr = [13395929, 6805940, 14251367, 9155042];
            this.strTypeArr = [Config.language("Blessings", 1), Config.language("Blessings", 2), Config.language("Blessings", 3), Config.language("Blessings", 4)];
            this.strNameArr = [Config.language("Blessings", 5), Config.language("Blessings", 6), Config.language("Blessings", 7), Config.language("Blessings", 8)];
            this.init();
            this.sockit();
            return;
        }// end function

        public function testGuide()
        {
            trace(this.rightPanel);
            GuideUI.testDoId(48, this.rightPanel);
            return;
        }// end function

        public function open(param1:int = 1)
        {
            var _loc_2:* = 0;
            if (param1 == 1 && Config.player.level >= 20)
            {
                _loc_2 = Config.player.level;
                this.loaderpicure(_loc_2, 0);
                this.testGuide();
            }
            else if (param1 == 0 && Config.ui._followcharui.followlev >= 20)
            {
                _loc_2 = Config.ui._followcharui.followlev;
                this.loaderpicure(_loc_2, 4);
            }
            else
            {
                Config.message(Config.language("Blessings", 9));
            }
            return;
        }// end function

        private function init()
        {
            this.drawsprite();
            return;
        }// end function

        private function sockit()
        {
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_BLESS_LIST, this.getlistbless);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_BLESS_UPGRADE, this.updatabless);
            return;
        }// end function

        private function getlistbless(event:SocketEvent)
        {
            this.allgradeArr = [];
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readByte();
            var _loc_4:* = _loc_2.readByte();
            var _loc_5:* = _loc_2.readByte();
            var _loc_6:* = _loc_2.readByte();
            var _loc_7:* = _loc_2.readByte();
            var _loc_8:* = _loc_2.readByte();
            var _loc_9:* = _loc_2.readByte();
            var _loc_10:* = _loc_2.readByte();
            this.allgradeArr.push(_loc_3);
            this.allgradeArr.push(_loc_4);
            this.allgradeArr.push(_loc_5);
            this.allgradeArr.push(_loc_6);
            this.allgradeArr.push(_loc_7);
            this.allgradeArr.push(_loc_8);
            this.allgradeArr.push(_loc_9);
            this.allgradeArr.push(_loc_10);
            return;
        }// end function

        private function updatabless(event:SocketEvent)
        {
            var _loc_3:* = 0;
            var _loc_9:* = 0;
            var _loc_23:* = 0;
            var _loc_24:* = null;
            var _loc_2:* = event.data;
            _loc_3 = _loc_2.readByte();
            var _loc_4:* = _loc_2.readByte();
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            if (_loc_3 < 5)
            {
                _loc_8 = 0;
                _loc_7 = Config.player.level;
            }
            else
            {
                _loc_8 = 4;
                _loc_7 = Config.ui._followcharui.followlev;
            }
            if (this.progArr.length > 0)
            {
                _loc_23 = 0;
                _loc_23 = int(_loc_7 / 5) - 3;
                if (_loc_23 < 0)
                {
                    _loc_23 = 0;
                }
                if (_loc_7 >= 99)
                {
                    _loc_23 = _loc_7 - 99 + 17;
                }
                this.progArr[_loc_3 - _loc_8 - 1].value = int(_loc_4 / _loc_23 * 85);
                this.allgradeArr[(_loc_3 - 1)] = _loc_4;
            }
            _loc_9 = int(_loc_4 / 5);
            if (_loc_9 > 3)
            {
                _loc_9 = 3;
            }
            var _loc_10:* = Config._belss[_loc_4]["property" + (_loc_3 - _loc_8)];
            var _loc_11:* = "";
            _loc_9 = int(_loc_4 / 5);
            if (_loc_9 > 3)
            {
                _loc_9 = 3;
            }
            if (_loc_3 == 1 || _loc_3 == 5)
            {
                _loc_11 = "akt" + _loc_9;
                _loc_5 = 48 - 10;
                _loc_6 = 56;
            }
            else if (_loc_3 == 2 || _loc_3 == 6)
            {
                _loc_11 = "def" + _loc_9;
                _loc_5 = 95 - 10;
                _loc_6 = 56;
            }
            else if (_loc_3 == 3 || _loc_3 == 7)
            {
                _loc_11 = "hp" + _loc_9;
                _loc_5 = 48 - 10;
                _loc_6 = 101;
            }
            else if (_loc_3 == 4 || _loc_3 == 8)
            {
                _loc_11 = "godakt" + _loc_9;
                _loc_5 = 95 - 10;
                _loc_6 = 101;
            }
            var _loc_12:* = "";
            if (_loc_4 == Setting.BLESSING_MAX_LEVEL)
            {
                _loc_12 = "  Max";
            }
            if (this.lvtxtArr[_loc_3 - _loc_8 - 1] != null)
            {
                this.lvtxtArr[_loc_3 - _loc_8 - 1].text = "<b><font size=\'12\'>Lv " + _loc_4 + _loc_12 + "</font></b>";
            }
            if (_loc_7 < Config._belss[(_loc_4 + 1)].playerLevel || _loc_4 == Setting.BLESSING_MAX_LEVEL)
            {
                if (this.btnArr[_loc_3 - _loc_8 - 1] != null)
                {
                    this.btnArr[_loc_3 - _loc_8 - 1].visible = false;
                }
            }
            if (_loc_4 == 5)
            {
                _loc_24 = new Bitmap();
                this.bgpanel.addChild(_loc_24);
                _loc_24.bitmapData = Config.findsysUI("bless/" + _loc_11, 40, 40);
                _loc_24.x = _loc_5;
                _loc_24.y = _loc_6;
                this.picupdateArr[_loc_3 - _loc_8 - 1] = _loc_24;
                this.picArr.push(_loc_24);
            }
            else if (_loc_4 == 10 || _loc_4 == 15)
            {
                if (_loc_4 == 15)
                {
                    _loc_5 = _loc_5 - 3;
                    _loc_6 = _loc_6 - 3;
                }
                if (this.picupdateArr[_loc_3 - _loc_8 - 1] != null)
                {
                    if (this.picupdateArr[_loc_3 - _loc_8 - 1].hasOwnProperty("bitmapData"))
                    {
                        this.picupdateArr[_loc_3 - _loc_8 - 1].bitmapData.dispose();
                        _loc_24 = new Bitmap();
                        this.bgpanel.addChild(_loc_24);
                        _loc_24.bitmapData = Config.findsysUI("bless/" + _loc_11, 40, 40);
                        _loc_24.x = _loc_5;
                        _loc_24.y = _loc_6;
                        this.picupdateArr[_loc_3 - _loc_8 - 1] = _loc_24;
                        this.picArr.push(_loc_24);
                    }
                }
            }
            var _loc_13:* = 0;
            var _loc_14:* = 0;
            var _loc_15:* = 0;
            var _loc_16:* = 0;
            var _loc_17:* = 0;
            var _loc_18:* = 0;
            var _loc_19:* = 0;
            var _loc_20:* = 0;
            var _loc_21:* = _loc_8;
            while (_loc_21 < _loc_8 + 4)
            {
                
                if (this.allgradeArr.length > 0)
                {
                    if (this.allgradeArr[_loc_21] >= 5 && this.allgradeArr[_loc_21] < 10)
                    {
                        _loc_13 = _loc_13 + 1;
                    }
                    else if (this.allgradeArr[_loc_21] >= 10 && this.allgradeArr[_loc_21] < 15)
                    {
                        _loc_13 = _loc_13 + 1;
                        _loc_14 = _loc_14 + 1;
                    }
                    else if (this.allgradeArr[_loc_21] >= 15 && this.allgradeArr[_loc_21] < 38)
                    {
                        _loc_13 = _loc_13 + 1;
                        _loc_14 = _loc_14 + 1;
                        _loc_15 = _loc_15 + 1;
                    }
                    else if (this.allgradeArr[_loc_21] >= 38 && this.allgradeArr[_loc_21] < 57)
                    {
                        _loc_13 = _loc_13 + 1;
                        _loc_14 = _loc_14 + 1;
                        _loc_15 = _loc_15 + 1;
                        _loc_16 = _loc_16 + 1;
                    }
                    else if (this.allgradeArr[_loc_21] >= 57)
                    {
                        _loc_13 = _loc_13 + 1;
                        _loc_14 = _loc_14 + 1;
                        _loc_15 = _loc_15 + 1;
                        _loc_16 = _loc_16 + 1;
                        _loc_17 = _loc_17 + 1;
                    }
                }
                _loc_21++;
            }
            if (_loc_17 == 4)
            {
                _loc_18 = Config._belss[62].awardatk;
                _loc_19 = Config._belss[62].awarddef;
                _loc_20 = Config._belss[62].awardhp;
            }
            else if (_loc_16 == 4)
            {
                _loc_18 = Config._belss[61].awardatk;
                _loc_19 = Config._belss[61].awarddef;
                _loc_20 = Config._belss[61].awardhp;
            }
            else if (_loc_15 == 4)
            {
                _loc_18 = Config._belss[60].awardatk;
                _loc_19 = Config._belss[60].awarddef;
                _loc_20 = Config._belss[60].awardhp;
            }
            else if (_loc_14 == 4)
            {
                _loc_18 = Config._belss[59].awardatk;
                _loc_19 = Config._belss[59].awarddef;
                _loc_20 = Config._belss[59].awardhp;
            }
            else if (_loc_13 == 4)
            {
                _loc_18 = Config._belss[58].awardatk;
                _loc_19 = Config._belss[58].awarddef;
                _loc_20 = Config._belss[58].awardhp;
            }
            var _loc_22:* = 0;
            _loc_22 = int(Config._belss[this.allgradeArr[0 + _loc_8]].property1) + _loc_18;
            this.aktxt.text = Config.language("Blessings", 11, _loc_22);
            _loc_22 = int(Config._belss[this.allgradeArr[1 + _loc_8]].property2) + _loc_19;
            this.deftxt.text = Config.language("Blessings", 12, _loc_22);
            _loc_22 = int(Config._belss[this.allgradeArr[2 + _loc_8]].property3) + _loc_20;
            this.blotxt.text = Config.language("Blessings", 13, _loc_22);
            this.godaktxt.text = Config.language("Blessings", 14, Config._belss[this.allgradeArr[3 + _loc_8]].property4);
            if (_loc_8 == 4)
            {
                Config.ui._followcharui.sendlistinfor();
            }
            return;
        }// end function

        private function suresendgrade(event:MouseEvent)
        {
            var _loc_5:* = 0;
            var _loc_2:* = int(event.currentTarget.data);
            var _loc_3:* = 0;
            if (_loc_2 >= 5)
            {
                _loc_3 = 4;
            }
            var _loc_4:* = "";
            _loc_5 = int(Config._belss[(this.allgradeArr[(_loc_2 - 1)] + 1)].money);
            if (_loc_2 == 1 || _loc_2 == 5)
            {
                _loc_4 = Config.language("Blessings", 1);
            }
            else if (_loc_2 == 2 || _loc_2 == 6)
            {
                _loc_4 = Config.language("Blessings", 2);
            }
            else if (_loc_2 == 3 || _loc_2 == 7)
            {
                _loc_4 = Config.language("Blessings", 3);
            }
            else if (_loc_2 == 4 || _loc_2 == 8)
            {
                _loc_4 = Config.language("Blessings", 15);
            }
            var _loc_6:* = _loc_4 + " +" + Config._belss[this.allgradeArr[(_loc_2 - 1)]]["property" + (_loc_2 - _loc_3)];
            var _loc_7:* = _loc_4 + " +" + Config._belss[(this.allgradeArr[(_loc_2 - 1)] + 1)]["property" + (_loc_2 - _loc_3)];
            if (Config._lanVersion == LanVersion.QQ_ZH_CN)
            {
                AlertUI.alert(Config.language("Blessings", 16), Config.language("Blessings", 29, this.strNameArr[_loc_2 - _loc_3 - 1], this.allgradeArr[(_loc_2 - 1)], (this.allgradeArr[(_loc_2 - 1)] + 1), _loc_6, _loc_7, Config._itemMap[896104].name, Config._belss[(this.allgradeArr[(_loc_2 - 1)] + 1)].itemCount, _loc_5), [Config.language("Blessings", 18), Config.language("Blessings", 19)], [this.sendgrade], _loc_2);
            }
            else
            {
                AlertUI.alert(Config.language("Blessings", 16), Config.language("Blessings", 17, this.strNameArr[_loc_2 - _loc_3 - 1], this.allgradeArr[(_loc_2 - 1)], (this.allgradeArr[(_loc_2 - 1)] + 1), _loc_6, _loc_7, Config._itemMap[896104].name, Config._belss[(this.allgradeArr[(_loc_2 - 1)] + 1)].itemCount, _loc_5), [Config.language("Blessings", 18), Config.language("Blessings", 19)], [this.sendgrade], _loc_2);
            }
            return;
        }// end function

        private function sendgrade(param1)
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_BLESS_UPGRADE);
            _loc_2.add8(param1);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function drawsprite()
        {
            var _loc_1:* = new Shape();
            _loc_1.graphics.beginFill(16777215, 0.4);
            _loc_1.graphics.drawRoundRect(10, 30, 247, 180, 5);
            _loc_1.graphics.endFill();
            var _loc_2:* = new Shape();
            _loc_2.graphics.beginFill(16777215, 0.4);
            _loc_2.graphics.drawRoundRect(10, 214, 247, 143, 5);
            _loc_2.graphics.endFill();
            var _loc_3:* = new Panel(this, 150, 30);
            _loc_3.roundCorner = 5;
            _loc_3.color = 15523521;
            _loc_3.setSize(105, 180);
            _loc_3.visible = false;
            this.rightPanel = _loc_3;
            this.addChild(_loc_1);
            this.addChild(_loc_2);
            this.bgpanel = new Sprite();
            this.bgpanel.x = 0;
            this.bgpanel.y = 0;
            this.addChild(this.bgpanel);
            var _loc_4:* = new Label(this, 20, 217);
            new Label(this, 20, 217).html = true;
            _loc_4.text = Config.language("Blessings", 20);
            var _loc_5:* = new Label(this, 20, 230);
            new Label(this, 20, 230).html = true;
            _loc_5.text = Config.language("Blessings", 21);
            return;
        }// end function

        private function loaderpicure(param1:int, param2:int)
        {
            var _loc_9:* = 0;
            var _loc_18:* = null;
            var _loc_19:* = null;
            var _loc_20:* = null;
            var _loc_21:* = null;
            var _loc_22:* = null;
            var _loc_23:* = null;
            var _loc_24:* = 0;
            var _loc_25:* = null;
            var _loc_26:* = 0;
            var _loc_27:* = 0;
            var _loc_28:* = 0;
            var _loc_29:* = 0;
            var _loc_30:* = 0;
            var _loc_31:* = null;
            var _loc_3:* = 0;
            while (_loc_3 < this.picArr.length)
            {
                
                if (this.picArr.hasOwnProperty("bitmapData"))
                {
                    this.picArr[_loc_3].bitmapData.dispose();
                }
                _loc_3 = _loc_3 + 1;
            }
            this.removeallspr(this.bgpanel);
            this.progArr = [];
            this.picArr = [];
            this.lvtxtArr = [];
            this.btnArr = [];
            this.picupdateArr = [0, 0, 0, 0];
            var _loc_4:* = new Sprite();
            new Sprite().x = 38;
            _loc_4.y = 45;
            _loc_4.graphics.beginFill(15523521);
            _loc_4.graphics.drawCircle(50, 50, 52);
            _loc_4.graphics.endFill();
            this.bgpanel.addChild(_loc_4);
            _loc_4.addEventListener(MouseEvent.ROLL_OVER, this.handover);
            _loc_4.addEventListener(MouseEvent.ROLL_OUT, this.handout);
            if (param2 == 0)
            {
                _loc_4.name = "0";
            }
            else
            {
                _loc_4.name = "9";
            }
            var _loc_5:* = new Bitmap();
            this.bgpanel.addChild(_loc_5);
            _loc_5.bitmapData = Config.findsysUI("bless/bigbg", 137, 163);
            _loc_5.x = 12;
            _loc_5.y = 38;
            this.picArr.push(_loc_5);
            var _loc_6:* = 0;
            _loc_6 = int(param1 / 5) - 3;
            if (_loc_6 < 0)
            {
                _loc_6 = 0;
            }
            if (param1 >= 99)
            {
                _loc_6 = param1 - 99 + 17;
            }
            var _loc_7:* = 40;
            var _loc_8:* = param2;
            while (_loc_8 < param2 + 4)
            {
                
                _loc_18 = new Sprite();
                _loc_18.x = 154;
                _loc_18.y = _loc_7;
                _loc_18.graphics.beginFill(15523521);
                _loc_18.graphics.drawRoundRect(0, 0, 34, 34, 5);
                _loc_18.graphics.endFill();
                this.bgpanel.addChild(_loc_18);
                _loc_18.addEventListener(MouseEvent.ROLL_OVER, this.handover);
                _loc_18.addEventListener(MouseEvent.ROLL_OUT, this.handout);
                _loc_18.name = "" + (_loc_8 + 1);
                _loc_19 = new Bitmap();
                this.bgpanel.addChild(_loc_19);
                _loc_19.bitmapData = Config.findsysUI("bless/" + ((_loc_8 + 1) - param2), 34, 34);
                _loc_19.x = 154;
                _loc_19.y = _loc_7;
                this.picArr.push(_loc_19);
                _loc_20 = new PushButton(this.bgpanel, 227 + 5, _loc_7 + 18, "+", this.suresendgrade);
                _loc_20.setTable("table18", "table31");
                _loc_20.width = 19;
                _loc_20.height = 17;
                _loc_20.textColor = Style.GOLD_FONT;
                _loc_20.data = _loc_8 + 1;
                _loc_20.visible = true;
                if (param1 < Config._belss[(this.allgradeArr[_loc_8] + 1)].playerLevel || this.allgradeArr[_loc_8] == Setting.BLESSING_MAX_LEVEL)
                {
                    _loc_20.visible = false;
                }
                this.btnArr.push(_loc_20);
                _loc_21 = new Label(this.bgpanel, 192, _loc_7 + 17);
                _loc_21.html = true;
                _loc_22 = "";
                if (this.allgradeArr[_loc_8] >= Setting.BLESSING_MAX_LEVEL)
                {
                    _loc_22 = "  Max";
                }
                _loc_21.text = "<b><font size=\'12\'>Lv " + this.allgradeArr[_loc_8] + _loc_22 + "</font></b>";
                this.lvtxtArr.push(_loc_21);
                _loc_23 = new ProgressBar(this.bgpanel, 192, _loc_7);
                _loc_23.height = 15;
                _loc_23.width = 60;
                _loc_23.maximum = 85;
                _loc_24 = 0;
                if (_loc_6 > 0)
                {
                    _loc_24 = int(this.allgradeArr[_loc_8] / _loc_6 * 85);
                }
                _loc_23.value = _loc_24;
                _loc_23.color = this.colorArr[_loc_8 - param2];
                this.progArr.push(_loc_23);
                _loc_7 = _loc_7 + 42;
                _loc_8++;
            }
            _loc_9 = param2;
            while (_loc_9 < param2 + 4)
            {
                
                if (this.allgradeArr[_loc_9] >= 5)
                {
                    _loc_25 = "";
                    _loc_26 = 0;
                    _loc_27 = 0;
                    _loc_28 = 0;
                    _loc_29 = 0;
                    _loc_30 = int(this.allgradeArr[_loc_9] / 5);
                    if (_loc_30 > 3)
                    {
                        _loc_30 = 3;
                    }
                    if (this.allgradeArr[_loc_9] >= 15)
                    {
                        _loc_28 = 3;
                        _loc_29 = 3;
                    }
                    if (_loc_9 - param2 == 0)
                    {
                        _loc_26 = 48 - 8;
                        _loc_27 = 56;
                        _loc_25 = "akt" + _loc_30;
                    }
                    else if (_loc_9 - param2 == 1)
                    {
                        _loc_26 = 95 - 8;
                        _loc_27 = 56;
                        _loc_25 = "def" + _loc_30;
                    }
                    else if (_loc_9 - param2 == 2)
                    {
                        _loc_26 = 48 - 8;
                        _loc_27 = 101;
                        _loc_25 = "hp" + _loc_30;
                    }
                    else if (_loc_9 - param2 == 3)
                    {
                        _loc_26 = 95 - 8;
                        _loc_27 = 101;
                        _loc_25 = "godakt" + _loc_30;
                    }
                    _loc_31 = new Bitmap();
                    this.bgpanel.addChild(_loc_31);
                    _loc_31.bitmapData = Config.findsysUI("bless/" + _loc_25, 40, 40);
                    _loc_31.x = _loc_26 - _loc_28;
                    _loc_31.y = _loc_27 - _loc_29;
                    this.picArr.push(_loc_31);
                    this.picupdateArr[_loc_9] = _loc_31;
                }
                _loc_9 = _loc_9 + 1;
            }
            var _loc_10:* = 0;
            var _loc_11:* = 0;
            var _loc_12:* = 0;
            var _loc_13:* = 0;
            var _loc_14:* = 0;
            var _loc_15:* = 0;
            var _loc_16:* = 0;
            var _loc_17:* = 0;
            _loc_9 = param2;
            while (_loc_9 < param2 + 4)
            {
                
                if (this.allgradeArr.length > 0)
                {
                    if (this.allgradeArr[_loc_9] >= 5 && this.allgradeArr[_loc_9] < 10)
                    {
                        _loc_10 = _loc_10 + 1;
                    }
                    else if (this.allgradeArr[_loc_9] >= 10 && this.allgradeArr[_loc_9] < 15)
                    {
                        _loc_10 = _loc_10 + 1;
                        _loc_11 = _loc_11 + 1;
                    }
                    else if (this.allgradeArr[_loc_9] >= 15 && this.allgradeArr[_loc_9] < 38)
                    {
                        _loc_10 = _loc_10 + 1;
                        _loc_11 = _loc_11 + 1;
                        _loc_12 = _loc_12 + 1;
                    }
                    else if (this.allgradeArr[_loc_9] >= 38 && this.allgradeArr[_loc_9] < 57)
                    {
                        _loc_10 = _loc_10 + 1;
                        _loc_11 = _loc_11 + 1;
                        _loc_12 = _loc_12 + 1;
                        _loc_13 = _loc_13 + 1;
                    }
                    else if (this.allgradeArr[_loc_9] >= 57)
                    {
                        _loc_10 = _loc_10 + 1;
                        _loc_11 = _loc_11 + 1;
                        _loc_12 = _loc_12 + 1;
                        _loc_13 = _loc_13 + 1;
                        _loc_14 = _loc_14 + 1;
                    }
                }
                _loc_9 = _loc_9 + 1;
            }
            if (_loc_14 == 4)
            {
                _loc_15 = Config._belss[62].awardatk;
                _loc_16 = Config._belss[62].awarddef;
                _loc_17 = Config._belss[62].awardhp;
            }
            else if (_loc_13 == 4)
            {
                _loc_15 = Config._belss[61].awardatk;
                _loc_16 = Config._belss[61].awarddef;
                _loc_17 = Config._belss[61].awardhp;
            }
            else if (_loc_12 == 4)
            {
                _loc_15 = Config._belss[60].awardatk;
                _loc_16 = Config._belss[60].awarddef;
                _loc_17 = Config._belss[60].awardhp;
            }
            else if (_loc_11 == 4)
            {
                _loc_15 = Config._belss[59].awardatk;
                _loc_16 = Config._belss[59].awarddef;
                _loc_17 = Config._belss[59].awardhp;
            }
            else if (_loc_10 == 4)
            {
                _loc_15 = Config._belss[58].awardatk;
                _loc_16 = Config._belss[58].awarddef;
                _loc_17 = Config._belss[58].awardhp;
            }
            this.aktxt = new Label(this.bgpanel, 26 - 10, 153);
            this.aktxt.html = true;
            this.aktxt.text = Config.language("Blessings", 11, int(Config._belss[this.allgradeArr[0 + param2]].property1) + _loc_15);
            this.deftxt = new Label(this.bgpanel, 26 - 10, 173);
            this.deftxt.html = true;
            this.deftxt.text = Config.language("Blessings", 12, int(Config._belss[this.allgradeArr[1 + param2]].property2) + _loc_16);
            this.blotxt = new Label(this.bgpanel, 85 - 10, 153);
            this.blotxt.html = true;
            this.blotxt.text = Config.language("Blessings", 13, int(Config._belss[this.allgradeArr[2 + param2]].property3) + _loc_17);
            this.godaktxt = new Label(this.bgpanel, 85 - 10, 173);
            this.godaktxt.html = true;
            this.godaktxt.text = Config.language("Blessings", 14, Config._belss[this.allgradeArr[3 + param2]].property4);
            return;
        }// end function

        private function handover(event:MouseEvent)
        {
            trace(event.currentTarget.name);
            Holder.showInfo(this.restr(int(event.currentTarget.name)), new Rectangle(Config.stage.mouseX, Config.stage.mouseY + 10), false, 1, 200);
            return;
        }// end function

        private function handout(param1)
        {
            Holder.closeInfo();
            return;
        }// end function

        private function restr(param1:int) : String
        {
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_11:* = 0;
            var _loc_12:* = 0;
            var _loc_13:* = 0;
            var _loc_14:* = 0;
            var _loc_2:* = "";
            var _loc_3:* = 0;
            if (param1 >= 5)
            {
                _loc_3 = 4;
            }
            if (param1 == 0 || param1 == 9)
            {
                _loc_2 = _loc_2 + Config.language("Blessings", 22);
                _loc_4 = 0;
                _loc_5 = 0;
                _loc_6 = 0;
                _loc_7 = 0;
                _loc_8 = 0;
                _loc_9 = 0;
                _loc_10 = 0;
                _loc_11 = 0;
                _loc_12 = 0;
                _loc_13 = _loc_3;
                while (_loc_13 < 4 + _loc_3)
                {
                    
                    if (this.allgradeArr[_loc_13] >= 5 && this.allgradeArr[_loc_13] < 10)
                    {
                        _loc_4 = _loc_4 + 1;
                    }
                    else if (this.allgradeArr[_loc_13] >= 10 && this.allgradeArr[_loc_13] < 15)
                    {
                        _loc_4 = _loc_4 + 1;
                        _loc_5 = _loc_5 + 1;
                    }
                    else if (this.allgradeArr[_loc_13] >= 15 && this.allgradeArr[_loc_13] < 38)
                    {
                        _loc_4 = _loc_4 + 1;
                        _loc_5 = _loc_5 + 1;
                        _loc_6 = _loc_6 + 1;
                    }
                    else if (this.allgradeArr[_loc_13] >= 38 && this.allgradeArr[_loc_13] < 57)
                    {
                        _loc_4 = _loc_4 + 1;
                        _loc_5 = _loc_5 + 1;
                        _loc_6 = _loc_6 + 1;
                        _loc_7 = _loc_7 + 1;
                    }
                    else if (this.allgradeArr[_loc_13] >= 57)
                    {
                        _loc_4 = _loc_4 + 1;
                        _loc_5 = _loc_5 + 1;
                        _loc_6 = _loc_6 + 1;
                        _loc_7 = _loc_7 + 1;
                        _loc_8 = _loc_8 + 1;
                    }
                    _loc_13 = _loc_13 + 1;
                }
                if (_loc_8 == 4)
                {
                    _loc_12 = 57;
                    _loc_9 = Config._belss[62].awardatk;
                    _loc_10 = Config._belss[62].awarddef;
                    _loc_11 = Config._belss[62].awardhp;
                }
                else if (_loc_7 == 4)
                {
                    _loc_12 = 38;
                    _loc_9 = Config._belss[61].awardatk;
                    _loc_10 = Config._belss[61].awarddef;
                    _loc_11 = Config._belss[61].awardhp;
                }
                else if (_loc_6 == 4)
                {
                    _loc_12 = 15;
                    _loc_9 = Config._belss[60].awardatk;
                    _loc_10 = Config._belss[60].awarddef;
                    _loc_11 = Config._belss[60].awardhp;
                }
                else if (_loc_5 == 4)
                {
                    _loc_12 = 10;
                    _loc_9 = Config._belss[59].awardatk;
                    _loc_10 = Config._belss[59].awarddef;
                    _loc_11 = Config._belss[59].awardhp;
                }
                else if (_loc_4 == 4)
                {
                    _loc_12 = 5;
                    _loc_9 = Config._belss[58].awardatk;
                    _loc_10 = Config._belss[58].awarddef;
                    _loc_11 = Config._belss[58].awardhp;
                }
                _loc_2 = _loc_2 + ("\n\n" + this.strTypeArr[0] + " +" + Config._belss[this.allgradeArr[0 + _loc_3]].property1);
                _loc_2 = _loc_2 + ("\n" + this.strTypeArr[1] + " +" + Config._belss[this.allgradeArr[1 + _loc_3]].property2);
                _loc_2 = _loc_2 + ("\n" + this.strTypeArr[2] + " +" + Config._belss[this.allgradeArr[2 + _loc_3]].property3);
                _loc_2 = _loc_2 + ("\n" + this.strTypeArr[3] + " +" + Config._belss[this.allgradeArr[3 + _loc_3]].property4);
                if (_loc_12 > 0)
                {
                    _loc_2 = _loc_2 + Config.language("Blessings", 23, _loc_12);
                    _loc_2 = _loc_2 + ("\n\n" + this.strTypeArr[0] + " +" + _loc_9);
                    _loc_2 = _loc_2 + ("\n" + this.strTypeArr[1] + " +" + _loc_10);
                    _loc_2 = _loc_2 + ("\n" + this.strTypeArr[2] + " +" + _loc_11);
                }
                _loc_2 = _loc_2 + Config.language("Blessings", 24);
            }
            else
            {
                _loc_14 = this.allgradeArr[(param1 - 1)];
                _loc_2 = _loc_2 + Config.language("Blessings", 25, this.strNameArr[param1 - _loc_3 - 1], _loc_14);
                _loc_2 = _loc_2 + ("\n\n" + this.strTypeArr[param1 - _loc_3 - 1] + " +" + Config._belss[_loc_14]["property" + (param1 - _loc_3)]);
                if (_loc_14 < Setting.BLESSING_MAX_LEVEL)
                {
                    _loc_2 = _loc_2 + Config.language("Blessings", 26, int((_loc_14 + 1)));
                    _loc_2 = _loc_2 + ("\n\n" + this.strTypeArr[param1 - _loc_3 - 1] + " +" + Config._belss[(_loc_14 + 1)]["property" + (param1 - _loc_3)]);
                    _loc_2 = _loc_2 + Config.language("Blessings", 27, Config._belss[(_loc_14 + 1)].playerLevel);
                    _loc_2 = _loc_2 + Config.language("Blessings", 28, Config._itemMap[896104].name, int(Config._belss[(_loc_14 + 1)].itemCount));
                }
            }
            return _loc_2;
        }// end function

        private function removeallspr(param1:Sprite)
        {
            while (param1.numChildren > 0)
            {
                
                param1.removeChildAt((param1.numChildren - 1));
            }
            return;
        }// end function

    }
}
