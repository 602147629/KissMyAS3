package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import lovefox.component.*;
    import lovefox.socket.*;

    public class ManyPlayerToair extends Window
    {
        private var _fbpushbtn:PushButton;
        private var _teamarr:Array;
        private var _teamtextarr:Array;
        private var _page:int = 1;
        private var _pagetext:Label;
        private var _menberArr:Array;
        private var _checkbArr:Array;
        private var _canv:CanvasUI;
        private var _shrect2:Sprite;
        private var _shrect3:Sprite;
        private var _checkb:CheckBox;
        private var _allpage:int;
        private var _cengtemp:int;
        private var _hightfloortemp:int;
        private var _updatetime:int = 0;
        private var _labnum:Label;
        private var _todaypasslab:Label;
        private var _timer:Timer;
        private var _timer0:Timer;
        private var _timer1:Timer;
        private var _timer2:Timer;
        private var _timer3:Timer;
        private var _shutdown:int;
        private var _logintime:int;
        private var _timeLB:Label;
        private var _timesprite:Sprite;
        private var _alertnum:int;
        private var _lineArr:Array;
        private var _flag:int;
        private var _xmlflag:Boolean = false;
        private var _len:int = 0;
        private var _passcount:int = 0;
        private var _passhfloor:int = 0;

        public function ManyPlayerToair(param1:DisplayObjectContainer = null)
        {
            this._checkbArr = [];
            this._lineArr = [];
            super(param1);
            this.initpanel();
            this.initsocket();
            return;
        }// end function

        override public function switchOpen() : void
        {
            super.switchOpen();
            if (this._opening)
            {
                this.sendteamlist();
                this._timer.addEventListener(TimerEvent.TIMER, this.timersend);
                this._timer.start();
                this.sendteaminfor();
            }
            return;
        }// end function

        private function initsocket() : void
        {
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.B2C_MULTISKYTOWER_TEAMSQUERY, this.teamlist);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.B2C_MULTISKYTOWER_TEAMJOIN, this.backcreatefb);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.B2C_MULTISKYTOWER_ENTERINST, this.teamplayerenter);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.B2C_MULTISKYTOWER_LEAVE, this.playerlevelfb);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.B2C_MULTISKYTOWER_TEAMINFO, this.teaminfor);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_MULTISKYTOWER_PASS, this.passair);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_MULTISKYTOWER_FAIL, this.failair);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_MULTISKYTOWER_MAXFLOOR, this.getfloor);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_MULTISKYTOWER_REWARD_COUNT, this.todayprize);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_MULTISKYTOWER_COUNTDOWN, this.alltime);
            return;
        }// end function

        private function initpanel() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            resize(500, 400);
            this.title = Config.language("ManyPlayerToair", 1);
            var _loc_1:* = new Shape();
            _loc_1.graphics.lineStyle(1, 0, 0.6);
            _loc_1.graphics.moveTo(10, 48);
            _loc_1.graphics.lineTo(120, 48);
            _loc_1.graphics.moveTo(130, 48);
            _loc_1.graphics.lineTo(300, 48);
            _loc_1.graphics.moveTo(310, 48);
            _loc_1.graphics.lineTo(490, 48);
            this.addChild(_loc_1);
            _loc_2 = new Label(this, 10, 30, Config.language("ManyPlayerToair", 2));
            _loc_2 = new Label(this, 130, 30, Config.language("ManyPlayerToair", 3));
            this._labnum = new Label(this, 310, 30, Config.language("ManyPlayerToair", 4, 0));
            _loc_3 = new Sprite();
            this.addChild(_loc_3);
            _loc_3.graphics.beginFill(16777215, 0.3);
            _loc_3.graphics.drawRoundRect(0, 0, 110, 260, 5);
            _loc_3.graphics.endFill();
            _loc_3.x = 10;
            _loc_3.y = 55;
            this._canv = new CanvasUI(_loc_3, 0, 0, 110, 260);
            this._shrect2 = new Sprite();
            this.addChild(this._shrect2);
            this._shrect2.graphics.beginFill(16777215, 0.3);
            this._shrect2.graphics.drawRoundRect(0, 0, 170, 260, 5);
            this._shrect2.graphics.endFill();
            this._shrect2.x = 130;
            this._shrect2.y = 55;
            this._shrect3 = new Sprite();
            this.addChild(this._shrect3);
            this._shrect3.graphics.beginFill(16777215, 0.3);
            this._shrect3.graphics.drawRoundRect(0, 0, 180, 260, 5);
            this._shrect3.graphics.endFill();
            this._shrect3.x = 310;
            this._shrect3.y = 55;
            var _loc_4:* = 5;
            while (_loc_4 < 10)
            {
                
                _loc_9 = new Shape();
                _loc_9.graphics.lineStyle(2, 16777215);
                _loc_9.graphics.moveTo(5, 5);
                _loc_9.graphics.lineTo(175, 5);
                _loc_9.graphics.moveTo(175, 5);
                _loc_9.graphics.lineTo(175, 48);
                _loc_9.graphics.moveTo(175, 48);
                _loc_9.graphics.lineTo(5, 48);
                _loc_9.graphics.moveTo(5, 48);
                _loc_9.graphics.lineTo(5, 5);
                _loc_9.x = 310;
                _loc_9.y = (_loc_4 - 5) * 50 + 55;
                this.addChild(_loc_9);
                this._lineArr[_loc_4] = _loc_9;
                _loc_4++;
            }
            this._todaypasslab = new Label(this, 345, 325);
            this._todaypasslab.html = true;
            var _loc_5:* = new Label(this, 12, 325);
            new Label(this, 12, 325).html = true;
            _loc_5.text = Config.language("ManyPlayerToair", 5);
            this._fbpushbtn = new PushButton(this, 360, 350, Config.language("ManyPlayerToair", 6), this.creatfb);
            this._fbpushbtn.data = 1;
            this._fbpushbtn.setTable("table13", "table14");
            this._fbpushbtn.width = 80;
            this._fbpushbtn.enabled = false;
            this._teamtextarr = [];
            var _loc_6:* = 0;
            while (_loc_6 < 5)
            {
                
                _loc_10 = new Object();
                _loc_10._teamlist = new Label(null, 140, 62 + _loc_6 * 45, Config.language("ManyPlayerToair", 7));
                _loc_10._teamlist.html = true;
                _loc_10._pbtn = new PushButton(null, 250, 68 + _loc_6 * 45, Config.language("ManyPlayerToair", 8), this.jionfb, null, "table18", "table31");
                _loc_10._pbtn.width = 40;
                _loc_10._pbtn.textColor = Style.GOLD_FONT;
                this._teamtextarr.push(_loc_10);
                _loc_6 = _loc_6 + 1;
            }
            var _loc_7:* = new PushButton(this, 150, 285, Config.language("ManyPlayerToair", 9), this.pagefun);
            new PushButton(this, 150, 285, Config.language("ManyPlayerToair", 9), this.pagefun).data = 1;
            _loc_7.width = 40;
            var _loc_8:* = new PushButton(this, 240, 285, Config.language("ManyPlayerToair", 10), this.pagefun);
            new PushButton(this, 240, 285, Config.language("ManyPlayerToair", 10), this.pagefun).data = 2;
            _loc_8.width = 40;
            this._pagetext = new Label(this, 210, 288);
            this._timer = new Timer(1000);
            this._timer0 = new Timer(1000);
            this._timer1 = new Timer(1000);
            this._timer2 = new Timer(1000);
            this._timer3 = new Timer(1000);
            return;
        }// end function

        private function creatfb(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            if (event.currentTarget.data == 1)
            {
                if (Config.ui._teamUI.teamId != 0)
                {
                    if (Config.ui._teamUI.teaminfor.type == 3)
                    {
                        _loc_2 = new DataSet();
                        _loc_2.addHead(CONST_ENUM.C2B_MULTISKYTOWER_TEAMJOIN);
                        _loc_2.add16(this._cengshu);
                        ClientSocket.send(_loc_2);
                    }
                    else
                    {
                        Config.message(Config.language("ManyPlayerToair", 11));
                    }
                }
                else if (Config.ui._teamUI.teamId == 0)
                {
                    _loc_2 = new DataSet();
                    _loc_2.addHead(CONST_ENUM.C2B_MULTISKYTOWER_PLAYERJOIN);
                    _loc_2.add16(this._cengshu);
                    ClientSocket.send(_loc_2);
                }
            }
            else if (event.currentTarget.data == 2)
            {
                this._timer3.stop();
                this._timer3.removeEventListener(TimerEvent.TIMER, this.strattimer3);
                AlertUI.remove(this._alertnum);
                _loc_2 = new DataSet();
                _loc_2.addHead(CONST_ENUM.C2G_ENTER_MULTISKYTOWER);
                _loc_2.add16(this._cengshu);
                ClientSocket.send(_loc_2);
            }
            return;
        }// end function

        private function teamlist(event:SocketEvent) : void
        {
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = 0;
            var _loc_12:* = 0;
            var _loc_13:* = null;
            var _loc_2:* = event.data;
            this._page = _loc_2.readUnsignedInt();
            this._allpage = _loc_2.readUnsignedInt();
            this._updatetime = _loc_2.readUnsignedInt();
            var _loc_3:* = _loc_2.readUnsignedByte();
            var _loc_4:* = _loc_2.readUnsignedInt();
            if (this._teamtextarr != null)
            {
                _loc_7 = 0;
                while (_loc_7 < this._teamtextarr.length)
                {
                    
                    if (this._teamtextarr[_loc_7]._teamlist.parent != null)
                    {
                        this._teamtextarr[_loc_7]._teamlist.parent.removeChild(this._teamtextarr[_loc_7]._teamlist);
                    }
                    if (this._teamtextarr[_loc_7]._pbtn.parent != null)
                    {
                        this._teamtextarr[_loc_7]._pbtn.parent.removeChild(this._teamtextarr[_loc_7]._pbtn);
                    }
                    _loc_7++;
                }
            }
            var _loc_5:* = 0;
            while (_loc_5 < 5)
            {
                
                if (this._lineArr[_loc_5] != null)
                {
                    this._lineArr[_loc_5].graphics.clear();
                }
                _loc_8 = new Shape();
                _loc_8.graphics.lineStyle(2, 16777215);
                _loc_8.graphics.moveTo(5, 5);
                _loc_8.graphics.lineTo(165, 5);
                _loc_8.graphics.moveTo(165, 5);
                _loc_8.graphics.lineTo(165, 42);
                _loc_8.graphics.moveTo(165, 42);
                _loc_8.graphics.lineTo(5, 42);
                _loc_8.graphics.moveTo(5, 42);
                _loc_8.graphics.lineTo(5, 5);
                _loc_8.x = 130;
                _loc_8.y = _loc_5 * 45 + 55;
                this.addChild(_loc_8);
                this._lineArr[_loc_5] = _loc_8;
                _loc_5++;
            }
            if (_loc_3 == 0)
            {
                this._fbpushbtn.data = 1;
                this._fbpushbtn.label = Config.language("ManyPlayerToair", 6);
                this._fbpushbtn.enabled = true;
                if (Config.ui._teamUI.teamId != 0)
                {
                    if (Config.ui._teamUI.teaminfor.type == 3)
                    {
                        this._fbpushbtn.enabled = true;
                    }
                    else
                    {
                        this._fbpushbtn.enabled = false;
                    }
                }
                else
                {
                    this._fbpushbtn.enabled = true;
                }
                _loc_9 = 0;
                while (_loc_9 < this._checkbArr.length)
                {
                    
                    this._checkbArr[_loc_9].enabled = true;
                    if (this._passcount >= 2 && this._hightfloor == (this.passhfloor + 1))
                    {
                        if (_loc_9 == (this._checkbArr.length - 1))
                        {
                            this._checkbArr[_loc_9].enabled = false;
                        }
                    }
                    _loc_9++;
                }
            }
            this._teamarr = [];
            var _loc_6:* = 0;
            while (_loc_6 < _loc_4)
            {
                
                _loc_10 = new Object();
                _loc_10.ceng = _loc_2.readUnsignedShort();
                _loc_10.teamid = _loc_2.readUnsignedInt();
                _loc_10.teamplayerid = _loc_2.readUnsignedInt();
                _loc_11 = _loc_2.readUnsignedShort();
                _loc_10.teamplayername = _loc_2.readUTFBytes(_loc_11);
                _loc_10.type = _loc_2.readUnsignedInt();
                _loc_10.count = _loc_2.readUnsignedInt();
                this._teamarr.push(_loc_10);
                if (Config.ui._teamUI.teamId == _loc_10.teamid)
                {
                    this._fbpushbtn.data = 2;
                    this._fbpushbtn.label = Config.language("ManyPlayerToair", 12);
                    this._fbpushbtn.enabled = true;
                    this._cengshu = _loc_10.ceng;
                    this._lineArr[_loc_6].graphics.clear();
                    _loc_8 = new Shape();
                    _loc_8.graphics.lineStyle(2, 11344686);
                    _loc_8.graphics.moveTo(5, 5);
                    _loc_8.graphics.lineTo(165, 5);
                    _loc_8.graphics.moveTo(165, 5);
                    _loc_8.graphics.lineTo(165, 42);
                    _loc_8.graphics.moveTo(165, 42);
                    _loc_8.graphics.lineTo(5, 42);
                    _loc_8.graphics.moveTo(5, 42);
                    _loc_8.graphics.lineTo(5, 5);
                    _loc_8.x = 130;
                    _loc_8.y = _loc_6 * 45 + 55;
                    this.addChild(_loc_8);
                    this._lineArr[_loc_6] = _loc_8;
                    _loc_12 = this._checkbArr.length - 1;
                    while (_loc_12 >= 0)
                    {
                        
                        if (this._checkbArr[_loc_12] != null)
                        {
                            this._checkbArr[_loc_12].enabled = false;
                            if (_loc_10.ceng == (_loc_12 + 1))
                            {
                                this._checkbArr[_loc_12].selected = true;
                            }
                            else
                            {
                                this._checkbArr[_loc_12].selected = false;
                            }
                            if (this._passcount >= 2)
                            {
                                if (_loc_12 == (this._checkbArr.length - 1))
                                {
                                    this._checkbArr[_loc_12].enabled = false;
                                }
                            }
                        }
                        _loc_12 = _loc_12 - 1;
                    }
                }
                _loc_6 = _loc_6 + 1;
            }
            if (this._allpage == 0)
            {
                this._allpage = 1;
            }
            this._pagetext.text = this._page + "/" + this._allpage;
            if (_loc_4 > 5)
            {
                _loc_4 = 5;
            }
            _loc_7 = 0;
            while (_loc_7 < _loc_4)
            {
                
                this.addChild(this._teamtextarr[_loc_7]._teamlist);
                if (Config.ui._teamUI.teamId != this._teamarr[_loc_7].teamid)
                {
                    this.addChild(this._teamtextarr[_loc_7]._pbtn);
                    this._teamtextarr[_loc_7]._pbtn.data = this._teamarr[_loc_7].teamid;
                }
                _loc_13 = "<font color=\'#ad1b2e\'>";
                if (this._teamarr[_loc_7].count == 2 || this._teamarr[_loc_7].count == 3)
                {
                    _loc_13 = "<font color=\'#30C74C\'>";
                }
                this._teamtextarr[_loc_7]._teamlist.text = Config.language("ManyPlayerToair", 13, this._teamarr[_loc_7].ceng) + this._teamarr[_loc_7].teamplayername + _loc_13 + " (" + this._teamarr[_loc_7].count + "/3)</font>";
                _loc_7++;
            }
            return;
        }// end function

        private function teaminfor(event:SocketEvent) : void
        {
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = undefined;
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            trace(_loc_3);
            var _loc_4:* = _loc_2.readUnsignedInt();
            this._labnum.text = Config.language("ManyPlayerToair", 4, _loc_4);
            if (this._menberArr != null)
            {
                this.removesprite(this._shrect3);
            }
            var _loc_5:* = 5;
            while (_loc_5 < 10)
            {
                
                if (this._lineArr[_loc_5] != null)
                {
                    this._lineArr[_loc_5].graphics.clear();
                }
                _loc_7 = new Shape();
                _loc_7.graphics.lineStyle(2, 16777215);
                _loc_7.graphics.moveTo(5, 5);
                _loc_7.graphics.lineTo(175, 5);
                _loc_7.graphics.moveTo(175, 5);
                _loc_7.graphics.lineTo(175, 48);
                _loc_7.graphics.moveTo(175, 48);
                _loc_7.graphics.lineTo(5, 48);
                _loc_7.graphics.moveTo(5, 48);
                _loc_7.graphics.lineTo(5, 5);
                _loc_7.x = 310;
                _loc_7.y = (_loc_5 - 5) * 50 + 55;
                this.addChild(_loc_7);
                this._lineArr[_loc_5] = _loc_7;
                _loc_5++;
            }
            this._menberArr = [];
            var _loc_6:* = 0;
            while (_loc_6 < _loc_4)
            {
                
                _loc_8 = new Object();
                _loc_8._teamplayerid = _loc_2.readUnsignedInt();
                _loc_9 = _loc_2.readUnsignedShort();
                _loc_8._name = _loc_2.readUTFBytes(_loc_9);
                _loc_8._level = _loc_2.readUnsignedInt();
                _loc_8._jobid = _loc_2.readUnsignedInt();
                if (_loc_8._teamplayerid == Config.player.id)
                {
                    this._lineArr[_loc_6 + 5].graphics.clear();
                    _loc_7 = new Shape();
                    _loc_7.graphics.lineStyle(2, 11344686);
                    _loc_7.graphics.moveTo(5, 5);
                    _loc_7.graphics.lineTo(175, 5);
                    _loc_7.graphics.moveTo(175, 5);
                    _loc_7.graphics.lineTo(175, 48);
                    _loc_7.graphics.moveTo(175, 48);
                    _loc_7.graphics.lineTo(5, 48);
                    _loc_7.graphics.moveTo(5, 48);
                    _loc_7.graphics.lineTo(5, 5);
                    _loc_7.x = 310;
                    _loc_7.y = _loc_6 * 50 + 55;
                    this.addChild(_loc_7);
                    this._lineArr[_loc_6 + 5] = _loc_7;
                }
                this.showteamMembers(_loc_8, _loc_6);
                _loc_6 = _loc_6 + 1;
            }
            return;
        }// end function

        private function jionfb(event:MouseEvent) : void
        {
            trace(event.currentTarget.data);
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2B_JOIN_MULTISKYTOWER_TEAM);
            _loc_2.add32(event.currentTarget.data);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function pagefun(event:MouseEvent) : void
        {
            trace(event.currentTarget.data);
            if (event.currentTarget.data == 1)
            {
                if (this._page > 1 && this._page <= this._allpage)
                {
                    var _loc_2:* = this;
                    var _loc_3:* = this._page - 1;
                    _loc_2._page = _loc_3;
                    this.sendteamlist(this._page, 1);
                }
            }
            else if (event.currentTarget.data == 2)
            {
                if (this._page < this._allpage)
                {
                    var _loc_2:* = this;
                    var _loc_3:* = this._page + 1;
                    _loc_2._page = _loc_3;
                    this.sendteamlist(this._page, 1);
                }
            }
            return;
        }// end function

        private function passair(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedShort();
            this._flag = _loc_2.readUnsignedByte();
            this._timer0.stop();
            this._timer0.removeEventListener(TimerEvent.TIMER, this.strattimer);
            AlertUI.remove(this._alertnum);
            this._shutdown = 15;
            var _loc_4:* = "";
            if (this._flag == 1)
            {
                _loc_4 = Config.language("ManyPlayerToair", 26);
                if (int(Config._crowdskytower[_loc_3].levelAwardNumber1) != 0)
                {
                    _loc_4 = _loc_4 + Config.language("activePanel", 66, Config._crowdskytower[_loc_3].levelAwardNumber1);
                }
                if (int(Config._crowdskytower[_loc_3].levelAwardNumber2) != 0)
                {
                    _loc_4 = _loc_4 + Config.language("activePanel", 67, Config._crowdskytower[_loc_3].levelAwardNumber2);
                }
                if (int(Config._crowdskytower[_loc_3].levelAwardItemNumber) != 0)
                {
                    _loc_4 = _loc_4 + ("\n                    <font color=\'#ad1b2e\'>" + Config._itemMap[Config._crowdskytower[_loc_3].levelAwardItemId].name + "</font> *<font color=\'#ad1b2e\'>" + Config._crowdskytower[_loc_3].levelAwardItemNumber + "</font>");
                }
            }
            this._alertnum = AlertUI.alert(Config.language("ManyPlayerToair", 14), "<p align=\'center\'>" + Config.language("ManyPlayerToair", 15, _loc_4, 15) + "</p>", [Config.language("ManyPlayerToair", 16)], [this.quickfb]);
            this._timer1.removeEventListener(TimerEvent.TIMER, this.strattimer1);
            this._timer1.addEventListener(TimerEvent.TIMER, this.strattimer1);
            this._timer1.start();
            return;
        }// end function

        private function failair(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedByte();
            this._timer0.stop();
            this._timer0.removeEventListener(TimerEvent.TIMER, this.strattimer);
            AlertUI.remove(this._alertnum);
            this._shutdown = 15;
            this._alertnum = AlertUI.alert(Config.language("ManyPlayerToair", 14), "<p align=\'center\'>" + Config.language("ManyPlayerToair", 17, 15) + "</p>", [Config.language("ManyPlayerToair", 16)], [this.quickfb]);
            this._timer2.removeEventListener(TimerEvent.TIMER, this.strattimer2);
            this._timer2.addEventListener(TimerEvent.TIMER, this.strattimer2);
            this._timer2.start();
            return;
        }// end function

        private function strattimer1(event:TimerEvent)
        {
            var _loc_3:* = this;
            var _loc_4:* = this._shutdown - 1;
            _loc_3._shutdown = _loc_4;
            if (this._shutdown <= 0)
            {
                this._timer1.stop();
                this._timer1.removeEventListener(TimerEvent.TIMER, this.strattimer1);
                AlertUI.remove(this._alertnum);
            }
            var _loc_2:* = "";
            if (this._flag == 1)
            {
                if (this._hightfloor > 1)
                {
                    _loc_2 = Config.language("ManyPlayerToair", 26);
                    if (int(Config._crowdskytower[(this._hightfloor - 1)].levelAwardNumber1) != 0)
                    {
                        _loc_2 = _loc_2 + Config.language("activePanel", 66, Config._crowdskytower[(this._hightfloor - 1)].levelAwardNumber1);
                    }
                    if (int(Config._crowdskytower[(this._hightfloor - 1)].levelAwardNumber2) != 0)
                    {
                        _loc_2 = _loc_2 + Config.language("activePanel", 67, Config._crowdskytower[(this._hightfloor - 1)].levelAwardNumber2);
                    }
                    if (int(Config._crowdskytower[(this._hightfloor - 1)].levelAwardItemNumber) != 0)
                    {
                        _loc_2 = _loc_2 + ("\n                    <font color=\'#ad1b2e\'>" + Config._itemMap[Config._crowdskytower[(this._hightfloor - 1)].levelAwardItemId].name + "</font> *<font color=\'#ad1b2e\'>" + Config._crowdskytower[(this._hightfloor - 1)].levelAwardItemNumber + "</font>");
                    }
                }
            }
            AlertUI.msg = "<p align=\'center\'>" + Config.language("ManyPlayerToair", 15, _loc_2, this._shutdown) + "</p>";
            return;
        }// end function

        private function strattimer2(event:TimerEvent)
        {
            var _loc_2:* = this;
            var _loc_3:* = this._shutdown - 1;
            _loc_2._shutdown = _loc_3;
            if (this._shutdown <= 0)
            {
                this._timer2.stop();
                this._timer2.removeEventListener(TimerEvent.TIMER, this.strattimer2);
                AlertUI.remove(this._alertnum);
            }
            AlertUI.msg = "<p align=\'center\'>" + Config.language("ManyPlayerToair", 17, this._shutdown) + "</p>";
            return;
        }// end function

        private function strattimer3(event:TimerEvent)
        {
            var _loc_2:* = this;
            var _loc_3:* = this._shutdown - 1;
            _loc_2._shutdown = _loc_3;
            if (this._shutdown <= 0)
            {
                this._timer3.stop();
                this._timer3.removeEventListener(TimerEvent.TIMER, this.strattimer3);
                AlertUI.remove(this._alertnum);
            }
            AlertUI.msg = "<p align=\'center\'>" + Config.language("ManyPlayerToair", 18, this._shutdown) + "</p>";
            return;
        }// end function

        private function getfloor(event:SocketEvent) : void
        {
            var _loc_6:* = null;
            var _loc_7:* = undefined;
            var _loc_8:* = null;
            var _loc_2:* = event.data;
            this.passhfloor = _loc_2.readUnsignedShort();
            this._passcount = _loc_2.readUnsignedByte();
            this._hightfloor = this.passhfloor + 1;
            this._todaypasslab.text = Config.language("ManyPlayerToair", 19, this._passcount);
            var _loc_3:* = 0;
            while (_loc_3 < this._checkbArr.length)
            {
                
                if (this._checkbArr[_loc_3].parent != null)
                {
                    this._canv.removeChildUI(this._checkbArr[_loc_3]);
                }
                _loc_3++;
            }
            this._checkbArr = [];
            if (!this._xmlflag)
            {
                this._xmlflag = true;
                _loc_6 = {};
                _loc_6 = Config._crowdskytower;
                this._len = 0;
                for (_loc_7 in _loc_6)
                {
                    
                    var _loc_11:* = this;
                    var _loc_12:* = this._len + 1;
                    _loc_11._len = _loc_12;
                }
            }
            if (this._hightfloor > this._len)
            {
                this._hightfloor = this._len;
            }
            var _loc_4:* = this._hightfloor;
            var _loc_5:* = 0;
            while (_loc_4 > 0)
            {
                
                _loc_8 = new CheckBox(null, 10, 5 + _loc_5 * 20, "    " + Config.language("ManyPlayerToair", 20, _loc_4), this.selectbox);
                _loc_8.data = _loc_4;
                if (_loc_4 == this._hightfloor)
                {
                    if (this._passcount >= 2 && this._hightfloor == (this.passhfloor + 1))
                    {
                        _loc_8.enabled = false;
                        _loc_8.selected = false;
                    }
                    else
                    {
                        _loc_8.enabled = true;
                        _loc_8.selected = true;
                        this._cengshu = this._hightfloor;
                    }
                }
                this._canv.addChildUI(_loc_8);
                this._checkbArr[(_loc_4 - 1)] = _loc_8;
                _loc_4 = _loc_4 - 1;
                _loc_5++;
            }
            if (this._passcount >= 2 && this._hightfloor >= 2)
            {
                if (this._hightfloor != (this.passhfloor + 1))
                {
                    if (this._checkbArr[(this._hightfloor - 1)] != null)
                    {
                        this._checkbArr[(this._hightfloor - 1)].selected = true;
                        this._cengshu = this._hightfloor;
                    }
                }
                else if (this._checkbArr[this._hightfloor - 2] != null)
                {
                    this._checkbArr[this._hightfloor - 2].selected = true;
                    this._cengshu = this._hightfloor - 1;
                }
            }
            return;
        }// end function

        private function selectbox(event:MouseEvent) : void
        {
            var _loc_2:* = 0;
            if (event.currentTarget.enabled)
            {
                if (event.currentTarget.selected)
                {
                    _loc_2 = 0;
                    while (_loc_2 < this._checkbArr.length)
                    {
                        
                        this._checkbArr[_loc_2].selected = false;
                        _loc_2++;
                    }
                    event.currentTarget.selected = true;
                    this._cengshu = event.currentTarget.data;
                }
                else
                {
                    event.currentTarget.selected = true;
                }
            }
            return;
        }// end function

        private function todayprize(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedByte();
            return;
        }// end function

        private function backcreatefb(event:SocketEvent) : void
        {
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = 0;
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedByte();
            var _loc_4:* = [];
            var _loc_5:* = 0;
            while (_loc_5 < _loc_3)
            {
                
                _loc_6 = _loc_2.readUnsignedShort();
                _loc_7 = _loc_2.readUTFBytes(_loc_6);
                _loc_4.push(_loc_7);
                _loc_5 = _loc_5 + 1;
            }
            if (_loc_4.length > 0)
            {
                _loc_8 = "";
                _loc_9 = 0;
                while (_loc_9 < _loc_4.length)
                {
                    
                    if (_loc_9 > 0)
                    {
                        _loc_8 = _loc_8 + "\n";
                    }
                    _loc_8 = _loc_8 + _loc_4[_loc_9];
                    _loc_9++;
                }
                AlertUI.remove(this._alertnum);
                this._alertnum = AlertUI.alert(Config.language("ManyPlayerToair", 14), Config.language("ManyPlayerToair", 21, _loc_8), [Config.language("ManyPlayerToair", 22)]);
            }
            return;
        }// end function

        private function teamplayerenter(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            var _loc_4:* = _loc_2.readUnsignedShort();
            var _loc_5:* = _loc_2.readUTFBytes(_loc_4);
            AlertUI.remove(this._alertnum);
            this._shutdown = Config._crowdskytower[1].enterTimeLimit;
            this._alertnum = AlertUI.alert(Config.language("ManyPlayerToair", 14), "<p align=\'center\'>" + Config.language("ManyPlayerToair", 18, this._shutdown) + "</p>", [Config.language("ManyPlayerToair", 12)], [this.nowenterfb]);
            this._timer3.removeEventListener(TimerEvent.TIMER, this.strattimer3);
            this._timer3.addEventListener(TimerEvent.TIMER, this.strattimer3);
            this._timer3.start();
            return;
        }// end function

        private function nowenterfb(event:MouseEvent) : void
        {
            this._timer3.stop();
            this._timer3.removeEventListener(TimerEvent.TIMER, this.strattimer3);
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_ENTER_MULTISKYTOWER);
            _loc_2.add16(this._cengshu);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function playerlevelfb(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            var _loc_4:* = _loc_2.readUnsignedShort();
            var _loc_5:* = _loc_2.readUTFBytes(_loc_4);
            return;
        }// end function

        private function sendteamlist(param1:int = 1, param2:uint = 0) : void
        {
            var _loc_3:* = new DataSet();
            _loc_3.addHead(CONST_ENUM.C2B_MULTISKYTOWER_TEAMSQUERY);
            _loc_3.add32(param1);
            _loc_3.add32(this._updatetime);
            _loc_3.add8(param2);
            ClientSocket.send(_loc_3);
            return;
        }// end function

        private function timersend(event:TimerEvent) : void
        {
            this.sendteamlist(this._page);
            if (!this._opening)
            {
                this._timer.stop();
                this._timer.removeEventListener(TimerEvent.TIMER, this.timersend);
            }
            return;
        }// end function

        private function sendteaminfor()
        {
            var _loc_1:* = null;
            if (Config.ui._teamUI.teamId != 0)
            {
                _loc_1 = new DataSet();
                _loc_1.addHead(CONST_ENUM.C2B_MULTISKYTOWER_TEAMINFO);
                _loc_1.add32(Config.ui._teamUI.teamId);
                ClientSocket.send(_loc_1);
            }
            return;
        }// end function

        private function addteam(event:SocketEvent) : void
        {
            return;
        }// end function

        private function showteamMembers(param1:Object, param2:int)
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_3:* = new Label(this._shrect3, 10, 10 + param2 * 50, param1._name + "\n Lv " + param1._level + "  " + Config._jobTitleMap[param1._jobid]);
            _loc_3.html = true;
            if (Config.ui._teamUI.teaminfor.type == 3)
            {
                if (param1._name == Config.player.name)
                {
                    _loc_4 = new PushButton(this._shrect3, 130, 15 + param2 * 50, Config.language("ManyPlayerToair", 24), this.mulebtn, null, "table18", "table31");
                    _loc_4.width = 40;
                    _loc_4.textColor = Style.GOLD_FONT;
                    _loc_4.data = 2;
                }
                else
                {
                    _loc_4 = new PushButton(this._shrect3, 130, 15 + param2 * 50, Config.language("ManyPlayerToair", 25), this.mulebtn, null, "table18", "table31");
                    _loc_4.width = 40;
                    _loc_4.textColor = Style.GOLD_FONT;
                    _loc_4.data = 4;
                    _loc_4.name = "" + param1._teamplayerid;
                }
            }
            else if (param1._name == Config.player.name)
            {
                _loc_5 = new PushButton(this._shrect3, 130, 15 + param2 * 50, Config.language("ManyPlayerToair", 24), this.mulebtn, null, "table18", "table31");
                _loc_5.width = 40;
                _loc_5.textColor = Style.GOLD_FONT;
                _loc_5.data = 3;
            }
            this._menberArr.push(param1);
            return;
        }// end function

        private function mulebtn(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            switch(event.currentTarget.data)
            {
                case 2:
                case 3:
                {
                    _loc_2 = new DataSet();
                    _loc_2.addHead(CONST_ENUM.C2B_QUIT_MULTISKYTOWER_TEAM);
                    ClientSocket.send(_loc_2);
                    this.removesprite(this._shrect3);
                    this._labnum.text = Config.language("ManyPlayerToair", 4, 0);
                    _loc_3 = 5;
                    while (_loc_3 < 10)
                    {
                        
                        if (this._lineArr[_loc_3] != null)
                        {
                            this._lineArr[_loc_3].graphics.clear();
                            trace(this._lineArr[_loc_3]);
                        }
                        _loc_4 = new Shape();
                        _loc_4.graphics.lineStyle(2, 16777215);
                        _loc_4.graphics.moveTo(5, 5);
                        _loc_4.graphics.lineTo(175, 5);
                        _loc_4.graphics.moveTo(175, 5);
                        _loc_4.graphics.lineTo(175, 48);
                        _loc_4.graphics.moveTo(175, 48);
                        _loc_4.graphics.lineTo(5, 48);
                        _loc_4.graphics.moveTo(5, 48);
                        _loc_4.graphics.lineTo(5, 5);
                        _loc_4.x = 310;
                        _loc_4.y = (_loc_3 - 5) * 50 + 55;
                        this.addChild(_loc_4);
                        this._lineArr[_loc_3] = _loc_4;
                        _loc_3++;
                    }
                    break;
                }
                case 4:
                {
                    _loc_2 = new DataSet();
                    _loc_2.addHead(CONST_ENUM.C2B_TEAM_KICKOUT_MEMBER);
                    _loc_2.add32(parseInt(event.currentTarget.name));
                    ClientSocket.send(_loc_2);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function entermap()
        {
            if (Config.ui._taskpanel._tasktips.opening)
            {
                Config.ui._taskpanel._tasktips.close();
            }
            if (this._opening)
            {
                this.close();
            }
            if (Config.ui._activePanel._opening)
            {
                Config.ui._activePanel.close();
            }
            return;
        }// end function

        private function quickfb(event:MouseEvent)
        {
            this._timer2.stop();
            this._timer1.stop();
            this._timer2.removeEventListener(TimerEvent.TIMER, this.strattimer2);
            this._timer1.removeEventListener(TimerEvent.TIMER, this.strattimer1);
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_LEAVE_MULTISKYTOWER);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function alltime(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            this._shutdown = _loc_2.readUnsignedInt();
            this._cengshu = _loc_2.readUnsignedShort();
            var _loc_3:* = this._checkbArr.length - 1;
            while (_loc_3 >= 0)
            {
                
                if (this._checkbArr[_loc_3] != null)
                {
                    if (this._cengshu == (_loc_3 + 1))
                    {
                        this._checkbArr[_loc_3].selected = true;
                    }
                    else
                    {
                        this._checkbArr[_loc_3].selected = false;
                    }
                }
                _loc_3 = _loc_3 - 1;
            }
            this._logintime = getTimer();
            this.addtimesprite();
            this._timeLB = new Label(this._timesprite, 5, 5);
            this._timeLB.html = true;
            this._timeLB.textColor = 16752190;
            this._timeLB.filters = [new GlowFilter(0, 1, 2, 2, 10)];
            this._timer0.removeEventListener(TimerEvent.TIMER, this.strattimer);
            this._timer0.addEventListener(TimerEvent.TIMER, this.strattimer);
            this._timer0.start();
            return;
        }// end function

        private function strattimer(event:TimerEvent)
        {
            var _loc_3:* = null;
            var _loc_2:* = Math.max(0, this._shutdown - int((getTimer() - this._logintime) / 1000));
            if (_loc_2 <= 0)
            {
                this._timer0.stop();
                this._timer0.removeEventListener(TimerEvent.TIMER, this.strattimer);
                this._timeLB.text = "";
                if (this._timesprite != null)
                {
                    this.removesprite(this._timesprite);
                    if (this._timesprite.parent != null)
                    {
                        this._timesprite.parent.removeChild(this._timesprite);
                    }
                }
            }
            else
            {
                _loc_3 = "";
                _loc_3 = Config.language("SeniorCopy", 21, this._cengshu);
                this._timeLB.text = Config.language("SeniorCopy", 22, _loc_3, Config.timeShow(_loc_2));
            }
            return;
        }// end function

        public function resizeposx()
        {
            if (this._timesprite != null)
            {
                if (this._timesprite.parent != null)
                {
                    this._timesprite.x = (-Config.ui._width) / 2 - 50;
                }
            }
            return;
        }// end function

        private function addtimesprite() : void
        {
            if (this._timesprite != null)
            {
                this.removesprite(this._timesprite);
                if (this._timesprite.parent != null)
                {
                    this._timesprite.parent.removeChild(this._timesprite);
                }
            }
            this._timesprite = new Sprite();
            this._timesprite.x = (-Config.ui._width) / 2 - 50;
            this._timesprite.y = 40;
            this._timesprite.graphics.beginFill(0, 0);
            this._timesprite.graphics.drawRoundRect(0, 0, 110, 40, 5);
            this._timesprite.graphics.endFill();
            Config.ui._radar.addChild(this._timesprite);
            return;
        }// end function

        public function backmap()
        {
            if (!Config.ui._taskpanel._tasktips.opening)
            {
                Config.ui._taskpanel._tasktips.open();
            }
            if (this._timesprite != null)
            {
                this.removesprite(this._timesprite);
                if (this._timesprite.parent != null)
                {
                    this._timesprite.parent.removeChild(this._timesprite);
                }
            }
            if (this._timer != null)
            {
                this._timer.stop();
                this._timer.removeEventListener(TimerEvent.TIMER, this.strattimer);
            }
            if (this._timer0 != null)
            {
                this._timer0.stop();
                this._timer0.removeEventListener(TimerEvent.TIMER, this.strattimer);
            }
            if (this._timer2 != null)
            {
                this._timer1.stop();
                this._timer2.stop();
                this._timer1.removeEventListener(TimerEvent.TIMER, this.strattimer1);
                this._timer2.removeEventListener(TimerEvent.TIMER, this.strattimer2);
                AlertUI.remove(this._alertnum);
            }
            return;
        }// end function

        private function removesprite(param1:Sprite) : void
        {
            while (param1.numChildren > 0)
            {
                
                param1.removeChildAt((param1.numChildren - 1));
            }
            return;
        }// end function

        private function set _cengshu(param1:int) : void
        {
            this._cengtemp = param1;
            return;
        }// end function

        private function get _cengshu() : int
        {
            return this._cengtemp;
        }// end function

        private function set _hightfloor(param1:int) : void
        {
            this._hightfloortemp = param1;
            return;
        }// end function

        private function get _hightfloor() : int
        {
            return this._hightfloortemp;
        }// end function

        public function set passhfloor(param1:int) : void
        {
            this._passhfloor = param1;
            return;
        }// end function

        public function get passhfloor() : int
        {
            return this._passhfloor;
        }// end function

    }
}
