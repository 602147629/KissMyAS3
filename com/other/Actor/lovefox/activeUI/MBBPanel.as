package lovefox.activeUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;
    import lovefox.component.*;
    import lovefox.gameUI.*;
    import lovefox.socket.*;

    public class MBBPanel extends Window
    {
        private var _awdardNum:int = 0;
        private var awardLabel:Label;
        private var _relevel:int = 30;
        private var _reBtn:PushButton;
        private var _reBtnFlag:int = 0;
        private var _codeLabel:Label;
        private var _code:String = "";
        private var _noteLabel:Label;
        private var mbbObj:Object;
        private var t2:Label;
        private var t3:Label;
        private var t4:ClickLabel;
        private var openFlag:int = 0;

        public function MBBPanel(param1:DisplayObjectContainer)
        {
            super(param1);
            this.initpanel();
            this.initsocket();
            return;
        }// end function

        private function initsocket() : void
        {
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_GETGIFTSTRING, this.backCode);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_ACTIVITY_QUERY, this.backActive);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_ACTIVITY_UPDATE, this.backActiveUpdate);
            return;
        }// end function

        private function initpanel() : void
        {
            this.title = Config.language("MBBPanel", 1);
            resize(340, 260);
            var _loc_1:* = new Shape();
            this.addChild(_loc_1);
            _loc_1.graphics.beginFill(7689037);
            _loc_1.graphics.drawRoundRect(20, 31, 200, 28, 2);
            _loc_1.graphics.endFill();
            _loc_1.graphics.beginFill(3286307);
            _loc_1.graphics.drawRoundRect(20, 110, 300, 28, 2);
            _loc_1.graphics.endFill();
            var _loc_2:* = new Label(this, 30, 34, Config.language("MBBPanel", 2));
            _loc_2.textColor = 16777215;
            this.t2 = new Label(this, 20, 65);
            this.t2.html = true;
            this.awardLabel = new Label(this, 20, 34);
            this.awardLabel.textColor = 16777215;
            this._codeLabel = new Label(this, 20, 115);
            this._codeLabel.textColor = 16777215;
            this._reBtn = new PushButton(this, 130, 160, " ", this.handleFuc);
            this._reBtn.width = 80;
            this._noteLabel = new Label(this, 20, 200);
            this._noteLabel.textColor = 6710886;
            this.t3 = new Label(this, 20, 230);
            this.t3.textColor = 6710886;
            this.t4 = new ClickLabel(this, 110, 230, "", this.openmbbwww, true);
            this.t4.clickColor([3295734, 3295734]);
            return;
        }// end function

        private function openmbbwww(param1)
        {
            var _loc_2:* = new URLRequest(this.mbbObj[this.openFlag].url);
            navigateToURL(_loc_2);
            return;
        }// end function

        private function sendqueNum(event:TextEvent = null) : void
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_GETGIFTSTRING);
            _loc_2.add32(0);
            ClientSocket.send(_loc_2);
            trace("send 0");
            return;
        }// end function

        private function mbbOpen() : void
        {
            var _loc_1:* = null;
            if (this._code != "")
            {
                this.open();
                this.reshowPanel();
            }
            else if (this._awdardNum > 0)
            {
                _loc_1 = new DataSet();
                _loc_1.addHead(CONST_ENUM.C2G_GETGIFTSTRING);
                _loc_1.add32(1);
                ClientSocket.send(_loc_1);
                trace("send 1");
            }
            else if (AlertUI._ui.parent == null)
            {
                AlertUI.alert(Config.language("MBBPanel", 5), Config.language("MBBPanel", 6), [Config.language("MBBPanel", 7)]);
            }
            return;
        }// end function

        private function reshowPanel() : void
        {
            this.awardLabel.text = String(this._awdardNum);
            this.awardLabel.x = 200 - this.awardLabel.width;
            if (Config.player.level >= this.mbbObj[this.openFlag].level)
            {
                if (this._code != "")
                {
                    this._reBtnFlag = 3;
                    this._reBtn.label = Config.language("MBBPanel", 8);
                    this._codeLabel.text = this._code;
                    this._codeLabel.tf.selectable = true;
                    this._codeLabel.tf.mouseEnabled = true;
                    this._noteLabel.text = Config.language("MBBPanel", 9);
                }
                else
                {
                    this._reBtnFlag = 2;
                    this._reBtn.label = Config.language("MBBPanel", 10);
                    this._codeLabel.text = Config.language("MBBPanel", 11, this.mbbObj[this.openFlag].level);
                    this._codeLabel.tf.selectable = false;
                    this._codeLabel.tf.mouseEnabled = false;
                    this._noteLabel.text = Config.language("MBBPanel", 12);
                }
            }
            else
            {
                this._reBtnFlag = 1;
                this._reBtn.label = Config.language("MBBPanel", 13);
                this._codeLabel.text = Config.language("MBBPanel", 14, this.mbbObj[this.openFlag].level);
                this._codeLabel.tf.selectable = false;
                this._codeLabel.tf.mouseEnabled = false;
                this._noteLabel.text = "";
            }
            this._codeLabel.x = (300 - this._codeLabel.width) / 2 + 20;
            return;
        }// end function

        private function backCode(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            this._awdardNum = _loc_2.readUnsignedInt();
            var _loc_3:* = _loc_2.readUnsignedShort();
            this._code = _loc_2.readUTFBytes(_loc_3);
            this.mbbOpen();
            trace("**************" + this._awdardNum + ":" + this._code + ":");
            return;
        }// end function

        private function backActive(event:SocketEvent) : void
        {
            var _loc_5:* = 0;
            this.mbbObj = new Object();
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = _loc_2.readUnsignedInt();
                this.mbbObj[_loc_5] = {};
                this.mbbObj[_loc_5].id = _loc_5;
                this.mbbObj[_loc_5].name = _loc_2.readUTFBytes(_loc_2.readUnsignedShort());
                this.mbbObj[_loc_5].startTime = _loc_2.readUTFBytes(_loc_2.readUnsignedShort());
                this.mbbObj[_loc_5].endTime = _loc_2.readUTFBytes(_loc_2.readUnsignedShort());
                this.mbbObj[_loc_5].level = _loc_2.readUnsignedInt();
                this.mbbObj[_loc_5].linNum = _loc_2.readUnsignedInt();
                this.mbbObj[_loc_5].cd = _loc_2.readUnsignedInt();
                this.mbbObj[_loc_5].url = _loc_2.readUTFBytes(_loc_2.readUnsignedShort());
                this.mbbObj[_loc_5].status = _loc_2.readUnsignedInt();
                _loc_4 = _loc_4 + 1;
            }
            return;
        }// end function

        private function handleFuc(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            switch(this._reBtnFlag)
            {
                case 0:
                case 1:
                {
                    this.close();
                    break;
                }
                case 2:
                {
                    _loc_2 = new DataSet();
                    _loc_2.addHead(CONST_ENUM.C2G_GETGIFTSTRING);
                    _loc_2.add32(1);
                    ClientSocket.send(_loc_2);
                    break;
                }
                case 3:
                {
                    System.setClipboard(this._code);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function npcTalk(param1:int, param2:Array, param3:Function = null) : void
        {
            var _loc_4:* = undefined;
            for (_loc_4 in this.mbbObj)
            {
                
                if (Config.now.getTime() >= this.realTime(this.mbbObj[_loc_4].startTime).getTime() && Config.now.getTime() <= this.realTime(this.mbbObj[_loc_4].endTime).getTime() && this.mbbObj[_loc_4].status > 0)
                {
                    param2.push({label:this.mbbObj[_loc_4].name, handler:Config.create(this.openPanel, this.mbbObj[_loc_4].id), closeflag:true});
                }
            }
            return;
        }// end function

        private function realTime(param1:String) : Date
        {
            var _loc_2:* = new Date();
            var _loc_3:* = int(param1.substr(0, 4));
            var _loc_4:* = int(param1.substr(5, 2)) - 1;
            var _loc_5:* = int(param1.substr(8, 2));
            var _loc_6:* = int(param1.substr(11, 2));
            var _loc_7:* = int(param1.substr(14, 2));
            var _loc_8:* = int(param1.substr(17, 2));
            _loc_2.setFullYear(_loc_3);
            _loc_2.setMonth(_loc_4);
            _loc_2.setDate(_loc_5);
            _loc_2.setHours(_loc_6, _loc_7, _loc_8);
            trace(_loc_2.toString());
            return _loc_2;
        }// end function

        private function openPanel(param1 = null, param2:int = 1) : void
        {
            this.openFlag = param2;
            this.title = this.mbbObj[param2].name;
            this.t2.text = Config.language("MBBPanel", 3, this.mbbObj[param2].level);
            this.t3.text = this.mbbObj[param2].name + Config.language("MBBPanel", 15);
            this.t4.text = this.mbbObj[param2].url;
            this.sendqueNum();
            return;
        }// end function

        public function sendQuery() : void
        {
            var _loc_1:* = new DataSet();
            _loc_1.addHead(CONST_ENUM.C2G_ACTIVITY_QUERY);
            ClientSocket.send(_loc_1);
            return;
        }// end function

        private function backActiveUpdate(event:SocketEvent) : void
        {
            this.sendQuery();
            return;
        }// end function

    }
}
