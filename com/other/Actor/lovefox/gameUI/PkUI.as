package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;
    import lovefox.socket.*;

    public class PkUI extends Sprite
    {
        private var _pkTimeStamp:Number;
        private var _pkTimeTimer:Number;
        private var _pkPlName:String;
        private var _opName:String;
        private var _cdCount:Number;
        private var _cdStamp:Number;
        private var _cdTimer:Number;
        private var _preCd:Number;
        private var _exitPB:PushButton;
        private var _timeLB:Label;
        private var _disturbFlag:Boolean = true;
        private var _preAlertId:Number = 0;
        private var _recording:Boolean = false;
        private var _frag:uint = 0;

        public function PkUI()
        {
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_DUEL_INVITE, this.handlePkInvited);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_DUEL_RESPONSE, this.handlePkResponse);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_DUEL_COUNTDOWN, this.handlePkCountDown);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_DUEL_RESULT, this.handlePkResult);
            this.initUI();
            return;
        }// end function

        private function initUI()
        {
            this._exitPB = new PushButton(this, 0, 20, Config.language("PkUI", 1), this.handleExit, null, "table18", "table31");
            this._exitPB.textColor = Style.GOLD_FONT;
            this._exitPB.width = 60;
            this._timeLB = new Label(this, -5, 40);
            this._timeLB.textColor = Style.WHITE_FONT;
            this._timeLB.filters = [new GlowFilter(0, 1, 1.5, 1.5, 5)];
            return;
        }// end function

        public function enter()
        {
            if (this.parent == null)
            {
                Config.ui._radar.addChild(this);
                if (Config.map._type == 24)
                {
                    this._exitPB.label = Config.language("PkUI", 25);
                }
                else if (Config.map._type == 14)
                {
                    this._exitPB.label = Config.language("PkUI", 1);
                }
            }
            this._timeLB.text = "";
            return;
        }// end function

        public function exit()
        {
            if (this.parent != null)
            {
                this.parent.removeChild(this);
            }
            AlertUI.remove(this._preAlertId);
            this.stopRecord();
            return;
        }// end function

        private function handlePkCountDown(param1)
        {
            var _loc_6:* = null;
            var _loc_2:* = param1.data;
            var _loc_3:* = _loc_2.readByte();
            var _loc_4:* = _loc_2.readUnsignedInt();
            var _loc_5:* = _loc_2.readUnsignedInt();
            this._frag = _loc_3;
            this._cdCount = _loc_4;
            this._cdStamp = getTimer();
            this._preCd = -1;
            if (_loc_3 == 2)
            {
                this.startRecord();
            }
            else if (_loc_3 == 3)
            {
                _loc_6 = Config.language("PkUI", 1);
                if (Config.map._type == 24)
                {
                    _loc_6 = Config.language("PkUI", 25);
                }
                this._preAlertId = AlertUI.alert(_loc_6, Config.language("PkUI", 2, 15), [Config.language("PkUI", 3)], [this.handleExit]);
            }
            clearTimeout(this._pkTimeTimer);
            clearTimeout(this._cdTimer);
            this._cdTimer = setTimeout(this.cdGo, 500, _loc_3);
            return;
        }// end function

        private function handleExit(param1 = null)
        {
            var _loc_2:* = null;
            if (Config.map._type == 14)
            {
                _loc_2 = new DataSet();
                _loc_2.addHead(CONST_ENUM.C2G_DUEL_LEAVE);
                ClientSocket.send(_loc_2);
                clearTimeout(this._cdTimer);
                clearTimeout(this._pkTimeTimer);
            }
            else if (Config.map._type == 24)
            {
                if (this._frag == 3)
                {
                    this.sendLeftRace();
                }
                else
                {
                    AlertUI.alert(Config.language("InterPkPanel", 11), Config.language("InterPkPanel", 12), [Config.language("InterPkPanel", 13), Config.language("InterPkPanel", 14)], [this.sendLeftRace]);
                }
            }
            return;
        }// end function

        private function sendLeftRace(param1 = null)
        {
            var _loc_2:* = null;
            if (Config.map._type == 24)
            {
                Config.ui._serveracebill.jionorin = 0;
                _loc_2 = new DataSet();
                _loc_2.addHead(CONST_ENUM.C2G_CARENA_LEAVE);
                ClientSocket.send(_loc_2);
                clearTimeout(this._cdTimer);
                clearTimeout(this._pkTimeTimer);
            }
            return;
        }// end function

        private function cdGo(param1)
        {
            var _loc_2:* = String(Math.max(0, this._cdCount - int((getTimer() - this._cdStamp) / 1000)));
            if (this._preCd != _loc_2)
            {
                this._preCd = _loc_2;
                if (param1 == 1)
                {
                    Neon.show(_loc_2 - 2);
                }
                else if (param1 == 2)
                {
                    this._timeLB.text = Config.language("PkUI", 4) + Config.timeShow(_loc_2);
                }
                else if (param1 == 3)
                {
                    _loc_2 = String(_loc_2);
                    if (_loc_2.length == 1)
                    {
                        _loc_2 = "0" + _loc_2;
                    }
                    AlertUI.msg = Config.language("PkUI", 2, _loc_2);
                }
            }
            clearTimeout(this._cdTimer);
            if (_loc_2 > 2)
            {
                this._cdTimer = setTimeout(this.cdGo, 500, param1);
            }
            else if (param1 == 3)
            {
                if (Config.map._type == 24)
                {
                    Config.ui._serveracebill.jionorin = 0;
                }
                AlertUI.close();
            }
            return;
        }// end function

        private function handlePkResult(param1)
        {
            var _loc_2:* = param1.data;
            var _loc_3:* = _loc_2.readByte();
            if (_loc_3 == 0)
            {
                Config.message(Config.language("PkUI", 5));
                Billboard.show(Config.language("PkUI", 6));
            }
            else if (_loc_3 == 1)
            {
                Config.message(Config.language("PkUI", 7));
                Billboard.show(Config.language("PkUI", 8));
                this.stopRecord(true);
            }
            else if (_loc_3 == 2)
            {
                Config.message(Config.language("PkUI", 9));
                Billboard.show(Config.language("PkUI", 10));
            }
            this._timeLB.text = "";
            return;
        }// end function

        private function handlePkInvited(param1)
        {
            var _loc_2:* = param1.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            var _loc_4:* = _loc_2.readUnsignedShort();
            var _loc_5:* = _loc_2.readUTFBytes(_loc_4);
            this._pkPlName = _loc_5;
            this._opName = _loc_5;
            var _loc_6:* = new Object();
            new Object().type = 8;
            _loc_6.fname = "pk";
            _loc_6.title = Config.language("PkUI", 11);
            _loc_6.msg = Config.language("PkUI", 12, this._pkPlName, 15);
            _loc_6.btns = [Config.language("PkUI", 13), Config.language("PkUI", 14)];
            _loc_6.funcs = [this.pkAccept, this.pkRefuse];
            _loc_6.onReplace = this.overTimeGo;
            _loc_6.onReon = this.continueTimeGo;
            _loc_6.timenum = 15;
            _loc_6.clickfunc = this.handleDisturbClick;
            if (Config.disturbMode)
            {
                this._disturbFlag = true;
                ListTip.addList(_loc_6);
            }
            else
            {
                this._disturbFlag = false;
                this._preAlertId = AlertUI.alert(Config.language("PkUI", 15), Config.language("PkUI", 12, this._pkPlName, 15), [Config.language("PkUI", 13), Config.language("PkUI", 14)], [this.pkAccept, this.pkRefuse], null, false, true, false, null, true);
            }
            this._pkTimeStamp = getTimer();
            clearTimeout(this._pkTimeTimer);
            clearTimeout(this._cdTimer);
            this._pkTimeTimer = setTimeout(this.pkTimeGo, 200);
            return;
        }// end function

        private function overTimeGo()
        {
            clearTimeout(this._pkTimeTimer);
            clearTimeout(this._cdTimer);
            return;
        }// end function

        private function continueTimeGo()
        {
            clearTimeout(this._pkTimeTimer);
            clearTimeout(this._cdTimer);
            this._pkTimeTimer = setTimeout(this.pkTimeGo, 200);
            return;
        }// end function

        private function handleDisturbClick(param1)
        {
            this._preAlertId = ListTip.ui._dealalert1;
            var _loc_2:* = String(Math.max(0, 15 - int((getTimer() - this._pkTimeStamp) / 1000)));
            if (_loc_2.length == 1)
            {
                _loc_2 = "0" + _loc_2;
            }
            this._disturbFlag = false;
            param1.msg = Config.language("PkUI", 12, this._pkPlName, _loc_2);
            return;
        }// end function

        private function pkTimeGo()
        {
            var _loc_1:* = String(Math.max(0, 15 - int((getTimer() - this._pkTimeStamp) / 1000)));
            if (_loc_1.length == 1)
            {
                _loc_1 = "0" + _loc_1;
            }
            if (this._disturbFlag)
            {
            }
            else
            {
                AlertUI.msg = Config.language("PkUI", 12, this._pkPlName, _loc_1);
            }
            clearTimeout(this._pkTimeTimer);
            this._pkTimeTimer = setTimeout(this.pkTimeGo, 500);
            return;
        }// end function

        private function handlePkResponse(param1)
        {
            var _loc_3:* = undefined;
            var _loc_2:* = param1.data;
            var _loc_4:* = _loc_2.readByte();
            var _loc_5:* = _loc_2.readByte();
            var _loc_6:* = _loc_2.readUnsignedInt();
            _loc_3 = _loc_2.readUnsignedShort();
            var _loc_7:* = _loc_2.readUTFBytes(_loc_3);
            var _loc_8:* = _loc_2.readUnsignedInt();
            _loc_3 = _loc_2.readUnsignedShort();
            var _loc_9:* = _loc_2.readUTFBytes(_loc_3);
            if (_loc_4 == 1)
            {
                if (Player._playerId == _loc_6)
                {
                    Config.message(Config.language("PkUI", 16));
                }
                else
                {
                    Config.message(Config.language("PkUI", 17));
                }
            }
            if (_loc_5 == 2)
            {
                Config.message(Config.language("PkUI", 23));
            }
            clearTimeout(this._pkTimeTimer);
            AlertUI.close();
            return;
        }// end function

        private function pkAccept(param1 = null)
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_DUEL_RESPONSE);
            _loc_2.add8(0);
            _loc_2.add8(0);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function pkRefuse(param1 = null)
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_DUEL_RESPONSE);
            _loc_2.add8(1);
            _loc_2.add8(0);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        public function invitePk(param1, param2)
        {
            if (Config.mapId > 1000000000 || Config.map._type == 3 || Config.map._type == 4 || Config.map._type == 5 || Config.map._type == 9 || Config.map._type == 11 || Config.map._type == 12 || Config.map._type == 13 || Config.map._type == 14 || Config.map._type == 15 || Config.map._type == 24)
            {
                Config.message(Config.language("PkUI", 24));
            }
            else
            {
                this._opName = param2;
                this._preAlertId = AlertUI.alert(Config.language("PkUI", 18), Config.language("PkUI", 19), [Config.language("PkUI", 20), Config.language("PkUI", 21)], [this.subInvitePk], param1, false, true, false);
            }
            return;
        }// end function

        public function subInvitePk(param1)
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_DUEL_INVITE);
            _loc_2.add32(param1);
            ClientSocket.send(_loc_2);
            Config.message(Config.language("PkUI", 22));
            return;
        }// end function

        public function startRecord()
        {
            if (!this._recording)
            {
                this._recording = true;
                Recorder.start(1);
            }
            return;
        }// end function

        public function stopRecord(param1 = false)
        {
            if (this._recording)
            {
                this._recording = false;
                if (param1)
                {
                    this.upload(Recorder.stop(1), Player.name + " vs " + this._opName);
                }
            }
            return;
        }// end function

        private function upload(param1, param2)
        {
            if (!FilterWords.chickwords(param2))
            {
                return;
            }
            var _loc_3:* = new URLRequest(Config.replayURL + "replay_upload.php?name=" + encodeURI(Player.name) + "&title=" + encodeURI(param2) + "&seconds=" + Math.floor(Recorder.getFrame(1) / 30) + "&score=" + Recorder.getScore(1) + "&account=" + Config.account + "&server=" + encodeURI(Config.serverName) + "&type=1");
            _loc_3.data = param1;
            _loc_3.method = URLRequestMethod.POST;
            _loc_3.contentType = "application/octet-stream";
            var _loc_4:* = new URLLoader();
            new URLLoader().addEventListener(Event.COMPLETE, this.completeHandler);
            _loc_4.addEventListener(IOErrorEvent.IO_ERROR, this.errorHandler);
            _loc_4.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.errorHandler);
            _loc_4.load(_loc_3);
            return;
        }// end function

        private function completeHandler(event:Event) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            _loc_2 = URLLoader(event.target);
            if (String(_loc_2.data) == "false")
            {
                trace("pk录像上传失败");
            }
            else
            {
                _loc_3 = XML(_loc_2.data);
                _loc_4 = Recorder.getCover(1);
                _loc_5 = new URLRequest(Config.replayURL + "replay_upload_thumb.php?id=" + Number(_loc_3.id));
                _loc_5.data = _loc_4;
                _loc_5.method = URLRequestMethod.POST;
                _loc_5.contentType = "application/octet-stream";
                _loc_2 = new URLLoader();
                _loc_2.addEventListener(Event.COMPLETE, this.completeHandlerThumb);
                _loc_2.addEventListener(IOErrorEvent.IO_ERROR, this.errorHandlerThumb);
                _loc_2.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.errorHandlerThumb);
                _loc_2.load(_loc_5);
            }
            Recorder.clearCover(1);
            return;
        }// end function

        private function completeHandlerThumb(param1)
        {
            trace("completeHandlerThumb");
            return;
        }// end function

        private function errorHandlerThumb(param1)
        {
            trace("errorHandlerThumb");
            return;
        }// end function

        private function errorHandler(event:IOErrorEvent) : void
        {
            trace("上传失败1");
            return;
        }// end function

    }
}
