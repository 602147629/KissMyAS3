package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import lovefox.component.*;
    import lovefox.socket.*;

    public class ServerInterRacebill extends Window
    {
        private var _listArr:Array;
        private var _playerArr:Array;
        private var _bitmapArr:Array;
        private var _bitmapArr1:Array;
        private var _lastupdatetime:uint = 0;
        private var infowindow:Window;
        private var info:TextAreaUI;
        private var _mainspr:Sprite;
        private var _fmainspr:Sprite;
        private var _sprwin:Sprite;

        public function ServerInterRacebill(param1:DisplayObjectContainer = null)
        {
            this._bitmapArr = [];
            this._bitmapArr1 = [];
            super(param1);
            resize(530, 460);
            this.title = Config.language("ServerInterRacebill", 1);
            this.initdrawline();
            this.inintsocket();
            return;
        }// end function

        public function inintsocket() : void
        {
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.B2C_CARENA3_TOP, this.toplist);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.B2C_CARENA3_VS, this.vslist);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_CARENA_VSRET, this.handlePkResult);
            return;
        }// end function

        private function initdrawline() : void
        {
            var _loc_2:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_1:* = 1;
            _loc_2 = 1;
            var _loc_3:* = 1;
            this._listArr = [];
            this._playerArr = [];
            this._mainspr = new Sprite();
            this._fmainspr = new Sprite();
            this.addChild(this._mainspr);
            this.addChild(this._fmainspr);
            _loc_2 = 1;
            while (_loc_2 <= 32)
            {
                
                _loc_6 = new Sprite();
                _loc_6.graphics.beginFill(16165741, 1);
                _loc_6.graphics.drawRoundRect(0, 0, 90, 18, 5);
                _loc_6.graphics.endFill();
                _loc_7 = new Shape();
                _loc_7.graphics.lineStyle(1, 0, 0.5);
                _loc_7.graphics.moveTo(0, 0);
                _loc_7.graphics.lineTo(90, 0);
                _loc_7.graphics.moveTo(90, 0);
                _loc_7.graphics.lineTo(90, 18);
                _loc_7.graphics.moveTo(90, 18);
                _loc_7.graphics.lineTo(0, 18);
                _loc_7.graphics.moveTo(0, 18);
                _loc_7.graphics.lineTo(0, 0);
                _loc_6.addChild(_loc_7);
                _loc_6.x = 20 + (Math.ceil(_loc_2 / 16) - 1) * 400;
                if (_loc_2 > 16)
                {
                    _loc_1 = _loc_2 - 16;
                }
                else
                {
                    _loc_1 = _loc_2;
                }
                _loc_6.y = 15 + (Math.ceil(_loc_1 / 2) - 1) * 10 + _loc_1 * 20;
                this.addChild(_loc_6);
                this._listArr.push(_loc_6);
                this._playerArr.push("0");
                _loc_2++;
            }
            _loc_3 = 1;
            while (_loc_3 <= 5)
            {
                
                _loc_2 = 1;
                while (_loc_2 <= 32)
                {
                    
                    if (_loc_3 == 2 && _loc_2 % 2 == 0)
                    {
                        ;
                    }
                    else if (_loc_3 == 3 && _loc_2 % 4 != 0)
                    {
                        ;
                    }
                    else if (_loc_3 == 4 && _loc_2 % 8 != 0)
                    {
                        ;
                    }
                    else if (_loc_3 == 5 && _loc_2 % 16 != 0)
                    {
                    }
                    this.drawline(_loc_2, _loc_3);
                    _loc_2++;
                }
                _loc_3++;
            }
            this._sprwin = new Sprite();
            this._sprwin.graphics.beginFill(16165741, 1);
            this._sprwin.graphics.drawRoundRect(0, 0, 90, 18, 5);
            this._sprwin.graphics.endFill();
            var _loc_4:* = new Shape();
            new Shape().graphics.lineStyle(1, 0, 0.5);
            _loc_4.graphics.moveTo(0, 0);
            _loc_4.graphics.lineTo(90, 0);
            _loc_4.graphics.moveTo(90, 0);
            _loc_4.graphics.lineTo(90, 18);
            _loc_4.graphics.moveTo(90, 18);
            _loc_4.graphics.lineTo(0, 18);
            _loc_4.graphics.moveTo(0, 18);
            _loc_4.graphics.lineTo(0, 0);
            this._sprwin.addChild(_loc_4);
            this._sprwin.x = 220;
            this._sprwin.y = 220;
            this.addChild(this._sprwin);
            this._listArr.push(this._sprwin);
            var _loc_5:* = new Label(this, 242, 195);
            new Label(this, 242, 195).html = true;
            _loc_5.text = "<b><font size=\'16\'>" + Config.language("ServerInterRacebill", 2) + "</font></b>";
            return;
        }// end function

        private function drawline(param1:uint, param2:uint, param3:uint = 1, param4:int = 16777215, param5 = 1) : void
        {
            var _loc_7:* = 0;
            var _loc_6:* = new Shape();
            new Shape().graphics.lineStyle(param3, param4, param5);
            if (param2 == 1)
            {
                if (param1 <= 16 && param1 > 0)
                {
                    if (param1 % 2 == 1)
                    {
                        _loc_6.graphics.moveTo(0, 0);
                        _loc_6.graphics.lineTo(25, 0);
                        _loc_6.graphics.moveTo(25, 0);
                        _loc_6.graphics.lineTo(25, 10);
                        _loc_6.x = 110;
                        _loc_6.y = 45 + (param1 - 1) * 25;
                    }
                    else
                    {
                        _loc_6.graphics.moveTo(25, 0);
                        _loc_6.graphics.lineTo(25, 10);
                        _loc_6.graphics.moveTo(0, 10);
                        _loc_6.graphics.lineTo(25, 10);
                        _loc_6.x = 110;
                        _loc_6.y = 55 + (param1 - 2) * 25;
                    }
                }
                else if (param1 > 16 && param1 <= 32)
                {
                    if ((param1 - 16) % 2 == 1)
                    {
                        _loc_6.graphics.moveTo(0, 0);
                        _loc_6.graphics.lineTo(0, 10);
                        _loc_6.graphics.moveTo(0, 0);
                        _loc_6.graphics.lineTo(25, 0);
                        _loc_6.x = 395;
                        _loc_6.y = 45 + (param1 - 16 - 1) * 25;
                    }
                    else
                    {
                        _loc_6.graphics.moveTo(0, 0);
                        _loc_6.graphics.lineTo(0, 10);
                        _loc_6.graphics.moveTo(0, 10);
                        _loc_6.graphics.lineTo(25, 10);
                        _loc_6.x = 395;
                        _loc_6.y = 55 + (param1 - 16 - 2) * 25;
                    }
                }
            }
            else if (param2 == 2)
            {
                if (param1 <= 16 && param1 > 0)
                {
                    if (param1 % 4 == 0 || (param1 + 1) % 4 == 0)
                    {
                        _loc_6.graphics.moveTo(25, 0);
                        _loc_6.graphics.lineTo(25, 25);
                        _loc_6.graphics.moveTo(0, 25);
                        _loc_6.graphics.lineTo(25, 25);
                        _loc_6.x = 135;
                        _loc_7 = 1;
                        if (param1 % 4 == 0)
                        {
                            _loc_7 = param1 / 4 - 1;
                        }
                        else
                        {
                            _loc_7 = (param1 + 1) / 4 - 1;
                        }
                        _loc_6.y = 80 + _loc_7 * 100;
                    }
                    else
                    {
                        _loc_6.graphics.moveTo(0, 0);
                        _loc_6.graphics.lineTo(25, 0);
                        _loc_6.graphics.moveTo(25, 0);
                        _loc_6.graphics.lineTo(25, 25);
                        _loc_6.x = 135;
                        _loc_7 = 1;
                        if ((param1 + 2) % 4 == 0)
                        {
                            _loc_7 = (param1 + 2) / 4 - 1;
                        }
                        else
                        {
                            _loc_7 = (param1 + 3) / 4 - 1;
                        }
                        _loc_6.y = 55 + _loc_7 * 100;
                    }
                }
                else if (param1 > 16 && param1 <= 32)
                {
                    if ((param1 - 16) % 4 == 0 || (param1 - 16 + 1) % 4 == 0)
                    {
                        _loc_6.graphics.moveTo(0, 0);
                        _loc_6.graphics.lineTo(0, 25);
                        _loc_6.graphics.moveTo(0, 25);
                        _loc_6.graphics.lineTo(25, 25);
                        _loc_6.x = 370;
                        _loc_7 = 1;
                        if ((param1 - 16) % 4 == 0)
                        {
                            _loc_7 = (param1 - 16) / 4 - 1;
                        }
                        else
                        {
                            _loc_7 = (param1 - 16 + 1) / 4 - 1;
                        }
                        _loc_6.y = 80 + _loc_7 * 100;
                    }
                    else
                    {
                        _loc_6.graphics.moveTo(0, 0);
                        _loc_6.graphics.lineTo(0, 25);
                        _loc_6.graphics.moveTo(0, 0);
                        _loc_6.graphics.lineTo(25, 0);
                        _loc_6.x = 370;
                        _loc_7 = 1;
                        if ((param1 - 16 + 2) % 4 == 0)
                        {
                            _loc_7 = (param1 - 16 + 2) / 4 - 1;
                        }
                        else
                        {
                            _loc_7 = (param1 - 16 + 3) / 4 - 1;
                        }
                        _loc_6.y = 55 + _loc_7 * 100;
                    }
                }
            }
            else if (param2 == 3)
            {
                if (param1 <= 16 && param1 > 0)
                {
                    if (param1 <= 4 || param1 > 8 && param1 <= 12)
                    {
                        _loc_6.graphics.moveTo(0, 0);
                        _loc_6.graphics.lineTo(25, 0);
                        _loc_6.graphics.moveTo(25, 0);
                        _loc_6.graphics.lineTo(25, 50);
                        _loc_6.x = 160;
                        _loc_6.y = 80 + (Math.ceil(param1 / 4) - 1) * 100;
                    }
                    else
                    {
                        _loc_6.graphics.moveTo(25, 0);
                        _loc_6.graphics.lineTo(25, 50);
                        _loc_6.graphics.moveTo(0, 50);
                        _loc_6.graphics.lineTo(25, 50);
                        _loc_6.x = 160;
                        _loc_6.y = 130 + (Math.ceil(param1 / 4) - 2) * 100;
                    }
                }
                else if (param1 > 16 && param1 <= 32)
                {
                    if (param1 - 16 <= 4 || param1 - 16 > 8 && param1 - 16 <= 12)
                    {
                        _loc_6.graphics.moveTo(0, 0);
                        _loc_6.graphics.lineTo(0, 50);
                        _loc_6.graphics.moveTo(0, 0);
                        _loc_6.graphics.lineTo(25, 0);
                        _loc_6.x = 345;
                        _loc_6.y = 80 + (Math.ceil((param1 - 16) / 4) - 1) * 100;
                    }
                    else
                    {
                        _loc_6.graphics.moveTo(0, 0);
                        _loc_6.graphics.lineTo(0, 50);
                        _loc_6.graphics.moveTo(0, 50);
                        _loc_6.graphics.lineTo(25, 50);
                        _loc_6.x = 345;
                        _loc_6.y = 130 + (Math.ceil((param1 - 16) / 4) - 2) * 100;
                    }
                }
            }
            else if (param2 == 4)
            {
                if (param1 <= 16 && param1 > 0)
                {
                    if (param1 <= 8)
                    {
                        _loc_6.graphics.moveTo(0, 0);
                        _loc_6.graphics.lineTo(25, 0);
                        _loc_6.graphics.moveTo(25, 0);
                        _loc_6.graphics.lineTo(25, 100);
                        _loc_6.x = 185;
                        _loc_6.y = 130;
                    }
                    else
                    {
                        _loc_6.graphics.moveTo(25, 0);
                        _loc_6.graphics.lineTo(25, 100);
                        _loc_6.graphics.moveTo(0, 100);
                        _loc_6.graphics.lineTo(25, 100);
                        _loc_6.x = 185;
                        _loc_6.y = 230;
                    }
                }
                else if (param1 > 16 && param1 <= 32)
                {
                    if (param1 <= 24)
                    {
                        _loc_6.graphics.moveTo(10, 100);
                        _loc_6.graphics.lineTo(10, 0);
                        _loc_6.graphics.moveTo(10, 0);
                        _loc_6.graphics.lineTo(35, 0);
                        _loc_6.x = 310;
                        _loc_6.y = 130;
                    }
                    else
                    {
                        _loc_6.graphics.moveTo(10, 0);
                        _loc_6.graphics.lineTo(10, 100);
                        _loc_6.graphics.moveTo(10, 100);
                        _loc_6.graphics.lineTo(35, 100);
                        _loc_6.x = 310;
                        _loc_6.y = 230;
                    }
                }
            }
            else if (param2 == 5)
            {
                _loc_6.graphics.moveTo(0, 0);
                _loc_6.graphics.lineTo(10, 0);
                if (param1 <= 16 && param1 > 0)
                {
                    _loc_6.x = 210;
                }
                else if (param1 > 16 && param1 <= 32)
                {
                    _loc_6.x = 310;
                }
                _loc_6.y = 230;
            }
            this._mainspr.addChild(_loc_6);
            return;
        }// end function

        private function addmagnifier(param1:int) : void
        {
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_2:* = 0;
            while (_loc_2 < this._bitmapArr.length)
            {
                
                if (this._bitmapArr[_loc_2].hasOwnProperty("bitmapData") != null)
                {
                    this._bitmapArr[_loc_2].bitmapData.dispose();
                }
                _loc_2 = _loc_2 + 1;
            }
            this._bitmapArr = [];
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            while (_loc_4 < param1)
            {
                
                if (_loc_4 < 4)
                {
                    _loc_5 = 0;
                    while (_loc_5 < 16)
                    {
                        
                        if (_loc_4 == 1 && _loc_5 % 2 != 0)
                        {
                            ;
                        }
                        else if (_loc_4 == 2 && _loc_5 % 4 != 0)
                        {
                            ;
                        }
                        else if (_loc_4 == 3 && _loc_5 % 8 != 0)
                        {
                            ;
                        }
                        else if (_loc_4 == 4 && _loc_5 % 16 != 0)
                        {
                        }
                        _loc_6 = new Bitmap();
                        _loc_6.bitmapData = Config.findsysUI("acitve/magnifier", 12, 13);
                        this._bitmapArr.push(_loc_6);
                        _loc_7 = 0;
                        _loc_8 = 0;
                        _loc_9 = 0;
                        if (_loc_5 < 8)
                        {
                            _loc_7 = 130 + _loc_4 * 25;
                            if (_loc_4 == 2)
                            {
                                _loc_9 = 1;
                            }
                            else if (_loc_4 == 3)
                            {
                                _loc_9 = 4;
                            }
                            else
                            {
                                _loc_9 = 0;
                            }
                            _loc_8 = 50 + 25 * _loc_4 + 50 * _loc_5 + _loc_9 * 25;
                        }
                        else
                        {
                            _loc_7 = 530 - 140 - 25 * _loc_4;
                            if (_loc_4 == 2)
                            {
                                _loc_9 = 1;
                            }
                            else if (_loc_4 == 3)
                            {
                                _loc_9 = 4;
                            }
                            else
                            {
                                _loc_9 = 0;
                            }
                            _loc_8 = 50 + 25 * _loc_4 + 50 * (_loc_5 - 8) + _loc_9 * 25;
                        }
                        _loc_10 = new Sprite();
                        this._fmainspr.addChild(_loc_10);
                        _loc_10.buttonMode = true;
                        _loc_10.x = _loc_7;
                        _loc_10.y = _loc_8;
                        _loc_10.addChild(_loc_6);
                        _loc_10.removeEventListener(MouseEvent.CLICK, this.quickfight);
                        _loc_10.addEventListener(MouseEvent.CLICK, this.quickfight);
                        _loc_3++;
                        _loc_10.name = String(_loc_3);
                        _loc_5++;
                    }
                }
                else
                {
                    this._sprwin.removeEventListener(MouseEvent.CLICK, this.quickfight);
                    this._sprwin.addEventListener(MouseEvent.CLICK, this.quickfight);
                    this._sprwin.name = String(33);
                }
                _loc_4++;
            }
            return;
        }// end function

        private function toplist(event:SocketEvent) : void
        {
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_11:* = null;
            var _loc_12:* = 0;
            var _loc_13:* = 0;
            var _loc_14:* = 0;
            var _loc_15:* = 0;
            var _loc_16:* = null;
            var _loc_17:* = 0;
            var _loc_18:* = null;
            var _loc_2:* = event.data;
            this._lastupdatetime = _loc_2.readUnsignedInt();
            var _loc_3:* = _loc_2.readUnsignedInt();
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_6 = _loc_2.readUnsignedInt();
                _loc_7 = _loc_2.readUnsignedInt();
                _loc_8 = _loc_2.readUnsignedInt();
                _loc_9 = _loc_2.readUnsignedInt();
                _loc_10 = _loc_2.readUnsignedShort();
                _loc_11 = _loc_2.readUTFBytes(_loc_10);
                _loc_12 = _loc_2.readUnsignedInt();
                _loc_13 = _loc_2.readUnsignedInt();
                _loc_14 = _loc_2.readUnsignedInt();
                _loc_15 = _loc_2.readUnsignedShort();
                _loc_16 = _loc_2.readUTFBytes(_loc_15);
                _loc_17 = 1;
                while (_loc_17 <= _loc_14)
                {
                    
                    if (_loc_14 == 5)
                    {
                        this.drawline(_loc_6, _loc_17, 2, 15898638, 1);
                    }
                    else
                    {
                        this.drawline(_loc_6, _loc_17, 1, 6196057, 1);
                    }
                    _loc_17 = _loc_17 + 1;
                }
                _loc_18 = new Label(this._listArr[(_loc_6 - 1)], 3, 1, _loc_11 + "." + _loc_16);
                this._playerArr[(_loc_6 - 1)] = _loc_11 + "." + _loc_16;
                trace(_loc_3, _loc_6, _loc_11, _loc_14, "_wintimes");
                _loc_4 = _loc_4 + 1;
            }
            var _loc_5:* = _loc_2.readUnsignedByte();
            if (_loc_2.readUnsignedByte() != 0)
            {
                _loc_18 = new Label(this._sprwin, 3, 1, this._playerArr[(_loc_5 - 1)]);
            }
            return;
        }// end function

        public function sendtoplist() : void
        {
            var _loc_1:* = new DataSet();
            _loc_1.addHead(CONST_ENUM.C2B_CARENA3_TOP);
            _loc_1.add32(this._lastupdatetime);
            ClientSocket.send(_loc_1);
            this.addmagnifier(Config.ui._activePanel.nowracetimes);
            return;
        }// end function

        private function quickfight(event:MouseEvent) : void
        {
            var _loc_2:* = parseInt(event.currentTarget.name);
            var _loc_3:* = 1;
            if (_loc_2 == 33)
            {
                _loc_2 = 1;
                _loc_3 = 5;
            }
            else if (_loc_2 > 28)
            {
                _loc_2 = _loc_2 - 28;
                _loc_3 = 4;
            }
            else if (_loc_2 > 24)
            {
                _loc_2 = _loc_2 - 24;
                _loc_3 = 3;
            }
            else if (_loc_2 > 16)
            {
                _loc_2 = _loc_2 - 16;
                _loc_3 = 2;
            }
            var _loc_4:* = new DataSet();
            new DataSet().addHead(CONST_ENUM.C2B_CARENA3_VS);
            _loc_4.add8(_loc_3);
            _loc_4.add8(_loc_2);
            ClientSocket.send(_loc_4);
            return;
        }// end function

        private function vslist(event:SocketEvent) : void
        {
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = 0;
            var _loc_15:* = 0;
            var _loc_16:* = undefined;
            var _loc_17:* = null;
            var _loc_18:* = null;
            var _loc_19:* = null;
            var _loc_20:* = null;
            var _loc_21:* = null;
            var _loc_22:* = null;
            var _loc_23:* = null;
            var _loc_24:* = null;
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedByte();
            var _loc_4:* = _loc_2.readUnsignedByte();
            var _loc_5:* = _loc_2.readUnsignedByte();
            _loc_6 = 0;
            _loc_7 = 0;
            var _loc_8:* = [];
            _loc_9 = 1;
            while (_loc_9 <= _loc_5)
            {
                
                _loc_6 = _loc_2.readUnsignedInt();
                _loc_7 = _loc_2.readUnsignedInt();
                _loc_10 = _loc_2.readUnsignedByte();
                _loc_8.push(_loc_10);
                _loc_9 = _loc_9 + 1;
            }
            if (_loc_6 != 0 && _loc_7 != 0)
            {
                this.openInfoPanel();
                if (_loc_8.length > 0)
                {
                    _loc_17 = new Sprite();
                    _loc_17.graphics.beginFill(16165741, 1);
                    _loc_17.graphics.drawRoundRect(0, 0, 90, 18, 5);
                    _loc_17.graphics.endFill();
                    _loc_17.x = 20;
                    _loc_17.y = 35;
                    this.infowindow.addChild(_loc_17);
                    _loc_18 = new Sprite();
                    _loc_18.graphics.beginFill(16165741, 1);
                    _loc_18.graphics.drawRoundRect(0, 0, 90, 18, 5);
                    _loc_18.graphics.endFill();
                    _loc_18.x = 160;
                    _loc_18.y = 35;
                    this.infowindow.addChild(_loc_18);
                    _loc_12 = new Label(this.infowindow, 125, 36);
                    _loc_12.html = true;
                    _loc_12.textColor = 11344686;
                    _loc_11 = new Label(this.infowindow, 62, 70);
                    _loc_11.html = true;
                    _loc_19 = new Shape();
                    _loc_19.graphics.lineStyle(1, 0, 0.5);
                    _loc_19.graphics.moveTo(0, 0);
                    _loc_19.graphics.lineTo(90, 0);
                    _loc_19.graphics.moveTo(90, 0);
                    _loc_19.graphics.lineTo(90, 18);
                    _loc_19.graphics.moveTo(90, 18);
                    _loc_19.graphics.lineTo(0, 18);
                    _loc_19.graphics.moveTo(0, 18);
                    _loc_19.graphics.lineTo(0, 0);
                    _loc_17.addChild(_loc_19);
                    _loc_20 = new Shape();
                    _loc_20.graphics.lineStyle(1, 0, 0.5);
                    _loc_20.graphics.moveTo(0, 0);
                    _loc_20.graphics.lineTo(90, 0);
                    _loc_20.graphics.moveTo(90, 0);
                    _loc_20.graphics.lineTo(90, 18);
                    _loc_20.graphics.moveTo(90, 18);
                    _loc_20.graphics.lineTo(0, 18);
                    _loc_20.graphics.moveTo(0, 18);
                    _loc_20.graphics.lineTo(0, 0);
                    _loc_18.addChild(_loc_20);
                    _loc_21 = new Label(_loc_17, 3, 1, this._playerArr[(_loc_6 - 1)]);
                    _loc_21 = new Label(_loc_18, 3, 1, this._playerArr[(_loc_7 - 1)]);
                }
                _loc_13 = "";
                _loc_14 = 0;
                _loc_15 = 0;
                _loc_9 = 0;
                while (_loc_9 < _loc_8.length)
                {
                    
                    if (_loc_8[_loc_9] == 1)
                    {
                        _loc_14++;
                        _loc_13 = _loc_13 + Config.language("ServerInterRacebill", 3, String((_loc_9 + 1)));
                    }
                    else if (_loc_8[_loc_9] == 2)
                    {
                        _loc_15++;
                        _loc_13 = _loc_13 + Config.language("ServerInterRacebill", 4, String((_loc_9 + 1)));
                    }
                    else
                    {
                        _loc_13 = _loc_13 + Config.language("ServerInterRacebill", 5, String((_loc_9 + 1)));
                    }
                    _loc_9 = _loc_9 + 1;
                }
                if (_loc_8.length > 0)
                {
                    _loc_12.text = _loc_14 + " : " + _loc_15;
                    _loc_11.text = _loc_13;
                }
                _loc_16 = 0;
                while (_loc_16 < this._bitmapArr1.length)
                {
                    
                    if (this._bitmapArr1[_loc_16].hasOwnProperty("bitmapData") != null)
                    {
                        this._bitmapArr1[_loc_16].bitmapData.dispose();
                    }
                    _loc_16 = _loc_16 + 1;
                }
                if (_loc_14 >= 3 || _loc_14 > _loc_15 && _loc_8.length >= 5)
                {
                    _loc_22 = new Bitmap();
                    _loc_22.bitmapData = Config.findsysUI("acitve/win", 102, 53);
                    this._bitmapArr1.push(_loc_22);
                    this.infowindow.addChild(_loc_22);
                    _loc_22.x = 10;
                    _loc_22.y = 125;
                }
                else if (_loc_15 >= 3 || _loc_14 < _loc_15 && _loc_8.length >= 5)
                {
                    _loc_22 = new Bitmap();
                    _loc_22.bitmapData = Config.findsysUI("acitve/win", 102, 53);
                    this._bitmapArr1.push(_loc_22);
                    this.infowindow.addChild(_loc_22);
                    _loc_22.x = 160;
                    _loc_22.y = 125;
                }
                else if (_loc_14 == _loc_15 && _loc_8.length >= 5)
                {
                    _loc_23 = new Bitmap();
                    _loc_23.bitmapData = Config.findsysUI("acitve/lose", 101, 54);
                    this._bitmapArr1.push(_loc_23);
                    this.infowindow.addChild(_loc_23);
                    _loc_23.x = 10;
                    _loc_23.y = 125;
                    _loc_23 = new Bitmap();
                    _loc_23.bitmapData = Config.findsysUI("acitve/lose", 101, 54);
                    this._bitmapArr1.push(_loc_23);
                    this.infowindow.addChild(_loc_23);
                    _loc_23.x = 160;
                    _loc_23.y = 125;
                }
            }
            else if (_loc_6 == 0 && _loc_7 == 0)
            {
                AlertUI.close();
                AlertUI.alert(Config.language("ServerInterRacebill", 6), Config.language("ServerInterRacebill", 7), [Config.language("ServerInterRacebill", 8)]);
            }
            else
            {
                _loc_24 = "";
                if (_loc_6 != 0)
                {
                    _loc_24 = this._playerArr[(_loc_6 - 1)];
                }
                else if (_loc_7 != 0)
                {
                    _loc_24 = this._playerArr[(_loc_7 - 1)];
                }
                AlertUI.close();
                AlertUI.alert(Config.language("ServerInterRacebill", 6), Config.language("ServerInterRacebill", 9, _loc_24), [Config.language("ServerInterRacebill", 8)]);
            }
            return;
        }// end function

        private function openInfoPanel() : void
        {
            var _loc_3:* = undefined;
            var _loc_1:* = this.x + 20;
            var _loc_2:* = this.y + 30;
            if (this.infowindow != null)
            {
                _loc_3 = 0;
                while (_loc_3 < this._bitmapArr1.length)
                {
                    
                    if (this._bitmapArr1[_loc_3].hasOwnProperty("bitmapData") != null)
                    {
                        this._bitmapArr1[_loc_3].bitmapData.dispose();
                    }
                    _loc_3 = _loc_3 + 1;
                }
                _loc_1 = this.infowindow.x;
                _loc_2 = this.infowindow.y;
                this.infowindow.close();
            }
            this.infowindow = new Window(this.container, _loc_1, _loc_2);
            this.infowindow.resize(270, 250);
            this.info = new TextAreaUI(this.infowindow, 10, 25, 230, 230);
            this.info.autoHeight = true;
            this.infowindow.title = Config.language("ServerInterRacebill", 10);
            this.infowindow.open();
            return;
        }// end function

        private function handlePkResult(param1)
        {
            var _loc_2:* = param1.data;
            var _loc_3:* = _loc_2.readByte();
            if (_loc_3 == 3)
            {
                Billboard.show(Config.language("PkUI", 6));
            }
            else if (_loc_3 == 1)
            {
                Billboard.show(Config.language("PkUI", 8));
            }
            else if (_loc_3 == 2)
            {
                Billboard.show(Config.language("PkUI", 10));
            }
            return;
        }// end function

    }
}
