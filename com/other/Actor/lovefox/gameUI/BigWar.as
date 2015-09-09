package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import lovefox.component.*;
    import lovefox.socket.*;

    public class BigWar extends Window
    {
        private var _waralert:Object;
        private var whetherjion:Boolean;
        private var temppagearr:Array;
        private var teamId:int;
        private var scorePanel:Sprite;
        private var datalist:DataGridUI;
        private var tim:Number;
        private var enterFlag:Boolean = false;
        private var btnFlag:Boolean = false;

        public function BigWar(param1:DisplayObjectContainer = null, param2:Number = 0, param3:Number = 0)
        {
            super(param1, param2, param3);
            resize(400, 235);
            this.initp();
            this.initsocket();
            return;
        }// end function

        private function initsocket() : void
        {
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_GR_JION, this.jionsuss);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_GR_ENTER, this.insuss);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_GR_ENTER_WAR, this.entersuss);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_GR_PLRLIST, this.getlistp);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_GR_EVENT, this.grevent);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_GR_LEFT, this.leftwar);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_GR_STATUS, this.onlinegrevent);
            return;
        }// end function

        private function initp()
        {
            this.title = Config.language("BigWar", 1);
            this.scorePanel = new Sprite();
            this.addChild(this.scorePanel);
            return;
        }// end function

        public function onwar(param1 = null) : void
        {
            var _loc_2:* = new Array();
            var _loc_3:* = [Config.language("BigWar", 2)];
            var _loc_4:* = [Config.language("BigWar", 3)];
            var _loc_5:* = [Config.language("BigWar", 4), Config.language("BigWar", 5)];
            if (Config.map._type == 11)
            {
                _loc_2 = _loc_5;
            }
            else if (!this.whetherjion)
            {
                _loc_2 = _loc_3;
            }
            else
            {
                _loc_2 = _loc_4;
            }
            DropDown.dropDown(_loc_2, this.bigwarclick);
            if (param1 == null)
            {
                DropDown._dropDown.x = Config.ui.mouseX + 10;
            }
            else
            {
                DropDown._dropDown.x = Config.ui.mouseX - 80;
                DropDown._dropDown.y = Config.ui.mouseY + 10;
            }
            return;
        }// end function

        public function warLogin(param1:String, param2:String) : void
        {
            var _loc_3:* = new Array();
            var _loc_4:* = [];
            var _loc_5:* = [Config.language("BigWar", 2), Config.language("BigWar", 10)];
            var _loc_6:* = [Config.language("BigWar", 3), Config.language("BigWar", 10)];
            var _loc_7:* = [Config.language("BigWar", 4), Config.language("BigWar", 5), Config.language("BigWar", 10)];
            if (Config.map._type == 11)
            {
                _loc_3 = _loc_7;
                _loc_4 = [this.lookscorepanel, this.surexitwar, null];
            }
            else if (!this.whetherjion)
            {
                _loc_3 = _loc_5;
                _loc_4 = [this.warbm, null];
            }
            else
            {
                _loc_3 = _loc_6;
                _loc_4 = [this.inbigwar, null];
            }
            AlertUI.alert(param1, Config.language("BigWar", 25, param1, param2), _loc_3, _loc_4);
            return;
        }// end function

        private function warbm(param1 = null) : void
        {
            var _loc_2:* = null;
            if (Config.player.level >= 40)
            {
                _loc_2 = new DataSet();
                _loc_2.addHead(CONST_ENUM.C2G_GR_JION);
                ClientSocket.send(_loc_2);
            }
            else
            {
                Config.message(Config.language("BigWar", 6));
            }
            return;
        }// end function

        private function bigwarclick(param1) : void
        {
            if (param1 == 0)
            {
                if (Config.map._type == 11)
                {
                    this.lookscorepanel();
                }
                else if (!this.whetherjion)
                {
                    this.warbm();
                }
                else
                {
                    this.inbigwar();
                }
            }
            else if (param1 == 1)
            {
                this.surexitwar();
            }
            return;
        }// end function

        private function cancelwar(event:MouseEvent = null)
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_GR_LEFT);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function surexitwar(param1 = null)
        {
            AlertUI.alert(Config.language("BigWar", 7), Config.language("BigWar", 8), [Config.language("BigWar", 9), Config.language("BigWar", 10)], [this.cancelwar]);
            return;
        }// end function

        private function jionsuss(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            if (_loc_3 == 0)
            {
                this.whetherjion = true;
                Config.message(Config.language("BigWar", 11));
            }
            else
            {
                Config.message(Config._codeWords[WordsType.TYPEID_ERR][_loc_3]);
            }
            return;
        }// end function

        private function lookscorepanel(param1 = null) : void
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_GR_PLRLIST);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function getlistp(event:SocketEvent)
        {
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            this.open();
            this.removeAllChildren(this.scorePanel);
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            this.temppagearr = [];
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_6 = new Object();
                _loc_7 = _loc_2.readUnsignedInt();
                _loc_8 = _loc_2.readUnsignedShort();
                _loc_6.playerName = _loc_2.readUTFBytes(_loc_8);
                _loc_6.killNum = _loc_2.readUnsignedInt();
                _loc_6.death = _loc_2.readUnsignedInt();
                _loc_6.hert = _loc_2.readUnsignedInt();
                _loc_6.getther = _loc_2.readUnsignedInt();
                this.temppagearr.push(_loc_6);
                _loc_4 = _loc_4 + 1;
            }
            var _loc_5:* = [{datafield:"playerName", label:Config.language("BigWar", 12), len:100}, {datafield:"killNum", label:Config.language("BigWar", 13), len:60}, {datafield:"death", label:Config.language("BigWar", 14), len:60}, {datafield:"hert", label:Config.language("BigWar", 15), len:65}, {datafield:"getther", label:Config.language("BigWar", 16), len:80}];
            this.datalist = new DataGridUI(_loc_5, this.scorePanel, 15, 25, 365, 170);
            this.datalist.dataProvider = this.temppagearr;
            return;
        }// end function

        private function invateinwar() : void
        {
            if (this._waralert != null)
            {
                AlertUI.remove(this._waralert);
            }
            this._waralert = AlertUI.alert(Config.language("BigWar", 17), Config.language("BigWar", 18), [Config.language("BigWar", 19), Config.language("BigWar", 10)], [this.inbigwar]);
            return;
        }// end function

        private function inbigwar(event:Event = null) : void
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_GR_ENTER);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function insuss(event:SocketEvent) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = undefined;
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            if (_loc_3 == 0)
            {
                this.teamId = _loc_2.readUnsignedInt();
                this.tim = _loc_2.readUnsignedInt();
                _loc_4 = new Date();
                _loc_5 = _loc_4.setTime(this.tim * 1000);
                trace(this.tim, "tim", _loc_4, _loc_5);
                Config.ui._bwscorepanel.openscPanel(this.tim);
                this.whetherjion = false;
            }
            else
            {
                Config.message(Config._codeWords[WordsType.TYPEID_ERR][_loc_3]);
            }
            return;
        }// end function

        public function npcTalkEnterWar(param1:int, param2:Array, param3:Function = null)
        {
            param2.push({label:Config.language("BigWar", 20), handler:this.enterbigwar, closeflag:true});
            return;
        }// end function

        private function enterbigwar(param1 = null) : void
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_GR_ENTER_WAR);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function entersuss(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            if (_loc_3 > 0)
            {
                Config.message(Config._codeWords[WordsType.TYPEID_ERR][_loc_3]);
            }
            return;
        }// end function

        private function grevent(event:SocketEvent) : void
        {
            var _loc_2:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = false;
            var _loc_8:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_11:* = 0;
            var _loc_12:* = 0;
            var _loc_13:* = 0;
            var _loc_14:* = 0;
            var _loc_15:* = 0;
            var _loc_16:* = 0;
            var _loc_17:* = 0;
            var _loc_18:* = null;
            var _loc_19:* = 0;
            var _loc_20:* = 0;
            _loc_2 = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            switch(_loc_3)
            {
                case 1:
                {
                    this.whetherjion = false;
                    break;
                }
                case 2:
                {
                    this.enterFlag = true;
                    this.invateinwar();
                    break;
                }
                case 3:
                {
                    if (this._waralert != null)
                    {
                        AlertUI.remove(this._waralert);
                    }
                    Config.message(Config.language("BigWar", 21));
                    break;
                }
                case 4:
                {
                    this.open();
                    this.removeAllChildren(this.scorePanel);
                    this.temppagearr = [];
                    _loc_4 = _loc_2.readUnsignedInt();
                    _loc_17 = 0;
                    while (_loc_17 < _loc_4)
                    {
                        
                        _loc_18 = new Object();
                        _loc_19 = _loc_2.readUnsignedInt();
                        _loc_10 = _loc_2.readUnsignedShort();
                        _loc_18.playerName = _loc_2.readUTFBytes(_loc_10);
                        _loc_18.killNum = _loc_2.readUnsignedInt();
                        _loc_18.death = _loc_2.readUnsignedInt();
                        _loc_18.hert = _loc_2.readUnsignedInt();
                        _loc_18.getther = _loc_2.readUnsignedInt();
                        _loc_18.susScore = _loc_2.readUnsignedInt();
                        _loc_18.susExp = _loc_2.readUnsignedInt();
                        this.temppagearr.push(_loc_18);
                        trace(_loc_18.susScore, _loc_18.susExp);
                        _loc_17++;
                    }
                    _loc_5 = [{datafield:"playerName", label:Config.language("BigWar", 12), len:70}, {datafield:"killNum", label:Config.language("BigWar", 13), len:40}, {datafield:"death", label:Config.language("BigWar", 14), len:40}, {datafield:"hert", label:Config.language("BigWar", 15), len:50}, {datafield:"getther", label:Config.language("BigWar", 16), len:60}, {datafield:"susScore", label:Config.language("BigWar", 22), len:40}, {datafield:"susExp", label:Config.language("BigWar", 23), len:65}];
                    this.datalist = new DataGridUI(_loc_5, this.scorePanel, 15, 25, 365, 170);
                    this.datalist.dataProvider = this.temppagearr;
                    _loc_6 = new PushButton(this.scorePanel, 170, 205, Config.language("BigWar", 24), this.cancelwar);
                    _loc_6.width = 60;
                    break;
                }
                case 5:
                {
                    _loc_7 = false;
                    _loc_8 = new Object();
                    _loc_9 = _loc_2.readUnsignedInt();
                    _loc_10 = _loc_2.readUnsignedShort();
                    _loc_8.playerName = _loc_2.readUTFBytes(_loc_10);
                    _loc_8.killNum = _loc_2.readUnsignedInt();
                    _loc_8.death = _loc_2.readUnsignedInt();
                    _loc_8.hert = _loc_2.readUnsignedInt();
                    _loc_8.getther = _loc_2.readUnsignedInt();
                    if (this.temppagearr == null)
                    {
                        return;
                    }
                    _loc_20 = 0;
                    while (_loc_20 < this.temppagearr.length)
                    {
                        
                        if (_loc_8.playerName == this.temppagearr[_loc_20].playerName)
                        {
                            this.temppagearr[_loc_20].playerName = _loc_8.playerName;
                            this.temppagearr[_loc_20].killNum = _loc_8.killNum;
                            this.temppagearr[_loc_20].death = _loc_8.death;
                            this.temppagearr[_loc_20].hert = _loc_8.hert;
                            this.temppagearr[_loc_20].getther = _loc_8.getther;
                            _loc_7 = true;
                            break;
                        }
                        _loc_20 = _loc_20 + 1;
                    }
                    if (!_loc_7)
                    {
                        this.temppagearr.push(_loc_8);
                    }
                    break;
                }
                case 6:
                {
                    _loc_11 = _loc_2.readUnsignedInt();
                    _loc_12 = _loc_2.readUnsignedInt();
                    _loc_13 = _loc_2.readUnsignedInt();
                    _loc_14 = _loc_2.readUnsignedInt();
                    _loc_15 = _loc_2.readUnsignedInt();
                    _loc_16 = _loc_2.readUnsignedInt();
                    Config.ui._bwscorepanel.openscPanel();
                    this.teamId = Config.player.warTeam;
                    Config.ui._bwscorepanel.addbwpanel(this.teamId, _loc_13, _loc_12, _loc_16, _loc_15);
                    break;
                }
                case 7:
                {
                    Config.ui._bwscorepanel.socketrelife();
                    break;
                }
                case 9:
                {
                    this.tim = _loc_2.readUnsignedInt();
                    Config.ui._bwscorepanel.openscPanel(this.tim);
                    this.teamId = Config.player.warTeam;
                    Config.ui._bwscorepanel.addbwpanel(this.teamId, 0, 0, 0, 0);
                    break;
                }
                case 10:
                {
                    this.enterFlag = false;
                    this.btnFlag = true;
                    Config.ui._radar.addwarbtn();
                    break;
                }
                case 11:
                {
                    this.btnFlag = false;
                    Config.ui._radar.removewarbtn();
                    break;
                }
                case 12:
                {
                    if (!this.enterFlag && this.btnFlag)
                    {
                        this.btnFlag = false;
                        Config.ui._radar.removewarbtn();
                    }
                    break;
                }
                case 13:
                {
                    if (Config.map._type != 11 && !this.enterFlag && this.btnFlag)
                    {
                        this.btnFlag = false;
                        Config.ui._radar.removewarbtn();
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function leftwar(event:SocketEvent) : void
        {
            this.btnFlag = false;
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            Config.ui._bwscorepanel.close();
            this.close();
            Config.ui._radar.removewarbtn();
            return;
        }// end function

        private function onlinegrevent(event:SocketEvent)
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readByte();
            var _loc_4:* = _loc_2.readByte();
            if (_loc_3 == 1)
            {
                if (_loc_4 == 0)
                {
                    this.whetherjion = false;
                }
                else if (_loc_4 == 1)
                {
                    this.whetherjion = true;
                }
                Config.ui._radar.addwarbtn();
            }
            return;
        }// end function

        private function removeAllChildren(param1:Sprite) : void
        {
            while (param1.numChildren > 0)
            {
                
                param1.removeChildAt((param1.numChildren - 1));
            }
            return;
        }// end function

        public function reShowName() : void
        {
            var _loc_2:* = undefined;
            var _loc_1:* = Unit.getPlayerlist();
            for (_loc_2 in _loc_1)
            {
                
                _loc_1[_loc_2].warTeam = _loc_1[_loc_2].warTeam;
            }
            return;
        }// end function

    }
}
