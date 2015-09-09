package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;
    import lovefox.socket.*;

    public class OnlineExpression extends Window
    {
        private var tlabe:Label;
        private var tlabel:Label;
        private var tlabe2:Label;
        private var tlabe3:Label;
        private var tlabeExp:TextField;
        private var tlabeMon:TextField;
        private var _getexpBtn:PushButton;
        private var _getexpBtnarr:Array;
        private var tlabeExpArr:Array;
        private var tlabeExptextArr:Array;
        private var tlabeMonArr:Array;
        private var tlabeMontextArr:Array;
        private var i:int;
        public var expnum:uint = 0;
        private var lev:Number;
        private var _alertIndex:int = -1;
        private var fbool:Boolean;
        private var updatemoney1:Label;
        private var updatemoney4:Label;
        private var onlineMc:Sprite;

        public function OnlineExpression(param1:DisplayObjectContainer)
        {
            this._getexpBtnarr = [];
            this.tlabeExpArr = [];
            this.tlabeExptextArr = [];
            this.tlabeMonArr = [];
            this.tlabeMontextArr = [];
            super(param1);
            this.onlineMc = new Sprite();
            this.addChild(this.onlineMc);
            resize(300, 180);
            this.initsocket();
            return;
        }// end function

        override public function open(event:MouseEvent = null)
        {
            var _loc_2:* = 0;
            if (this.expnum > 0)
            {
                super.open();
                if (Config.player.level >= 159 && this._getexpBtnarr != null)
                {
                    _loc_2 = 0;
                    while (_loc_2 < this._getexpBtnarr.length)
                    {
                        
                        this._getexpBtnarr[_loc_2].enabled = false;
                        this._getexpBtnarr[_loc_2].removeEventListener(MouseEvent.CLICK, this.handlegetexp);
                        _loc_2 = _loc_2 + 1;
                    }
                }
            }
            else if (Config.player.level >= 20)
            {
                Config.message(Config.language("OnlineExpression", 19));
            }
            else
            {
                Config.message(Config.language("OnlineExpression", 20));
            }
            return;
        }// end function

        override public function close()
        {
            Config.player.removeEventListener("update", this.updatemoney);
            super.close();
            if (this.expnum > 0)
            {
                if (this._alertIndex >= 0)
                {
                    AlertUI.remove(this._alertIndex);
                }
                this._alertIndex = AlertUI.alert(Config.language("OnlineExpression", 1), Config.language("OnlineExpression", 2), [Config.language("OnlineExpression", 4), Config.language("OnlineExpression", 5)], [this.repanel]);
            }
            return;
        }// end function

        private function repanel(event:MouseEvent)
        {
            this.open();
            Config.player.removeEventListener("update", this.updatemoney);
            Config.player.addEventListener("update", this.updatemoney);
            return;
        }// end function

        public function initsocket()
        {
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_OFFLINE_EXP, this.backexpnum);
            return;
        }// end function

        private function drawline()
        {
            var _loc_5:* = null;
            this.removeallchild(this.onlineMc);
            this.title = Config.language("OnlineExpression", 6);
            this.lev = Config.player.level;
            var _loc_1:* = new Sprite();
            _loc_1.graphics.lineStyle(0);
            _loc_1.graphics.moveTo(28, 148);
            _loc_1.graphics.lineTo(275, 148);
            this.onlineMc.addChild(_loc_1);
            this.tlabel = new Label(this.onlineMc, 25, 30);
            this.tlabel.html = true;
            this.tlabe2 = new Label(this.onlineMc, 20, 60);
            this.tlabe2.text = Config.language("OnlineExpression", 8);
            var _loc_2:* = 0;
            while (_loc_2 < 2)
            {
                
                this.tlabeMon = Config.getSimpleTextField();
                this.tlabeExp = Config.getSimpleTextField();
                this.tlabeMon.y = 85 + 32 * _loc_2;
                this.tlabeExp.y = 85 + 32 * _loc_2;
                this.tlabeMon.x = 25;
                this.tlabeExp.x = 100;
                this.tlabeMon.width = 50;
                this.tlabeExp.width = 50;
                this.tlabeMon.autoSize = TextFieldAutoSize.CENTER;
                this.tlabeExp.autoSize = TextFieldAutoSize.CENTER;
                this.onlineMc.addChild(this.tlabeExp);
                this.onlineMc.addChild(this.tlabeMon);
                _loc_5 = "";
                if (_loc_2 == 0)
                {
                    _loc_5 = Config.language("OnlineExpression", 9);
                    this.tlabeMontextArr[_loc_2] = Config._ListExp[this.lev].freexpmon1;
                    this.tlabeExptextArr[_loc_2] = Config._ListExp[this.lev].freexp1;
                    this._getexpBtn = new PushButton(this.onlineMc, 180, 85, Config.language("OnlineExpression", 11));
                    this._getexpBtn.addEventListener(MouseEvent.CLICK, this.handlegetexp);
                }
                else
                {
                    _loc_5 = Config.language("OnlineExpression", 10);
                    this.tlabeMontextArr[_loc_2] = Config._ListExp[this.lev].buyexpmon2;
                    this.tlabeExptextArr[_loc_2] = Config._ListExp[this.lev].buyexp2;
                    this._getexpBtn = new PushButton(this.onlineMc, 180, 115, Config.language("OnlineExpression", 13));
                    this._getexpBtn.addEventListener(MouseEvent.CLICK, this.handlegetexp);
                    if (Config._lanVersion == LanVersion.QQ_ZH_CN)
                    {
                        this._getexpBtn.visible = false;
                        this.tlabeExp.visible = false;
                        this.tlabeMon.visible = false;
                    }
                }
                this._getexpBtnarr.push(this._getexpBtn);
                this._getexpBtn.name = _loc_2.toString();
                this.onlineMc.addChild(this._getexpBtn);
                this.tlabeMon.text = this.tlabeMontextArr[_loc_2].toString() + _loc_5;
                this.tlabeMonArr[_loc_2] = this.tlabeMon;
                this.tlabeExp.text = this.tlabeExptextArr[_loc_2].toString();
                this.tlabeExpArr[_loc_2] = this.tlabeExp;
                _loc_2 = _loc_2 + 1;
            }
            var _loc_3:* = Config.coinShow(Config.player.money4);
            var _loc_4:* = Config.coinShow(Config.player.money1);
            this.updatemoney4 = new Label(this.onlineMc, 30, 154, Config.language("OnlineExpression", 14) + _loc_3);
            this.updatemoney1 = new Label(this.onlineMc, 185, 154, Config.language("OnlineExpression", 15) + _loc_4);
            if (Config._lanVersion == LanVersion.QQ_ZH_CN)
            {
                this.updatemoney1.visible = false;
            }
            trace(Config.player.money3, Config.player.money2);
            return;
        }// end function

        private function handlegetexp(event:MouseEvent)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            if (this.expnum > 0)
            {
                if (Config.ui._playerHead.fcmstatus > 0)
                {
                    Config.message(Config.language("OnlineExpression", 7));
                    return;
                }
                _loc_2 = event.currentTarget;
                _loc_3 = int(parseInt(_loc_2.name));
                _loc_4 = "";
                if (_loc_3 == 0)
                {
                    _loc_4 = Config.language("OnlineExpression", 9);
                }
                else if (_loc_3 == 1)
                {
                    _loc_4 = Config.language("OnlineExpression", 10);
                }
                if (this._alertIndex >= 0)
                {
                    AlertUI.remove(this._alertIndex);
                }
                this._alertIndex = AlertUI.alert(Config.language("OnlineExpression", 1), Config.language("OnlineExpression", 16, this.tlabeMontextArr[_loc_3], _loc_4, this.tlabeExptextArr[_loc_3]), [Config.language("OnlineExpression", 3), Config.language("OnlineExpression", 12)], [this.buyExp], _loc_3);
            }
            return;
        }// end function

        private function buyExp(param1:int)
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_BUY_OFFLINE_EXP);
            _loc_2.add32((param1 + 1));
            _loc_2.add32(1);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        public function backexpnum(event:SocketEvent = null)
        {
            var _loc_2:* = null;
            if (event != null)
            {
                _loc_2 = event.data;
                this.expnum = _loc_2.readUnsignedInt();
            }
            if (this.expnum <= 0)
            {
                if (this._opening)
                {
                    this.i = 0;
                    while (this.i < this._getexpBtnarr.length)
                    {
                        
                        if (this._getexpBtnarr[this.i] != null)
                        {
                            this._getexpBtnarr[this.i].enabled = false;
                            this._getexpBtnarr[this.i].buttonMode = false;
                        }
                        var _loc_3:* = this;
                        var _loc_4:* = this.i + 1;
                        _loc_3.i = _loc_4;
                    }
                    this.tlabel.text = Config.language("OnlineExpression", 17, this.expnum);
                }
            }
            else
            {
                this.drawline();
                Config.player.removeEventListener("update", this.updatemoney);
                Config.player.addEventListener("update", this.updatemoney);
                this.tlabel.text = Config.language("OnlineExpression", 17, this.expnum);
            }
            return;
        }// end function

        private function updatemoney(param1) : void
        {
            if (param1.param == "money1")
            {
                this.updatemoney1.text = Config.language("OnlineExpression", 15) + Config.coinShow(param1.value);
            }
            if (param1.param == "money4")
            {
                this.updatemoney4.text = Config.language("OnlineExpression", 14) + Config.coinShow(param1.value);
            }
            return;
        }// end function

        public function alertfun()
        {
            AlertUI.alert(Config.language("OnlineExpression", 1), Config.language("OnlineExpression", 18), [Config.language("OnlineExpression", 3), Config.language("OnlineExpression", 12)], [this.openshopui]);
            return;
        }// end function

        private function openshopui(param1)
        {
            Config.ui._shopmail.openListPanel(3);
            Config.ui._shopmail.itemcontain.verticalScrollPosition = 85;
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

    }
}
