package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;
    import lovefox.gui.*;
    import lovefox.socket.*;

    public class GodMade extends Window
    {
        private var _allbitmapArr:Array;
        private var lab1:Label;
        private var lab2:Label;
        private var pushbtn1:PushButton;
        private var checkbox:CheckBox;
        private var pushbtn3:PushButton;
        private var _f:Boolean = false;
        private var _enable:Boolean = false;
        private var _enable_flag:Boolean = true;
        private var _flag:Boolean = false;
        private var _flaggou:Boolean = false;
        private var _alertint:int;
        private var _godpropArr:Array;
        private var _mainspritelayer:Sprite;
        private var _mainspritelayer1:Sprite;
        private var _belssStack:Array;
        private var _belssStack1:Array;
        private var _belssStack2:Array;
        private var _belssStack3:Array;
        private var _belssStack4:Array;
        private var _pdnum:NumericStepper;
        private var _fornumber:int = 0;
        private var _lv10bitmapArr:Array;
        private var _lvflagnumber:uint = 0;
        private var _lvflag:Boolean = false;
        private var _s1234Arr:Array;
        private var _squarebitmapArr:Array;
        private var _bitmaplockArr:Array;
        private var _god2bitArr:Array;

        public function GodMade(param1:DisplayObjectContainer = null)
        {
            this._belssStack = [];
            this._belssStack1 = [];
            this._belssStack2 = [];
            this._belssStack3 = [];
            this._belssStack4 = [];
            this._lv10bitmapArr = [];
            this._s1234Arr = [];
            this._squarebitmapArr = [];
            this._bitmaplockArr = [];
            this._god2bitArr = [];
            super(param1);
            resize(491, 396);
            this.initsocket();
            this.init();
            return;
        }// end function

        override public function testGuide()
        {
            if (GuideUI.testId(249))
            {
                GuideUI.doId(249, this.pushbtn1, [this.pushbtn3, this.checkbox]);
            }
            return;
        }// end function

        private function initsocket()
        {
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_GODATTRIBUTE_LIST, this.godMadetips);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_GODATTRIBUTE_HIT, this.showMore);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_GODATTRIBUTE_Upgrade, this.upgrade);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_GODATTRIBUTE_EXPUPDATE, this.addexp);
            return;
        }// end function

        override public function open(event:MouseEvent = null)
        {
            super.open();
            this.addallbitmap();
            this.lab2.text = Config.language("GodMade", 3, Config.ui._charUI.getItemAmount(898004), Config.ui._charUI.getItemAmount(898005));
            if (Config.ui._charUI.getItemAmount(898005) > 0)
            {
                this._pdnum.value = 1;
            }
            else
            {
                this._pdnum.value = 0;
            }
            if (Config.ui._charUI.getItemAmount(898004) > 0)
            {
                this.pushbtn1.textColor = Style.WINDOW_FONT;
            }
            else
            {
                this.pushbtn1.textColor = Style.WINDOW_FONT_DISABLE;
            }
            Config.ui._charUI.removeEventListener("itemchange", this.itemchange);
            Config.ui._charUI.addEventListener("itemchange", this.itemchange);
            return;
        }// end function

        override public function close()
        {
            var _loc_1:* = 0;
            Config.ui._charUI.removeEventListener("itemchange", this.itemchange);
            Config.stopLoop(this.sendLoop);
            this._enable = false;
            this.pushbtn3.label = Config.language("GodMade", 1);
            _loc_1 = 0;
            while (_loc_1 < this._allbitmapArr.length)
            {
                
                if (this._allbitmapArr[_loc_1] != null)
                {
                    if (this._allbitmapArr[_loc_1].hasOwnProperty("bitmapData"))
                    {
                        this._allbitmapArr[_loc_1].bitmapData.dispose();
                        this._allbitmapArr[_loc_1] = null;
                    }
                }
                _loc_1++;
            }
            this._allbitmapArr = [];
            _loc_1 = 0;
            while (_loc_1 < this._bitmaplockArr.length)
            {
                
                if (this._bitmaplockArr[_loc_1] != null)
                {
                    if (this._bitmaplockArr[_loc_1].hasOwnProperty("bitmapData"))
                    {
                        this._bitmaplockArr[_loc_1].bitmapData.dispose();
                        this._bitmaplockArr[_loc_1] = null;
                    }
                }
                _loc_1++;
            }
            this._bitmaplockArr = [];
            _loc_1 = 0;
            while (_loc_1 < this._god2bitArr.length)
            {
                
                if (this._god2bitArr[_loc_1] != null)
                {
                    if (this._god2bitArr[_loc_1].hasOwnProperty("bitmapData"))
                    {
                        this._god2bitArr[_loc_1].bitmapData.dispose();
                        this._god2bitArr[_loc_1] = null;
                    }
                }
                _loc_1++;
            }
            this._god2bitArr = [];
            AlertUI.remove(this._alertint);
            super.close();
            return;
        }// end function

        private function init()
        {
            var _loc_2:* = null;
            this._mainspritelayer = new Sprite();
            this.addChild(this._mainspritelayer);
            this._mainspritelayer1 = new Sprite();
            this.addChild(this._mainspritelayer1);
            this.title = Config.language("GodMade", 2);
            var _loc_1:* = new Sprite();
            _loc_1.graphics.beginFill(0, 0);
            _loc_1.graphics.drawCircle(0, 0, 45);
            _loc_1.graphics.endFill();
            _loc_1.x = 85;
            _loc_1.y = 225;
            this._mainspritelayer1.addChild(_loc_1);
            _loc_2 = new Sprite();
            _loc_2.graphics.beginFill(0, 0);
            _loc_2.graphics.drawCircle(0, 0, 45);
            _loc_2.graphics.endFill();
            _loc_2.x = 136 + 45;
            _loc_2.y = 140 + 45;
            this._mainspritelayer1.addChild(_loc_2);
            var _loc_3:* = new Sprite();
            _loc_3.graphics.beginFill(0, 0);
            _loc_3.graphics.drawCircle(0, 0, 45);
            _loc_3.graphics.endFill();
            _loc_3.x = 245 + 45;
            _loc_3.y = 140 + 45;
            this._mainspritelayer1.addChild(_loc_3);
            var _loc_4:* = new Sprite();
            new Sprite().graphics.beginFill(0, 0);
            _loc_4.graphics.drawCircle(0, 0, 45);
            _loc_4.graphics.endFill();
            _loc_4.x = 340 + 45;
            _loc_4.y = 180 + 45;
            this._mainspritelayer1.addChild(_loc_4);
            _loc_1.addEventListener(MouseEvent.MOUSE_OVER, this.handleover);
            _loc_1.addEventListener(MouseEvent.MOUSE_OUT, this.handleout);
            _loc_1.name = String(13);
            _loc_2.addEventListener(MouseEvent.MOUSE_OVER, this.handleover);
            _loc_2.addEventListener(MouseEvent.MOUSE_OUT, this.handleout);
            _loc_2.name = String(14);
            _loc_3.addEventListener(MouseEvent.MOUSE_OVER, this.handleover);
            _loc_3.addEventListener(MouseEvent.MOUSE_OUT, this.handleout);
            _loc_3.name = String(11);
            _loc_4.addEventListener(MouseEvent.MOUSE_OVER, this.handleover);
            _loc_4.addEventListener(MouseEvent.MOUSE_OUT, this.handleout);
            _loc_4.name = String(12);
            this._s1234Arr.push(_loc_1);
            this._s1234Arr.push(_loc_2);
            this._s1234Arr.push(_loc_3);
            this._s1234Arr.push(_loc_4);
            var _loc_5:* = new Sprite();
            new Sprite().graphics.beginFill(8472674, 0.6);
            _loc_5.graphics.drawRoundRect(0, 0, 140, 70, 5);
            _loc_5.graphics.endFill();
            _loc_5.x = 10;
            _loc_5.y = 30;
            this._mainspritelayer1.addChild(_loc_5);
            var _loc_6:* = new Sprite();
            new Sprite().graphics.beginFill(8472674, 0.6);
            _loc_6.graphics.drawRoundRect(0, 0, 140, 70, 5);
            _loc_6.graphics.endFill();
            _loc_6.x = 340;
            _loc_6.y = 30;
            this._mainspritelayer1.addChild(_loc_6);
            var _loc_7:* = new Sprite();
            new Sprite().graphics.beginFill(8472674, 1);
            _loc_7.graphics.drawRoundRect(0, 0, 55, 22, 5);
            _loc_7.graphics.endFill();
            _loc_7.x = 208;
            _loc_7.y = 310;
            this._mainspritelayer1.addChild(_loc_7);
            this._pdnum = new NumericStepper(this._mainspritelayer1, 335, 342, this.changenumber);
            this._pdnum.width = 110;
            this._pdnum.percent = false;
            this._pdnum.maximum = 999;
            this._pdnum.value = 1;
            this._pdnum.addEventListener(MouseEvent.MOUSE_OVER, this.handleover);
            this._pdnum.addEventListener(MouseEvent.MOUSE_OUT, this.handleout);
            this._pdnum.name = String(20);
            this.lab1 = new Label(this._mainspritelayer1, 15, 33);
            this.lab1.html = true;
            this.lab2 = new Label(this._mainspritelayer1, 380, 40);
            this.lab2.html = true;
            this.pushbtn1 = new PushButton(this._mainspritelayer1, 145, 340, Config.language("GodMade", 4), this.addsprit);
            this.checkbox = new CheckBox(this._mainspritelayer1, 215, 316, Config.language("GodMade", 5), this.bless);
            this.checkbox.addEventListener(MouseEvent.MOUSE_OVER, this.handleover);
            this.checkbox.addEventListener(MouseEvent.MOUSE_OUT, this.handleout);
            this.checkbox.name = String(15);
            this.checkbox.selected = false;
            this.pushbtn3 = new PushButton(this._mainspritelayer1, 245, 340, Config.language("GodMade", 6), this.addgodspritbtn, null, "table38", "table37");
            this.pushbtn1.width = 80;
            this.pushbtn3.width = 80;
            this.pushbtn1.addEventListener(MouseEvent.MOUSE_OVER, this.handleover);
            this.pushbtn1.addEventListener(MouseEvent.MOUSE_OUT, this.handleout);
            this.pushbtn1.name = String(16);
            this.pushbtn3.addEventListener(MouseEvent.MOUSE_OVER, this.handleover);
            this.pushbtn3.addEventListener(MouseEvent.MOUSE_OUT, this.handleout);
            this.pushbtn3.name = String(17);
            var _loc_8:* = new Sprite();
            new Sprite().graphics.beginFill(0, 0);
            _loc_8.graphics.drawRoundRect(0, 0, 130, 13, 5);
            _loc_8.graphics.endFill();
            _loc_8.x = 15;
            _loc_8.y = 36;
            this._mainspritelayer1.addChild(_loc_8);
            var _loc_9:* = new Sprite();
            new Sprite().graphics.beginFill(0, 0);
            _loc_9.graphics.drawRoundRect(0, 0, 130, 13, 5);
            _loc_9.graphics.endFill();
            _loc_9.x = 15;
            _loc_9.y = 52;
            this._mainspritelayer1.addChild(_loc_9);
            var _loc_10:* = new Sprite();
            new Sprite().graphics.beginFill(0, 0);
            _loc_10.graphics.drawRoundRect(0, 0, 130, 13, 5);
            _loc_10.graphics.endFill();
            _loc_10.x = 15;
            _loc_10.y = 68;
            this._mainspritelayer1.addChild(_loc_10);
            var _loc_11:* = new Sprite();
            new Sprite().graphics.beginFill(0, 0);
            _loc_11.graphics.drawRoundRect(0, 0, 130, 13, 5);
            _loc_11.graphics.endFill();
            _loc_11.x = 15;
            _loc_11.y = 83;
            this._mainspritelayer1.addChild(_loc_11);
            _loc_8.addEventListener(MouseEvent.MOUSE_OVER, this.handleover);
            _loc_8.addEventListener(MouseEvent.MOUSE_OUT, this.handleout);
            _loc_8.name = String(13);
            _loc_9.addEventListener(MouseEvent.MOUSE_OVER, this.handleover);
            _loc_9.addEventListener(MouseEvent.MOUSE_OUT, this.handleout);
            _loc_9.name = String(14);
            _loc_10.addEventListener(MouseEvent.MOUSE_OVER, this.handleover);
            _loc_10.addEventListener(MouseEvent.MOUSE_OUT, this.handleout);
            _loc_10.name = String(11);
            _loc_11.addEventListener(MouseEvent.MOUSE_OVER, this.handleover);
            _loc_11.addEventListener(MouseEvent.MOUSE_OUT, this.handleout);
            _loc_11.name = String(12);
            var _loc_12:* = new Sprite();
            new Sprite().graphics.beginFill(0, 0);
            _loc_12.graphics.drawRect(0, 0, 120, 30);
            _loc_12.graphics.endFill();
            _loc_12.x = 340;
            _loc_12.y = 32;
            _loc_12.addEventListener(MouseEvent.MOUSE_OVER, this.handleover);
            _loc_12.addEventListener(MouseEvent.MOUSE_OUT, this.handleout);
            _loc_12.name = String(18);
            this._mainspritelayer1.addChild(_loc_12);
            var _loc_13:* = new Sprite();
            new Sprite().graphics.beginFill(0, 0);
            _loc_13.graphics.drawRect(0, 0, 120, 30);
            _loc_13.graphics.endFill();
            _loc_13.x = 340;
            _loc_13.y = 64;
            _loc_13.addEventListener(MouseEvent.MOUSE_OVER, this.handleover);
            _loc_13.addEventListener(MouseEvent.MOUSE_OUT, this.handleout);
            _loc_13.name = String(19);
            this._mainspritelayer1.addChild(_loc_13);
            return;
        }// end function

        private function addsprit(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (this.pushbtn1.textColor == Style.WINDOW_FONT)
            {
                if (!this._f)
                {
                    this.sendjion(1, 0);
                }
                else if (Config.player.money1 >= 5 || Config.ui._charUI.getItemAmount(898006) >= 1)
                {
                    if (!this._flag)
                    {
                        _loc_2 = new Sprite();
                        _loc_3 = new CheckBox(_loc_2, 25, 5, Config.language("FightSprit", 27), this.checkflag);
                        _loc_3.buttonMode = true;
                        _loc_3.enabled = true;
                        _loc_3.selected = false;
                        this._flaggou = false;
                        AlertUI.close();
                        AlertUI.remove(this._alertint);
                        this._alertint = AlertUI.alert(Config.language("GodMade", 7), Config.language("GodMade", 10), [Config.language("GodMade", 8), Config.language("GodMade", 9)], [this.suresendjion, this.cancel], 1, false, true, false, _loc_2);
                    }
                    else
                    {
                        this.sendjion(1, 1);
                    }
                }
                else
                {
                    this.notenoughmoney();
                }
            }
            return;
        }// end function

        private function addgodspritbtn(event:MouseEvent) : void
        {
            if (!this._enable)
            {
                if (Config.ui._charUI.getItemAmount(898005) > 0)
                {
                    if (this._pdnum.value > 1)
                    {
                        this._enable = true;
                        this._enable_flag = true;
                        if (this.pushbtn3 != null)
                        {
                            this.pushbtn3.label = Config.language("GodMade", 11);
                        }
                    }
                    else
                    {
                        this._enable = false;
                    }
                    this.addgodsprit();
                }
                else
                {
                    AlertUI.remove(this._alertint);
                    this._alertint = AlertUI.alert(Config.language("GodMade", 7), Config.language("GodMade", 12), [Config.language("GodMade", 8), Config.language("GodMade", 9)], [this.gotoshopmail]);
                }
            }
            else
            {
                this._enable = false;
                this._enable_flag = true;
                if (this.pushbtn3 != null)
                {
                    this.pushbtn3.label = Config.language("GodMade", 1);
                }
            }
            return;
        }// end function

        private function addgodsprit() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            if (this._opening)
            {
                if (!this._f)
                {
                    this.sendjion(2, 0);
                }
                else if (Config.player.money1 >= 5 || Config.ui._charUI.getItemAmount(898006) >= 1)
                {
                    if (this._enable)
                    {
                        if (this._enable_flag)
                        {
                            this._enable_flag = false;
                            AlertUI.remove(this._alertint);
                            this._alertint = AlertUI.alert(Config.language("GodMade", 7), Config.language("GodMade", 13, this._pdnum.value, this._pdnum.value * 5), [Config.language("GodMade", 8), Config.language("GodMade", 9)], [this.suresendjion, this.cancel], 2);
                        }
                        else
                        {
                            this.sendjion(2, 1);
                        }
                    }
                    else if (!this._flag)
                    {
                        _loc_1 = new Sprite();
                        _loc_2 = new CheckBox(_loc_1, 25, 5, Config.language("FightSprit", 27), this.checkflag);
                        _loc_2.buttonMode = true;
                        _loc_2.enabled = true;
                        _loc_2.selected = false;
                        this._flaggou = false;
                        AlertUI.remove(this._alertint);
                        this._alertint = AlertUI.alert(Config.language("GodMade", 7), Config.language("GodMade", 14), [Config.language("GodMade", 8), Config.language("GodMade", 9)], [this.suresendjion, this.cancel], 2, false, true, false, _loc_1);
                    }
                    else
                    {
                        this.sendjion(2, 1);
                    }
                }
                else
                {
                    this.notenoughmoney();
                }
            }
            else
            {
                AlertUI.remove(this._alertint);
            }
            return;
        }// end function

        private function suresendjion(param1) : void
        {
            if (this._flaggou)
            {
                this._flag = true;
            }
            this.sendjion(param1, 1);
            return;
        }// end function

        private function cancel(param1) : void
        {
            if (!this._flaggou)
            {
                this._flag = false;
            }
            this._enable_flag = true;
            if (this.pushbtn3 != null)
            {
                this._enable = false;
                this.pushbtn3.label = Config.language("GodMade", 1);
            }
            return;
        }// end function

        private function sendjion(param1:uint = 1, param2:uint = 0) : void
        {
            var _loc_3:* = new DataSet();
            _loc_3.addHead(CONST_ENUM.C2G_GODATTRIBUTE_UPGRADE);
            _loc_3.add8(param1);
            _loc_3.add8(param2);
            ClientSocket.send(_loc_3);
            return;
        }// end function

        private function bless(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            Config.stopLoop(this.sendLoop);
            if (this._enable)
            {
                this._enable = false;
                this._enable_flag = true;
                if (this.pushbtn3 != null)
                {
                    this.pushbtn3.label = Config.language("GodMade", 1);
                }
                _loc_2 = "";
                if (!this._f)
                {
                    _loc_2 = Config.language("GodMade", 15);
                }
                else
                {
                    _loc_2 = Config.language("GodMade", 16);
                }
                this._alertint = AlertUI.alert(Config.language("GodMade", 7), _loc_2, [Config.language("GodMade", 8)]);
            }
            if (this.checkbox.enabled)
            {
                if (!this._f)
                {
                    this._f = true;
                    this.checkbox.selected = true;
                }
                else
                {
                    this._f = false;
                    this.checkbox.selected = false;
                }
            }
            return;
        }// end function

        private function godMadetips(event:SocketEvent) : void
        {
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = 0;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = 0;
            var _loc_15:* = 0;
            var _loc_16:* = 0;
            var _loc_17:* = null;
            var _loc_18:* = null;
            var _loc_19:* = null;
            var _loc_20:* = null;
            var _loc_21:* = 0;
            var _loc_22:* = null;
            var _loc_23:* = null;
            this._godpropArr = [];
            var _loc_2:* = [];
            var _loc_3:* = 0;
            while (_loc_3 < this._squarebitmapArr.length)
            {
                
                if (this._squarebitmapArr[_loc_3].parent != null)
                {
                    this._squarebitmapArr[_loc_3].parent.removeChild(this._squarebitmapArr[_loc_3]);
                    this._squarebitmapArr[_loc_3] = null;
                }
                _loc_3++;
            }
            this._squarebitmapArr = [];
            var _loc_4:* = event.data;
            var _loc_5:* = event.data.readByte();
            var _loc_6:* = 0;
            if (this._opening)
            {
                _loc_7 = 0;
                while (_loc_7 < _loc_5)
                {
                    
                    _loc_10 = new Object();
                    _loc_10.lv = _loc_4.readUnsignedShort();
                    _loc_10.exp = _loc_4.readUnsignedInt();
                    this._godpropArr.push(_loc_10);
                    _loc_2[_loc_7] = int(_loc_10.lv / 10);
                    _loc_11 = 54 - int(int(_loc_10.exp / Config._godAttribute[(_loc_10.lv + 1)].exp * 100) * 54 / 100);
                    _loc_12 = new Sprite();
                    _loc_12.graphics.beginFill(65280);
                    _loc_12.graphics.drawRoundRect(0, 0, 54, _loc_11, 5);
                    _loc_12.graphics.endFill();
                    if (_loc_7 == 0)
                    {
                        _loc_12.x = -25;
                        _loc_12.y = -25;
                        this._s1234Arr[2].addChild(_loc_12);
                        this._god2bitArr[2].mask = _loc_12;
                    }
                    else if (_loc_7 == 1)
                    {
                        _loc_12.x = -27;
                        _loc_12.y = -27;
                        this._s1234Arr[3].addChild(_loc_12);
                        this._god2bitArr[3].mask = _loc_12;
                    }
                    else if (_loc_7 == 2)
                    {
                        _loc_12.x = -27;
                        _loc_12.y = -25;
                        this._s1234Arr[0].addChild(_loc_12);
                        this._god2bitArr[0].mask = _loc_12;
                    }
                    else if (_loc_7 == 3)
                    {
                        _loc_12.x = -27;
                        _loc_12.y = -26;
                        this._s1234Arr[1].addChild(_loc_12);
                        this._god2bitArr[1].mask = _loc_12;
                    }
                    this._squarebitmapArr.push(_loc_12);
                    if (Config._godAttribute[(_loc_10.lv + 1)].requestLevel > Config.player.level)
                    {
                        if (this._bitmaplockArr[_loc_7] == null)
                        {
                            _loc_13 = new Bitmap();
                            _loc_13.bitmapData = Config.findsysUI("icon/fight3", 14, 18);
                            _loc_13.x = -7;
                            _loc_13.y = -9;
                            if (_loc_7 == 0)
                            {
                                this._s1234Arr[2].addChild(_loc_13);
                            }
                            else if (_loc_7 == 1)
                            {
                                this._s1234Arr[3].addChild(_loc_13);
                            }
                            else if (_loc_7 == 2)
                            {
                                this._s1234Arr[0].addChild(_loc_13);
                            }
                            else if (_loc_7 == 3)
                            {
                                this._s1234Arr[1].addChild(_loc_13);
                            }
                            this._bitmaplockArr[_loc_7] = _loc_13;
                        }
                        _loc_6++;
                    }
                    else if (this._bitmaplockArr[_loc_7] != null)
                    {
                        if (this._bitmaplockArr[_loc_7].hasOwnProperty("bitmapData"))
                        {
                            this._bitmaplockArr[_loc_7].bitmapData.dispose();
                            this._bitmaplockArr[_loc_7] = null;
                        }
                    }
                    _loc_7++;
                }
                if (_loc_6 >= 3)
                {
                    this._f = false;
                    this.checkbox.selected = false;
                    this.checkbox.enabled = false;
                    this.checkbox.buttonMode = false;
                }
                else
                {
                    this.checkbox.enabled = true;
                    this.checkbox.buttonMode = true;
                }
                this.lab1.text = Config.language("GodMade", 17, this._godpropArr[2].lv, Config._godAttribute[(this._godpropArr[2].lv + 1)].type4Value, this._godpropArr[3].lv, Config._godAttribute[(this._godpropArr[3].lv + 1)].type3Value, this._godpropArr[0].lv, Config._godAttribute[(this._godpropArr[0].lv + 1)].type1Value, this._godpropArr[1].lv, Config._godAttribute[(this._godpropArr[1].lv + 1)].type2Value);
                _loc_8 = 0;
                _loc_9 = 1;
                while (_loc_9 < 11)
                {
                    
                    _loc_14 = 0;
                    _loc_15 = 0;
                    while (_loc_15 < _loc_2.length)
                    {
                        
                        if (_loc_2[_loc_15] >= _loc_9)
                        {
                            _loc_14++;
                        }
                        if (_loc_14 == 4)
                        {
                            _loc_8 = _loc_8 + 1;
                            break;
                        }
                        _loc_15++;
                    }
                    _loc_9++;
                }
                if (!this._lvflag)
                {
                    this._lvflag = true;
                    _loc_9 = 1;
                    while (_loc_9 < 11)
                    {
                        
                        _loc_16 = 1;
                        _loc_14 = 0;
                        _loc_15 = 0;
                        while (_loc_15 < _loc_2.length)
                        {
                            
                            if (_loc_2[_loc_15] >= _loc_9)
                            {
                                _loc_14++;
                            }
                            if (_loc_14 == 4)
                            {
                                _loc_16 = 0;
                                var _loc_24:* = this;
                                var _loc_25:* = this._lvflagnumber + 1;
                                _loc_24._lvflagnumber = _loc_25;
                                break;
                            }
                            _loc_15++;
                        }
                        _loc_17 = new Sprite();
                        _loc_17.graphics.beginFill(0, 0);
                        _loc_17.graphics.drawRoundRect(0, 0, 34, 34, 5);
                        _loc_17.graphics.endFill();
                        this._mainspritelayer1.addChild(_loc_17);
                        _loc_17.x = _loc_9 * 41;
                        _loc_17.y = 265;
                        _loc_17.addEventListener(MouseEvent.MOUSE_OVER, this.handleover);
                        _loc_17.addEventListener(MouseEvent.MOUSE_OUT, this.handleout);
                        _loc_17.name = String(_loc_9);
                        _loc_18 = new Bitmap();
                        _loc_17.addChild(_loc_18);
                        _loc_19 = "";
                        _loc_19 = "godmade/" + (_loc_9 * 10 + _loc_16);
                        _loc_18.bitmapData = Config.findsysUI(_loc_19, 34, 34);
                        this._lv10bitmapArr.push(_loc_18);
                        if (this._lv10bitmapArr.length == 1)
                        {
                            if (GuideUI._nextObjArray != null && GuideUI._nextObjArray[0] == this.pushbtn3)
                            {
                                GuideUI._nextObjArray[2] = _loc_18;
                            }
                        }
                        _loc_9++;
                    }
                }
                if (_loc_8 > this._lvflagnumber)
                {
                    if (this._lv10bitmapArr[this._lvflagnumber] != null)
                    {
                        if (this._lv10bitmapArr[this._lvflagnumber].hasOwnProperty("bitmapData"))
                        {
                            this._lv10bitmapArr[this._lvflagnumber].bitmapData.dispose();
                            _loc_20 = new Bitmap();
                            this._mainspritelayer1.addChild(_loc_20);
                            _loc_20.bitmapData = Config.findsysUI("godmade/" + _loc_8 * 10, 34, 34);
                            _loc_20.x = _loc_8 * 41;
                            _loc_20.y = 265;
                            this._lv10bitmapArr[this._lvflagnumber] = _loc_20;
                            _loc_21 = 0;
                            _loc_22 = GClip.newGClip("effecgetlife");
                            _loc_22.x = _loc_8 * 41 - 5;
                            _loc_22.y = 260;
                            _loc_22.mouseChildren = false;
                            _loc_22.mouseEnabled = false;
                            this._mainspritelayer1.addChild(_loc_22);
                            setTimeout(this.destroyeffec, 1000, _loc_22);
                            _loc_23 = "";
                            switch(_loc_8)
                            {
                                case 1:
                                {
                                    _loc_23 = _loc_23 + Config._itemPropMap[130].name;
                                    break;
                                }
                                case 2:
                                {
                                    _loc_23 = _loc_23 + Config._itemPropMap[131].name;
                                    break;
                                }
                                case 3:
                                {
                                    _loc_23 = _loc_23 + Config._itemPropMap[132].name;
                                    break;
                                }
                                case 4:
                                {
                                    _loc_23 = _loc_23 + Config._itemPropMap[134].name;
                                    break;
                                }
                                case 5:
                                {
                                    _loc_23 = _loc_23 + Config._itemPropMap[40].name;
                                    break;
                                }
                                case 6:
                                {
                                    _loc_23 = _loc_23 + Config._itemPropMap[125].name;
                                    break;
                                }
                                case 7:
                                {
                                    _loc_23 = _loc_23 + Config._itemPropMap[133].name;
                                    break;
                                }
                                case 8:
                                {
                                    _loc_23 = _loc_23 + Config._itemPropMap[135].name;
                                    break;
                                }
                                case 9:
                                {
                                    _loc_23 = _loc_23 + Config._itemPropMap[138].name;
                                    break;
                                }
                                case 10:
                                {
                                    _loc_23 = _loc_23 + Config._itemPropMap[136].name;
                                    break;
                                }
                                default:
                                {
                                    break;
                                }
                            }
                            _loc_23 = _loc_23 + ("+" + Config._godAttribute[_loc_8 * 10 + 1].awardValue);
                            this.blesseffc(Config.language("GodMade", 18, _loc_23));
                        }
                    }
                    this._lvflagnumber = _loc_8;
                }
            }
            return;
        }// end function

        private function showMore(event:SocketEvent) : void
        {
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedByte();
            var _loc_4:* = _loc_2.readUnsignedByte();
            this.blesseffc(Config.language("GodMade", 19, _loc_3), 18);
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            while (_loc_8 < _loc_4)
            {
                
                _loc_9 = _loc_2.readUnsignedByte();
                if (_loc_9 == 1)
                {
                    _loc_7 = 2;
                }
                else if (_loc_9 == 2)
                {
                    _loc_7 = 3;
                }
                else if (_loc_9 == 3)
                {
                    _loc_7 = 0;
                }
                else if (_loc_9 == 4)
                {
                    _loc_7 = 1;
                }
                else
                {
                    trace("出错了");
                    return;
                }
                _loc_10 = GClip.newGClip("effecbond");
                _loc_10.x = -26;
                _loc_10.y = -26;
                _loc_10.mouseChildren = false;
                _loc_10.mouseEnabled = false;
                this._s1234Arr[_loc_7].addChild(_loc_10);
                setTimeout(this.destroyeffec1, 500, _loc_10);
                _loc_8++;
            }
            return;
        }// end function

        private function destroyeffec1(param1:GClip)
        {
            if (GClip(param1).parent != null)
            {
                GClip(param1).parent.removeChild(GClip(param1));
            }
            GClip(param1).destroy();
            return;
        }// end function

        private function upgrade(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedByte();
            trace(_loc_3);
            var _loc_4:* = 0;
            if (_loc_3 == 1)
            {
                _loc_4 = 2;
            }
            else if (_loc_3 == 2)
            {
                _loc_4 = 3;
            }
            else if (_loc_3 == 3)
            {
                _loc_4 = 0;
            }
            else if (_loc_3 == 4)
            {
                _loc_4 = 1;
            }
            else
            {
                trace("出错了");
                return;
            }
            var _loc_5:* = GClip.newGClip("effecgrade");
            GClip.newGClip("effecgrade").x = -24;
            _loc_5.y = -55;
            _loc_5.mouseChildren = false;
            _loc_5.mouseEnabled = false;
            this._s1234Arr[_loc_4].addChild(_loc_5);
            setTimeout(this.destroyeffec, 1000, _loc_5);
            return;
        }// end function

        private function destroyeffec(param1:GClip)
        {
            if (GClip(param1).parent != null)
            {
                GClip(param1).parent.removeChild(GClip(param1));
            }
            GClip(param1).destroy();
            return;
        }// end function

        private function addexp(event:SocketEvent) : void
        {
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedByte();
            var _loc_4:* = _loc_2.readUnsignedByte();
            var _loc_5:* = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_6 = _loc_2.readUnsignedByte();
                _loc_7 = _loc_2.readUnsignedInt();
                _loc_8 = Config.language("GodMade", 20, _loc_7);
                if (_loc_6 == 1)
                {
                    this.blesseffc1(_loc_8, 265, 160);
                }
                else if (_loc_6 == 2)
                {
                    this.blesseffc2(_loc_8, 360, 200);
                }
                else if (_loc_6 == 3)
                {
                    this.blesseffc3(_loc_8, 60, 200);
                }
                else if (_loc_6 == 4)
                {
                    this.blesseffc4(_loc_8, 155, 160);
                }
                _loc_5++;
            }
            if (_loc_3 == 2)
            {
                (this._pdnum.value - 1);
                if (this._pdnum.value > 0 && this._enable)
                {
                    Config.startLoop(this.sendLoop);
                }
                else if (this._pdnum.value <= 0)
                {
                    this._enable = false;
                    this._enable_flag = true;
                    if (this.pushbtn3 != null)
                    {
                        this.pushbtn3.label = Config.language("GodMade", 1);
                    }
                    Config.stopLoop(this.sendLoop);
                    if (Config.ui._charUI.getItemAmount(898005) > 0)
                    {
                        this._pdnum.value = 1;
                    }
                    else
                    {
                        this._pdnum.value = 0;
                    }
                }
            }
            return;
        }// end function

        private function checkflag(event:MouseEvent)
        {
            if (this._flaggou)
            {
                event.currentTarget.selected = false;
                this._flaggou = false;
            }
            else
            {
                event.currentTarget.selected = true;
                this._flaggou = true;
            }
            return;
        }// end function

        private function blessTf(param1:String, param2:int = 14)
        {
            var _loc_3:* = Config.getSimpleTextField();
            _loc_3.defaultTextFormat = new TextFormat(null, param2, 16711680, true);
            _loc_3.htmlText = param1;
            _loc_3.alpha = 0;
            this._mainspritelayer1.addChild(_loc_3);
            return _loc_3;
        }// end function

        private function blesseffc(param1:String, param2:int = 14)
        {
            var _loc_3:* = this.blessTf(param1, param2);
            var _loc_4:* = {};
            _loc_3.x = 180;
            _loc_3.y = 140;
            _loc_4.y = 140 - 40;
            _loc_4.count = 0;
            _loc_4.tf = _loc_3;
            this._belssStack.push(_loc_4);
            if (this._belssStack.length == 1)
            {
                Config.startLoop(this.belssLoop);
            }
            return;
        }// end function

        private function belssLoop(param1)
        {
            var _loc_3:* = undefined;
            var _loc_2:* = 0;
            while (_loc_2 < this._belssStack.length)
            {
                
                _loc_3 = this._belssStack[_loc_2];
                if (_loc_2 == (this._belssStack.length - 1))
                {
                    if (_loc_3.count <= 20)
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
                    else if (_loc_3.count <= 40)
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
                            this._mainspritelayer1.removeChild(_loc_3.tf);
                            this._belssStack.splice(_loc_2, 1);
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
                        this._mainspritelayer1.removeChild(_loc_3.tf);
                        this._belssStack.splice(_loc_2, 1);
                        _loc_2 = _loc_2 - 1;
                    }
                }
                _loc_2 = _loc_2 + 1;
            }
            if (this._belssStack.length == 0)
            {
                Config.stopLoop(this.belssLoop);
            }
            return;
        }// end function

        private function blesseffc1(param1:String, param2:int = 210, param3:int = 140)
        {
            var _loc_4:* = this.blessTf(param1);
            var _loc_5:* = {};
            _loc_4.x = param2;
            _loc_4.y = param3;
            _loc_5.y = param3 - 40;
            _loc_5.count = 0;
            _loc_5.tf = _loc_4;
            this._belssStack1.push(_loc_5);
            if (this._belssStack1.length == 1)
            {
                Config.startLoop(this.belssLoop1);
            }
            return;
        }// end function

        private function belssLoop1(param1)
        {
            var _loc_3:* = undefined;
            var _loc_2:* = 0;
            while (_loc_2 < this._belssStack1.length)
            {
                
                _loc_3 = this._belssStack1[_loc_2];
                if (_loc_2 == (this._belssStack1.length - 1))
                {
                    if (_loc_3.count <= 20)
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
                    else if (_loc_3.count <= 40)
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
                            this._mainspritelayer1.removeChild(_loc_3.tf);
                            this._belssStack1.splice(_loc_2, 1);
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
                        this._mainspritelayer1.removeChild(_loc_3.tf);
                        this._belssStack1.splice(_loc_2, 1);
                        _loc_2 = _loc_2 - 1;
                    }
                }
                _loc_2 = _loc_2 + 1;
            }
            if (this._belssStack1.length == 0)
            {
                Config.stopLoop(this.belssLoop1);
            }
            return;
        }// end function

        public function blesseffc2(param1:String, param2:int = 260, param3:int = 330)
        {
            var _loc_4:* = this.blessTf(param1);
            var _loc_5:* = {};
            _loc_4.x = param2;
            _loc_4.y = param3;
            _loc_5.y = param3 - 40;
            _loc_5.count = 0;
            _loc_5.tf = _loc_4;
            this._belssStack2.push(_loc_5);
            if (this._belssStack2.length == 1)
            {
                Config.startLoop(this.belssLoop2);
            }
            return;
        }// end function

        private function belssLoop2(param1)
        {
            var _loc_3:* = undefined;
            var _loc_2:* = 0;
            while (_loc_2 < this._belssStack2.length)
            {
                
                _loc_3 = this._belssStack2[_loc_2];
                if (_loc_2 == (this._belssStack2.length - 1))
                {
                    if (_loc_3.count <= 20)
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
                    else if (_loc_3.count <= 40)
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
                            this._mainspritelayer1.removeChild(_loc_3.tf);
                            this._belssStack2.splice(_loc_2, 1);
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
                        this._mainspritelayer1.removeChild(_loc_3.tf);
                        this._belssStack2.splice(_loc_2, 1);
                        _loc_2 = _loc_2 - 1;
                    }
                }
                _loc_2 = _loc_2 + 1;
            }
            if (this._belssStack2.length == 0)
            {
                Config.stopLoop(this.belssLoop2);
            }
            return;
        }// end function

        public function blesseffc3(param1:String, param2:int = 260, param3:int = 330)
        {
            var _loc_4:* = this.blessTf(param1);
            var _loc_5:* = {};
            _loc_4.x = param2;
            _loc_4.y = param3;
            _loc_5.y = param3 - 40;
            _loc_5.count = 0;
            _loc_5.tf = _loc_4;
            this._belssStack3.push(_loc_5);
            if (this._belssStack3.length == 1)
            {
                Config.startLoop(this.belssLoop3);
            }
            return;
        }// end function

        private function belssLoop3(param1)
        {
            var _loc_3:* = undefined;
            var _loc_2:* = 0;
            while (_loc_2 < this._belssStack3.length)
            {
                
                _loc_3 = this._belssStack3[_loc_2];
                if (_loc_2 == (this._belssStack3.length - 1))
                {
                    if (_loc_3.count <= 20)
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
                    else if (_loc_3.count <= 40)
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
                            this._mainspritelayer1.removeChild(_loc_3.tf);
                            this._belssStack3.splice(_loc_2, 1);
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
                        this._mainspritelayer1.removeChild(_loc_3.tf);
                        this._belssStack3.splice(_loc_2, 1);
                        _loc_2 = _loc_2 - 1;
                    }
                }
                _loc_2 = _loc_2 + 1;
            }
            if (this._belssStack3.length == 0)
            {
                Config.stopLoop(this.belssLoop3);
            }
            return;
        }// end function

        public function blesseffc4(param1:String, param2:int = 260, param3:int = 330)
        {
            var _loc_4:* = this.blessTf(param1);
            var _loc_5:* = {};
            _loc_4.x = param2;
            _loc_4.y = param3;
            _loc_5.y = param3 - 40;
            _loc_5.count = 0;
            _loc_5.tf = _loc_4;
            this._belssStack4.push(_loc_5);
            if (this._belssStack4.length == 1)
            {
                Config.startLoop(this.belssLoop4);
            }
            return;
        }// end function

        private function belssLoop4(param1)
        {
            var _loc_3:* = undefined;
            var _loc_2:* = 0;
            while (_loc_2 < this._belssStack4.length)
            {
                
                _loc_3 = this._belssStack4[_loc_2];
                if (_loc_2 == (this._belssStack4.length - 1))
                {
                    if (_loc_3.count <= 20)
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
                    else if (_loc_3.count <= 40)
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
                            this._mainspritelayer1.removeChild(_loc_3.tf);
                            this._belssStack4.splice(_loc_2, 1);
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
                        this._mainspritelayer1.removeChild(_loc_3.tf);
                        this._belssStack4.splice(_loc_2, 1);
                        _loc_2 = _loc_2 - 1;
                    }
                }
                _loc_2 = _loc_2 + 1;
            }
            if (this._belssStack4.length == 0)
            {
                Config.stopLoop(this.belssLoop4);
            }
            return;
        }// end function

        private function changenumber(param1) : void
        {
            var _loc_2:* = Config.ui._charUI.getItemAmount(898005);
            if (this._pdnum.value >= _loc_2)
            {
                this._pdnum.value = _loc_2;
            }
            return;
        }// end function

        private function sendLoop(param1) : void
        {
            if (Config.player.money1 < 5 && Config.ui._charUI.getItemAmount(898006) < 1 && this._f)
            {
                Config.stopLoop(this.sendLoop);
                this.notenoughmoney();
                return;
            }
            if (this._fornumber <= 12)
            {
                var _loc_2:* = this;
                var _loc_3:* = this._fornumber + 1;
                _loc_2._fornumber = _loc_3;
            }
            else
            {
                this._fornumber = 0;
                this.addgodsprit();
            }
            if (this._enable_flag)
            {
                if (this._pdnum.value == 0 || !this._flag && this._f || !this._enable)
                {
                    Config.stopLoop(this.sendLoop);
                    this._fornumber = 0;
                    this._enable = false;
                    this.pushbtn3.label = Config.language("GodMade", 1);
                }
            }
            else if (this._pdnum.value == 0)
            {
                Config.stopLoop(this.sendLoop);
                this._fornumber = 0;
                this._enable = false;
                this.pushbtn3.label = Config.language("GodMade", 1);
            }
            return;
        }// end function

        private function handleover(event:MouseEvent) : void
        {
            var _loc_2:* = event.currentTarget;
            Holder.showInfo(this.strectext(parseInt(_loc_2.name)), new Rectangle(Config.stage.mouseX + 10, Config.stage.mouseY + 15));
            return;
        }// end function

        private function handleout(param1) : void
        {
            Holder.closeInfo();
            return;
        }// end function

        private function strectext(param1:int) : String
        {
            var _loc_2:* = "";
            if (param1 <= 10)
            {
                _loc_2 = _loc_2 + Config.language("GodMade", 21);
                if (param1 > this._lvflagnumber)
                {
                    _loc_2 = _loc_2 + Config.language("GodMade", 22);
                }
            }
            switch(param1)
            {
                case 1:
                {
                    _loc_2 = _loc_2 + Config._itemPropMap[130].name;
                    break;
                }
                case 2:
                {
                    _loc_2 = _loc_2 + Config._itemPropMap[131].name;
                    break;
                }
                case 3:
                {
                    _loc_2 = _loc_2 + Config._itemPropMap[132].name;
                    break;
                }
                case 4:
                {
                    _loc_2 = _loc_2 + Config._itemPropMap[134].name;
                    break;
                }
                case 5:
                {
                    _loc_2 = _loc_2 + Config._itemPropMap[40].name;
                    break;
                }
                case 6:
                {
                    _loc_2 = _loc_2 + Config._itemPropMap[125].name;
                    break;
                }
                case 7:
                {
                    _loc_2 = _loc_2 + Config._itemPropMap[133].name;
                    break;
                }
                case 8:
                {
                    _loc_2 = _loc_2 + Config._itemPropMap[135].name;
                    break;
                }
                case 9:
                {
                    _loc_2 = _loc_2 + Config._itemPropMap[138].name;
                    break;
                }
                case 10:
                {
                    _loc_2 = _loc_2 + Config._itemPropMap[136].name;
                    break;
                }
                case 11:
                case 12:
                case 13:
                case 14:
                {
                    _loc_2 = _loc_2 + this.godtips(param1);
                    break;
                }
                case 15:
                {
                    _loc_2 = _loc_2 + Config.language("GodMade", 23);
                    break;
                }
                case 16:
                {
                    if (this.pushbtn1.textColor == Style.WINDOW_FONT)
                    {
                        _loc_2 = _loc_2 + Config.language("GodMade", 24);
                    }
                    else
                    {
                        _loc_2 = _loc_2 + Config.language("GodMade", 47);
                    }
                    break;
                }
                case 17:
                {
                    _loc_2 = _loc_2 + Config.language("GodMade", 25);
                    break;
                }
                case 18:
                {
                    _loc_2 = _loc_2 + Config.language("GodMade", 26);
                    break;
                }
                case 19:
                {
                    _loc_2 = _loc_2 + Config.language("GodMade", 27);
                    break;
                }
                case 20:
                {
                    _loc_2 = _loc_2 + Config.language("GodMade", 28);
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (param1 <= 10)
            {
                if (param1 > this._lvflagnumber)
                {
                    _loc_2 = _loc_2 + Config.language("GodMade", 29, param1 * 10);
                }
                else
                {
                    _loc_2 = _loc_2 + Config.language("GodMade", 30, Config._godAttribute[param1 * 10 + 1].awardValue);
                }
            }
            return _loc_2;
        }// end function

        private function godtips(param1:int) : String
        {
            var _loc_2:* = "";
            var _loc_3:* = "";
            var _loc_4:* = "";
            var _loc_5:* = "";
            var _loc_6:* = "";
            var _loc_7:* = [Config.language("GodMade", 31), Config.language("GodMade", 32), Config.language("GodMade", 33), Config.language("GodMade", 34)];
            var _loc_8:* = 1;
            switch(param1)
            {
                case 13:
                {
                    _loc_2 = _loc_2 + Config.language("GodMade", 35);
                    _loc_6 = "type3Value";
                    break;
                }
                case 14:
                {
                    _loc_2 = _loc_2 + Config.language("GodMade", 36);
                    _loc_6 = "type4Value";
                    break;
                }
                case 11:
                {
                    _loc_2 = _loc_2 + Config.language("GodMade", 37);
                    _loc_6 = "type1Value";
                    break;
                }
                case 12:
                {
                    _loc_2 = _loc_2 + Config.language("GodMade", 38);
                    _loc_6 = "type2Value";
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (this._godpropArr[param1 - 11] != null)
            {
                _loc_8 = this._godpropArr[param1 - 11].lv;
                _loc_3 = Config.language("GodMade", 39, this._godpropArr[param1 - 11].lv);
                _loc_4 = Config.language("GodMade", 40, this._godpropArr[param1 - 11].exp, Config._godAttribute[(this._godpropArr[param1 - 11].lv + 1)].exp);
                _loc_5 = Config.language("GodMade", 41, _loc_7[param1 - 11], Config._godAttribute[(this._godpropArr[param1 - 11].lv + 1)][_loc_6]);
            }
            _loc_2 = _loc_2 + ("\n\n" + _loc_3);
            _loc_2 = _loc_2 + ("\n" + _loc_4);
            _loc_2 = _loc_2 + ("\n" + _loc_5);
            if (_loc_8 < Setting.GOD_MADE_MAX_LEVEL)
            {
                _loc_2 = _loc_2 + Config.language("GodMade", 42);
                if (Config.player.level < Config._godAttribute[_loc_8 + 2].requestLevel)
                {
                    _loc_2 = _loc_2 + ("<font color=\'#ad1b2e\'>" + Config.language("GodMade", 43, Config._godAttribute[_loc_8 + 2].requestLevel) + "</font>");
                }
                else
                {
                    _loc_2 = _loc_2 + Config.language("GodMade", 43, Config._godAttribute[_loc_8 + 2].requestLevel);
                }
                _loc_2 = _loc_2 + Config.language("GodMade", 44, _loc_7[param1 - 11], Config._godAttribute[_loc_8 + 2][_loc_6]);
            }
            else
            {
                _loc_2 = _loc_2 + ("\n\n<font color=\'#ad1b2e\'>" + Config.language("GodMade", 45) + "</font>");
            }
            return _loc_2;
        }// end function

        private function addallbitmap()
        {
            this._allbitmapArr = [];
            var _loc_1:* = new Bitmap();
            this._mainspritelayer.addChild(_loc_1);
            _loc_1.x = 4;
            _loc_1.y = 22;
            _loc_1.bitmapData = Config.findsysUI("godmade/bg", 483, 371);
            this._allbitmapArr.push(_loc_1);
            var _loc_2:* = new Bitmap();
            this._s1234Arr[0].addChild(_loc_2);
            _loc_2.x = -25;
            _loc_2.y = -25;
            _loc_2.bitmapData = Config.findsysUI("godmade/godakt1", 54, 54);
            var _loc_3:* = new Bitmap();
            this._s1234Arr[0].addChild(_loc_3);
            _loc_3.x = -26;
            _loc_3.y = -26;
            _loc_3.bitmapData = Config.findsysUI("godmade/godakt2", 54, 54);
            this._god2bitArr[0] = _loc_3;
            var _loc_4:* = new Bitmap();
            this._s1234Arr[1].addChild(_loc_4);
            _loc_4.x = -27;
            _loc_4.y = -26;
            _loc_4.bitmapData = Config.findsysUI("godmade/goddef1", 54, 54);
            var _loc_5:* = new Bitmap();
            this._s1234Arr[1].addChild(_loc_5);
            _loc_5.x = -27;
            _loc_5.y = -26;
            _loc_5.bitmapData = Config.findsysUI("godmade/goddef2", 54, 54);
            this._god2bitArr[1] = _loc_5;
            var _loc_6:* = new Bitmap();
            this._s1234Arr[2].addChild(_loc_6);
            _loc_6.x = -26;
            _loc_6.y = -26;
            _loc_6.bitmapData = Config.findsysUI("godmade/godblo1", 54, 54);
            var _loc_7:* = new Bitmap();
            this._s1234Arr[2].addChild(_loc_7);
            _loc_7.x = -26;
            _loc_7.y = -26;
            _loc_7.bitmapData = Config.findsysUI("godmade/godblo2", 54, 54);
            this._god2bitArr[2] = _loc_7;
            var _loc_8:* = new Bitmap();
            this._s1234Arr[3].addChild(_loc_8);
            _loc_8.x = -27;
            _loc_8.y = -27;
            _loc_8.bitmapData = Config.findsysUI("godmade/godgod1", 54, 54);
            var _loc_9:* = new Bitmap();
            this._s1234Arr[3].addChild(_loc_9);
            _loc_9.x = -27;
            _loc_9.y = -27;
            _loc_9.bitmapData = Config.findsysUI("godmade/godgod2", 54, 54);
            this._god2bitArr[3] = _loc_9;
            var _loc_10:* = new Bitmap();
            new Bitmap().bitmapData = Config.findIcon(Config._itemMap[898004].icon);
            this._mainspritelayer.addChild(_loc_10);
            _loc_10.x = 345;
            _loc_10.y = 32;
            this._allbitmapArr.push(_loc_10);
            var _loc_11:* = new Bitmap();
            new Bitmap().bitmapData = Config.findIcon(Config._itemMap[898005].icon);
            this._mainspritelayer.addChild(_loc_11);
            _loc_11.x = 345;
            _loc_11.y = 62;
            this._allbitmapArr.push(_loc_11);
            var _loc_12:* = new DataSet();
            new DataSet().addHead(CONST_ENUM.C2G_GODATTRIBUTE_LIST);
            ClientSocket.send(_loc_12);
            return;
        }// end function

        private function itemchange(param1) : void
        {
            if (this._opening)
            {
                this.lab2.text = Config.language("GodMade", 3, Config.ui._charUI.getItemAmount(898004), Config.ui._charUI.getItemAmount(898005));
                if (Config.ui._charUI.getItemAmount(898004) > 0)
                {
                    this.pushbtn1.textColor = Style.WINDOW_FONT;
                }
                else
                {
                    this.pushbtn1.textColor = Style.WINDOW_FONT_DISABLE;
                }
            }
            return;
        }// end function

        private function notenoughmoney()
        {
            AlertUI.remove(this._alertint);
            this._alertint = AlertUI.alert(Config.language("GodMade", 7), Config.language("GodMade", 46), [Config.language("GodMade", 8)]);
            this._enable = false;
            if (this.pushbtn3 != null)
            {
                this.pushbtn3.label = Config.language("GodMade", 1);
            }
            return;
        }// end function

        private function gotoshopmail(param1) : void
        {
            Config.ui._shopmail.openListPanel(99);
            return;
        }// end function

        public function notgrade() : void
        {
            Config.stopLoop(this.sendLoop);
            this._enable = false;
            if (this.pushbtn3 != null)
            {
                this.pushbtn3.label = Config.language("GodMade", 1);
            }
            return;
        }// end function

    }
}
