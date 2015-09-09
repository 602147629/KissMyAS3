package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import lovefox.component.*;
    import lovefox.socket.*;
    import lovefox.unit.*;

    public class TeamPanel extends Window
    {
        private var teamarr:Array;
        private var scenearr:Array;
        private var mapTeamArr:Array;
        private var teamobj:Object;
        private var leaderarr:Array;
        private var leadericon2:Sprite;
        private var teamexp:CheckBox;
        private var teamitem:CheckBox;
        private var autore:CheckBox;
        private var teamMemData:DataGridUI;
        private var senceData:DataGridUI;
        private var removeBtn:PushButton;
        private var leaderBtn:PushButton;
        private var leftBtn:PushButton;
        private var madeBtn:PushButton;
        public var autoLoginRb:CheckBox;
        private var typeaRb:RadioButton;
        private var typebRb:RadioButton;
        private var reTeamBtn:PushButton;
        private var refreshBtn:PushButton;
        private var pageCount:int = 10;

        public function TeamPanel(param1:DisplayObjectContainer)
        {
            this.leaderarr = new Array();
            super(param1);
            this.teamobj = new Object();
            this.init();
            return;
        }// end function

        override public function open(event:MouseEvent = null)
        {
            super.open();
            this.scenefuc();
            return;
        }// end function

        override public function testGuide()
        {
            return;
        }// end function

        private function addbg() : void
        {
            var _loc_1:* = new Shape();
            this.addChild(_loc_1);
            _loc_1.graphics.beginFill(13545363);
            _loc_1.graphics.drawRect(10, 25, 320, 140);
            _loc_1.graphics.drawRect(10, 230, 320, 180);
            _loc_1.graphics.endFill();
            return;
        }// end function

        private function initpanel() : void
        {
            this.addbg();
            var _loc_1:* = [{datafield:"name", label:Config.language("TeamPanel", 1), len:110}, {datafield:"level", label:Config.language("TeamPanel", 2), len:60}, {datafield:"jobname", label:Config.language("TeamPanel", 3), len:70}, {datafield:"rightstr", label:Config.language("TeamPanel", 4), len:80}];
            var _loc_2:* = [{datafield:"name", label:Config.language("TeamPanel", 1), len:90}, {datafield:"level", label:Config.language("TeamPanel", 2), len:40}, {datafield:"jobname", label:Config.language("TeamPanel", 3), len:70}, {datafield:"countstr", label:Config.language("TeamPanel", 5), len:60}, {datafield:"pickstr", label:Config.language("TeamPanel", 6), len:60}];
            this.teamMemData = new DataGridUI(_loc_1, this, 10, 25, 320, 140);
            this.senceData = new DataGridUI(_loc_2, this, 10, 230, 320, 180);
            this.removeBtn = new PushButton(this, 10, 170, Config.language("TeamPanel", 7), Config.create(this.teamMemberFuc, true));
            this.removeBtn.width = 70;
            this.leaderBtn = new PushButton(this, 90, 170, Config.language("TeamPanel", 8), Config.create(this.teamMemberFuc, false));
            this.leaderBtn.width = 70;
            this.leftBtn = new PushButton(this, 170, 170, Config.language("TeamPanel", 9), this.sendmemberleft);
            this.leftBtn.width = 70;
            this.madeBtn = new PushButton(this, 250, 170, Config.language("TeamPanel", 10), this.createTeam);
            this.madeBtn.width = 70;
            this.autoLoginRb = new CheckBox(this, 10, 205, Config.language("TeamPanel", 11), this.autoModeFuc);
            this.autoLoginRb.visible = false;
            this.autore = new CheckBox(this, 10, 205, Config.language("TeamPanel", 79), this.autoModeFuc);
            this.autore.visible = true;
            var _loc_3:* = new Label(this, 120, 200, Config.language("TeamPanel", 12));
            this.typeaRb = new RadioButton(this, 180, 205, Config.language("TeamPanel", 13), true, Config.create(this.pickupModeFuc, 0));
            this.typeaRb.group = "itemstatus";
            this.typebRb = new RadioButton(this, 250, 205, Config.language("TeamPanel", 14), false, Config.create(this.pickupModeFuc, 1));
            this.typebRb.group = "itemstatus";
            this.reTeamBtn = new PushButton(this, 90, 420, Config.language("TeamPanel", 15), this.handlelogin);
            this.reTeamBtn.width = 70;
            this.refreshBtn = new PushButton(this, 180, 420, Config.language("TeamPanel", 16), this.scenefuc);
            this.refreshBtn.width = 70;
            this.scenearr = new Array();
            return;
        }// end function

        private function init() : void
        {
            this.title = Config.language("TeamPanel", 17);
            resize(340, 450);
            this.initpanel();
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_TEAM_CREATE_TEAM, this.backCreateTeam);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_TEAM_INVITE, this.getrequest);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_TEAM_APPLY, this.teamApply);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_TEAM_MEMBERS_INFO, this.accpettream);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_TEAM_ADD, this.addmember);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_TEAM_QUIT, Config.create(this.leftmember, 0));
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_TEAM_REMOVE, Config.create(this.leftmember, 1));
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_MEMBER_OFF_LINE, Config.create(this.leftmember, 2));
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_TEAM_DESTROY, this.teamDestroy);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_TEAM_APPOINT_LEADER, Config.create(this.getleader, 0));
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_TEAM_CHANGE_MAP, this.mapChangeFuc);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_TEAM_PICKUP_MODE, this.backPickupModeFuc);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_TEAM_APPROVAL_MODE, this.backAutoModeFuc);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_TEAM_IFO_FROM_MAP, this.backMapTeam);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_TEAM_REJECT_INVITATION, Config.create(this.appToPlayer, 0));
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_TEAM_REJECT_APPLICATION, Config.create(this.appToPlayer, 1));
            this.teamarr = new Array();
            this.leadericon2 = new Sprite();
            var _loc_1:* = new Bitmap(Config.findsysUI("team/flag", 19, 20));
            this.leadericon2.addChild(_loc_1);
            this.leadericon2.x = 10;
            this.leadericon2.y = 15;
            this.leadericon2.mouseChildren = false;
            this.leadericon2.mouseEnabled = false;
            this.teamexp = new CheckBox(null, 5, 80, Config.language("TeamPanel", 18), Config.create(this.sendshare, 1));
            this.teamitem = new CheckBox(null, 5, 100, Config.language("TeamPanel", 19), Config.create(this.sendshare, 0));
            this.teamexp.textColor = 16777215;
            this.teamitem.textColor = 16777215;
            return;
        }// end function

        public function loginInit() : void
        {
            this.setPanelRight(0);
            this.scenefuc();
            return;
        }// end function

        private function scenefuc(event:MouseEvent = null) : void
        {
            this.mapTeamArr = [];
            this.mapTeam();
            return;
        }// end function

        private function sendshare(event:MouseEvent, param2:int) : void
        {
            var _loc_3:* = new DataSet();
            _loc_3.addHead(CONST_ENUM.CMSG_TEAM_LOOT_METHOD);
            if (param2 == 1)
            {
                if (this.teamexp.selected)
                {
                    _loc_3.add8(0);
                }
                else
                {
                    _loc_3.add8(1);
                }
            }
            else if (this.teamitem.selected)
            {
                _loc_3.add8(0);
            }
            else
            {
                _loc_3.add8(1);
            }
            _loc_3.add8(param2);
            ClientSocket.send(_loc_3);
            return;
        }// end function

        private function backshare(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readByte();
            var _loc_4:* = _loc_2.readByte();
            if (_loc_2.readByte() == 1)
            {
                if (_loc_3 == 0)
                {
                    this.teamexp.selected = true;
                }
                else
                {
                    this.teamexp.selected = false;
                }
            }
            else if (_loc_3 == 0)
            {
                this.teamitem.selected = true;
            }
            else
            {
                this.teamitem.selected = false;
            }
            return;
        }// end function

        public function createTeam(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            if (event.currentTarget.enabled)
            {
                _loc_2 = new DataSet();
                _loc_2.addHead(CONST_ENUM.C2G_TEAM_CREATE_TEAM);
                ClientSocket.send(_loc_2);
            }
            return;
        }// end function

        private function backCreateTeam(event:SocketEvent) : void
        {
            this.autoLoginRb.visible = true;
            this.autore.visible = false;
            var _loc_2:* = event.data;
            this.teamobj.teamid = _loc_2.readUnsignedInt();
            this.teamobj.leaderId = Config.player._id;
            this.teamobj.num = 1;
            this.teamobj.pickUpMode = 1;
            this.teamobj.auto = 1;
            this.changePickMode(this.teamobj.pickUpMode);
            this.playerteam();
            this.autoLoginRb.selected = true;
            Config.ui._fbEntranceUI.handleTeamCreate();
            return;
        }// end function

        private function autoModeFuc(event:MouseEvent) : void
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_TEAM_APPROVAL_MODE);
            if (this.autoLoginRb.selected)
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

        private function backAutoModeFuc(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readByte();
            if (_loc_3 == 1)
            {
                this.autoLoginRb.selected = true;
                Config.ui._fbEntranceUI._3autoLoginRb.selected = true;
            }
            else
            {
                this.autoLoginRb.selected = false;
                Config.ui._fbEntranceUI._3autoLoginRb.selected = false;
            }
            return;
        }// end function

        private function pickupModeFuc(event:MouseEvent, param2:int) : void
        {
            var _loc_3:* = null;
            if (this.typeaRb.enabled)
            {
                _loc_3 = new DataSet();
                _loc_3.addHead(CONST_ENUM.C2G_TEAM_PICKUP_MODE);
                _loc_3.add8(param2);
                ClientSocket.send(_loc_3);
            }
            return;
        }// end function

        private function backPickupModeFuc(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readByte();
            this.teamobj.pickUpMode = _loc_3;
            this.changePickMode(_loc_3);
            return;
        }// end function

        private function changePickMode(param1:int) : void
        {
            if (param1 == 0)
            {
                this.typeaRb.selected = true;
                this.typebRb.selected = false;
                Config.ui._fbEntranceUI._3typeaRb.selected = true;
                Config.ui._fbEntranceUI._3typebRb.selected = false;
            }
            else
            {
                this.typeaRb.selected = false;
                this.typebRb.selected = true;
                Config.ui._fbEntranceUI._3typeaRb.selected = false;
                Config.ui._fbEntranceUI._3typebRb.selected = true;
            }
            return;
        }// end function

        public function inviteTeam(param1:int) : void
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_TEAM_INVITE);
            _loc_2.add32(param1);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        public function backInviteTeam(param1) : void
        {
            switch(param1)
            {
                case 0:
                {
                    Config.message(Config.language("TeamPanel", 20));
                    break;
                }
                case 1:
                {
                    Config.message(Config.language("TeamPanel", 21));
                    break;
                }
                case 201:
                {
                    Config.message(Config.language("TeamPanel", 22));
                    break;
                }
                case 202:
                {
                    Config.message(Config.language("TeamPanel", 23));
                    break;
                }
                case 212:
                {
                    Config.message(Config.language("TeamPanel", 78));
                    break;
                }
                case 213:
                {
                    Config.message(Config.language("TeamPanel", 25));
                    break;
                }
                case 216:
                {
                    Config.message(Config.language("TeamPanel", 26));
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function getrequest(event:SocketEvent) : void
        {
            var _loc_12:* = null;
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            var _loc_4:* = _loc_2.readUnsignedInt();
            var _loc_5:* = _loc_2.readUnsignedShort();
            var _loc_6:* = _loc_2.readUTFBytes(_loc_5);
            var _loc_7:* = _loc_2.readUnsignedInt();
            var _loc_8:* = _loc_2.readUnsignedInt();
            var _loc_9:* = _loc_2.readUnsignedInt();
            var _loc_10:* = Config.language("TeamPanel", 80);
            if (_loc_9 > 0)
            {
                _loc_10 = Config.language("TeamPanel", 81, Config._fbInfo[_loc_9].level, Config._fbInfo[_loc_9].name);
            }
            var _loc_11:* = new Object();
            new Object().type = 3;
            _loc_11.fname = _loc_6;
            _loc_11.title = Config.language("TeamPanel", 27);
            _loc_11.msg = Config.language("TeamPanel", 28, "LV" + _loc_7 + Config._jobTitleMap[_loc_8], _loc_6, _loc_10);
            _loc_11.btns = [Config.language("TeamPanel", 29), Config.language("TeamPanel", 30)];
            _loc_11.funcs = [this.sendokmsg, this.sendcancelmsg];
            _loc_11.d = {rename:_loc_6, teamid:_loc_3, playerid:_loc_4};
            _loc_11.backfuc = this.sendcancelmsg;
            if (this.autore.visible && this.autore.selected)
            {
                _loc_12 = new DataSet();
                _loc_12.addHead(CONST_ENUM.C2G_TEAM_REPLAY_INVITATION);
                _loc_12.add8(1);
                _loc_12.add32(_loc_3);
                _loc_12.add32(_loc_4);
                ClientSocket.send(_loc_12);
            }
            else if (Config.disturbMode)
            {
                ListTip.addList(_loc_11);
            }
            else
            {
                AlertUI.alert(Config.language("TeamPanel", 27), Config.language("TeamPanel", 28, "LV" + _loc_7 + Config._jobTitleMap[_loc_8], _loc_6, _loc_10), [Config.language("TeamPanel", 29), Config.language("TeamPanel", 30)], [this.sendokmsg, this.sendcancelmsg], {rename:_loc_6, teamid:_loc_3, playerid:_loc_4}, false, true, false, null, true);
            }
            return;
        }// end function

        private function sendokmsg(param1) : void
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_TEAM_REPLAY_INVITATION);
            _loc_2.add8(1);
            _loc_2.add32(param1.teamid);
            _loc_2.add32(param1.playerid);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        public function sendcancelmsg(param1) : void
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_TEAM_REPLAY_INVITATION);
            _loc_2.add8(0);
            _loc_2.add32(param1.teamid);
            _loc_2.add32(param1.playerid);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        public function backLoginAtion(param1:int) : void
        {
            switch(param1)
            {
                case 201:
                {
                    Config.message(Config.language("TeamPanel", 33));
                    break;
                }
                case 204:
                {
                    Config.message(Config.language("TeamPanel", 34));
                    break;
                }
                case 219:
                {
                    Config.message(Config.language("TeamPanel", 35));
                    break;
                }
                case 220:
                {
                    Config.message(Config.language("TeamPanel", 36));
                    break;
                }
                case 202:
                {
                    Config.message(Config.language("TeamPanel", 37));
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function backteamno(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedShort();
            var _loc_4:* = _loc_2.readUTFBytes(_loc_3);
            return;
        }// end function

        private function teamMemberFuc(event:MouseEvent, param2:Boolean) : void
        {
            if (this.removeBtn.enabled || this.leaderBtn.enabled)
            {
                if (this.teamMemData.rowIndex != -1)
                {
                    if (param2)
                    {
                        this.sendRemove(this.teamarr[this.teamMemData.rowIndex].memberid);
                    }
                    else
                    {
                        this.sendLeader(this.teamarr[this.teamMemData.rowIndex].memberid);
                    }
                }
                else
                {
                    Config.message(Config.language("TeamPanel", 39));
                }
            }
            return;
        }// end function

        private function handlelogin(event:MouseEvent) : void
        {
            if (this.senceData.rowIndex != -1)
            {
                if (Config.player.teamflag)
                {
                    this.inviteTeam(this.mapTeamArr[this.senceData.rowIndex].playerId);
                }
                else
                {
                    this.reloginteam(this.mapTeamArr[this.senceData.rowIndex].playerId);
                }
            }
            else
            {
                Config.message(Config.language("TeamPanel", 40));
            }
            return;
        }// end function

        public function reloginteam(param1:int) : void
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_TEAM_APPLY);
            _loc_2.add32(param1);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        public function backReloginTeam(param1:int) : void
        {
            switch(param1)
            {
                case 0:
                {
                    Config.message(Config.language("TeamPanel", 41));
                    break;
                }
                case 1:
                {
                    Config.message(Config.language("TeamPanel", 42));
                    break;
                }
                case 201:
                {
                    Config.message(Config.language("TeamPanel", 43));
                    break;
                }
                case 202:
                {
                    Config.message(Config.language("TeamPanel", 37));
                    break;
                }
                case 203:
                {
                    Config.message(Config.language("TeamPanel", 44));
                    break;
                }
                case 209:
                {
                    Config.message(Config.language("TeamPanel", 45));
                    break;
                }
                case 210:
                {
                    Config.message(Config.language("TeamPanel", 46));
                    break;
                }
                case 212:
                {
                    Config.message(Config.language("TeamPanel", 78));
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function teamApply(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            var _loc_4:* = _loc_2.readUnsignedShort();
            var _loc_5:* = _loc_2.readUTFBytes(_loc_4);
            var _loc_6:* = _loc_2.readUnsignedInt();
            var _loc_7:* = _loc_2.readUnsignedInt();
            var _loc_8:* = _loc_2.readUnsignedInt();
            var _loc_9:* = Config.language("TeamPanel", 80);
            if (_loc_8 > 0)
            {
                _loc_9 = Config.language("TeamPanel", 81, Config._fbInfo[_loc_8].level, Config._fbInfo[_loc_8].name);
            }
            var _loc_10:* = new Object();
            new Object().type = 3;
            _loc_10.fname = _loc_5;
            _loc_10.title = Config.language("TeamPanel", 47);
            _loc_10.msg = Config.language("TeamPanel", 48, "LV" + _loc_6 + Config._jobTitleMap[_loc_7], _loc_5, _loc_9);
            _loc_10.btns = [Config.language("TeamPanel", 29), Config.language("TeamPanel", 30)];
            _loc_10.funcs = [this.sendApplyOk, this.sendApplyCancel];
            _loc_10.d = {rename:_loc_5, playerid:_loc_3};
            _loc_10.backfuc = this.sendApplyCancel;
            if (Config.disturbMode)
            {
                ListTip.addList(_loc_10);
            }
            else
            {
                AlertUI.alert(Config.language("TeamPanel", 47), Config.language("TeamPanel", 48, "LV" + _loc_6 + Config._jobTitleMap[_loc_7], _loc_5, _loc_9), [Config.language("TeamPanel", 29), Config.language("TeamPanel", 30)], [this.sendApplyOk, this.sendApplyCancel], {rename:_loc_5, playerid:_loc_3}, false, true, false, null, true);
            }
            return;
        }// end function

        private function sendApplyOk(param1) : void
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_TEAM_REPLAY_APPLICATION);
            _loc_2.add32(param1.playerid);
            _loc_2.add8(1);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        public function sendApplyCancel(param1) : void
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_TEAM_REPLAY_APPLICATION);
            _loc_2.add32(param1.playerid);
            _loc_2.add8(0);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        public function backApply(param1:int) : void
        {
            switch(param1)
            {
                case 1:
                {
                    Config.message(Config.language("TeamPanel", 49));
                    break;
                }
                case 201:
                {
                    Config.message(Config.language("TeamPanel", 77));
                    break;
                }
                case 205:
                {
                    Config.message(Config.language("TeamPanel", 50));
                    break;
                }
                case 203:
                {
                    Config.message(Config.language("TeamPanel", 51));
                    break;
                }
                case 220:
                {
                    Config.message(Config.language("TeamPanel", 36));
                    break;
                }
                case 208:
                {
                    Config.message(Config.language("TeamPanel", 52));
                    break;
                }
                case 219:
                {
                    Config.message(Config.language("TeamPanel", 53));
                    break;
                }
                case 202:
                {
                    Config.message(Config.language("TeamPanel", 37));
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function accpettream(event:SocketEvent) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            trace("accpettream");
            this.autoLoginRb.visible = true;
            this.autore.visible = false;
            var _loc_2:* = event.data;
            this.teamobj = new Object();
            this.teamobj.teamid = _loc_2.readUnsignedInt();
            this.teamobj.leaderId = _loc_2.readUnsignedInt();
            this.teamobj.num = _loc_2.readByte();
            this.teamobj.pickUpMode = _loc_2.readByte();
            this.teamobj.auto = _loc_2.readByte();
            var _loc_3:* = Unit.getPlayerlist();
            var _loc_4:* = 0;
            while (_loc_4 < this.teamobj.num)
            {
                
                _loc_5 = new Object();
                _loc_5.memberid = _loc_2.readUnsignedInt();
                _loc_6 = _loc_2.readUnsignedShort();
                _loc_5.name = _loc_2.readUTFBytes(_loc_6);
                _loc_5.job = _loc_2.readByte();
                _loc_5.jobname = Config._jobTitleMap[_loc_5.job];
                _loc_5.sex = _loc_2.readByte();
                _loc_5.mxhp = 0;
                _loc_5.hp = 0;
                _loc_5.mxmp = 0;
                _loc_5.mp = 0;
                _loc_5.line = _loc_2.readUnsignedInt();
                _loc_5.map = _loc_2.readUnsignedInt();
                _loc_5.level = _loc_2.readUnsignedShort();
                if (this.teamobj.leaderId == _loc_5.memberid)
                {
                    _loc_5.textcolor = 477447;
                }
                else
                {
                    _loc_5.textcolor = 6697728;
                    Config.message(Config.language("TeamPanel", 54));
                }
                for (_loc_7 in _loc_3)
                {
                    
                    if (_loc_5.memberid == _loc_3[_loc_7]._id)
                    {
                        _loc_5.mxhp = _loc_3[_loc_7].hpMax;
                        _loc_5.hp = _loc_3[_loc_7].hp;
                        _loc_5.mxmp = _loc_3[_loc_7].mpMax;
                        _loc_5.mp = _loc_3[_loc_7].mp;
                        break;
                    }
                }
                this.changePickMode(this.teamobj.pickUpMode);
                if (this.teamobj.auto == 1)
                {
                    this.autoLoginRb.selected = true;
                }
                else
                {
                    this.autoLoginRb.selected = false;
                }
                if (_loc_5.memberid == this.teamobj.leaderId)
                {
                    _loc_5.type = 3;
                }
                else
                {
                    _loc_5.type = 1;
                }
                if (_loc_5.memberid == Config.player.id)
                {
                    this.teamobj.right = _loc_5.type;
                }
                this.teamarr.push(_loc_5);
                _loc_4 = _loc_4 + 1;
            }
            if (Config.player != null)
            {
                this.playerteam();
            }
            return;
        }// end function

        public function playerteam() : void
        {
            var _loc_1:* = false;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            if (this.teamobj.hasOwnProperty("leaderId") && Config.player != null)
            {
                _loc_1 = true;
                _loc_2 = 0;
                _loc_3 = 0;
                while (_loc_3 < this.teamarr.length)
                {
                    
                    if (this.teamarr[_loc_3].memberid == Config.player._id)
                    {
                        _loc_1 = false;
                        _loc_2 = _loc_3;
                    }
                    if (this.teamarr[_loc_3].memberid == this.teamobj.leaderId)
                    {
                        this.teamarr[_loc_3].type = 3;
                    }
                    else
                    {
                        this.teamarr[_loc_3].type = 1;
                    }
                    _loc_3 = _loc_3 + 1;
                }
                if (_loc_1)
                {
                    _loc_6 = new Object();
                    _loc_6.memberid = Config.player._id;
                    _loc_6.name = Config.player.name;
                    _loc_6.sex = Config.player.sex;
                    _loc_6.level = Config.player.level;
                    _loc_6.mp = Config.player.mp;
                    _loc_6.mxmp = Config.player.mpMax;
                    _loc_6.hp = Config.player.hp;
                    _loc_6.mxhp = Config.player.hpMax;
                    _loc_6.job = Config.player.job;
                    _loc_6.jobname = Config._jobTitleMap[_loc_6.job];
                    this.teamarr.push(_loc_6);
                    _loc_2 = this.teamarr.length - 1;
                    if (this.teamobj.leaderId == _loc_6.memberid)
                    {
                        _loc_6.textcolor = 477447;
                    }
                    else
                    {
                        _loc_6.textcolor = 6697728;
                        Config.message(Config.language("TeamPanel", 54));
                    }
                }
                if (String(Config.player.id) == String(this.teamobj.leaderId))
                {
                    this.teamobj.right = 3;
                    this.teamarr[_loc_2].type = 3;
                    this.setPanelRight(3);
                }
                else
                {
                    this.teamobj.right = 1;
                    this.teamarr[_loc_2].type = 1;
                    this.setPanelRight(1);
                }
                _loc_4 = this.teamarr.length - 1;
                while (_loc_4 >= 0)
                {
                    
                    this.delmemberpanel(_loc_4);
                    _loc_4 = _loc_4 - 1;
                }
                this.setdata();
                _loc_5 = 0;
                while (_loc_5 < this.leaderarr.length)
                {
                    
                    if (Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_PLAYER, this.leaderarr[_loc_5]) != null)
                    {
                        Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_PLAYER, this.leaderarr[_loc_5]).teamflag = true;
                    }
                    _loc_5 = _loc_5 + 1;
                }
            }
            return;
        }// end function

        private function setPanelRight(param1:int = 0) : void
        {
            if (param1 == 3)
            {
                this.removeBtn.enabled = true;
                this.leaderBtn.enabled = true;
                this.leftBtn.enabled = true;
                this.madeBtn.enabled = false;
                this.autoLoginRb.enabled = true;
                this.typeaRb.enabled = true;
                this.typebRb.enabled = true;
                Config.ui._fbEntranceUI._3teamPB1.enabled = true;
                Config.ui._fbEntranceUI._3teamPB2.enabled = true;
                Config.ui._fbEntranceUI._3teamPB3.enabled = true;
                Config.ui._fbEntranceUI._3autoLoginRb.enabled = true;
                Config.ui._fbEntranceUI._3typeaRb.enabled = true;
                Config.ui._fbEntranceUI._3typebRb.enabled = true;
                this.reTeamBtn.enabled = true;
                this.reTeamBtn.label = Config.language("TeamPanel", 55);
            }
            else if (param1 == 1)
            {
                this.removeBtn.enabled = false;
                this.leaderBtn.enabled = false;
                this.leftBtn.enabled = true;
                this.madeBtn.enabled = false;
                this.autoLoginRb.enabled = false;
                this.typeaRb.enabled = false;
                this.typebRb.enabled = false;
                Config.ui._fbEntranceUI._3teamPB1.enabled = false;
                Config.ui._fbEntranceUI._3teamPB2.enabled = false;
                Config.ui._fbEntranceUI._3teamPB3.enabled = true;
                Config.ui._fbEntranceUI._3autoLoginRb.enabled = false;
                Config.ui._fbEntranceUI._3typeaRb.enabled = false;
                Config.ui._fbEntranceUI._3typebRb.enabled = false;
                this.reTeamBtn.enabled = false;
                this.reTeamBtn.label = Config.language("TeamPanel", 56);
            }
            else
            {
                this.removeBtn.enabled = false;
                this.leaderBtn.enabled = false;
                this.leftBtn.enabled = false;
                this.madeBtn.enabled = true;
                this.autoLoginRb.enabled = false;
                this.typeaRb.enabled = false;
                this.typebRb.enabled = false;
                Config.ui._fbEntranceUI._3teamPB1.enabled = false;
                Config.ui._fbEntranceUI._3teamPB2.enabled = false;
                Config.ui._fbEntranceUI._3teamPB3.enabled = false;
                Config.ui._fbEntranceUI._3autoLoginRb.enabled = false;
                Config.ui._fbEntranceUI._3typeaRb.enabled = false;
                Config.ui._fbEntranceUI._3typebRb.enabled = false;
                this.reTeamBtn.enabled = true;
                this.reTeamBtn.label = Config.language("TeamPanel", 56);
            }
            return;
        }// end function

        private function setdata() : void
        {
            var _loc_1:* = 0;
            while (_loc_1 < this.teamarr.length)
            {
                
                this.addmemberpanel(_loc_1);
                _loc_1 = _loc_1 + 1;
            }
            this.showLeaderStr();
            this.teamMemData.dataProvider = this.teamarr;
            Config.ui._fbEntranceUI.refreshTeam();
            return;
        }// end function

        private function showLeaderStr() : void
        {
            var _loc_1:* = 0;
            while (_loc_1 < this.teamarr.length)
            {
                
                if (this.teamarr[_loc_1].type == 3)
                {
                    this.teamarr[_loc_1].rightstr = Config.language("TeamPanel", 57);
                }
                else
                {
                    this.teamarr[_loc_1].rightstr = Config.language("TeamPanel", 58);
                }
                _loc_1 = _loc_1 + 1;
            }
            return;
        }// end function

        private function addmemberpanel(param1:int) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            if (this.teamarr[param1].memberid != Player._playerId)
            {
                _loc_2 = new TeamHeadUI(this.teamobj, this.teamarr[param1]);
                container.addChild(_loc_2);
                _loc_2.x = 0;
                this.teamarr[param1].icon = _loc_2;
                if (Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_PLAYER, this.teamarr[param1].memberid) == null)
                {
                    this.teamarr[param1].icon.alpha = 0.4;
                }
                _loc_3 = new Sprite();
                this.teamarr[param1].bmpd1 = Config.findsysUI("team/break", 25, 23);
                _loc_4 = new Bitmap(this.teamarr[param1].bmpd1);
                _loc_3.addChild(_loc_4);
                this.teamarr[param1].onlineicon = _loc_3;
                if (this.teamarr[param1].type == 3)
                {
                    _loc_6 = new Sprite();
                    this.teamarr[param1].bmpd2 = Config.findsysUI("team/flag", 19, 20);
                    _loc_4 = new Bitmap(this.teamarr[param1].bmpd2);
                    _loc_6.addChild(_loc_4);
                    _loc_6.y = 25;
                    _loc_6.x = 16;
                    _loc_6.mouseChildren = false;
                    _loc_6.mouseEnabled = false;
                    container.addChild(_loc_6);
                    this.teamarr[param1].leadericon = _loc_6;
                }
                _loc_2.y = param1 * 60 + 120;
                if (this.teamarr[param1].type == 3)
                {
                    _loc_6.y = param1 * 60 + 140;
                }
                _loc_5 = 0;
                while (_loc_5 < this.teamarr.length)
                {
                    
                    if (this.teamarr[_loc_5].memberid == Player._playerId)
                    {
                        if (_loc_5 > param1)
                        {
                            _loc_2.y = param1 * 60 + 120;
                            if (this.teamarr[param1].type == 3)
                            {
                                _loc_6.y = param1 * 60 + 140;
                            }
                        }
                        else
                        {
                            _loc_2.y = (param1 - 1) * 60 + 120;
                            if (this.teamarr[param1].type == 3)
                            {
                                _loc_6.y = (param1 - 1) * 60 + 125;
                            }
                        }
                        break;
                    }
                    _loc_5 = _loc_5 + 1;
                }
            }
            else if (this.teamarr[param1].type == 3)
            {
                container.addChild(this.leadericon2);
                this.teamexp.enabled = true;
                this.teamitem.enabled = true;
            }
            return;
        }// end function

        private function addmember(event:SocketEvent) : void
        {
            var _loc_6:* = null;
            var _loc_9:* = null;
            var _loc_10:* = 0;
            this.autoLoginRb.visible = true;
            this.autore.visible = false;
            Config.ui._playerHead.teamOn();
            var _loc_2:* = event.data;
            var _loc_3:* = new Object();
            _loc_3.memberid = _loc_2.readUnsignedInt();
            var _loc_4:* = _loc_2.readUnsignedShort();
            _loc_3.name = _loc_2.readUTFBytes(_loc_4);
            _loc_3.job = _loc_2.readByte();
            _loc_3.jobname = Config._jobTitleMap[_loc_3.job];
            _loc_3.sex = _loc_2.readByte();
            _loc_3.mxhp = 0;
            _loc_3.hp = 0;
            _loc_3.mxmp = 0;
            _loc_3.mp = 0;
            _loc_3.line = _loc_2.readUnsignedInt();
            _loc_3.map = _loc_2.readUnsignedInt();
            _loc_3.level = _loc_2.readUnsignedShort();
            if (this.teamobj.leaderId == _loc_3.memberid)
            {
                _loc_3.textcolor = 477447;
            }
            else
            {
                _loc_3.textcolor = 6697728;
            }
            var _loc_5:* = Unit.getPlayerlist();
            for (_loc_6 in _loc_5)
            {
                
                if (_loc_3.memberid == _loc_5[_loc_6]._id)
                {
                    _loc_3.mxhp = _loc_5[_loc_6].hpMax;
                    _loc_3.hp = _loc_5[_loc_6].hp;
                    _loc_3.mxmp = _loc_5[_loc_6].mpMax;
                    _loc_3.mp = _loc_5[_loc_6].mp;
                    break;
                }
            }
            if (_loc_3.memberid == this.teamobj.leaderId)
            {
                _loc_3.type = 3;
            }
            else
            {
                _loc_3.type = 1;
            }
            var _loc_7:* = true;
            var _loc_8:* = 0;
            while (_loc_8 < this.teamarr.length)
            {
                
                if (this.teamarr[_loc_8].memberid == _loc_3.memberid)
                {
                    this.teamarr[_loc_8] = _loc_3;
                    _loc_7 = false;
                    break;
                }
                _loc_8 = _loc_8 + 1;
            }
            if (_loc_7)
            {
                this.teamarr.push(_loc_3);
                var _loc_11:* = this.teamobj;
                var _loc_12:* = this.teamobj.num + 1;
                _loc_11.num = _loc_12;
                _loc_9 = Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_PLAYER, _loc_3.memberid);
                if (_loc_9 != null)
                {
                    Config.ui._radar.addUnit(_loc_9);
                }
            }
            if (Config.player != null)
            {
                this.teamarr.sort(this.order);
                _loc_10 = this.teamarr.length - 1;
                while (_loc_10 >= 0)
                {
                    
                    this.delmemberpanel(_loc_10);
                    _loc_10 = _loc_10 - 1;
                }
                this.setdata();
            }
            this.mapTeam();
            if (Config.player.id != _loc_3.memberid)
            {
                Config.message(_loc_3.name + Config.language("TeamPanel", 59));
            }
            else
            {
                Config.message(Config.language("TeamPanel", 54));
            }
            return;
        }// end function

        private function leftmember(event:SocketEvent, param2:int) : void
        {
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_3:* = event.data;
            var _loc_4:* = _loc_3.readUnsignedInt();
            var _loc_5:* = _loc_3.readUnsignedShort();
            var _loc_6:* = _loc_3.readUTFBytes(_loc_5);
            if (Player._playerId != _loc_4)
            {
                _loc_7 = 0;
                while (_loc_7 < this.teamarr.length)
                {
                    
                    if (this.teamarr[_loc_7].name == _loc_6)
                    {
                        _loc_9 = this.teamarr[_loc_7].memberid;
                        this.delmemberpanel(_loc_7);
                        this.teamarr.splice(_loc_7, 1);
                        var _loc_11:* = this.teamobj;
                        var _loc_12:* = this.teamobj.num - 1;
                        _loc_11.num = _loc_12;
                        _loc_10 = Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_PLAYER, _loc_9);
                        if (_loc_10 != null)
                        {
                            Config.ui._radar.addUnit(_loc_10);
                        }
                        break;
                    }
                    _loc_7 = _loc_7 + 1;
                }
                _loc_8 = this.teamarr.length - 1;
                while (_loc_8 >= 0)
                {
                    
                    this.delmemberpanel(_loc_8);
                    _loc_8 = _loc_8 - 1;
                }
                this.setdata();
                if (param2 == 0)
                {
                    Config.message(Config.language("TeamPanel", 60, _loc_6));
                }
                else if (param2 == 1)
                {
                    if (Config.player.id == this.teamobj.leaderId)
                    {
                        Config.message(Config.language("TeamPanel", 61, _loc_6));
                    }
                    else
                    {
                        Config.message(Config.language("TeamPanel", 62, _loc_6));
                    }
                }
                Config.ui._fbEntranceUI.refreshTeam();
            }
            else
            {
                this.autoLoginRb.visible = false;
                this.autore.visible = true;
                Config.ui._playerHead.teamOff();
                _loc_8 = this.teamarr.length - 1;
                while (_loc_8 >= 0)
                {
                    
                    _loc_9 = this.teamarr[_loc_8].memberid;
                    this.delmemberpanel(_loc_8);
                    this.teamarr.splice(_loc_8, 1);
                    var _loc_11:* = this.teamobj;
                    var _loc_12:* = this.teamobj.num - 1;
                    _loc_11.num = _loc_12;
                    _loc_10 = Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_PLAYER, _loc_9);
                    if (_loc_10 != null)
                    {
                        Config.ui._radar.addUnit(_loc_10);
                    }
                    _loc_8 = _loc_8 - 1;
                }
                this.teamobj = {};
                this.teamarr = [];
                this.teamMemData.dataProvider = [];
                this.setPanelRight(0);
                if (param2 == 0)
                {
                    Config.message(Config.language("TeamPanel", 63));
                }
                else if (param2 == 1)
                {
                    Config.message(Config.language("TeamPanel", 64));
                }
                Config.ui._fbEntranceUI.quitTeam();
            }
            this.mapTeam();
            return;
        }// end function

        private function teamDestroy(event:SocketEvent) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            Config.ui._playerHead.teamOff();
            var _loc_2:* = this.teamarr.length - 1;
            while (_loc_2 >= 0)
            {
                
                _loc_3 = this.teamarr[_loc_2].memberid;
                this.delmemberpanel(_loc_2);
                this.teamarr.splice(_loc_2, 1);
                var _loc_5:* = this.teamobj;
                var _loc_6:* = this.teamobj.num - 1;
                _loc_5.num = _loc_6;
                _loc_4 = Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_PLAYER, _loc_3);
                if (_loc_4 != null)
                {
                    Config.ui._radar.addUnit(_loc_4);
                }
                _loc_2 = _loc_2 - 1;
            }
            this.teamobj = {};
            this.teamarr = [];
            this.teamMemData.dataProvider = [];
            this.setPanelRight(0);
            Config.ui._fbEntranceUI.quitTeam();
            return;
        }// end function

        public function sendmemberleft(event:MouseEvent = null) : void
        {
            if (event.currentTarget.enabled)
            {
                if (Config.mapId > 1000000000)
                {
                    AlertUI.alert(Config.language("TeamPanel", 82), Config.language("TeamPanel", 83), [Config.language("TeamPanel", 29), Config.language("TeamPanel", 32)], [this.cleft]);
                }
                else
                {
                    this.cleft();
                }
            }
            return;
        }// end function

        private function cleft(param1 = null) : void
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_TEAM_QUIT);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        public function backSendMemberLeft(param1:int) : void
        {
            switch(param1)
            {
                case 203:
                {
                    Config.message(Config.language("TeamPanel", 51));
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function teamdestroyed(event:MouseEvent = null) : void
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.CMSG_TEAM_DESTROYED);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        public function sendRemove(param1:int) : void
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_TEAM_REMOVE);
            _loc_2.add32(param1);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        public function backSendRemove(param1:int) : void
        {
            switch(param1)
            {
                case 203:
                {
                    Config.message(Config.language("TeamPanel", 51));
                    break;
                }
                case 208:
                {
                    Config.message(Config.language("TeamPanel", 52));
                    break;
                }
                case 1:
                {
                    Config.message(Config.language("TeamPanel", 65));
                    break;
                }
                case 214:
                {
                    Config.message(Config.language("TeamPanel", 66));
                    break;
                }
                case 218:
                {
                    Config.message(Config.language("TeamPanel", 67));
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function sendLeader(param1:int) : void
        {
            if (param1 == Config.player.id)
            {
                Config.message(Config.language("TeamPanel", 68));
                return;
            }
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_TEAM_APPOINT_LEADER);
            _loc_2.add32(param1);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        public function backSendLeader(param1:int) : void
        {
            switch(param1)
            {
                case 203:
                {
                    Config.message(Config.language("TeamPanel", 51));
                    break;
                }
                case 208:
                {
                    Config.message(Config.language("TeamPanel", 52));
                    break;
                }
                case 1:
                {
                    Config.message(Config.language("TeamPanel", 65));
                    break;
                }
                case 214:
                {
                    Config.message(Config.language("TeamPanel", 66));
                    break;
                }
                case 223:
                {
                    Config.message(Config.language("TeamPanel", 68));
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function getleader(event:SocketEvent, param2:int) : void
        {
            var _loc_3:* = event.data;
            var _loc_4:* = _loc_3.readUnsignedInt();
            this.teamobj.leaderId = _loc_3.readUnsignedInt();
            var _loc_5:* = _loc_3.readUnsignedShort();
            this.teamobj.leader = _loc_3.readUTFBytes(_loc_5);
            this.teamobj.right = 1;
            var _loc_6:* = 0;
            while (_loc_6 < this.teamarr.length)
            {
                
                if (this.teamarr[_loc_6].memberid == this.teamobj.leaderId)
                {
                    this.teamarr[_loc_6].type = 3;
                }
                else
                {
                    this.teamarr[_loc_6].type = 1;
                }
                if (this.teamarr[_loc_6].memberid == Config.player.id)
                {
                    this.teamobj.right = this.teamarr[_loc_6].type;
                    this.setPanelRight(this.teamobj.right);
                }
                _loc_6 = _loc_6 + 1;
            }
            this.teamarr.sort(this.order);
            var _loc_7:* = this.teamarr.length - 1;
            while (_loc_7 >= 0)
            {
                
                this.delmemberpanel(_loc_7);
                _loc_7 = _loc_7 - 1;
            }
            this.setdata();
            return;
        }// end function

        private function mapChangeFuc(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            var _loc_4:* = 0;
            while (_loc_4 < this.teamarr.length)
            {
                
                if (this.teamarr[_loc_4].memberid == _loc_3)
                {
                    this.teamarr[_loc_4].map = _loc_2.readUnsignedInt();
                    this.teamarr[_loc_4].line = _loc_2.readUnsignedInt();
                    if (this.teamarr[_loc_4].memberid != Player._playerId)
                    {
                        this.teamarr[_loc_4].icon.update(this.teamarr[_loc_4].hp, this.teamarr[_loc_4].mxhp, this.teamarr[_loc_4].mp, this.teamarr[_loc_4].mxmp, this.teamarr[_loc_4].level);
                    }
                    break;
                }
                _loc_4 = _loc_4 + 1;
            }
            return;
        }// end function

        public function teamMemberInit(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int) : void
        {
            var _loc_7:* = 0;
            while (_loc_7 < this.teamarr.length)
            {
                
                if (this.teamarr[_loc_7].memberid == param1)
                {
                    this.teamarr[_loc_7].hp = param2;
                    this.teamarr[_loc_7].mxhp = param3;
                    this.teamarr[_loc_7].mp = param4;
                    this.teamarr[_loc_7].mxmp = param5;
                    this.teamarr[_loc_7].level = param6;
                    if (param1 != Config.player.id)
                    {
                        this.teamarr[_loc_7].icon.update(param2, param3, param4, param5, param6);
                    }
                    break;
                }
                _loc_7 = _loc_7 + 1;
            }
            this.teamMemData.dataProvider = this.teamarr;
            Config.ui._fbEntranceUI.refreshTeam();
            return;
        }// end function

        public function teamUpdate(param1:int, param2:int, param3:int) : void
        {
            var _loc_4:* = false;
            var _loc_5:* = 0;
            while (_loc_5 < this.teamarr.length)
            {
                
                switch(param2)
                {
                    case 4:
                    {
                        break;
                    }
                    case 5:
                    {
                        break;
                    }
                    case 6:
                    {
                        break;
                    }
                    case 7:
                    {
                        break;
                    }
                    case 8:
                    {
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                if (param1 != Config.player.id)
                {
                }
            }
            if (_loc_4)
            {
                this.teamMemData.dataProvider = this.teamarr;
                Config.ui._fbEntranceUI.refreshTeam();
            }
            return;
        }// end function

        private function delmemberpanel(param1:int) : void
        {
            if (param1 < 0)
            {
                return;
            }
            if (this.teamarr[param1].icon != null)
            {
                if (this.teamarr[param1].icon.parent != null)
                {
                    container.removeChild(this.teamarr[param1].icon);
                    this.teamarr[param1].icon.destroy();
                    this.teamarr[param1].icon = null;
                }
            }
            if (this.teamarr[param1].leadericon != null)
            {
                if (this.teamarr[param1].leadericon.parent != null)
                {
                    container.removeChild(this.teamarr[param1].leadericon);
                    this.teamarr[param1].leadericon = null;
                }
            }
            if (this.leadericon2 != null)
            {
                if (this.leadericon2.parent != null)
                {
                    container.removeChild(this.leadericon2);
                }
            }
            if (this.teamexp.parent != null)
            {
                this.teamexp.enabled = false;
                this.teamitem.enabled = false;
            }
            return;
        }// end function

        public function get teaminfor() : Object
        {
            var _loc_1:* = false;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            while (_loc_3 < this.teamarr.length)
            {
                
                if (this.teamarr[_loc_3].memberid == Player._playerId)
                {
                    _loc_1 = true;
                    _loc_2 = _loc_3;
                }
                _loc_3 = _loc_3 + 1;
            }
            if (_loc_1)
            {
                return this.teamarr[_loc_2];
            }
            return null;
        }// end function

        private function teamerror(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readByte();
            switch(_loc_3)
            {
                case 0:
                {
                    break;
                }
                case 1:
                {
                    Config.message(Config.language("TeamPanel", 69));
                    break;
                }
                case 2:
                {
                    Config.message(Config.language("TeamPanel", 70));
                    break;
                }
                case 3:
                {
                    Config.message(Config.language("TeamPanel", 71));
                    break;
                }
                case 4:
                {
                    Config.message(Config.language("TeamPanel", 37));
                    break;
                }
                case 6:
                {
                    Config.message(Config.language("TeamPanel", 72));
                    break;
                }
                case 7:
                {
                    Config.message(Config.language("TeamPanel", 73));
                    break;
                }
                case 8:
                {
                    Config.message("");
                    break;
                }
                case 9:
                {
                    Config.message(Config.language("TeamPanel", 74));
                    break;
                }
                case 10:
                {
                    Config.message(Config.language("TeamPanel", 42));
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function create(param1:Function, ... args) : Function
        {
            args = new activation;
            var F:Boolean;
            var f:* = param1;
            var arg:* = args;
            F;
            var _f:* = function (param1) : void
            {
                var _loc_2:* = arg;
                if (!F)
                {
                    F = true;
                    _loc_2.unshift(param1);
                }
                f.apply(null, _loc_2);
                return;
            }// end function
            ;
            return ;
        }// end function

        private function order(param1:Object, param2:Object)
        {
            var _loc_3:* = int(param1.type);
            var _loc_4:* = int(param2.type);
            if (_loc_3 > _loc_4)
            {
                return -1;
            }
            if (_loc_3 < _loc_4)
            {
                return 1;
            }
            return 0;
        }// end function

        public function leaderFlag(param1:int, param2:int) : void
        {
            var _loc_3:* = 0;
            if (param2 == 1)
            {
                if (Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_PLAYER, param1) != null)
                {
                    Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_PLAYER, param1).teamflag = true;
                }
                this.leaderarr.push(param1);
            }
            else
            {
                if (Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_PLAYER, param1) != null)
                {
                    Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_PLAYER, param1).teamflag = false;
                }
                _loc_3 = 0;
                while (_loc_3 < this.leaderarr.length)
                {
                    
                    if (this.leaderarr[_loc_3] == param1)
                    {
                        this.leaderarr.splice(_loc_3, 1);
                        break;
                    }
                    _loc_3 = _loc_3 + 1;
                }
            }
            return;
        }// end function

        public function teamlen(param1:int, param2:Boolean) : void
        {
            var _loc_3:* = 0;
            while (_loc_3 < this.teamarr.length)
            {
                
                if (this.teamarr[_loc_3].memberid == param1 && Config.player.id != param1)
                {
                    if (param2)
                    {
                        if (this.teamarr[_loc_3].icon != null)
                        {
                            this.teamarr[_loc_3].icon.alpha = 1;
                        }
                    }
                    else
                    {
                        if (this.teamarr[_loc_3].icon != null)
                        {
                            this.teamarr[_loc_3].icon.alpha = 0.4;
                        }
                        if (Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_PLAYER, param1) != null)
                        {
                            Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_PLAYER, param1).teamflag = false;
                        }
                    }
                    break;
                }
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

        public function teamoutlen(param1:int) : void
        {
            if (this.teamarr == null)
            {
                return;
            }
            var _loc_2:* = 0;
            while (_loc_2 < this.teamarr.length)
            {
                
                if (this.teamarr[_loc_2].memberid != param1)
                {
                    if (this.teamarr[_loc_2].icon != null)
                    {
                        this.teamarr[_loc_2].icon.alpha = 0.4;
                    }
                    if (Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_PLAYER, param1) != null)
                    {
                        Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_PLAYER, param1).teamflag = false;
                    }
                }
                _loc_2 = _loc_2 + 1;
            }
            this.scenefuc();
            return;
        }// end function

        private function memberstatus(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            var _loc_4:* = _loc_2.readByte();
            var _loc_5:* = 0;
            while (_loc_5 < this.teamarr.length)
            {
                
                switch(_loc_4)
                {
                    case 0:
                    {
                        if (this.teamarr[_loc_5].onlineicon.parent != null)
                        {
                        }
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
                    default:
                    {
                        break;
                        break;
                    }
                }
            }
            return;
        }// end function

        public function inTeam(param1:int) : Boolean
        {
            var _loc_3:* = 0;
            var _loc_2:* = false;
            if (this.teamarr != null)
            {
                _loc_3 = 0;
                while (_loc_3 < this.teamarr.length)
                {
                    
                    if (param1 == this.teamarr[_loc_3].memberid)
                    {
                        _loc_2 = true;
                        break;
                    }
                    _loc_3 = _loc_3 + 1;
                }
            }
            else
            {
                return false;
            }
            return _loc_2;
        }// end function

        public function get teamId() : int
        {
            if (this.teamobj.hasOwnProperty("teamid"))
            {
                return this.teamobj.teamid;
            }
            return 0;
        }// end function

        public function mapTeam() : void
        {
            var _loc_1:* = null;
            if (this.parent != null)
            {
                _loc_1 = new DataSet();
                _loc_1.addHead(CONST_ENUM.C2G_TEAM_IFO_FROM_MAP);
                ClientSocket.send(_loc_1);
            }
            return;
        }// end function

        private function backMapTeam(event:SocketEvent) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readByte();
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = new Object();
                _loc_5.playerId = _loc_2.readUnsignedInt();
                _loc_6 = _loc_2.readUnsignedShort();
                _loc_5.name = _loc_2.readUTFBytes(_loc_6);
                _loc_5.level = _loc_2.readUnsignedShort();
                _loc_5.job = _loc_2.readByte();
                _loc_5.jobname = Config._jobTitleMap[_loc_5.job];
                _loc_5.count = _loc_2.readByte();
                _loc_5.pickUpMode = _loc_2.readByte();
                if (_loc_5.count > 0)
                {
                    _loc_5.countstr = _loc_5.count + "/5";
                    _loc_5.textcolor = 491023;
                    if (_loc_5.pickUpMode == 0)
                    {
                        _loc_5.pickstr = Config.language("TeamPanel", 13);
                    }
                    else
                    {
                        _loc_5.pickstr = Config.language("TeamPanel", 14);
                    }
                }
                else
                {
                    _loc_5.countstr = " ";
                    _loc_5.textcolor = 1266301;
                    _loc_5.pickstr = " ";
                }
                _loc_7 = 0;
                while (_loc_7 < this.mapTeamArr.length)
                {
                    
                    if (this.mapTeamArr[_loc_7].playerId == _loc_5.playerId)
                    {
                        this.mapTeamArr.splice(_loc_7, 1);
                        break;
                    }
                    _loc_7 = _loc_7 + 1;
                }
                this.mapTeamArr.splice(0, 0, _loc_5);
                _loc_4 = _loc_4 + 1;
            }
            this.senceListShow();
            return;
        }// end function

        private function senceListShow() : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_1:* = 20;
            var _loc_2:* = 0;
            var _loc_3:* = new Array();
            if (this.teamobj.hasOwnProperty("leaderId"))
            {
                if (this.teamobj.right == 3)
                {
                    _loc_4 = 0;
                    while (_loc_4 < this.mapTeamArr.length)
                    {
                        
                        if (this.mapTeamArr[_loc_4].count == 0 && _loc_2 < _loc_1)
                        {
                            _loc_3.push(this.mapTeamArr[_loc_4]);
                            _loc_2 = _loc_2 + 1;
                        }
                        _loc_4 = _loc_4 + 1;
                    }
                }
                else
                {
                    _loc_5 = 0;
                    while (_loc_5 < this.mapTeamArr.length)
                    {
                        
                        if (_loc_5 < _loc_1)
                        {
                            _loc_3.push(this.mapTeamArr[_loc_5]);
                        }
                        _loc_5 = _loc_5 + 1;
                    }
                }
            }
            else
            {
                _loc_6 = 0;
                while (_loc_6 < this.mapTeamArr.length)
                {
                    
                    if (_loc_6 < _loc_1)
                    {
                        _loc_3.push(this.mapTeamArr[_loc_6]);
                    }
                    _loc_6 = _loc_6 + 1;
                }
            }
            this.senceData.dataProvider = _loc_3;
            return;
        }// end function

        private function appToPlayer(event:SocketEvent, param2:int) : void
        {
            var _loc_3:* = event.data;
            var _loc_4:* = _loc_3.readUnsignedInt();
            var _loc_5:* = _loc_3.readUnsignedShort();
            var _loc_6:* = _loc_3.readUTFBytes(_loc_5);
            if (param2 == 0)
            {
                Config.message(Config.language("TeamPanel", 75, _loc_6));
            }
            else
            {
                Config.message(Config.language("TeamPanel", 76, _loc_6));
            }
            return;
        }// end function

        public function getMemberName(param1:int) : String
        {
            var _loc_2:* = Config.player.name;
            var _loc_3:* = 0;
            while (_loc_3 < this.teamarr.length)
            {
                
                if (param1 == this.teamarr[_loc_3].memberid)
                {
                    _loc_2 = this.teamarr[_loc_3].name;
                }
                _loc_3 = _loc_3 + 1;
            }
            return _loc_2;
        }// end function

        public function getTeamArr() : Array
        {
            return this.teamarr;
        }// end function

    }
}
