package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;
    import lovefox.component.*;
    import lovefox.socket.*;

    public class GildPanel extends Window
    {
        private var mainpanel:Sprite;
        private var bpanel:Sprite;
        private var cpanel:Sprite;
        private var _gildid:int = 0;
        private var _mytype:int = 0;
        private var memberarr:Array;
        private var memberlistdata:DataGridUI;
        private var gildlistarr:Array;
        private var gildlistdata:DataGridUI;
        private var applylistarr:Array;
        private var applylistdata:DataGridUI;
        private var leaguelistarr:Array;
        private var leaguelistdata:DataGridUI;
        private var leaguedata:DataGridUI;
        private var _gildmoney:Number = 0;
        private var _price:int = 0;
        private var bgshape:Sprite;
        public var typenamearr:Array;
        private var allpage:int = 0;
        private var thispage:int = 0;
        private var subpanel:Window;
        private var spanel:Window;
        private var gildpanelobj:Object;
        private var gildinforobj:Object;
        private var leaguearr:Array;
        private var leagueflag:int = -1;
        private var online:CheckBox;
        private var membersortobj:Object;
        private var reMemSort:Object;
        private var gildsortobj:Object;
        private var pagelabel:TextField;
        private var repagelabel:TextField;
        private var repage:int = 1;
        private var reallpage:int = 1;
        private var _downgildtasknum:int = 0;
        private var chattoname:Object;
        private var chatWarObj:Object;
        private var typeBtnArr:Array;
        private var vsList:Array;
        private var vsdata:DataGridUI;
        private var gildTimer:Timer;
        private var templabel1:Label;
        private var templabel2:Label;
        private var gildNamePanel:Window;
        private var gildNmaeInput:InputText;
        private var _gildShopLevel:int = 1;
        private var _gildSource:int = 0;
        private var _gildlv:int = 0;

        public function GildPanel(param1:DisplayObjectContainer)
        {
            this.memberarr = new Array();
            this.leaguelistarr = [];
            this.chatWarObj = {};
            super(param1);
            this.initsocket();
            this.initpanel();
            return;
        }// end function

        override public function switchOpen() : void
        {
            super.switchOpen();
            if (this.parent != null)
            {
                if (this._gildid == 0)
                {
                    this.getgildlist();
                }
                else
                {
                    if (this.gildlistdata != null)
                    {
                        if (this.gildlistdata.parent != null)
                        {
                            this.getgildlist();
                        }
                    }
                    if (this.memberlistdata != null)
                    {
                        if (this.memberlistdata.parent.parent != null)
                        {
                            this.sendmemberlist();
                        }
                    }
                }
            }
            return;
        }// end function

        override public function close()
        {
            this.clearsub();
            super.close();
            Holder.closeInfo();
            return;
        }// end function

        private function initpanel() : void
        {
            resize(750, 450);
            this.title = Config.language("GildPanel", 1);
            this.typenamearr = ["", Config.language("GildPanel", 2), Config.language("GildPanel", 3), Config.language("GildPanel", 4), Config.language("GildPanel", 5)];
            this.membersortobj = {page:1, flag:3, sort:1, online:0, allpage:1};
            this.reMemSort = {page:1, flag:3, sort:2};
            this.gildsortobj = {page:1, flag:1, sort:0, allpage:1};
            this.pagelabel = Config.getSimpleTextField();
            this.pagelabel.defaultTextFormat = new TextFormat(null, 16, Style.WINDOW_FONT, true);
            this.repagelabel = Config.getSimpleTextField();
            this.repagelabel.defaultTextFormat = new TextFormat(null, 16, Style.WINDOW_FONT, true);
            this.bgshape = new Sprite();
            this.addChild(this.bgshape);
            this.mainpanel = new Sprite();
            this.addChild(this.mainpanel);
            this.gildpanelobj = new Object();
            this.templabel1 = new Label(null, 0, 0);
            this.templabel2 = new Label(null, 0, 0);
            var _loc_1:* = [{datafield:"name", label:Config.language("GildPanel", 6), len:120, childmc:"chatname"}, {datafield:"typename", label:Config.language("GildPanel", 7), len:70}, {datafield:"level", label:Config.language("GildPanel", 8), len:40}, {datafield:"jobname", label:Config.language("GildPanel", 9), len:50}, {datafield:"gamemoney", label:Config.language("GildPanel", 241), len:90}, {datafield:"gildSource", label:Config.language("GildPanel", 242), len:90}];
            if (Config._switchMobage)
            {
                this.memberlistdata = new DataGridUI(_loc_1, null, 270, 50, 460, 320);
            }
            else
            {
                this.memberlistdata = new DataGridUI(_loc_1, null, 270, 100, 460, 270);
            }
            this.memberlistdata.addEventListener(DataGridEvent.CLOMN_SORT, this.membersort);
            var _loc_2:* = [{datafield:"atkName", label:Config.language("GildPanel", 11), len:120, childmc:"atkNameSp"}, {datafield:"atkPoint", label:Config.language("GildPanel", 12), len:80}, {datafield:"vs", label:" ", len:30}, {datafield:"defPoint", label:Config.language("GildPanel", 12), len:80}, {datafield:"defName", label:Config.language("GildPanel", 13), len:80, childmc:"defNameSp"}, {datafield:"endTime", label:Config.language("GildPanel", 14), len:120, childmc:"endTime"}];
            this.vsdata = new DataGridUI(_loc_2, null, 10, 30, 510, 400);
            this.vsdata.addEventListener(DataGridEvent.ROW_ROLLOVER, this.vsdataRollOver);
            this.vsdata.addEventListener(DataGridEvent.ROW_ROLLOUT, this.vsdataRollOut);
            this.bpanel = new Sprite();
            this.mainpanel.addChild(this.bpanel);
            this.cpanel = new Sprite();
            this.mainpanel.addChild(this.cpanel);
            var _loc_3:* = new PushButton(null, 690, 70, Config.language("GildPanel", 15), this.changeedit);
            _loc_3.width = 30;
            this.gildpanelobj.editbtn = _loc_3;
            _loc_3.setTable("table18", "table31");
            _loc_3.textColor = Style.GOLD_FONT;
            _loc_3.color = 16777215;
            if (Config._switchMobage)
            {
                _loc_3.visible = false;
            }
            this.gildpanelobj.btn2 = new PushButton(null, 190, 70, Config.language("GildPanel", 16), this.upgildcheck);
            this.gildpanelobj.btn3 = new PushButton(null, 190, 140, Config.language("GildPanel", 17), this.donationpanel);
            this.gildpanelobj.btn4 = new PushButton(null, 190, 310, Config.language("GildPanel", 18), this.leaguelistpanel);
            this.gildpanelobj.btn5 = new PushButton(null, 190, 105, Config.language("GildPanel", 16), this.upShopcheck);
            this.gildpanelobj.btn6 = new PushButton(null, 190, 175, Config.language("GildPanel", 17), this.gildSourcePanel);
            this.gildpanelobj.btn7 = new PushButton(null, 25, 380, Config.language("GildPanel", 243), this.openGildShop);
            this.gildpanelobj.btn8 = new PushButton(null, 150, 380, Config.language("GildPanel", 244), this.donationpanel);
            this.gildpanelobj.btn9 = new PushButton(null, 190, 255, Config.language("GildPanel", 266), Config.ui._activePanel.openLandList);
            this.gildpanelobj.btn2.width = 40;
            this.gildpanelobj.btn3.width = 40;
            this.gildpanelobj.btn4.width = 40;
            this.gildpanelobj.btn5.width = 40;
            this.gildpanelobj.btn6.width = 40;
            this.gildpanelobj.btn7.width = 80;
            this.gildpanelobj.btn8.width = 80;
            this.gildpanelobj.btn9.width = 40;
            this.gildpanelobj.btn2.setTable("table18", "table31");
            this.gildpanelobj.btn2.textColor = Style.GOLD_FONT;
            this.gildpanelobj.btn2.color = 16777215;
            this.gildpanelobj.btn3.setTable("table18", "table31");
            this.gildpanelobj.btn3.textColor = Style.GOLD_FONT;
            this.gildpanelobj.btn3.color = 16777215;
            this.gildpanelobj.btn4.setTable("table18", "table31");
            this.gildpanelobj.btn4.textColor = Style.GOLD_FONT;
            this.gildpanelobj.btn4.color = 16777215;
            this.gildpanelobj.btn5.setTable("table18", "table31");
            this.gildpanelobj.btn5.textColor = Style.GOLD_FONT;
            this.gildpanelobj.btn5.color = 16777215;
            this.gildpanelobj.btn6.setTable("table18", "table31");
            this.gildpanelobj.btn6.textColor = Style.GOLD_FONT;
            this.gildpanelobj.btn6.color = 16777215;
            this.gildpanelobj.btn7.setTable("table18", "table31");
            this.gildpanelobj.btn7.textColor = Style.GOLD_FONT;
            this.gildpanelobj.btn7.color = 16777215;
            this.gildpanelobj.btn8.setTable("table18", "table31");
            this.gildpanelobj.btn8.textColor = Style.GOLD_FONT;
            this.gildpanelobj.btn8.color = 16777215;
            this.gildpanelobj.btn9.setTable("table18", "table31");
            this.gildpanelobj.btn9.textColor = Style.GOLD_FONT;
            this.gildpanelobj.btn9.color = 16777215;
            this.typeBtnArr = [{label:Config.language("GildPanel", 19), fuc:this.getdildtask}, {label:Config.language("GildPanel", 20), fuc:this.closegild}, {label:Config.language("GildPanel", 21), fuc:this.leavegild}, {label:Config.language("GildPanel", 22), fuc:this.changenamepanel}, {label:Config.language("GildPanel", 23), fuc:this.applypanel}, {label:Config.language("GildPanel", 24), fuc:this.seleteleader}, {label:Config.language("GildPanel", 25), fuc:this.gildlist}, {label:Config.language("GildPanel", 26), fuc:this.warlist}];
            var _loc_4:* = 0;
            while (_loc_4 < 8)
            {
                
                this.gildpanelobj["typeBtn" + _loc_4] = new PushButton(null, 0, 0, this.typeBtnArr[_loc_4].label, this.typeBtnArr[_loc_4].fuc);
                this.gildpanelobj["typeBtn" + _loc_4].width = 80;
                if (_loc_4 == 0)
                {
                    this.gildpanelobj["typeBtn" + _loc_4].width = 100;
                }
                else if (_loc_4 == 4)
                {
                    this.gildpanelobj["typeBtn" + _loc_4].width = 120;
                }
                _loc_4 = _loc_4 + 1;
            }
            this.gildTimer = new Timer(1000);
            this.gildTimer.addEventListener(TimerEvent.TIMER, this.timeUpdate);
            this.gildNamePanel = new Window(this.container, this.x + 50, this.y + 50);
            this.gildNamePanel.title = Config.language("GildPanel", 231);
            this.gildNamePanel.resize(250, 150);
            var _loc_5:* = new Label(this.gildNamePanel, 20, 35, Config.language("GildPanel", 232));
            new Label(this.gildNamePanel, 20, 35, Config.language("GildPanel", 232)).html = true;
            this.gildNmaeInput = new InputText(this.gildNamePanel, 50, 80, "");
            this.gildNmaeInput.maxChars = 8;
            this.gildNmaeInput.width = 120;
            if (Config._switchEnglish)
            {
                this.gildNmaeInput._tf.restrict = "^<>一-龥";
            }
            else
            {
                this.gildNmaeInput._tf.restrict = "^<>";
            }
            var _loc_6:* = new PushButton(this.gildNamePanel, 50, 110, Config.language("GildPanel", 233), this.gildNameCenter);
            new PushButton(this.gildNamePanel, 50, 110, Config.language("GildPanel", 233), this.gildNameCenter).width = 60;
            var _loc_7:* = new PushButton(this.gildNamePanel, 130, 110, Config.language("GildPanel", 234), this.gildNameCancel);
            new PushButton(this.gildNamePanel, 130, 110, Config.language("GildPanel", 234), this.gildNameCancel).width = 60;
            return;
        }// end function

        private function initsocket() : void
        {
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_GUILD_CREATE, this.backbuild);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_GUILD_INVITE, this.backinviteguild);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_GUILD_DECLINE, this.backcancelinvite);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_GUILD_REMOVE, this.backremovemember);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_GUILD_LEAVE, this.backleavgild);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_GUILD_MOTD, this.backgildmotd);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_GUILD_LEADER, this.backchangeleader);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_GUILD_CHANGE_RANK, this.backmemberright);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_GUILD_DISBAND, this.backdisgild);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.SMSG_GUILD_MEMBER_UPDATE, this.memberupdate);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_GUILD_GET_DETAIL, this.backdetail);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_GUILD_ROSTER, this.getmemberlist);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_GUILD_LIST, this.backgildlist);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_GUILD_COMMAND_RESULT, this.gildresult);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_GUILD_MEMBER_ADD, this.memberadd);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_GUILDINFO_TOVIEW, this.showothergild);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_GUILD_APPLY, this.backapply);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_GUILD_APPLY_LIST, this.backapplylist);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_BUY_GUILD_MONEY, this.backbugm);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_GUILD_DONATION, this.backdonation);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_GET_GUILDDAILY_REWARD, this.backreward);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_DELETE_GUILD_APPLY, this.backsetapply);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_ADD_ALIANECE_APPLY_LIST, this.backleaguelist);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_ALIANECE_LIST, this.backleague);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_GUILD_ENTER_REQ, this.backgildenter);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_GUILD_UPDATE, this.backgildchange);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_REOMVE_ALIANECE_APPLY, this.backallow);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_ADD_ALIANCE, this.backallowsuc);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_REMOVE_ALIANCE, this.backreleague);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_UPDATE_GUILD, this.backupgild);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_VS_DELEAR_WAR, this.backDelearWar);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_VS_LIST, this.backVsList);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_VS_UPDATE, this.warUpdate);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_VS_INFO, this.vsdataRollOverShow);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_CHANGEGNAME, this.backGildName);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_TERR_EXP, this.gildExpFuc);
            return;
        }// end function

        private function labelinit() : void
        {
            var _loc_28:* = null;
            this.removeallchild(this.mainpanel);
            var _loc_1:* = new Label(this.mainpanel, 25, 70, Config.language("GildPanel", 30));
            var _loc_2:* = new Label(this.mainpanel, 25, 105, Config.language("GildPanel", 245));
            var _loc_3:* = new Label(this.mainpanel, 25, 140, Config.language("GildPanel", 32));
            var _loc_4:* = new Label(this.mainpanel, 25, 175, Config.language("GildPanel", 246));
            var _loc_5:* = new Label(this.mainpanel, 25, 205, Config.language("GildPanel", 27));
            var _loc_6:* = new Label(this.mainpanel, 25, 230, Config.language("GildPanel", 28));
            var _loc_7:* = new Label(this.mainpanel, 25, 255, Config.language("GildPanel", 247));
            var _loc_8:* = new Label(this.mainpanel, 25, 280, Config.language("GildPanel", 29));
            var _loc_9:* = new Label(this.mainpanel, 25, 305, Config.language("GildPanel", 33));
            var _loc_10:* = new Label(this.mainpanel, 25, 355, Config.language("GildPanel", 248));
            var _loc_11:* = new Label(this.mainpanel, 25, 35, "");
            this.gildpanelobj.gildname = _loc_11;
            var _loc_12:* = new PushButton(this.mainpanel, 180, 35, Config.language("GildPanel", 240), this.openGildNmae);
            new PushButton(this.mainpanel, 180, 35, Config.language("GildPanel", 240), this.openGildNmae).width = 50;
            this.gildpanelobj.nameBtn = _loc_12;
            this.gildpanelobj.nameBtn.visible = false;
            this.gildpanelobj.nameBtn.setTable("table18", "table31");
            this.gildpanelobj.nameBtn.textColor = Style.GOLD_FONT;
            this.gildpanelobj.nameBtn.color = 16777215;
            var _loc_13:* = new LabelUI(this.mainpanel, 100, 205, "");
            this.gildpanelobj.chairman = _loc_13;
            var _loc_14:* = new LabelUI(this.mainpanel, 100, 230, "");
            this.gildpanelobj.memnum = _loc_14;
            var _loc_15:* = new LabelUI(this.mainpanel, 100, 280, "");
            this.gildpanelobj.residentid = _loc_15;
            var _loc_16:* = new LabelUI(this.mainpanel, 100, 70, "");
            this.gildpanelobj.level = _loc_16;
            var _loc_17:* = new LabelUI(this.mainpanel, 100, 140, "");
            this.gildpanelobj.gamemoney = _loc_17;
            var _loc_18:* = new LabelUI(this.mainpanel, 100, 305, "");
            this.gildpanelobj.leaguegild = _loc_18;
            var _loc_19:* = new LabelUI(this.mainpanel, 100, 105, "");
            this.gildpanelobj.shoplevel = _loc_19;
            var _loc_20:* = new LabelUI(this.mainpanel, 100, 175, "");
            this.gildpanelobj.resources = _loc_20;
            var _loc_21:* = new LabelUI(this.mainpanel, 100, 255, "");
            new LabelUI(this.mainpanel, 100, 255, "").textColor = Style.FONT_3int_Orange;
            this.gildpanelobj.landgrave = _loc_21;
            var _loc_22:* = new Label(this.mainpanel, 110, 355, "");
            new Label(this.mainpanel, 110, 355, "").textColor = Style.FONT_3int_Orange;
            this.gildpanelobj.gildCoin = _loc_22;
            var _loc_23:* = new ProgressBar(null, 55, 165);
            new ProgressBar(null, 55, 165).height = 15;
            _loc_23.width = 150;
            _loc_23.gradientFillDirection = Math.PI;
            _loc_23.roundCorner = 6;
            _loc_23.color = 15981107;
            _loc_23.subColor = 16750899;
            this.gildpanelobj.gildmoneybar = _loc_23;
            var _loc_24:* = new Label(null, 85, 165, "");
            new Label(null, 85, 165, "").textColor = 16315890;
            _loc_24.filters = [new GlowFilter(Style.WINDOW_FONT, 1, 3, 3, 10, 1)];
            this.gildpanelobj.gildmoney = _loc_24;
            _loc_24.mouseEnabled = false;
            var _loc_25:* = new Text(this.mainpanel, 270, 55);
            new Text(this.mainpanel, 270, 55).width = 460;
            _loc_25.height = 40;
            _loc_25.tf.maxChars = 50;
            this.gildpanelobj.notice = _loc_25;
            this.gildpanelobj.notice.editable = false;
            if (Config._switchMobage)
            {
                _loc_25.parent.removeChild(_loc_25);
            }
            else
            {
                _loc_28 = new Label(this.mainpanel, 270, 30, Config.language("GildPanel", 34));
            }
            var _loc_26:* = new PushButton(this.mainpanel, 455, 380, "<", Config.create(this.memberpage, -1));
            new PushButton(this.mainpanel, 455, 380, "<", Config.create(this.memberpage, -1)).width = 30;
            this.mainpanel.addChild(this.pagelabel);
            this.pagelabel.x = 485;
            this.pagelabel.y = 380;
            this.pagelabel.width = 42;
            this.pagelabel.autoSize = TextFieldAutoSize.CENTER;
            var _loc_27:* = new PushButton(this.mainpanel, 527, 380, ">", Config.create(this.memberpage, 1));
            new PushButton(this.mainpanel, 527, 380, ">", Config.create(this.memberpage, 1)).width = 30;
            this.online = new CheckBox(this.mainpanel, 270, 390, Config.language("GildPanel", 37), this.checkonline);
            this.online.selected = false;
            return;
        }// end function

        private function openGildNmae(event:MouseEvent) : void
        {
            this.gildNamePanel.switchOpen();
            return;
        }// end function

        private function gildNameCenter(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            if (String(this.gildNmaeInput.text).length == 0)
            {
                Config.message(Config.language("GildPanel", 235));
            }
            else
            {
                _loc_2 = new DataSet();
                _loc_2.addHead(CONST_ENUM.C2G_CHANGEGNAME);
                _loc_2.addUTF(this.gildNmaeInput.text);
                ClientSocket.send(_loc_2);
            }
            return;
        }// end function

        private function gildNameCancel(event:MouseEvent) : void
        {
            this.gildNamePanel.close();
            return;
        }// end function

        private function backGildName(event:SocketEvent) : void
        {
            var _loc_2:* = event.data.readUnsignedByte();
            var _loc_3:* = event.data.readUnsignedShort();
            var _loc_4:* = event.data.readUTFBytes(_loc_3);
            if (_loc_2 == 0)
            {
                this.gildNamePanel.close();
                this.gildpanelobj.gildname.text = _loc_4;
                this.gildpanelobj.gildname.x = (220 - this.gildpanelobj.gildname.width) / 2 + 20;
                this.gildpanelobj.nameBtn.visible = false;
            }
            else if (_loc_2 == 1)
            {
                AlertUI.alert(Config.language("GildPanel", 238), Config.language("GildPanel", 236), [Config.language("GildPanel", 239)]);
            }
            else
            {
                AlertUI.alert(Config.language("GildPanel", 238), Config.language("GildPanel", 237, _loc_2), [Config.language("GildPanel", 239)]);
            }
            return;
        }// end function

        private function backgild(event:MouseEvent = null) : void
        {
            this.bgshape.graphics.clear();
            this.removeallchild(this.mainpanel);
            this.removeallchild(this.bpanel);
            this.removeallchild(this.cpanel);
            this.mainpanel.addChild(this.bpanel);
            this.mainpanel.addChild(this.cpanel);
            this.setbg();
            this.labelinit();
            this.listpage();
            this.senddetail(this.gildid);
            this.hadgild();
            this.getleague();
            return;
        }// end function

        private function hadgild(event:MouseEvent = null) : void
        {
            if (this.bpanel != null)
            {
                this.mainpanel.addChild(this.bpanel);
            }
            if (this.cpanel != null)
            {
                this.mainpanel.addChild(this.cpanel);
            }
            var _loc_2:* = new Array();
            switch(this._mytype)
            {
                case 0:
                {
                    trace("000");
                    break;
                }
                case 1:
                {
                    _loc_2 = [0, 1, 3, 4, 5, 6, 7];
                    this.bpanel.addChild(this.gildpanelobj.editbtn);
                    this.bpanel.addChild(this.gildpanelobj.btn2);
                    this.bpanel.addChild(this.gildpanelobj.btn3);
                    this.bpanel.addChild(this.gildpanelobj.btn4);
                    this.bpanel.addChild(this.gildpanelobj.btn5);
                    this.bpanel.addChild(this.gildpanelobj.btn6);
                    this.bpanel.addChild(this.gildpanelobj.btn7);
                    this.bpanel.addChild(this.gildpanelobj.btn9);
                    break;
                }
                case 2:
                {
                    _loc_2 = [0, 2, 3, 4, 6, 7];
                    this.bpanel.addChild(this.gildpanelobj.editbtn);
                    this.bpanel.addChild(this.gildpanelobj.btn2);
                    this.bpanel.addChild(this.gildpanelobj.btn3);
                    this.bpanel.addChild(this.gildpanelobj.btn4);
                    this.bpanel.addChild(this.gildpanelobj.btn5);
                    this.bpanel.addChild(this.gildpanelobj.btn6);
                    this.bpanel.addChild(this.gildpanelobj.btn7);
                    this.bpanel.addChild(this.gildpanelobj.btn9);
                    break;
                }
                case 3:
                {
                    _loc_2 = [0, 2, 3, 4, 6, 7];
                    this.bpanel.addChild(this.gildpanelobj.btn3);
                    this.bpanel.addChild(this.gildpanelobj.btn6);
                    this.bpanel.addChild(this.gildpanelobj.btn7);
                    this.bpanel.addChild(this.gildpanelobj.btn9);
                    break;
                }
                case 4:
                {
                    _loc_2 = [0, 2, 6, 7];
                    this.bpanel.addChild(this.gildpanelobj.btn3);
                    this.bpanel.addChild(this.gildpanelobj.btn6);
                    this.bpanel.addChild(this.gildpanelobj.btn7);
                    this.bpanel.addChild(this.gildpanelobj.btn9);
                    break;
                }
                default:
                {
                    break;
                }
            }
            var _loc_3:* = 20;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_2.length)
            {
                
                this.bpanel.addChild(this.gildpanelobj["typeBtn" + _loc_2[_loc_4]]);
                this.gildpanelobj["typeBtn" + _loc_2[_loc_4]].x = _loc_3;
                this.gildpanelobj["typeBtn" + _loc_2[_loc_4]].y = 415 + 30 * int(_loc_4 / 7);
                _loc_3 = _loc_3 + (this.gildpanelobj["typeBtn" + _loc_2[_loc_4]].width + 5);
                _loc_4 = _loc_4 + 1;
            }
            return;
        }// end function

        private function setbg() : void
        {
            this.bgshape.graphics.clear();
            this.bgshape.graphics.beginFill(13418405, 1);
            this.bgshape.graphics.drawRoundRect(10, 25, 240, 380, 5);
            this.bgshape.graphics.drawRoundRect(260, 25, 480, 380, 5);
            this.bgshape.graphics.beginFill(16777215, 0.3);
            this.bgshape.graphics.drawRoundRect(20, 30, 220, 30, 5);
            this.bgshape.graphics.drawRoundRect(20, 65, 220, 30, 5);
            this.bgshape.graphics.drawRoundRect(20, 100, 220, 30, 5);
            this.bgshape.graphics.drawRoundRect(20, 135, 220, 30, 5);
            this.bgshape.graphics.drawRoundRect(20, 170, 220, 30, 5);
            this.bgshape.graphics.drawRoundRect(20, 205, 220, 20, 5);
            this.bgshape.graphics.drawRoundRect(20, 230, 220, 20, 5);
            this.bgshape.graphics.drawRoundRect(20, 255, 220, 20, 5);
            this.bgshape.graphics.drawRoundRect(20, 280, 220, 20, 5);
            this.bgshape.graphics.drawRoundRect(20, 305, 220, 45, 5);
            this.bgshape.graphics.drawRoundRect(20, 355, 220, 20, 5);
            this.bgshape.graphics.drawRoundRect(270, 50, 460, 45, 5);
            this.bgshape.graphics.endFill();
            return;
        }// end function

        private function setbg2() : void
        {
            this.bgshape.graphics.clear();
            this.bgshape.graphics.beginFill(13418405, 1);
            this.bgshape.graphics.drawRoundRect(10, 25, 240, 380, 5);
            this.bgshape.graphics.drawRoundRect(260, 25, 480, 380, 5);
            this.bgshape.graphics.beginFill(16777215, 0.3);
            this.bgshape.graphics.drawRoundRect(20, 30, 220, 30, 5);
            this.bgshape.graphics.drawRoundRect(20, 65, 220, 20, 5);
            this.bgshape.graphics.drawRoundRect(20, 90, 220, 20, 5);
            this.bgshape.graphics.drawRoundRect(20, 115, 220, 20, 5);
            this.bgshape.graphics.drawRoundRect(20, 140, 220, 20, 5);
            this.bgshape.graphics.drawRoundRect(20, 165, 220, 20, 5);
            this.bgshape.graphics.drawRoundRect(20, 190, 220, 20, 5);
            this.bgshape.graphics.drawRoundRect(20, 215, 220, 40, 5);
            this.bgshape.graphics.drawRoundRect(20, 280, 220, 120, 5);
            this.bgshape.graphics.endFill();
            return;
        }// end function

        private function nogild() : void
        {
            var _loc_2:* = null;
            this.bgshape.graphics.clear();
            this.removeallchild(this.mainpanel);
            var _loc_1:* = new Label(this.mainpanel, 50, 40, Config.language("GildPanel", 38));
            _loc_2 = new PushButton(this.mainpanel, 320, 40, Config.language("GildPanel", 39), this.talkcreate);
            _loc_2.width = 60;
            var _loc_3:* = new Label(this.mainpanel, 440, 40, Config.language("GildPanel", 40));
            var _loc_4:* = new InputText(this.mainpanel, 510, 40);
            _loc_2 = new PushButton(this.mainpanel, 630, 40, Config.language("GildPanel", 41), Config.create(this.findgildlist, _loc_4));
            _loc_2.width = 60;
            var _loc_5:* = [{datafield:"i", label:Config.language("GildPanel", 42), len:40}, {datafield:"name", label:Config.language("GildPanel", 43), len:150}, {datafield:"chairman", label:Config.language("GildPanel", 27), len:120}, {datafield:"level", label:Config.language("GildPanel", 30), len:60}, {datafield:"num", label:Config.language("GildPanel", 44), len:60}, {datafield:"pnum", label:Config.language("GildPanel", 45), len:60}, {datafield:"warflag", label:Config.language("GildPanel", 26), len:60}, {datafield:"regbtn", label:Config.language("GildPanel", 46), len:140, childmc:"regbtn"}];
            this.gildlistdata = new DataGridUI(_loc_5, this.mainpanel, 30, 70, 690, 325);
            this.gildlistdata.addEventListener(DataGridEvent.CLOMN_SORT, this.gildlistsort);
            this.mainpanel.addChild(this.pagelabel);
            this.pagelabel.x = 325;
            this.pagelabel.y = 410;
            this.pagelabel.width = 42;
            this.pagelabel.autoSize = TextFieldAutoSize.CENTER;
            var _loc_6:* = new PushButton(this.mainpanel, 260, 410, "<<", Config.create(this.gildpage, -2));
            new PushButton(this.mainpanel, 260, 410, "<<", Config.create(this.gildpage, -2)).width = 30;
            var _loc_7:* = new PushButton(this.mainpanel, 295, 410, "<", Config.create(this.gildpage, -1));
            new PushButton(this.mainpanel, 295, 410, "<", Config.create(this.gildpage, -1)).width = 30;
            var _loc_8:* = new PushButton(this.mainpanel, 367, 410, ">", Config.create(this.gildpage, 1));
            new PushButton(this.mainpanel, 367, 410, ">", Config.create(this.gildpage, 1)).width = 30;
            var _loc_9:* = new PushButton(this.mainpanel, 402, 410, ">>", Config.create(this.gildpage, 2));
            new PushButton(this.mainpanel, 402, 410, ">>", Config.create(this.gildpage, 2)).width = 30;
            var _loc_10:* = new Label(this.mainpanel, 470, 410, Config.language("GildPanel", 49));
            var _loc_11:* = new InputText(this.mainpanel, 520, 410);
            new InputText(this.mainpanel, 520, 410).width = 40;
            _loc_11.maxChars = 3;
            var _loc_12:* = new PushButton(this.mainpanel, 580, 410, Config.language("GildPanel", 50), Config.create(this.tmemberpage, _loc_11));
            new PushButton(this.mainpanel, 580, 410, Config.language("GildPanel", 50), Config.create(this.tmemberpage, _loc_11)).width = 60;
            return;
        }// end function

        private function findnpc(event:MouseEvent) : void
        {
            DistrictMap.goNpc(21001);
            return;
        }// end function

        private function listpage() : void
        {
            this.removeallchild(this.cpanel);
            this.cpanel.addChild(this.memberlistdata);
            this.sendmemberlist();
            return;
        }// end function

        private function clearsub(event:MouseEvent = null) : void
        {
            if (this.subpanel != null)
            {
                if (this.subpanel.parent != null)
                {
                    this.subpanel.parent.removeChild(this.subpanel);
                    this.subpanel = null;
                }
            }
            this.gildTimer.stop();
            return;
        }// end function

        private function sendmemberlist(event:MouseEvent = null) : void
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_GUILD_ROSTER);
            _loc_2.add8(this.membersortobj.page);
            _loc_2.add8(this.membersortobj.flag);
            _loc_2.add8(this.membersortobj.sort);
            _loc_2.add8(this.membersortobj.online);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function getmemberlist(event:SocketEvent) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            this.memberarr = new Array();
            var _loc_2:* = event.data;
            this.membersortobj.allpage = _loc_2.readByte();
            this.membersortobj.page = _loc_2.readByte();
            var _loc_3:* = _loc_2.readUnsignedShort();
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = new Object();
                _loc_5.id = _loc_2.readUnsignedInt();
                _loc_5.online = _loc_2.readUnsignedInt();
                _loc_6 = _loc_2.readUnsignedShort();
                _loc_5.name = _loc_2.readUTFBytes(_loc_6);
                _loc_5.type = _loc_2.readByte();
                _loc_5.typename = this.typenamearr[_loc_5.type];
                _loc_5.level = _loc_2.readUnsignedShort();
                _loc_5.job = _loc_2.readByte();
                _loc_5.jobname = Config._jobTitleMap[_loc_5.job];
                _loc_5.gildmoney = _loc_2.readUnsignedInt();
                _loc_5.gamemoney = _loc_2.readUnsignedInt();
                _loc_5.gildSource = _loc_2.readUnsignedInt();
                _loc_5.coinmc = new Sprite();
                _loc_7 = new Sprite();
                _loc_5.chatname = _loc_7;
                if (_loc_5.online != 0)
                {
                    _loc_5.textcolor = 6697728;
                }
                else
                {
                    _loc_5.textcolor = 6710886;
                }
                _loc_8 = new ClickLabel(_loc_7, 10, 0, _loc_5.name, Config.create(this.chatgildmem, _loc_5), true);
                _loc_8.clickColor([26367, 6837142]);
                _loc_9 = new Panel(_loc_5.coinmc, 10, 5);
                _loc_9.setSize(20, 8);
                _loc_9.color = 16763904;
                _loc_10 = new Panel(_loc_5.coinmc, 90, 5);
                _loc_10.setSize(10, 10);
                _loc_10.roundCorner = 10;
                _loc_10.color = 16763904;
                _loc_5.gildmoneylab = new Label(_loc_5.coinmc, 33, 0);
                _loc_5.gildmoneylab.text = Config.coinShow(_loc_5.gildmoney);
                _loc_5.gildmoneylab.textColor = _loc_5.textcolor;
                _loc_5.gamemoneylab = new Label(_loc_5.coinmc, 105, 0);
                _loc_5.gamemoneylab.text = Config.coinShow(_loc_5.gamemoney);
                _loc_5.gamemoneylab.textColor = _loc_5.textcolor;
                _loc_11 = new Sprite();
                if (this._mytype == 1 || this._mytype == 2)
                {
                    _loc_12 = new ClickLabel(_loc_11, 0, 0, Config.language("GildPanel", 51), Config.create(this.changemembtype, this.memberarr.length, _loc_5.id), true);
                    _loc_12.clickColor([26367, 6837142]);
                    _loc_13 = new ClickLabel(_loc_11, 90, 0, Config.language("GildPanel", 52), Config.create(this.delmem, _loc_5), true);
                    _loc_13.clickColor([26367, 6837142]);
                }
                _loc_5.makemc = _loc_11;
                this.memberarr.push(_loc_5);
                _loc_4 = _loc_4 + 1;
            }
            this.hadgild();
            this.pagelabel.text = this.membersortobj.page + "/" + this.membersortobj.allpage;
            this.memberlistdata.dataProvider = this.memberarr;
            return;
        }// end function

        private function chatgildmem(event:TextEvent, param2) : void
        {
            var _loc_3:* = param2.name;
            if (Config.player.name == _loc_3)
            {
                Config.message(Config.language("GildPanel", 53));
            }
            else
            {
                this.chattoname = param2;
                if (Config._switchMobage)
                {
                    if (this._mytype == 1 || this._mytype == 2)
                    {
                        DropDown.dropDown([Config.language("GildPanel", 55), Config.language("GildPanel", 51), Config.language("GildPanel", 52)], this.handleDropDownClick);
                    }
                    else
                    {
                        DropDown.dropDown([Config.language("GildPanel", 55)], this.handleDropDownClick);
                    }
                }
                else if (this._mytype == 1 || this._mytype == 2)
                {
                    DropDown.dropDown([Config.language("GildPanel", 54), Config.language("GildPanel", 55), Config.language("GildPanel", 56), Config.language("GildPanel", 51), Config.language("GildPanel", 52)], this.handleDropDownClick);
                }
                else
                {
                    DropDown.dropDown([Config.language("GildPanel", 54), Config.language("GildPanel", 55), Config.language("GildPanel", 56)], this.handleDropDownClick);
                }
            }
            return;
        }// end function

        private function handleDropDownClick(param1)
        {
            if (Config._switchMobage)
            {
                param1 = param1 + 1;
                if (param1 > 1)
                {
                    param1 = param1 + 1;
                }
            }
            if (param1 == 0)
            {
                Config.ui._chatUI.whisperTo(this.chattoname.name);
            }
            else if (param1 == 1)
            {
                Config.ui._teamUI.inviteTeam(this.chattoname.id);
            }
            else if (param1 == 2)
            {
                Config.ui._mailpanel.sendmailshow(null, this.chattoname.name);
                Config.ui._mailpanel.open();
            }
            else if (param1 == 3)
            {
                this.changemembtype(null, 0, this.chattoname.id);
            }
            else if (param1 == 4)
            {
                this.delmem(null, this.chattoname);
            }
            return;
        }// end function

        public function gildlist(param1) : void
        {
            var _loc_3:* = null;
            this.bgshape.graphics.clear();
            this.removeallchild(this.mainpanel);
            var _loc_2:* = new Label(this.mainpanel, 50, 40, Config.language("GildPanel", 57));
            _loc_3 = new PushButton(this.mainpanel, 320, 40, Config.language("GildPanel", 58), this.backgild);
            _loc_3.width = 60;
            var _loc_4:* = new Label(this.mainpanel, 440, 40, Config.language("GildPanel", 40));
            var _loc_5:* = new InputText(this.mainpanel, 510, 40);
            new InputText(this.mainpanel, 510, 40).maxChars = 10;
            _loc_3 = new PushButton(this.mainpanel, 630, 40, Config.language("GildPanel", 41), Config.create(this.findgildlist, _loc_5));
            _loc_3.width = 60;
            var _loc_6:* = [{datafield:"i", label:Config.language("GildPanel", 42), len:40}, {datafield:"name", label:Config.language("GildPanel", 43), len:150}, {datafield:"chairman", label:Config.language("GildPanel", 27), len:120}, {datafield:"level", label:Config.language("GildPanel", 30), len:60}, {datafield:"num", label:Config.language("GildPanel", 28), len:60}, {datafield:"pnum", label:Config.language("GildPanel", 45), len:60}, {datafield:"warflag", label:Config.language("GildPanel", 26), len:60}, {datafield:"regbtn", label:Config.language("GildPanel", 46), len:140, childmc:"regbtn"}];
            this.gildlistdata = new DataGridUI(_loc_6, this.mainpanel, 30, 70, 690, 325);
            this.gildlistdata.addEventListener(DataGridEvent.CLOMN_SORT, this.gildlistsort);
            this.mainpanel.addChild(this.pagelabel);
            this.pagelabel.x = 325;
            this.pagelabel.y = 410;
            this.pagelabel.width = 42;
            this.pagelabel.autoSize = TextFieldAutoSize.CENTER;
            var _loc_7:* = new PushButton(this.mainpanel, 260, 410, "<<", Config.create(this.gildpage, -2));
            new PushButton(this.mainpanel, 260, 410, "<<", Config.create(this.gildpage, -2)).width = 30;
            var _loc_8:* = new PushButton(this.mainpanel, 295, 410, "<", Config.create(this.gildpage, -1));
            new PushButton(this.mainpanel, 295, 410, "<", Config.create(this.gildpage, -1)).width = 30;
            var _loc_9:* = new PushButton(this.mainpanel, 367, 410, ">", Config.create(this.gildpage, 1));
            new PushButton(this.mainpanel, 367, 410, ">", Config.create(this.gildpage, 1)).width = 30;
            var _loc_10:* = new PushButton(this.mainpanel, 402, 410, ">>", Config.create(this.gildpage, 2));
            new PushButton(this.mainpanel, 402, 410, ">>", Config.create(this.gildpage, 2)).width = 30;
            var _loc_11:* = new Label(this.mainpanel, 470, 410, Config.language("GildPanel", 49));
            var _loc_12:* = new InputText(this.mainpanel, 520, 410);
            new InputText(this.mainpanel, 520, 410).width = 40;
            _loc_12.maxChars = 3;
            var _loc_13:* = new PushButton(this.mainpanel, 580, 410, Config.language("GildPanel", 50), Config.create(this.tmemberpage, _loc_12));
            new PushButton(this.mainpanel, 580, 410, Config.language("GildPanel", 50), Config.create(this.tmemberpage, _loc_12)).width = 60;
            this.getgildlist();
            return;
        }// end function

        private function changemembtype(event:TextEvent, param2:int, param3:int) : void
        {
            if (param3 == Config.player.id)
            {
                Config.message(Config.language("GildPanel", 59));
                return;
            }
            var _loc_4:* = 0;
            while (_loc_4 < this.memberarr.length)
            {
                
                if (this.memberarr[_loc_4].id == param3)
                {
                    this.memberinfor(_loc_4);
                    break;
                }
                _loc_4 = _loc_4 + 1;
            }
            return;
        }// end function

        private function memberinfor(param1:int) : void
        {
            var obj:Object;
            var cr:*;
            var stype:int;
            var j:uint;
            var radiobtn:RadioButton;
            var i:* = param1;
            cr = function (event:MouseEvent, param2:int) : void
            {
                obj.m = param2;
                return;
            }// end function
            ;
            this.clearsub();
            this.subpanel = new Window(this.container, this.x + 50, this.y + 50);
            this.subpanel.open();
            this.subpanel.title = Config.language("GildPanel", 62);
            this.subpanel.resize(250, 200);
            var tempa:* = new Label(this.subpanel, 20, 35, this.memberarr[i].name);
            var tempb:* = new Label(this.subpanel, 140, 35, Config.language("GildPanel", 60, this.memberarr[i].level, this.memberarr[i].jobname));
            var tempc:* = new Label(this.subpanel, 20, 75, Config.language("GildPanel", 17));
            var tempf:* = new Label(this.subpanel, 60, 75, this.memberarr[i].gamemoney);
            var tempe:* = new Label(this.subpanel, 20, 95, Config.language("GildPanel", 61) + this.typenamearr[this.memberarr[i].type]);
            var xpos:int;
            var selectnum:int;
            if (this._mytype == 1 || this._mytype == 2)
            {
                stype;
                if (this._mytype == 2)
                {
                    stype;
                }
                if (this.memberarr[i].type != 1)
                {
                    j = stype;
                    while (j < this.typenamearr.length)
                    {
                        
                        radiobtn = new RadioButton(this.subpanel, xpos, 125, this.typenamearr[j], false, Config.create(cr, j));
                        if (this.memberarr[i].type == j)
                        {
                            radiobtn.selected = true;
                            selectnum = j;
                        }
                        radiobtn.group = "typearr";
                        xpos = xpos + 70;
                        j = (j + 1);
                    }
                }
            }
            obj = new Object();
            obj.m = selectnum;
            obj.id = this.memberarr[i].id;
            var btn2:* = new PushButton(this.subpanel, 90, 160, Config.language("GildPanel", 63), Config.create(this.sltype, obj));
            btn2.width = 60;
            return;
        }// end function

        private function sltype(event:MouseEvent, param2:Object) : void
        {
            trace(param2.m);
            if (param2.m == 1)
            {
                this.changeleader(param2.id);
            }
            else if (param2.m == -1)
            {
            }
            else
            {
                this.setmemberright(param2.id, param2.m);
            }
            return;
        }// end function

        private function removeallchild(param1:Sprite) : void
        {
            while (param1.numChildren > 0)
            {
                
                param1.removeChildAt((param1.numChildren - 1));
            }
            param1.graphics.clear();
            return;
        }// end function

        public function get gildid() : int
        {
            return this._gildid;
        }// end function

        public function set gildid(param1:int) : void
        {
            if (this._gildid != param1 || param1 == 0)
            {
                if (param1 == 0)
                {
                    this.nogild();
                    this._mytype = 0;
                }
                else
                {
                    this.setbg();
                    this.labelinit();
                    this.listpage();
                    this.senddetail(param1);
                }
            }
            this._gildid = param1;
            if (Config.player != null)
            {
                Config.player.gildid = param1;
            }
            if (this._gildid != 0)
            {
                this.getleague();
            }
            else
            {
                this.leaguearr = [];
            }
            return;
        }// end function

        private function talkcreate(event:MouseEvent = null) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = null;
            this.clearsub();
            this.subpanel = new Window(this.container, this.x + 50, this.y + 50);
            this.subpanel.open();
            this.subpanel.title = Config.language("GildPanel", 39);
            var _loc_2:* = 0;
            if (Config.player.level < 20)
            {
                _loc_2 = 1;
            }
            if (Config.player.money4 < 30000)
            {
                if (_loc_2 == 1)
                {
                    _loc_2 = 3;
                }
                else
                {
                    _loc_2 = 2;
                }
            }
            if (_loc_2 == 0)
            {
                this.subpanel.resize(300, 290);
                this.subpanel.y = this.y + 20;
                _loc_3 = new Label(this.subpanel, 20, 30, Config.language("GildPanel", 64));
                _loc_4 = new Label(this.subpanel, 20, 60, Config.language("GildPanel", 65));
                _loc_5 = new InputText(this.subpanel, 90, 60, "");
                if (Config._switchNameLength)
                {
                    _loc_5.maxChars = 16;
                }
                else
                {
                    _loc_5.maxChars = 8;
                }
                _loc_5.width = 120;
                if (Config._switchEnglish)
                {
                    _loc_5._tf.restrict = "^<>一-龥";
                }
                else
                {
                    _loc_5._tf.restrict = "^<>";
                }
                _loc_6 = new LabelUI(this.subpanel, 20, 80, Config.language("GildPanel", 66));
                _loc_4 = new Label(this.subpanel, 20, 100, Config.language("GildPanel", 67));
                _loc_7 = new Text(this.subpanel, 20, 120);
                _loc_7.width = 260;
                _loc_7.height = 100;
                _loc_7.tf.maxChars = 50;
                _loc_8 = new LabelUI(this.subpanel, 20, 230, Config.language("GildPanel", 68));
                if (Config._switchMobage)
                {
                    _loc_4.parent.removeChild(_loc_4);
                    _loc_7.parent.removeChild(_loc_7);
                    _loc_8.parent.removeChild(_loc_8);
                    _loc_7.text = " ";
                }
                _loc_9 = new PushButton(this.subpanel, 120, 250, Config.language("GildPanel", 69), Config.create(this.buildgild, _loc_5, _loc_7));
                _loc_9.width = 60;
            }
            else
            {
                this.subpanel.resize(300, 150);
                _loc_10 = new Label(this.subpanel, 30, 40, Config.language("GildPanel", 70));
                _loc_11 = Config.language("GildPanel", 71);
                _loc_12 = Config.language("GildPanel", 72);
                if (_loc_2 == 1)
                {
                    _loc_11 = _loc_11 + Config.language("GildPanel", 73);
                }
                else if (_loc_2 == 2)
                {
                    _loc_12 = _loc_12 + Config.language("GildPanel", 73);
                }
                else
                {
                    _loc_11 = _loc_11 + Config.language("GildPanel", 73);
                    _loc_12 = _loc_12 + Config.language("GildPanel", 73);
                }
                _loc_13 = new Label(this.subpanel, 40, 65, _loc_11);
                _loc_14 = new Label(this.subpanel, 40, 90, _loc_12);
                _loc_15 = new PushButton(this.subpanel, 80, 115, Config.language("GildPanel", 74), this.clearsub);
                _loc_15.width = 60;
            }
            return;
        }// end function

        private function buildgild(event:MouseEvent, param2:InputText, param3:Text) : void
        {
            if (param2.text == "")
            {
                Config.message(Config.language("GildPanel", 75));
                return;
            }
            if (!FilterWords.chickwords(String(param2.text)))
            {
                AlertUI.alert(Config.language("GildPanel", 76), Config.language("GildPanel", 77), [Config.language("GildPanel", 78)]);
                return;
            }
            var _loc_4:* = new DataSet();
            new DataSet().addHead(CONST_ENUM.C2G_GUILD_CREATE);
            _loc_4.addUTF(param2.text);
            _loc_4.addUTF(param3.text);
            ClientSocket.send(_loc_4);
            return;
        }// end function

        private function backbuild(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readByte();
            if (_loc_3 == 0)
            {
                Config.message(Config.language("GildPanel", 79));
                this.clearsub();
                this._mytype = 1;
                this.gildid = _loc_2.readUnsignedInt();
                Config.ui._yabiao.setYbiaoName();
            }
            return;
        }// end function

        private function gildresult(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readByte();
            var _loc_4:* = _loc_2.readByte();
            var _loc_5:* = _loc_2.readUnsignedShort();
            var _loc_6:* = _loc_2.readUTFBytes(_loc_5);
            trace(_loc_3);
            switch(_loc_3)
            {
                case 1:
                {
                    break;
                }
                case 2:
                {
                    break;
                }
                case 3:
                {
                    break;
                }
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
                case 9:
                {
                    break;
                }
                case 10:
                {
                    break;
                }
                case 11:
                {
                    break;
                }
                case 12:
                {
                    break;
                }
                default:
                {
                    break;
                }
            }
            switch(_loc_4)
            {
                case 1:
                {
                    Config.message(Config.language("GildPanel", 80));
                    break;
                }
                case 2:
                {
                    Config.message(_loc_6 + Config.language("GildPanel", 81));
                    break;
                }
                case 3:
                {
                    Config.message(Config.language("GildPanel", 82));
                    break;
                }
                case 4:
                {
                    Config.message(Config.language("GildPanel", 83));
                    break;
                }
                case 5:
                {
                    Config.message(_loc_6 + Config.language("GildPanel", 84));
                    break;
                }
                case 6:
                {
                    Config.message(Config.language("GildPanel", 85));
                    break;
                }
                case 7:
                {
                    Config.message(Config.language("GildPanel", 86));
                    break;
                }
                case 8:
                {
                    Config.message(Config.language("GildPanel", 87));
                    break;
                }
                case 9:
                {
                    break;
                }
                case 10:
                {
                    Config.message(_loc_6 + Config.language("GildPanel", 88));
                    break;
                }
                case 11:
                {
                    Config.message(_loc_6 + Config.language("GildPanel", 89));
                    break;
                }
                case 12:
                {
                    Config.message(Config.language("GildPanel", 90));
                    break;
                }
                case 13:
                {
                    Config.message(Config.language("GildPanel", 91));
                    break;
                }
                case 14:
                {
                    Config.message(Config.language("GildPanel", 92));
                    break;
                }
                case 15:
                {
                    Config.message(Config.language("GildPanel", 93));
                    break;
                }
                case 16:
                {
                    Config.message(_loc_6 + Config.language("GildPanel", 94));
                    break;
                }
                case 17:
                {
                    Config.message(Config.language("GildPanel", 95));
                    break;
                }
                case 18:
                {
                    Config.message(Config.language("GildPanel", 96));
                    break;
                }
                case 19:
                {
                    Config.message(Config.language("GildPanel", 97));
                    break;
                }
                case 20:
                {
                    Config.message(Config.language("GildPanel", 98));
                    break;
                }
                case 21:
                {
                    Config.message(Config.language("GildPanel", 99));
                    break;
                }
                case 22:
                {
                    Config.message(Config.language("GildPanel", 100));
                    break;
                }
                case 23:
                {
                    Config.message(Config.language("GildPanel", 101));
                    break;
                }
                case 24:
                {
                    Config.message(Config.language("GildPanel", 102));
                    break;
                }
                case 25:
                {
                    Config.message(Config.language("GildPanel", 103));
                    break;
                }
                case 26:
                {
                    Config.message(Config.language("GildPanel", 104));
                    break;
                }
                case 27:
                {
                    Config.message(Config.language("GildPanel", 105));
                    break;
                }
                case 28:
                {
                    Config.message(Config.language("GildPanel", 106));
                    break;
                }
                case 29:
                {
                    Config.message(Config.language("GildPanel", 107));
                    break;
                }
                case 30:
                {
                    Config.message(Config.language("GildPanel", 108));
                    break;
                }
                case 31:
                {
                    Config.message(Config.language("GildPanel", 109));
                    break;
                }
                case 32:
                {
                    Config.message(Config.language("GildPanel", 110));
                    break;
                }
                case 33:
                {
                    Config.message(Config.language("GildPanel", 111));
                    break;
                }
                case 34:
                {
                    AlertUI.alert(Config.language("GildPanel", 76), Config.language("GildPanel", 112), [Config.language("GildPanel", 78)]);
                    break;
                }
                case 35:
                {
                    Config.message(Config.language("GildPanel", 113));
                    break;
                }
                case 37:
                case 38:
                {
                    AlertUI.alert(Config.language("GildPanel", 268), Config.language("GildPanel", 269), [Config.language("GildPanel", 78)]);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function memberupdate(event:SocketEvent) : void
        {
            return;
        }// end function

        private function senddetail(param1:int) : void
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_GUILD_GET_DETAIL);
            _loc_2.add32(param1);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function backdetail(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = new Object();
            _loc_3.gildid = _loc_2.readUnsignedInt();
            var _loc_4:* = _loc_2.readUnsignedShort();
            _loc_3.gildname = _loc_2.readUTFBytes(_loc_4);
            _loc_3.leaderid = _loc_2.readUnsignedInt();
            var _loc_5:* = _loc_2.readUnsignedShort();
            _loc_3.chairman = _loc_2.readUTFBytes(_loc_5);
            _loc_3.level = _loc_2.readUnsignedShort();
            var _loc_6:* = _loc_2.readUnsignedShort();
            _loc_3.gamemoney = Number(_loc_2.readUTFBytes(_loc_6));
            _loc_3.gildmoney = _loc_2.readUnsignedInt();
            _loc_3.homeid = _loc_2.readUnsignedInt();
            var _loc_7:* = _loc_2.readUnsignedShort();
            _loc_3.notice = _loc_2.readUTFBytes(_loc_7);
            var _loc_8:* = _loc_2.readUnsignedShort();
            _loc_3.gildinfor = _loc_2.readUTFBytes(_loc_8);
            _loc_3.buildid = _loc_2.readUnsignedInt();
            var _loc_9:* = _loc_2.readUnsignedShort();
            _loc_3.buildname = _loc_2.readUTFBytes(_loc_9);
            _loc_3.buildtime = _loc_2.readUnsignedInt();
            _loc_3.gildnum = _loc_2.readUnsignedInt();
            _loc_3.onlinenum = _loc_2.readUnsignedInt();
            _loc_3.uptime = _loc_2.readUnsignedInt();
            _loc_3.rugamemoney = _loc_2.readUnsignedInt();
            _loc_3.rugildmoney = _loc_2.readUnsignedInt();
            _loc_3.residentid = _loc_2.readUnsignedShort();
            this.gildSource = _loc_2.readUnsignedInt();
            this.gildShopLevel = _loc_2.readUnsignedInt();
            if (this.gildShopLevel <= 0)
            {
                this.gildShopLevel = 1;
            }
            if (this._gildid == _loc_3.gildid)
            {
                this.gildinforobj = _loc_3;
                this.gildpanelobj.gildname.text = _loc_3.gildname;
                this.gildpanelobj.gildname.x = (220 - this.gildpanelobj.gildname.width) / 2 + 20;
                if (String(this.gildpanelobj.gildname.text).search(":") > -1)
                {
                    if (Config.player.name == _loc_3.chairman)
                    {
                        this.gildpanelobj.nameBtn.enabled = true;
                    }
                    else
                    {
                        this.gildpanelobj.nameBtn.enabled = false;
                    }
                    this.gildpanelobj.nameBtn.visible = true;
                }
                else
                {
                    this.gildpanelobj.nameBtn.visible = false;
                }
                this.gildpanelobj.chairman.text = _loc_3.chairman;
                this.gildpanelobj.level.text = _loc_3.level;
                this.gildlv = _loc_3.level;
                if (this.gildinforobj.level == 15)
                {
                    this.gildpanelobj.btn2.visible = false;
                }
                this.gildpanelobj.memnum.text = _loc_3.gildnum;
                this.gildpanelobj.residentid.text = _loc_3.residentid;
                this.gildpanelobj.gamemoney.text = Config.coinShow(_loc_3.gamemoney);
                if (this.gildinforobj.level < 10)
                {
                    this.gildpanelobj.gildmoney.text = Config.coinShow(_loc_3.gildmoney) + "/" + Config._guildExpendMap[int((this.gildinforobj.level + 1))].brickNumber;
                    this.gildpanelobj.gildmoneybar.maximum = Config._guildExpendMap[int((this.gildinforobj.level + 1))].brickNumber;
                    this.gildpanelobj.gildmoneybar.value = _loc_3.gildmoney;
                }
                else
                {
                    this.gildpanelobj.gildmoney.text = Config.language("GildPanel", 114);
                }
                if (_loc_3.notice == "")
                {
                    this.gildpanelobj.notice.text = " ";
                }
                else
                {
                    this.gildpanelobj.notice.text = _loc_3.notice;
                }
                if (Config.player != null)
                {
                    Config.player.setgildinfor(this._gildid, _loc_3.gildname, this._mytype, Config.player._camp, Config.player._gildTeam);
                }
                this.setGildCoin();
                Config.ui._landGravePanel.showLandNum();
            }
            return;
        }// end function

        private function changeedit(event:MouseEvent) : void
        {
            if (this.gildpanelobj.notice.editable)
            {
                this.sendgildmotd(this.gildpanelobj.notice.text);
            }
            else
            {
                this.gildpanelobj.editbtn.label = Config.language("GildPanel", 115);
                this.gildpanelobj.notice.editable = true;
            }
            return;
        }// end function

        private function sendgildmotd(param1:String) : void
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_GUILD_MOTD);
            _loc_2.addUTF(param1);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function backgildmotd(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedShort();
            var _loc_4:* = _loc_2.readUTFBytes(_loc_3);
            this.gildpanelobj.notice.text = _loc_4;
            this.gildpanelobj.editbtn.label = Config.language("GildPanel", 116);
            this.gildpanelobj.notice.editable = false;
            return;
        }// end function

        private function disgild(param1) : void
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_GUILD_DISBAND);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function backdisgild(event:SocketEvent) : void
        {
            this._mytype = 0;
            this.gildid = 0;
            this.getgildlist();
            Config.message(Config.language("GildPanel", 120));
            return;
        }// end function

        private function closegild(event:MouseEvent = null) : void
        {
            AlertUI.alert(Config.language("GildPanel", 76), Config.language("GildPanel", 121), [Config.language("GildPanel", 78), Config.language("GildPanel", 122)], [this.disgild, null]);
            return;
        }// end function

        private function invitecheck(event:MouseEvent, param2:int, param3:InputText) : void
        {
            if (param2 == 1)
            {
                if (param3.text == "")
                {
                    Config.message(Config.language("GildPanel", 123));
                }
                else
                {
                    this.inviteguild(param3.text);
                }
            }
            else
            {
                this.clearsub();
            }
            return;
        }// end function

        public function inviteguild(param1:String) : void
        {
            trace(param1);
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_GUILD_INVITE);
            _loc_2.addUTF(param1);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function backinviteguild(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedShort();
            var _loc_4:* = _loc_2.readUTFBytes(_loc_3);
            var _loc_5:* = _loc_2.readUnsignedShort();
            var _loc_6:* = _loc_2.readUTFBytes(_loc_5);
            var _loc_7:* = new Object();
            new Object().type = 2;
            _loc_7.fname = _loc_4;
            _loc_7.title = Config.language("GildPanel", 124);
            _loc_7.msg = _loc_4 + Config.language("GildPanel", 125) + _loc_6;
            _loc_7.btns = [Config.language("GildPanel", 78), Config.language("GildPanel", 126)];
            _loc_7.funcs = [this.acceptinvite, this.cancelinvite];
            _loc_7.d = {rename:_loc_4};
            if (Config.disturbMode)
            {
                ListTip.addList(_loc_7);
            }
            else
            {
                AlertUI.alert(Config.language("GildPanel", 124), _loc_4 + Config.language("GildPanel", 125) + _loc_6, [Config.language("GildPanel", 78), Config.language("GildPanel", 126)], [this.acceptinvite, this.cancelinvite], {rename:_loc_4}, false, true, false, null, true);
            }
            return;
        }// end function

        private function acceptinvite(param1) : void
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_GUILD_ACCEPT);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function memberadd(event:SocketEvent) : void
        {
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_2:* = new Object();
            var _loc_3:* = event.data;
            _loc_2.id = _loc_3.readUnsignedInt();
            _loc_2.online = _loc_3.readUnsignedInt();
            var _loc_4:* = _loc_3.readUnsignedShort();
            _loc_2.name = _loc_3.readUTFBytes(_loc_4);
            _loc_2.type = _loc_3.readByte();
            _loc_2.typename = this.typenamearr[_loc_2.type];
            _loc_2.level = _loc_3.readUnsignedShort();
            _loc_2.job = _loc_3.readByte();
            _loc_2.jobname = Config._jobTitleMap[_loc_2.job];
            _loc_2.gamemoney = _loc_3.readUnsignedInt();
            _loc_2.gildmoney = _loc_3.readUnsignedInt();
            _loc_2.gildSource = _loc_3.readUnsignedInt();
            if (_loc_2.online != 0)
            {
                _loc_2.textcolor = 6697728;
            }
            else
            {
                _loc_2.textcolor = 6710886;
            }
            _loc_2.coinmc = new Sprite();
            var _loc_5:* = new Panel(_loc_2.coinmc, 10, 5);
            new Panel(_loc_2.coinmc, 10, 5).setSize(20, 8);
            _loc_5.color = 16763904;
            var _loc_6:* = new Panel(_loc_2.coinmc, 90, 5);
            new Panel(_loc_2.coinmc, 90, 5).setSize(10, 10);
            _loc_6.roundCorner = 10;
            _loc_6.color = 16763904;
            _loc_2.gildmoneylab = new Label(_loc_2.coinmc, 33, 0);
            _loc_2.gildmoneylab.text = _loc_2.gildmoney;
            _loc_2.gildmoneylab.textColor = _loc_2.textcolor;
            _loc_2.gamemoneylab = new Label(_loc_2.coinmc, 105, 0);
            _loc_2.gamemoneylab.text = _loc_2.gamemoney;
            _loc_2.gamemoneylab.textColor = _loc_2.textcolor;
            var _loc_7:* = new Sprite();
            var _loc_8:* = new ClickLabel(_loc_7, 10, 0, _loc_2.name, Config.create(this.chatgildmem, _loc_2), true);
            new ClickLabel(_loc_7, 10, 0, _loc_2.name, Config.create(this.chatgildmem, _loc_2), true).clickColor([26367, 6837142]);
            _loc_2.chatname = _loc_7;
            var _loc_9:* = new Sprite();
            if (this._mytype == 1 || this._mytype == 2)
            {
                _loc_10 = new ClickLabel(_loc_9, 0, 0, Config.language("GildPanel", 127), Config.create(this.changemembtype, this.memberarr.length, _loc_2.id), true);
                _loc_10.clickColor([26367, 6837142]);
                _loc_11 = new ClickLabel(_loc_9, 90, 0, Config.language("GildPanel", 128), Config.create(this.delmem, _loc_2), true);
                _loc_11.clickColor([26367, 6837142]);
            }
            _loc_2.makemc = _loc_9;
            if (_loc_2.name == Config.player.name)
            {
                this.sendmemberlist();
            }
            else
            {
                this.memberarr.push(_loc_2);
                this.memberlistdata.dataProvider = this.memberarr;
            }
            if (this.gildpanelobj.memnum != null)
            {
                this.gildpanelobj.memnum.text = String((int(this.gildpanelobj.memnum.text) + 1));
            }
            Config.ui._yabiao.setYbiaoName();
            return;
        }// end function

        public function cancelinvite(param1) : void
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_GUILD_DECLINE);
            _loc_2.addUTF(param1.rename);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function backcancelinvite(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedShort();
            var _loc_4:* = _loc_2.readUTFBytes(_loc_3);
            Config.message(Config.language("GildPanel", 129, _loc_4));
            return;
        }// end function

        private function showothergild(event:SocketEvent) : void
        {
            var _loc_11:* = undefined;
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            var _loc_4:* = _loc_2.readUnsignedInt();
            var _loc_5:* = _loc_2.readUnsignedShort();
            var _loc_6:* = _loc_2.readUTFBytes(_loc_5);
            var _loc_7:* = _loc_2.readByte();
            var _loc_8:* = _loc_2.readUnsignedInt();
            var _loc_9:* = _loc_2.readUnsignedInt();
            if (Config.player != null)
            {
                if (Config.player.id == _loc_3)
                {
                    this._mytype = _loc_7;
                    Config.player.guildInfo = [_loc_4, _loc_6, _loc_7, _loc_8, _loc_9];
                    this.gildid = _loc_4;
                    return;
                }
            }
            var _loc_10:* = Unit.getPlayerlist();
            if (Unit.getPlayerlist() != null)
            {
                for (_loc_11 in _loc_10)
                {
                    
                    if (_loc_10[_loc_11]._id == _loc_3)
                    {
                        _loc_10[_loc_11].setgildinfor(_loc_4, _loc_6, _loc_7, _loc_8, _loc_9);
                        break;
                    }
                }
            }
            return;
        }// end function

        private function delmem(event:TextEvent, param2:Object) : void
        {
            if (param2.id != Config.player.id)
            {
                AlertUI.alert(Config.language("GildPanel", 76), Config.language("GildPanel", 130, param2.name), [Config.language("GildPanel", 78), Config.language("GildPanel", 122)], [this.removemember, null], {id:param2.id});
            }
            else
            {
                Config.message(Config.language("GildPanel", 132));
            }
            return;
        }// end function

        public function removemember(param1) : void
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_GUILD_REMOVE);
            _loc_2.add32(param1.id);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function backremovemember(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            var _loc_4:* = _loc_2.readUnsignedShort();
            var _loc_5:* = _loc_2.readUTFBytes(_loc_4);
            var _loc_6:* = _loc_2.readUnsignedInt();
            var _loc_7:* = _loc_2.readUnsignedShort();
            var _loc_8:* = _loc_2.readUTFBytes(_loc_7);
            if (Config.player.name == _loc_5)
            {
                this.gildid = 0;
                this.getgildlist();
                Config.message(Config.language("GildPanel", 133));
            }
            else
            {
                this.nameoutgild(_loc_5);
            }
            Config.ui._yabiao.setYbiaoName();
            return;
        }// end function

        private function leavegild(event:MouseEvent = null) : void
        {
            if (Config.map._type == 23)
            {
                Config.message(Config.language("GildPanel", 267));
                return;
            }
            AlertUI.alert(Config.language("GildPanel", 76), Config.language("GildPanel", 134), [Config.language("GildPanel", 78), Config.language("GildPanel", 122)], [this.leavegildcen, null]);
            return;
        }// end function

        private function leavegildcen(event:MouseEvent = null) : void
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_GUILD_LEAVE);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function backleavgild(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            var _loc_4:* = _loc_2.readUnsignedShort();
            var _loc_5:* = _loc_2.readUTFBytes(_loc_4);
            if (Config.player.name == _loc_5)
            {
                this.gildid = 0;
                this.getgildlist();
            }
            else
            {
                this.nameoutgild(_loc_5);
                this.gildpanelobj.memnum.text = String((int(this.gildpanelobj.memnum.text) - 1));
            }
            Config.ui._yabiao.setYbiaoName();
            return;
        }// end function

        private function nameoutgild(param1:String) : void
        {
            var _loc_2:* = 0;
            while (_loc_2 < this.memberarr.length)
            {
                
                if (this.memberarr[_loc_2].name == param1)
                {
                    this.memberarr.splice(_loc_2, 1);
                    break;
                }
                _loc_2 = _loc_2 + 1;
            }
            this.memberlistdata.dataProvider = this.memberarr;
            return;
        }// end function

        private function seleteleader(event:MouseEvent) : void
        {
            if (this.memberlistdata.rowIndex != -1 && Config.player.id != this.memberarr[this.memberlistdata.rowIndex].id)
            {
                AlertUI.alert(Config.language("GildPanel", 76), Config.language("GildPanel", 135, this.memberarr[this.memberlistdata.rowIndex].name), [Config.language("GildPanel", 78), Config.language("GildPanel", 122)], [this.changeleader, null], {id:this.memberarr[this.memberlistdata.rowIndex].id});
            }
            else
            {
                Config.message(Config.language("GildPanel", 136));
            }
            return;
        }// end function

        private function changeleader(param1) : void
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_GUILD_LEADER);
            _loc_2.add32(param1.id);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function backchangeleader(event:SocketEvent) : void
        {
            var _loc_7:* = 0;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            var _loc_4:* = _loc_2.readUnsignedShort();
            var _loc_5:* = _loc_2.readUTFBytes(_loc_4);
            this.gildpanelobj.chairman.text = _loc_5;
            var _loc_6:* = this._mytype;
            var _loc_8:* = 0;
            while (_loc_8 < this.memberarr.length)
            {
                
                _loc_9 = new Sprite();
                if (_loc_3 == Config.player.id)
                {
                    _loc_10 = new ClickLabel(_loc_9, 0, 0, Config.language("GildPanel", 51), Config.create(this.changemembtype, _loc_8, this.memberarr[_loc_8].id), true);
                    _loc_10.clickColor([26367, 6837142]);
                    _loc_11 = new ClickLabel(_loc_9, 90, 0, Config.language("GildPanel", 52), Config.create(this.delmem, this.memberarr[_loc_8]), true);
                    _loc_11.clickColor([26367, 6837142]);
                    this.memberarr[_loc_8].makemc = _loc_9;
                    this._mytype = 1;
                }
                if (_loc_6 == 1)
                {
                    this.memberarr[_loc_8].makemc = _loc_9;
                }
                if (_loc_3 == this.memberarr[_loc_8].id)
                {
                    this.memberarr[_loc_8].type = 1;
                    this.memberarr[_loc_8].typename = this.typenamearr[1];
                }
                if (this.memberarr[_loc_8].id == this.gildinforobj.leaderid)
                {
                    this.memberarr[_loc_8].type = 4;
                    this.memberarr[_loc_8].typename = this.typenamearr[4];
                }
                _loc_8 = _loc_8 + 1;
            }
            if (_loc_6 == 1)
            {
                this._mytype = 4;
            }
            this.memberlistdata.dataProvider = this.memberarr;
            if (this.gildlistdata != null)
            {
                if (this.gildlistdata.stage != null)
                {
                    this.hadgild();
                }
            }
            return;
        }// end function

        public function get mytype() : int
        {
            return this._mytype;
        }// end function

        public function set mytype(param1:int) : void
        {
            this._mytype = param1;
            if (this._gildid != 0)
            {
                this.backgild();
            }
            return;
        }// end function

        private function setmemberright(param1:int, param2:int) : void
        {
            var _loc_3:* = new DataSet();
            _loc_3.addHead(CONST_ENUM.C2G_GUILD_CHANGE_RANK);
            _loc_3.add32(param1);
            _loc_3.add8(param2);
            ClientSocket.send(_loc_3);
            return;
        }// end function

        private function backmemberright(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            var _loc_4:* = _loc_2.readByte();
            if (Config.player._id == _loc_3)
            {
                this.mytype = _loc_4;
            }
            var _loc_5:* = 0;
            while (_loc_5 < this.memberarr.length)
            {
                
                if (this.memberarr[_loc_5].id == _loc_3)
                {
                    this.memberarr[_loc_5].type = _loc_4;
                    this.memberarr[_loc_5].typename = this.typenamearr[_loc_4];
                    this.memberlistdata.dataProvider = this.memberarr;
                    break;
                }
                _loc_5 = _loc_5 + 1;
            }
            return;
        }// end function

        public function gildmoney(param1:int, param2:int = 0) : void
        {
            this._gildmoney = param1;
            if (param2 != 0)
            {
                this._price = param2;
            }
            if (this.gildid == 0)
            {
            }
            return;
        }// end function

        private function findgildlist(event:MouseEvent, param2:InputText) : void
        {
            this.getgildlist(null, param2.text);
            return;
        }// end function

        private function getgildlist(event:MouseEvent = null, param2:String = "") : void
        {
            var _loc_3:* = new DataSet();
            _loc_3.addHead(CONST_ENUM.C2G_GUILD_LIST);
            _loc_3.add16(this.gildsortobj.page);
            _loc_3.add8(this.gildsortobj.flag);
            _loc_3.add8(this.gildsortobj.sort);
            _loc_3.addUTF(param2);
            ClientSocket.send(_loc_3);
            return;
        }// end function

        private function backgildlist(event:SocketEvent) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = null;
            this.gildlistarr = new Array();
            var _loc_2:* = event.data;
            this.gildsortobj.allpage = _loc_2.readUnsignedInt();
            this.gildsortobj.page = _loc_2.readUnsignedInt();
            var _loc_3:* = _loc_2.readUnsignedInt();
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = new Object();
                _loc_5.i = _loc_4 + 1;
                _loc_5.id = _loc_2.readUnsignedInt();
                _loc_6 = _loc_2.readUnsignedShort();
                _loc_5.name = _loc_2.readUTFBytes(_loc_6);
                _loc_5.chairmanid = _loc_2.readUnsignedInt();
                _loc_7 = _loc_2.readUnsignedShort();
                _loc_5.chairman = _loc_2.readUTFBytes(_loc_7);
                _loc_5.level = _loc_2.readUnsignedShort();
                _loc_8 = _loc_2.readUnsignedShort();
                _loc_5.gamemoney = Number(_loc_2.readUTFBytes(_loc_8));
                _loc_5.gildmoney = _loc_2.readUnsignedInt();
                _loc_5.membernum = _loc_2.readUnsignedInt();
                _loc_5.onlinenum = _loc_2.readUnsignedInt();
                _loc_5.num = _loc_5.onlinenum + "/" + _loc_5.membernum;
                _loc_5.rugamemoney = _loc_2.readUnsignedInt();
                _loc_5.rugildmoney = _loc_2.readUnsignedInt();
                _loc_5.pnum = _loc_2.readUnsignedShort();
                _loc_5.camp = _loc_2.readUnsignedInt();
                _loc_5.gildTeam = _loc_2.readUnsignedInt();
                if (_loc_5.gildTeam == 1)
                {
                    _loc_5.warflag = Config.language("GildPanel", 137);
                }
                else if (_loc_5.gildTeam == 2)
                {
                    _loc_5.warflag = Config.language("GildPanel", 138);
                }
                else
                {
                    _loc_5.warflag = " ";
                }
                _loc_9 = new Sprite();
                if (this.gildid == 0)
                {
                    _loc_12 = new ClickLabel(_loc_9, 30, 0, Config.language("GildPanel", 139), Config.create(this.applygild, _loc_5.id), true);
                    _loc_12.clickColor([26367, 6837142]);
                }
                else if (this._mytype == 1 || this._mytype == 2)
                {
                    if (_loc_5.id != this.gildid)
                    {
                        _loc_13 = new ClickLabel(_loc_9, 10, 0, Config.language("GildPanel", 140), Config.create(this.sendleague, _loc_5.id), true);
                        _loc_13.clickColor([26367, 6837142]);
                        if (Config.player._camp == 0)
                        {
                            if (_loc_5.camp == 0 || _loc_5.gildTeam == 0)
                            {
                                _loc_14 = new ClickLabel(_loc_9, 50, 0, Config.language("GildPanel", 141), Config.create(this.sendWar, _loc_5.id, _loc_5.name), true);
                                _loc_14.clickColor([26367, 6837142]);
                            }
                            else
                            {
                                _loc_15 = new ClickLabel(_loc_9, 90, 0, Config.language("GildPanel", 142), Config.create(this.sendLeagWar, _loc_5.id, _loc_5.name), true);
                                _loc_15.clickColor([26367, 6837142]);
                            }
                        }
                    }
                }
                _loc_5.regbtn = _loc_9;
                _loc_5.logincoin = new Sprite();
                _loc_10 = new Panel(_loc_5.logincoin, 10, 5);
                _loc_10.setSize(20, 8);
                _loc_10.color = 16763904;
                _loc_11 = new Panel(_loc_5.logincoin, 70, 5);
                _loc_11.setSize(10, 10);
                _loc_11.roundCorner = 10;
                _loc_11.color = 16763904;
                _loc_5.gildmoneylab = new Label(_loc_5.logincoin, 33, 0);
                _loc_5.gildmoneylab.text = _loc_5.rugildmoney;
                _loc_5.gamemoneylab = new Label(_loc_5.logincoin, 85, 0);
                _loc_5.gamemoneylab.text = _loc_5.rugamemoney;
                this.gildlistarr.push(_loc_5);
                _loc_4 = _loc_4 + 1;
            }
            this.pagelabel.text = this.gildsortobj.page + "/" + this.gildsortobj.allpage;
            this.gildlistdata.dataProvider = this.gildlistarr;
            return;
        }// end function

        private function applygild(event:TextEvent, param2:int) : void
        {
            var _loc_3:* = new DataSet();
            _loc_3.addHead(CONST_ENUM.C2G_GUILD_APPLY);
            _loc_3.add32(param2);
            ClientSocket.send(_loc_3);
            Config.message(Config.language("GildPanel", 143));
            return;
        }// end function

        private function backapply(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readByte();
            switch(_loc_3)
            {
                case 0:
                {
                    Config.message(Config.language("GildPanel", 144));
                    break;
                }
                case 1:
                {
                    Config.message(Config.language("GildPanel", 145));
                    break;
                }
                case 2:
                {
                    Config.message(Config.language("GildPanel", 146));
                    break;
                }
                default:
                {
                    Config.message(Config.language("GildPanel", 147));
                    break;
                    break;
                }
            }
            return;
        }// end function

        private function sendapplylist(event:MouseEvent, param2:int) : void
        {
            var _loc_3:* = 1;
            if (param2 == -2)
            {
                _loc_3 = 1;
            }
            else if (param2 == 2)
            {
                _loc_3 = this.reallpage;
            }
            else if (param2 == -1)
            {
                if (this.repage + param2 >= 1)
                {
                    _loc_3 = this.repage + param2;
                }
                else
                {
                    _loc_3 = 1;
                }
            }
            else if (param2 == 1)
            {
                if (this.repage + param2 <= this.reallpage)
                {
                    _loc_3 = this.repage + param2;
                }
                else
                {
                    _loc_3 = this.reallpage;
                }
            }
            else
            {
                var _loc_5:* = 0;
                param2 = 0;
                if (_loc_5)
                {
                    _loc_3 = this.repage;
                }
            }
            var _loc_4:* = new DataSet();
            new DataSet().addHead(CONST_ENUM.C2G_GUILD_APPLY_LIST);
            _loc_4.add16(_loc_3);
            _loc_4.add8(this.reMemSort.flag);
            _loc_4.add8(this.reMemSort.sort);
            ClientSocket.send(_loc_4);
            return;
        }// end function

        private function backapplylist(event:SocketEvent) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            this.applylistarr = new Array();
            var _loc_2:* = event.data;
            this.repage = _loc_2.readUnsignedShort();
            this.reallpage = _loc_2.readUnsignedShort();
            var _loc_3:* = _loc_2.readUnsignedShort();
            this.repagelabel.text = this.repage + "/" + this.reallpage;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = new Object();
                _loc_5.i = int((_loc_4 + 1));
                _loc_5.id = _loc_2.readUnsignedInt();
                _loc_6 = _loc_2.readUnsignedShort();
                _loc_5.name = _loc_2.readUTFBytes(_loc_6);
                _loc_5.level = _loc_2.readUnsignedInt();
                _loc_5.job = _loc_2.readUnsignedInt();
                _loc_5.jobname = Config._jobTitleMap[_loc_5.job];
                _loc_5.mapplytime = _loc_2.readUnsignedInt();
                _loc_7 = new Date();
                _loc_7.setTime(_loc_5.mapplytime * 1000);
                _loc_5.applytime = _loc_7.getFullYear() + "-" + int((_loc_7.getMonth() + 1)) + "-" + _loc_7.getDate();
                _loc_8 = new Sprite();
                _loc_9 = new ClickLabel(_loc_8, 0, 0, Config.language("GildPanel", 148), Config.create(this.setapply, _loc_5.id, 1), true);
                _loc_9.clickColor([26367, 6837142]);
                _loc_10 = new ClickLabel(_loc_8, 40, 0, Config.language("GildPanel", 126), Config.create(this.setapply, _loc_5.id, 0), true);
                _loc_10.clickColor([26367, 6837142]);
                _loc_5.makemc = _loc_8;
                this.applylistarr.push(_loc_5);
                _loc_4 = _loc_4 + 1;
            }
            this.applylistdata.dataProvider = this.applylistarr;
            return;
        }// end function

        private function setapply(event:TextEvent, param2:int, param3:int) : void
        {
            var _loc_4:* = new DataSet();
            new DataSet().addHead(CONST_ENUM.C2G_SET_GUILD_APPLY);
            _loc_4.add32(param2);
            _loc_4.add8(param3);
            ClientSocket.send(_loc_4);
            return;
        }// end function

        private function backsetapply(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            this.sendapplylist(null, this.repage);
            return;
        }// end function

        private function applypanel(event:MouseEvent = null) : void
        {
            this.clearsub();
            this.subpanel = new Window(this.container, this.x + 50, this.y + 50);
            this.subpanel.open();
            this.subpanel.title = Config.language("GildPanel", 149);
            this.subpanel.resize(540, 340);
            var _loc_2:* = [{datafield:"i", label:Config.language("GildPanel", 150), len:40}, {datafield:"name", label:Config.language("GildPanel", 151), len:120}, {datafield:"level", label:Config.language("GildPanel", 152), len:40}, {datafield:"jobname", label:Config.language("GildPanel", 153), len:70}, {datafield:"applytime", label:Config.language("GildPanel", 154), len:100}, {datafield:"regbtn", label:Config.language("GildPanel", 155), len:140, childmc:"makemc"}];
            this.applylistdata = new DataGridUI(_loc_2, this.subpanel, 10, 25, 510, 300);
            this.applylistdata.addEventListener(DataGridEvent.CLOMN_SORT, this.remembersort);
            this.subpanel.addChild(this.repagelabel);
            this.repagelabel.x = 250;
            this.repagelabel.y = 310;
            this.repagelabel.width = 42;
            this.repagelabel.autoSize = TextFieldAutoSize.CENTER;
            var _loc_3:* = new PushButton(this.subpanel, 220, 310, "<", Config.create(this.sendapplylist, -1));
            _loc_3.width = 30;
            var _loc_4:* = new PushButton(this.subpanel, 292, 310, ">", Config.create(this.sendapplylist, 1));
            new PushButton(this.subpanel, 292, 310, ">", Config.create(this.sendapplylist, 1)).width = 30;
            this.sendapplylist(null, 0);
            return;
        }// end function

        private function backbugm(event:SocketEvent) : void
        {
            return;
        }// end function

        private function senddonation(event:MouseEvent, param2:int, param3:InputText) : void
        {
            if (int(param3.text) > 0)
            {
            }
            else
            {
                Config.message(Config.language("GildPanel", 160));
                return;
            }
            var _loc_4:* = new DataSet();
            new DataSet().addHead(CONST_ENUM.C2G_GUILD_DONATION);
            _loc_4.add32(int(param3.text));
            _loc_4.add32(param2);
            ClientSocket.send(_loc_4);
            return;
        }// end function

        private function backdonation(event:SocketEvent) : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readByte();
            if (_loc_3 == 1)
            {
                _loc_4 = _loc_2.readUnsignedInt();
                _loc_5 = _loc_2.readUnsignedInt();
                if (_loc_4 > 0)
                {
                    this.clearsub();
                    this.subpanel = new Window(this.container, this.x + 50, this.y + 50);
                    this.subpanel.open();
                    this.subpanel.title = Config.language("GildPanel", 161);
                    this.subpanel.resize(250, 200);
                    if (_loc_3 == 0)
                    {
                        Config.message(Config.language("GildPanel", 162));
                        _loc_7 = new Label(this.subpanel, 20, 110, Config.language("GildPanel", 163));
                    }
                    else
                    {
                        _loc_7 = new Label(this.subpanel, 20, 80, Config.language("GildPanel", 164));
                    }
                    _loc_6 = new PushButton(this.subpanel, 100, 150, Config.language("GildPanel", 165), this.handleClose);
                    _loc_6.width = 60;
                    this.sendmemberlist();
                }
                if (_loc_5 > 0)
                {
                    Config.message(Config.language("GildPanel", 166));
                }
            }
            return;
        }// end function

        private function handleClose(event:MouseEvent) : void
        {
            this.clearsub();
            return;
        }// end function

        private function backgildchange(event:SocketEvent) : void
        {
            var _loc_2:* = null;
            var _loc_4:* = 0;
            _loc_2 = event.data;
            var _loc_3:* = _loc_2.readByte();
            switch(_loc_3)
            {
                case 1:
                {
                    _loc_4 = _loc_2.readUnsignedShort();
                    this.gildinforobj.gamemoney = Number(_loc_2.readUTFBytes(_loc_4));
                    this.gildinforobj.gildmoney = _loc_2.readUnsignedInt();
                    this.gildpanelobj.gamemoney.text = Config.coinShow(this.gildinforobj.gamemoney);
                    if (this.gildinforobj.level < 10)
                    {
                        this.gildpanelobj.gildmoney.text = this.gildinforobj.gildmoney + "/" + Config._guildExpendMap[int((this.gildinforobj.level + 1))].brickNumber;
                        this.gildpanelobj.gildmoneybar.maximum = Config._guildExpendMap[int((this.gildinforobj.level + 1))].brickNumber;
                        this.gildpanelobj.gildmoneybar.value = this.gildinforobj.gildmoney;
                    }
                    else
                    {
                        this.gildpanelobj.gildmoney.text = Config.language("GildPanel", 114);
                    }
                    break;
                }
                case 2:
                {
                    _loc_4 = _loc_2.readUnsignedShort();
                    this.gildSource = Number(_loc_2.readUTFBytes(_loc_4));
                    this.gildShopLevel = _loc_2.readUnsignedInt();
                    if (this.gildShopLevel <= 0)
                    {
                        this.gildShopLevel = 1;
                    }
                    break;
                }
                default:
                {
                    break;
                    break;
                }
            }
            return;
        }// end function

        public function firstgtask() : void
        {
            return;
        }// end function

        public function getdildtask(event:MouseEvent = null) : void
        {
            Config.ui._gildwar.gildwarauction();
            return;
        }// end function

        private function donationpanel(event:MouseEvent) : void
        {
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            this.clearsub();
            this.subpanel = new Window(this.container, this.x + 50, this.y + 50);
            this.subpanel.open();
            this.subpanel.title = Config.language("GildPanel", 161);
            this.subpanel.resize(250, 210);
            var _loc_2:* = new Label(this.subpanel, 20, 30, Config.language("GildPanel", 167));
            var _loc_3:* = new Panel(this.subpanel, 20, 60);
            _loc_3.setSize(10, 10);
            _loc_3.roundCorner = 10;
            _loc_3.color = 16763904;
            var _loc_4:* = new Label(this.subpanel, 40, 60);
            new Label(this.subpanel, 40, 60).text = Config.coinShow(this.gildinforobj.gamemoney);
            var _loc_5:* = new Label(this.subpanel, 50, 60);
            var _loc_6:* = new Label(this.subpanel, 20, 80, Config.language("GildPanel", 168));
            if (this.gildinforobj.level < 15)
            {
                _loc_9 = new Panel(this.subpanel, 20, 110);
                _loc_9.setSize(10, 10);
                _loc_9.roundCorner = 10;
                _loc_9.color = 16763904;
                _loc_10 = new Label(this.subpanel, 40, 110);
                _loc_10.text = Config.coinShow(Number(Config._guildExpendMap[int((this.gildinforobj.level + 1))].brickMoney));
                _loc_11 = new Panel(this.subpanel, 20, 143);
                _loc_11.setSize(10, 10);
                _loc_11.roundCorner = 10;
                _loc_11.color = 16763904;
            }
            else
            {
                _loc_12 = new Label(this.subpanel, 20, 110, Config.language("GildPanel", 169));
            }
            var _loc_7:* = new InputText(this.subpanel, 40, 140);
            new InputText(this.subpanel, 40, 140).width = 100;
            _loc_7.maxChars = 8;
            _loc_7.restrict = "0-9";
            var _loc_8:* = new PushButton(this.subpanel, 100, 170, Config.language("GildPanel", 170), Config.create(this.senddonation, 0, _loc_7));
            new PushButton(this.subpanel, 100, 170, Config.language("GildPanel", 170), Config.create(this.senddonation, 0, _loc_7)).width = 60;
            return;
        }// end function

        public function gildSourcePanel(event:MouseEvent = null) : void
        {
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = null;
            this.clearsub();
            this.subpanel = new Window(this.container, this.x + 50, this.y + 50);
            this.subpanel.open();
            this.subpanel.title = Config.language("GildPanel", 249);
            this.subpanel.resize(250, 210);
            var _loc_2:* = new Label(this.subpanel, 20, 30, Config.language("GildPanel", 250));
            var _loc_3:* = new Panel(this.subpanel, 20, 60);
            _loc_3.setSize(10, 10);
            _loc_3.roundCorner = 10;
            _loc_3.color = 16763904;
            var _loc_4:* = new Label(this.subpanel, 40, 60);
            new Label(this.subpanel, 40, 60).text = Config.coinShow(this.gildSource);
            var _loc_5:* = new Label(this.subpanel, 110, 30, Config.language("GildPanel", 251));
            if (this.gildShopLevel < 15)
            {
                _loc_13 = new Panel(this.subpanel, 120, 60);
                _loc_13.setSize(10, 10);
                _loc_13.roundCorner = 10;
                _loc_13.color = 16763904;
                _loc_14 = new Label(this.subpanel, 140, 58);
                _loc_14.text = Config.coinShow(Number(Config._guildExpendMap[int((this.gildShopLevel + 1))].guildRes));
            }
            else
            {
                _loc_15 = new Label(this.subpanel, 110, 58, Config.language("GildPanel", 252));
            }
            var _loc_6:* = new Label(this.subpanel, 20, 80, Config.language("GildPanel", 253));
            var _loc_7:* = new Panel(this.subpanel, 20, 110);
            new Panel(this.subpanel, 20, 110).setSize(10, 10);
            _loc_7.roundCorner = 10;
            _loc_7.color = 16763904;
            var _loc_8:* = new Label(this.subpanel, 40, 108);
            new Label(this.subpanel, 40, 108).text = Config.ui._charUI.getItemAmount(94502);
            var _loc_9:* = new Panel(this.subpanel, 20, 143);
            new Panel(this.subpanel, 20, 143).setSize(10, 10);
            _loc_9.roundCorner = 10;
            _loc_9.color = 16763904;
            var _loc_10:* = new InputText(this.subpanel, 40, 140);
            new InputText(this.subpanel, 40, 140).width = 100;
            _loc_10.maxChars = 8;
            _loc_10.restrict = "0-9";
            var _loc_11:* = new PushButton(this.subpanel, 150, 140, Config.language("GildPanel", 254), Config.create(this.maxSource, _loc_10));
            new PushButton(this.subpanel, 150, 140, Config.language("GildPanel", 254), Config.create(this.maxSource, _loc_10)).width = 40;
            _loc_11.setTable("table18", "table31");
            _loc_11.textColor = Style.GOLD_FONT;
            _loc_11.overshow = true;
            var _loc_12:* = new PushButton(this.subpanel, 90, 170, Config.language("GildPanel", 170), Config.create(this.sendgildSource, _loc_10));
            new PushButton(this.subpanel, 90, 170, Config.language("GildPanel", 170), Config.create(this.sendgildSource, _loc_10)).width = 60;
            return;
        }// end function

        private function sendgildSource(event:MouseEvent, param2:InputText) : void
        {
            if (int(param2.text) > 0)
            {
                if (Config.ui._charUI.getItemAmount(94502) < int(param2.text))
                {
                    AlertUI.alert(Config.language("GildPanel", 255), Config.language("GildPanel", 256), [Config.language("GildPanel", 257)]);
                    return;
                }
            }
            else
            {
                AlertUI.alert(Config.language("GildPanel", 255), Config.language("GildPanel", 160), [Config.language("GildPanel", 257)]);
                return;
            }
            var _loc_3:* = new DataSet();
            _loc_3.addHead(CONST_ENUM.C2G_GUILDSOURCE_DONATION);
            _loc_3.add32(int(param2.text));
            ClientSocket.send(_loc_3);
            return;
        }// end function

        public function backSource() : void
        {
            this.clearsub();
            this.subpanel = new Window(this.container, this.x + 50, this.y + 50);
            this.subpanel.open();
            this.subpanel.title = Config.language("GildPanel", 161);
            this.subpanel.resize(250, 200);
            var _loc_1:* = new Label(this.subpanel, 20, 80, Config.language("GildPanel", 164));
            var _loc_2:* = new PushButton(this.subpanel, 100, 150, Config.language("GildPanel", 165), this.handleClose);
            _loc_2.width = 60;
            this.sendmemberlist();
            return;
        }// end function

        private function sendreward(event:TextEvent) : void
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_GET_GUILDDAILY_REWARD);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function backreward(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readByte();
            return;
        }// end function

        private function upgildcheck(event:MouseEvent = null) : void
        {
            var _loc_9:* = null;
            this.clearsub();
            this.subpanel = new Window(this.container, this.x + 50, this.y + 50);
            this.subpanel.open();
            this.subpanel.title = Config.language("GildPanel", 171);
            this.subpanel.resize(250, 160);
            var _loc_2:* = new Sprite();
            this.subpanel.addChild(_loc_2);
            if (this.gildinforobj.level == 15)
            {
                _loc_9 = new Label(_loc_2, 20, 20, Config.language("GildPanel", 172));
                return;
            }
            var _loc_3:* = new Label(_loc_2, 20, 35, Config.language("GildPanel", 173, this.gildinforobj.level, int((this.gildinforobj.level + 1))));
            var _loc_4:* = int(60 + 10 * this.gildinforobj.level);
            if (int(60 + 10 * this.gildinforobj.level) > 150)
            {
                _loc_4 = 150;
            }
            var _loc_5:* = new Label(_loc_2, 20, 75, Config.language("GildPanel", 176, _loc_4));
            var _loc_6:* = new Label(_loc_2, 20, 100, Config.language("GildPanel", 179));
            var _loc_7:* = new Label(_loc_2, 116, 100);
            new Label(_loc_2, 116, 100).text = Config._guildExpendMap[int((this.gildinforobj.level + 1))].brickMoney;
            var _loc_8:* = new PushButton(_loc_2, 90, 125, Config.language("GildPanel", 180), Config.create(this.sendupgild, 1));
            new PushButton(_loc_2, 90, 125, Config.language("GildPanel", 180), Config.create(this.sendupgild, 1)).width = 60;
            return;
        }// end function

        private function sendupgild(event:MouseEvent, param2:int = 1) : void
        {
            if (this.gildinforobj.gamemoney < Config._guildExpendMap[int((this.gildinforobj.level + 1))].brickMoney)
            {
                AlertUI.alert(Config.language("GildPanel", 76), Config.language("GildPanel", 182), [Config.language("GildPanel", 78)]);
                return;
            }
            var _loc_3:* = new DataSet();
            _loc_3.addHead(CONST_ENUM.C2G_UPDATE_GUILD);
            _loc_3.add8(param2);
            ClientSocket.send(_loc_3);
            return;
        }// end function

        private function backupgild(event:SocketEvent) : void
        {
            var _loc_4:* = 0;
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedShort();
            if (_loc_3 == 0)
            {
                Config.message(Config.language("GildPanel", 183));
            }
            else if (_loc_3 == 1)
            {
                _loc_4 = _loc_2.readUnsignedInt();
                Config.message(Config.language("GildPanel", 184));
                this.gildinforobj.uptime = _loc_4;
            }
            else
            {
                Config.message(Config.language("GildPanel", 184));
                this.gildinforobj.level = _loc_2.readUnsignedInt();
                this.gildpanelobj.level.text = this.gildinforobj.level;
                this.gildlv = this.gildinforobj.level;
                if (this.gildinforobj.level < 15)
                {
                    this.gildpanelobj.gildmoney.text = Config.coinShow(Number(this.gildinforobj.gildmoney)) + "/" + Config._guildExpendMap[int((this.gildinforobj.level + 1))].brickNumber;
                    this.gildpanelobj.gildmoneybar.maximum = Config._guildExpendMap[int((this.gildinforobj.level + 1))].brickNumber;
                    this.gildpanelobj.gildmoneybar.value = this.gildinforobj.gildmoney;
                }
                else
                {
                    this.gildpanelobj.gildmoney.text = Config.language("GildPanel", 185);
                    this.gildpanelobj.btn2.visible = false;
                }
                if ((this.mytype == 1 || this.mytype == 2) && this.subpanel.parent != null)
                {
                    this.upgildcheck();
                }
            }
            return;
        }// end function

        private function upShopcheck(event:MouseEvent = null) : void
        {
            var _loc_8:* = null;
            this.clearsub();
            this.subpanel = new Window(this.container, this.x + 50, this.y + 50);
            this.subpanel.open();
            this.subpanel.title = Config.language("GildPanel", 258);
            this.subpanel.resize(250, 160);
            var _loc_2:* = new Sprite();
            this.subpanel.addChild(_loc_2);
            if (this.gildShopLevel == 15)
            {
                _loc_8 = new Label(_loc_2, 20, 20, Config.language("GildPanel", 259));
                return;
            }
            var _loc_3:* = new Label(_loc_2, 20, 35, Config.language("GildPanel", 173, this.gildShopLevel, int((this.gildShopLevel + 1))));
            var _loc_4:* = new Label(_loc_2, 20, 75, Config.language("GildPanel", 260, int((this.gildShopLevel + 1))));
            var _loc_5:* = new Label(_loc_2, 20, 100, Config.language("GildPanel", 261));
            var _loc_6:* = new Label(_loc_2, 116, 100);
            new Label(_loc_2, 116, 100).text = Config._guildExpendMap[int((this.gildShopLevel + 1))].guildRes;
            var _loc_7:* = new PushButton(_loc_2, 90, 125, Config.language("GildPanel", 180), Config.create(this.sendupShop, 1));
            new PushButton(_loc_2, 90, 125, Config.language("GildPanel", 180), Config.create(this.sendupShop, 1)).width = 60;
            return;
        }// end function

        private function sendupShop(event:MouseEvent, param2:int = 1) : void
        {
            if (this.gildSource < Config._guildExpendMap[int((this.gildShopLevel + 1))].guildRes)
            {
                AlertUI.alert(Config.language("GildPanel", 76), Config.language("GildPanel", 262), [Config.language("GildPanel", 78)]);
                return;
            }
            if (this.gildinforobj.level <= this.gildShopLevel)
            {
                AlertUI.alert(Config.language("GildPanel", 76), Config.language("GildPanel", 263, int((this.gildShopLevel + 1))), [Config.language("GildPanel", 78)]);
                return;
            }
            var _loc_3:* = new DataSet();
            _loc_3.addHead(CONST_ENUM.C2G_GUILDSHOP_LEVELUP);
            _loc_3.add32(this.gildShopLevel);
            ClientSocket.send(_loc_3);
            return;
        }// end function

        public function backUpGildShop() : void
        {
            if ((this.mytype == 1 || this.mytype == 2) && this.subpanel.stage != null)
            {
                this.upShopcheck();
            }
            return;
        }// end function

        private function sendleague(param1, param2:int) : void
        {
            if (int(param2) == this.gildid)
            {
                Config.message(Config.language("GildPanel", 186));
                return;
            }
            var _loc_3:* = new DataSet();
            _loc_3.addHead(CONST_ENUM.C2G_ADD_ALIANECE_APPLY);
            _loc_3.add32(param2);
            ClientSocket.send(_loc_3);
            Config.message(Config.language("GildPanel", 187));
            return;
        }// end function

        private function sendWar(param1, param2:int, param3:String) : void
        {
            if (this.inGild(param2))
            {
                Config.message(Config.language("GildPanel", 188));
                return;
            }
            AlertUI.alert(Config.language("GildPanel", 76), Config.language("GildPanel", 189, param3), [Config.language("GildPanel", 78), Config.language("GildPanel", 122)], [this.checkSrndWar, null], {gid:param2});
            return;
        }// end function

        private function checkSrndWar(param1) : void
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_VS_DELEAR_WAR);
            _loc_2.add32(param1.gid);
            ClientSocket.send(_loc_2);
            Config.message(Config.language("GildPanel", 191));
            return;
        }// end function

        private function sendLeagWar(param1, param2:int, param3:String) : void
        {
            AlertUI.alert(Config.language("GildPanel", 76), Config.language("GildPanel", 192, param3), [Config.language("GildPanel", 78), Config.language("GildPanel", 122)], [this.checkLeagWar, null], {gid:param2});
            return;
        }// end function

        private function checkLeagWar(param1) : void
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_VS_ASSIANT);
            _loc_2.add32(param1.gid);
            ClientSocket.send(_loc_2);
            Config.message(Config.language("GildPanel", 191));
            return;
        }// end function

        private function sendleaguelist(param1:int = 1) : void
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_ADD_ALIANECE_APPLY_LIST);
            _loc_2.add16(param1);
            _loc_2.add8(1);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function backleaguelist(event:SocketEvent) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            trace("backleaguelist");
            this.leaguelistarr = new Array();
            var _loc_2:* = event.data;
            this.thispage = _loc_2.readUnsignedShort();
            this.allpage = _loc_2.readUnsignedShort();
            var _loc_3:* = _loc_2.readUnsignedShort();
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = new Object();
                _loc_5.i = _loc_4 + 1;
                _loc_5.id = _loc_2.readUnsignedInt();
                _loc_6 = _loc_2.readUnsignedShort();
                _loc_5.name = _loc_2.readUTFBytes(_loc_6);
                _loc_5.chairmanid = _loc_2.readUnsignedInt();
                _loc_7 = _loc_2.readUnsignedShort();
                _loc_5.chairman = _loc_2.readUTFBytes(_loc_7);
                _loc_5.level = _loc_2.readUnsignedShort();
                _loc_8 = _loc_2.readUnsignedShort();
                _loc_5.gamemoney = _loc_2.readUTFBytes(_loc_8);
                _loc_5.gildmoney = _loc_2.readUnsignedInt();
                _loc_5.membernum = _loc_2.readUnsignedInt();
                _loc_5.onlinenum = _loc_2.readUnsignedInt();
                _loc_5.rugamemoney = _loc_2.readUnsignedInt();
                _loc_5.rugildmoney = _loc_2.readUnsignedInt();
                _loc_5.pnum = _loc_2.readUnsignedShort();
                _loc_9 = new Sprite();
                _loc_10 = new ClickLabel(_loc_9, 0, 0, Config.language("GildPanel", 148), Config.create(this.sendallow, _loc_5.id, 1), true);
                _loc_10.clickColor([26367, 6837142]);
                _loc_11 = new ClickLabel(_loc_9, 40, 0, Config.language("GildPanel", 126), Config.create(this.sendallow, _loc_5.id, 0), true);
                _loc_11.clickColor([26367, 6837142]);
                _loc_5.makemc = _loc_9;
                this.leaguelistarr.push(_loc_5);
                _loc_4 = _loc_4 + 1;
            }
            this.leaguelistdata.dataProvider = this.leaguelistarr;
            return;
        }// end function

        private function getleague() : void
        {
            var _loc_1:* = new DataSet();
            _loc_1.addHead(CONST_ENUM.C2G_ALIANECE_LIST);
            ClientSocket.send(_loc_1);
            return;
        }// end function

        private function backleague(event:SocketEvent) : void
        {
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = null;
            this.leaguearr = new Array();
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedShort();
            var _loc_4:* = "";
            var _loc_5:* = 0;
            while (_loc_5 < _loc_3)
            {
                
                _loc_6 = new Object();
                _loc_6.i = _loc_5 + 1;
                _loc_6.id = _loc_2.readUnsignedInt();
                _loc_7 = _loc_2.readUnsignedShort();
                _loc_6.name = _loc_2.readUTFBytes(_loc_7);
                _loc_6.chairmanid = _loc_2.readUnsignedInt();
                _loc_8 = _loc_2.readUnsignedShort();
                _loc_6.chairman = _loc_2.readUTFBytes(_loc_8);
                _loc_6.level = _loc_2.readUnsignedShort();
                _loc_9 = _loc_2.readUnsignedShort();
                _loc_6.gamemoney = Number(_loc_2.readUTFBytes(_loc_9));
                _loc_6.gildmoney = _loc_2.readUnsignedInt();
                _loc_6.membernum = _loc_2.readUnsignedInt();
                _loc_6.onlinenum = _loc_2.readUnsignedInt();
                _loc_6.num = _loc_6.onlinenum + "/" + _loc_6.membernum;
                _loc_6.rugamemoney = _loc_2.readUnsignedInt();
                _loc_6.rugildmoney = _loc_2.readUnsignedInt();
                _loc_6.pnum = _loc_2.readUnsignedShort();
                _loc_10 = new Sprite();
                _loc_11 = new ClickLabel(_loc_10, 0, 0, Config.language("GildPanel", 194), Config.create(this.sendrmleague, _loc_6.id), true);
                _loc_11.clickColor([26367, 6837142]);
                _loc_6.makemc = _loc_10;
                this.leaguearr.push(_loc_6);
                _loc_4 = _loc_4 + (_loc_6.name + "\n");
                _loc_5 = _loc_5 + 1;
            }
            if (this.leaguedata != null)
            {
                this.leaguedata.dataProvider = this.leaguearr;
            }
            if (_loc_3 == 0)
            {
                _loc_4 = Config.language("GildPanel", 265);
            }
            this.gildpanelobj.leaguegild.text = _loc_4;
            this.playerleague();
            return;
        }// end function

        private function showleague() : void
        {
            var _loc_3:* = null;
            if (this.subpanel == null)
            {
                return;
            }
            var _loc_1:* = this.subpanel.getChildByName("topsp");
            if (_loc_1 != null)
            {
                this.removeallchild(_loc_1);
            }
            var _loc_2:* = 0;
            while (_loc_2 < this.leaguearr.length)
            {
                
                _loc_3 = new SimplelipUI(_loc_1, 10 + _loc_2 % 4 * 80, 45 + int(_loc_2 / 4) * 30, 80);
                _loc_3.label = [{str:this.leaguearr[_loc_2].name, id:this.leaguearr[_loc_2].id}];
                _loc_3.addEventListener(MouseEvent.CLICK, Config.create(this.selectlg, _loc_3.id));
                this.leaguearr[_loc_2].mc = _loc_3;
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        private function selectlg(event:MouseEvent, param2:int) : void
        {
            this.leagueflag = param2;
            var _loc_3:* = 0;
            while (_loc_3 < this.leaguearr.length)
            {
                
                if (this.leaguearr[_loc_3].id == this.leagueflag)
                {
                    this.leaguearr[_loc_3].mc.select = true;
                }
                else
                {
                    this.leaguearr[_loc_3].mc.select = false;
                }
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

        private function playerleague() : void
        {
            Config.player.gildid = this._gildid;
            return;
        }// end function

        private function sendallow(param1, param2:int, param3:int) : void
        {
            if (this.leaguearr != null)
            {
                if (this.leaguearr.length == 2)
                {
                    Config.message(Config.language("GildPanel", 195));
                    return;
                }
            }
            var _loc_4:* = new DataSet();
            new DataSet().addHead(CONST_ENUM.C2G_ADD_ALIANECE_REPONDSE);
            _loc_4.add32(param2);
            _loc_4.add8(param3);
            ClientSocket.send(_loc_4);
            return;
        }// end function

        private function backallow(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            this.sendleaguelist();
            return;
        }// end function

        private function backallowsuc(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = new Object();
            _loc_3.id = _loc_2.readUnsignedInt();
            var _loc_4:* = _loc_2.readUnsignedShort();
            _loc_3.name = _loc_2.readUTFBytes(_loc_4);
            this.leaguearr.push(_loc_3);
            Config.message(Config.language("GildPanel", 196, _loc_3.name));
            this.getleague();
            this.playerleague();
            Config.ui._yabiao.setYbiaoName();
            return;
        }// end function

        private function sendrmleague(event:TextEvent, param2:int) : void
        {
            var _loc_3:* = new DataSet();
            _loc_3.addHead(CONST_ENUM.C2G_REMOVE_ALIANCE);
            _loc_3.add32(param2);
            ClientSocket.send(_loc_3);
            return;
        }// end function

        private function backreleague(event:SocketEvent) : void
        {
            var _loc_4:* = null;
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            var _loc_5:* = "";
            var _loc_6:* = 0;
            while (_loc_6 < this.leaguearr.length)
            {
                
                if (this.leaguearr[_loc_6].id == _loc_3)
                {
                    _loc_4 = this.leaguearr[_loc_6].name;
                    this.leaguearr.splice(_loc_6, 1);
                    Config.message(Config.language("GildPanel", 198, _loc_4));
                    break;
                }
                _loc_6 = _loc_6 + 1;
            }
            var _loc_7:* = 0;
            while (_loc_7 < this.leaguearr.length)
            {
                
                _loc_5 = _loc_5 + this.leaguearr[_loc_7].name;
                _loc_7 = _loc_7 + 1;
            }
            this.leagueflag = -1;
            this.playerleague();
            if (this.leaguedata != null)
            {
                this.leaguedata.dataProvider = this.leaguearr;
            }
            if (this.leaguearr.length == 0)
            {
                _loc_5 = Config.language("GildPanel", 199);
            }
            this.gildpanelobj.leaguegild.text = _loc_5;
            Config.ui._yabiao.setYbiaoName();
            return;
        }// end function

        private function leaguelistpanel(event:MouseEvent) : void
        {
            this.clearsub();
            this.subpanel = new Window(this.container, this.x + 50, this.y + 50);
            this.subpanel.open();
            this.subpanel.title = Config.language("GildPanel", 200);
            this.subpanel.resize(510, 350);
            this.leagueflag = -1;
            var _loc_2:* = new Sprite();
            _loc_2.name = "topsp";
            this.subpanel.addChild(_loc_2);
            var _loc_3:* = [{datafield:"i", label:Config.language("GildPanel", 201), len:40}, {datafield:"name", label:Config.language("GildPanel", 202), len:120}, {datafield:"chairman", label:Config.language("GildPanel", 203), len:70}, {datafield:"level", label:Config.language("GildPanel", 204), len:40}, {datafield:"gamemoney", label:Config.language("GildPanel", 205), len:70}, {datafield:"membernum", label:Config.language("GildPanel", 206), len:40}, {datafield:"membernum", label:Config.language("GildPanel", 207), len:90, childmc:"makemc"}];
            var _loc_4:* = new Label(this.subpanel, 10, 25, Config.language("GildPanel", 208));
            this.getleague();
            this.leaguedata = new DataGridUI(_loc_3, this.subpanel, 10, 25, 470, 160);
            this.leaguedata.topshow = false;
            var _loc_5:* = new Label(this.subpanel, 10, 100, Config.language("GildPanel", 209));
            this.leaguelistdata = new DataGridUI(_loc_3, this.subpanel, 10, 120, 470, 160);
            this.sendleaguelist();
            return;
        }// end function

        private function setgildmoney(event:MouseEvent) : void
        {
            var tempa:TextAreaUI;
            var tempb:TextAreaUI;
            var writebtn:PushButton;
            var btcfuc:*;
            var e:* = event;
            btcfuc = function (event:MouseEvent) : void
            {
                if (writebtn.label == Config.language("GildPanel", 15))
                {
                    writebtn.label = Config.language("GildPanel", 212);
                    tempa.edit = true;
                    tempb.edit = true;
                }
                else
                {
                    writebtn.label = Config.language("GildPanel", 15);
                    tempa.edit = false;
                    tempb.edit = false;
                    sendgildenter(tempa, tempb);
                }
                return;
            }// end function
            ;
            this.clearsub();
            this.subpanel = new Window(this.container, this.x + 50, this.y + 50);
            this.subpanel.open();
            this.subpanel.title = Config.language("GildPanel", 210);
            this.subpanel.resize(250, 200);
            var tm1:* = new Label(this.subpanel, 20, 30, Config.language("GildPanel", 211));
            var tma:* = new Panel(this.subpanel, 20, 60);
            tma.setSize(25, 10);
            tma.color = 16763904;
            tempa = new TextAreaUI(this.subpanel, 40, 55, 70, 14);
            tempa.text = this.gildinforobj.rugildmoney;
            tempa.maxChars = 8;
            tempa.restrict = "0-9";
            var tmb:* = new Panel(this.subpanel, 120, 60);
            tmb.setSize(10, 10);
            tmb.roundCorner = 10;
            tmb.color = 16763904;
            tempb = new TextAreaUI(this.subpanel, 140, 55, 70, 14);
            tempb.text = this.gildinforobj.rugamemoney;
            tempb.restrict = "0-9";
            tempb.maxChars = 8;
            writebtn = new PushButton(this.subpanel, 220, 60, Config.language("GildPanel", 15), btcfuc);
            writebtn.width = 20;
            if (Config._switchMobage)
            {
                writebtn.visible = false;
            }
            return;
        }// end function

        private function sendgildenter(param1:TextAreaUI, param2:TextAreaUI) : void
        {
            var _loc_3:* = new DataSet();
            _loc_3.addHead(CONST_ENUM.C2G_GUILD_ENTER_REQ);
            _loc_3.add32(int(param2.text));
            _loc_3.add32(int(param1.text));
            ClientSocket.send(_loc_3);
            return;
        }// end function

        private function backgildenter(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            var _loc_4:* = _loc_2.readUnsignedInt();
            this.gildinforobj.rugamemoney = _loc_3;
            this.gildinforobj.rugildmoney = _loc_4;
            return;
        }// end function

        public function get leagarr() : Array
        {
            return this.leaguearr;
        }// end function

        private function vsdataRollOver(event:DataGridEvent) : void
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_VS_INFO);
            _loc_2.add32(int(event.rowobj.id));
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function vsdataRollOverShow(event:SocketEvent) : void
        {
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_2:* = event.data;
            var _loc_3:* = "";
            _loc_3 = _loc_3 + ("<font color=\'" + Style.FONT_3_Orange + "\'>");
            _loc_3 = _loc_3 + Config.language("GildPanel", 213);
            _loc_3 = _loc_3 + "</font>";
            var _loc_4:* = _loc_2.readUnsignedInt();
            var _loc_5:* = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_8 = _loc_2.readUnsignedInt();
                _loc_9 = _loc_2.readUnsignedShort();
                _loc_3 = _loc_3 + ("\n" + this.getLenStr(String("[ " + int((_loc_5 + 1)) + " ] " + _loc_2.readUTFBytes(_loc_9)), String(_loc_2.readUnsignedInt()), 180));
                _loc_5 = _loc_5 + 1;
            }
            _loc_3 = _loc_3 + ("<font color=\'" + Style.FONT_5_Green + "\'>");
            _loc_3 = _loc_3 + Config.language("GildPanel", 214);
            _loc_3 = _loc_3 + "</font>";
            var _loc_6:* = _loc_2.readUnsignedInt();
            var _loc_7:* = 0;
            while (_loc_7 < _loc_6)
            {
                
                _loc_8 = _loc_2.readUnsignedInt();
                _loc_10 = _loc_2.readUnsignedShort();
                _loc_3 = _loc_3 + ("\n" + this.getLenStr(String("[ " + int((_loc_7 + 1)) + " ] " + _loc_2.readUTFBytes(_loc_10)), String(_loc_2.readUnsignedInt()), 180));
                _loc_7 = _loc_7 + 1;
            }
            Holder.showInfo(_loc_3, new Rectangle(stage.mouseX, stage.mouseY, 0, 0));
            return;
        }// end function

        private function getLenStr(param1:String, param2:String, param3:int) : String
        {
            var _loc_4:* = "";
            this.templabel1.text = param1;
            this.templabel2.text = param2;
            if (this.templabel1.width + this.templabel2.width <= param3)
            {
                _loc_4 = param1 + this.lenToStr(param3 - this.templabel1.width - this.templabel2.width) + param2;
            }
            else
            {
                _loc_4 = param1 + param2;
            }
            return _loc_4;
        }// end function

        private function lenToStr(param1:int = 0) : String
        {
            var _loc_2:* = "";
            var _loc_3:* = Math.floor(param1 / 3.13);
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_2 = _loc_2 + " ";
                _loc_4 = _loc_4 + 1;
            }
            return _loc_2;
        }// end function

        private function vsdataRollOut(event:DataGridEvent) : void
        {
            Holder.closeInfo();
            return;
        }// end function

        private function membersort(event:DataGridEvent) : void
        {
            switch(event.selectIndex)
            {
                case 0:
                {
                    break;
                }
                case 1:
                {
                    this.membersortobj.flag = 3;
                    break;
                }
                case 2:
                {
                    this.membersortobj.flag = 1;
                    break;
                }
                case 3:
                {
                    this.membersortobj.flag = 2;
                    break;
                }
                case 4:
                {
                    this.membersortobj.flag = 4;
                    break;
                }
                case 5:
                {
                    this.membersortobj.flag = 5;
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (event.rowobj.sort)
            {
                this.membersortobj.sort = 0;
            }
            else
            {
                this.membersortobj.sort = 1;
            }
            this.membersortobj.page = 1;
            this.sendmemberlist();
            return;
        }// end function

        private function remembersort(event:DataGridEvent) : void
        {
            switch(event.selectIndex)
            {
                case 0:
                {
                    break;
                }
                case 1:
                {
                    break;
                }
                case 2:
                {
                    this.reMemSort.flag = 1;
                    break;
                }
                case 3:
                {
                    this.reMemSort.flag = 2;
                    break;
                }
                case 4:
                {
                    this.reMemSort.flag = 3;
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (event.rowobj.sort)
            {
                this.reMemSort.sort = 1;
            }
            else
            {
                this.reMemSort.sort = 2;
            }
            this.sendapplylist(null, 0);
            return;
        }// end function

        private function checkonline(event:MouseEvent = null) : void
        {
            if (this.online.selected)
            {
                this.membersortobj.online = 1;
            }
            else
            {
                this.membersortobj.online = 0;
            }
            this.membersortobj.page = 1;
            this.sendmemberlist();
            return;
        }// end function

        private function gildpage(event:MouseEvent, param2:int) : void
        {
            if (param2 == 1)
            {
                if ((this.gildsortobj.page + 1) <= this.gildsortobj.allpage)
                {
                    (this.gildsortobj.page + 1);
                    this.getgildlist();
                }
            }
            else if (param2 == -1)
            {
                if ((this.gildsortobj.page - 1) >= 1)
                {
                    (this.gildsortobj.page - 1);
                    this.getgildlist();
                }
            }
            else if (param2 == -2)
            {
                this.gildsortobj.page = 1;
                this.getgildlist();
            }
            else if (param2 == 2)
            {
                this.gildsortobj.page = this.gildsortobj.allpage;
                this.getgildlist();
            }
            return;
        }// end function

        private function tmemberpage(event:MouseEvent, param2:InputText) : void
        {
            if (param2.text == "")
            {
                Config.message(Config.language("GildPanel", 215));
                return;
            }
            if (int(param2.text) < 1)
            {
                this.gildsortobj.page = 1;
            }
            else if (int(param2.text) > this.gildsortobj.allpage)
            {
                this.gildsortobj.page = this.gildsortobj.allpage;
            }
            else
            {
                this.gildsortobj.page = int(param2.text);
            }
            this.getgildlist();
            return;
        }// end function

        private function memberpage(event:MouseEvent, param2:int) : void
        {
            if (param2 == 1)
            {
                if ((this.membersortobj.page + 1) <= this.membersortobj.allpage)
                {
                    (this.membersortobj.page + 1);
                    this.sendmemberlist();
                }
            }
            else if ((this.membersortobj.page - 1) >= 1)
            {
                (this.membersortobj.page - 1);
                this.sendmemberlist();
            }
            return;
        }// end function

        private function gildlistsort(event:DataGridEvent) : void
        {
            switch(event.selectIndex)
            {
                case 0:
                {
                    break;
                }
                case 1:
                {
                    this.gildsortobj.flag = 1;
                    break;
                }
                case 2:
                {
                    this.gildsortobj.flag = 2;
                    break;
                }
                case 3:
                {
                    this.gildsortobj.flag = 3;
                    break;
                }
                case 4:
                {
                    this.gildsortobj.flag = 4;
                    break;
                }
                case 5:
                {
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (event.rowobj.sort)
            {
                this.gildsortobj.sort = 0;
            }
            else
            {
                this.gildsortobj.sort = 1;
            }
            this.gildsortobj.page = 1;
            this.getgildlist();
            return;
        }// end function

        private function changenamepanel(event:MouseEvent) : void
        {
            this.clearsub();
            this.subpanel = new Window(this.container, this.x + 50, this.y + 50);
            this.subpanel.open();
            this.subpanel.title = Config.language("GildPanel", 216);
            this.subpanel.resize(250, 150);
            var _loc_2:* = new Label(this.subpanel, 20, 50, Config.language("GildPanel", 217));
            var _loc_3:* = new InputText(this.subpanel, 90, 50);
            var _loc_4:* = new PushButton(this.subpanel, 30, 100, Config.language("GildPanel", 218), Config.create(this.invitecheck, 1, _loc_3));
            new PushButton(this.subpanel, 30, 100, Config.language("GildPanel", 218), Config.create(this.invitecheck, 1, _loc_3)).width = 60;
            var _loc_5:* = new PushButton(this.subpanel, 130, 100, Config.language("GildPanel", 219), Config.create(this.invitecheck, 0, _loc_3));
            new PushButton(this.subpanel, 130, 100, Config.language("GildPanel", 219), Config.create(this.invitecheck, 0, _loc_3)).width = 60;
            return;
        }// end function

        public function get downgildtasknum() : int
        {
            return this._downgildtasknum;
        }// end function

        public function set downgildtasknum(param1:int) : void
        {
            this._downgildtasknum = param1;
            return;
        }// end function

        public function inGild(param1:int) : Boolean
        {
            var _loc_3:* = 0;
            if (Config.player == null || this.leaguearr == null)
            {
                return false;
            }
            var _loc_2:* = false;
            if (Config.player.gildid == param1 && param1 != 0)
            {
                _loc_2 = true;
            }
            else
            {
                _loc_3 = 0;
                while (_loc_3 < this.leaguearr.length)
                {
                    
                    if (param1 == this.leaguearr[_loc_3].id)
                    {
                        _loc_2 = true;
                        break;
                    }
                    _loc_3 = _loc_3 + 1;
                }
            }
            return _loc_2;
        }// end function

        public function inCamp(param1:int = 0, param2:int = 0, param3:int = 0) : Boolean
        {
            var _loc_4:* = false;
            if (param2 == 0 || Config.player._camp == 0 || param1 == 0 || Config.player._gildid == 0 || Config.player._gildTeam == 0)
            {
                _loc_4 = false;
            }
            else if (param2 == Config.player._camp)
            {
                if (param3 == Config.player._gildTeam)
                {
                    _loc_4 = false;
                }
                else
                {
                    _loc_4 = true;
                }
            }
            return _loc_4;
        }// end function

        public function inPkCamp(param1:int = 0, param2:int = 0, param3:int = 0) : Boolean
        {
            var _loc_4:* = false;
            if (param2 == 0 || Config.player._camp == 0 || param1 == 0 || Config.player._gildid == 0 || Config.player._gildTeam == 0)
            {
                _loc_4 = true;
            }
            else if (param2 == Config.player._camp)
            {
                if (param3 == Config.player._gildTeam)
                {
                    _loc_4 = false;
                }
                else
                {
                    _loc_4 = true;
                }
            }
            else
            {
                _loc_4 = true;
            }
            return _loc_4;
        }// end function

        public function get gild_money() : Number
        {
            return this.gildinforobj.gamemoney;
        }// end function

        private function warlist(event:MouseEvent = null) : void
        {
            this.clearsub();
            this.subpanel = new Window(this.container, this.x + 50, this.y + 50);
            this.subpanel.open();
            this.subpanel.title = Config.language("GildPanel", 26);
            this.subpanel.resize(540, 250);
            this.subpanel.addChild(this.vsdata);
            this.sendVsList();
            return;
        }// end function

        private function backDelearWar(event:SocketEvent) : void
        {
            var _loc_2:* = event.data.readByte();
            switch(_loc_2)
            {
                case 0:
                {
                    if (this.gildlistdata != null)
                    {
                        if (this.gildlistdata.stage != null)
                        {
                            this.getgildlist();
                        }
                    }
                    if (this.vsdata != null)
                    {
                        if (this.vsdata.stage != null)
                        {
                            this.warlist();
                        }
                    }
                    break;
                }
                case 1:
                {
                    Config.message(Config.language("GildPanel", 220));
                    break;
                }
                case 2:
                {
                    Config.message(Config.language("GildPanel", 221));
                    break;
                }
                case 3:
                {
                    Config.message(Config.language("GildPanel", 222));
                    break;
                }
                case 4:
                {
                    Config.message(Config.language("GildPanel", 223));
                    break;
                }
                case 5:
                {
                    Config.message(Config.language("GildPanel", 224));
                    break;
                }
                case 6:
                {
                    Config.message(Config.language("GildPanel", 225));
                    break;
                }
                case 7:
                {
                    Config.message(Config.language("GildPanel", 226));
                    break;
                }
                case 8:
                {
                    Config.message(Config.language("GildPanel", 227));
                    break;
                }
                case 9:
                {
                    Config.message(Config.language("GildPanel", 228));
                    break;
                }
                case 10:
                {
                    Config.message(Config.language("GildPanel", 229));
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function sendVsList() : void
        {
            var _loc_1:* = new DataSet();
            _loc_1.addHead(CONST_ENUM.C2G_VS_LIST);
            ClientSocket.send(_loc_1);
            return;
        }// end function

        private function backVsList(event:SocketEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_9:* = false;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            this.vsList = new Array();
            _loc_2 = event.data;
            _loc_3 = _loc_2.readUnsignedInt();
            _loc_4 = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = new Object();
                _loc_5.id = _loc_2.readUnsignedInt();
                _loc_5.atkId = _loc_2.readUnsignedInt();
                _loc_6 = _loc_2.readUnsignedShort();
                _loc_5.atkName = _loc_2.readUTFBytes(_loc_6);
                _loc_5.atkPoint = _loc_2.readUnsignedInt();
                _loc_5.defId = _loc_2.readUnsignedInt();
                _loc_7 = _loc_2.readUnsignedShort();
                _loc_5.defName = _loc_2.readUTFBytes(_loc_7);
                _loc_5.defPoint = _loc_2.readUnsignedInt();
                _loc_5.time = _loc_2.readUnsignedInt();
                _loc_5.timeText = new Label(null, 10, 0, Config.timePoint(_loc_5.time, 3));
                _loc_8 = new Sprite();
                _loc_8.addChild(_loc_5.timeText);
                _loc_5.endTime = _loc_8;
                _loc_5.vs = "vs";
                _loc_5.atkNameSp = new Sprite();
                _loc_5.defNameSp = new Sprite();
                _loc_9 = false;
                if (this._mytype == 1 || this._mytype == 2)
                {
                    if (Config.player._camp == 0)
                    {
                        _loc_9 = true;
                    }
                }
                if (_loc_9)
                {
                    _loc_10 = new ClickLabel(_loc_5.atkNameSp, 0, 0, _loc_5.atkName, Config.create(this.reWarTip, _loc_5.atkId, _loc_5.atkName), true);
                    _loc_10.clickColor([26367, 6837142]);
                    _loc_11 = new ClickLabel(_loc_5.defNameSp, 0, 0, _loc_5.defName, Config.create(this.reWarTip, _loc_5.defId, _loc_5.defName), true);
                    _loc_11.clickColor([26367, 6837142]);
                }
                else
                {
                    _loc_12 = new Label(_loc_5.atkNameSp, 0, 0, _loc_5.atkName);
                    _loc_13 = new Label(_loc_5.defNameSp, 0, 0, _loc_5.defName);
                }
                this.vsList.push(_loc_5);
                _loc_4 = _loc_4 + 1;
            }
            this.vsdata.dataProvider = this.vsList;
            this.gildTimer.start();
            return;
        }// end function

        private function reWarTip(event:TextEvent, param2:int, param3:String) : void
        {
            this.chatWarObj = {tid:param2, tname:param3};
            DropDown.dropDown([Config.language("GildPanel", 230)], this.handleWarDownClick);
            Holder.closeInfo();
            return;
        }// end function

        private function handleWarDownClick(param1)
        {
            if (param1 == 0)
            {
                this.sendLeagWar(null, this.chatWarObj.tid, this.chatWarObj.tname);
            }
            return;
        }// end function

        private function timeUpdate(event:TimerEvent) : void
        {
            var _loc_2:* = false;
            var _loc_3:* = 0;
            _loc_2 = false;
            _loc_3 = 0;
            while (_loc_3 < this.vsList.length)
            {
                
                if (this.vsList[_loc_3].time > int(Config.now.getTime() / 1000))
                {
                    this.vsList[_loc_3].timeText.text = Config.timePoint(this.vsList[_loc_3].time, 3);
                    _loc_2 = true;
                }
                _loc_3 = _loc_3 + 1;
            }
            if (!_loc_2)
            {
                this.gildTimer.stop();
            }
            return;
        }// end function

        private function warUpdate(event:SocketEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            _loc_2 = event.data;
            _loc_3 = _loc_2.readUnsignedInt();
            _loc_4 = _loc_2.readUnsignedInt();
            _loc_5 = _loc_2.readUnsignedInt();
            _loc_6 = 0;
            while (_loc_6 < this.vsList.length)
            {
                
                if (this.vsList[_loc_6].id == _loc_3)
                {
                    this.vsList[_loc_6].atkPoint = _loc_4;
                    this.vsList[_loc_6].defPoint = _loc_5;
                }
                _loc_6 = _loc_6 + 1;
            }
            if (this.vsdata.parent != null)
            {
                this.vsdata.dataProvider = this.vsList;
            }
            return;
        }// end function

        public function get gildShopLevel() : int
        {
            return this._gildShopLevel;
        }// end function

        public function set gildShopLevel(param1:int) : void
        {
            this._gildShopLevel = param1;
            this.gildpanelobj.shoplevel.text = Config.coinShow(param1);
            if (this._gildShopLevel == 15)
            {
                this.gildpanelobj.btn5.visible = false;
            }
            return;
        }// end function

        private function openGildShop(event:MouseEvent) : void
        {
            Config.ui._shopUI.getitemlist(20050);
            return;
        }// end function

        public function get gildSource() : int
        {
            return this._gildSource;
        }// end function

        public function set gildSource(param1:int) : void
        {
            this._gildSource = param1;
            this.gildpanelobj.resources.text = Config.coinShow(param1);
            return;
        }// end function

        public function get gildlv() : int
        {
            return this._gildlv;
        }// end function

        public function set gildlv(param1:int) : void
        {
            this._gildlv = param1;
            return;
        }// end function

        public function setGildCoin() : void
        {
            if (this.gildpanelobj.gildCoin != null)
            {
                this.gildpanelobj.gildCoin.text = Config.player.gildCoin;
            }
            return;
        }// end function

        public function setGildLandNum(param1:int) : void
        {
            if (this.gildpanelobj.landgrave != null)
            {
                this.gildpanelobj.landgrave.text = param1;
            }
            return;
        }// end function

        private function maxSource(event:MouseEvent, param2:InputText) : void
        {
            param2.text = Config.ui._charUI.getItemAmount(94502);
            return;
        }// end function

        private function gildExpFuc(event:SocketEvent) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            _loc_2 = event.data.readUnsignedInt();
            _loc_3 = Config.language("GildPanel", 264, _loc_2);
            BubbleUI.bubble(_loc_3, 16776960);
            Config.addHistory(_loc_3);
            return;
        }// end function

    }
}
