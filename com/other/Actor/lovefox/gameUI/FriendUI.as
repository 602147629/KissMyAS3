package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;
    import lovefox.component.*;
    import lovefox.socket.*;

    public class FriendUI extends Window
    {
        private var friendarr:Array;
        private var blackarr:Array;
        private var enemyarr:Array;
        private var scenearr:Array;
        private var _slotArray:Array;
        private var datalist:DataGridUI;
        private var infor:FriendInfor;
        private var friendmc:CanvasUI;
        private var blackmc:CanvasUI;
        private var scenemc:CanvasUI;
        private var blackinput:TextField;
        private var topbtn:ButtonBar;
        private var mainpanel:Sprite;
        private var subpanel:Window;
        private var empanel:Window;
        private var blpanel:Window;
        private var firsortobj:Object;
        private var lookinfopanel:Window;
        private var personchartpanel:Window;
        private var flaglook:Boolean = true;
        private var tabel:TextField;
        private var infoarray:Object;
        private var temppagearr:Array;
        private var ii:int;
        private var pagetotal:int;
        private var allpg:int = 10;
        private var delRelationType:uint;
        private var delRelationId:int;

        public function FriendUI(param1)
        {
            this.infoarray = [];
            super(param1);
            resize(300, 380);
            this.initDraw();
            Config.jobTitleMap = [Config.language("FriendUI", 58), Config.language("FriendUI", 59), "狂战", "剑士", Config.language("FriendUI", 60), "魔射手", "赏金猎人", "骑士", "龙骑", "圣骑士", Config.language("FriendUI", 61), "青魔法师", "红魔法师"];
            title = Config.language("FriendUI", 1);
            return;
        }// end function

        private function initDraw() : void
        {
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_RELATION_LIST, this.backallist);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_APPLY_ADD_FRIEND, this.getrequest);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_FRIEND_STATUS, this.backinventrefuse);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_RELATION_ADD, this.addallrelation);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_RELATION_DEL, this.delallrelation);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_RELATION_ONLINE, this.noticeonline);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_RELATION_OFFLINE, this.noticeoffline);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_RELATION_LEVELUP, this.updatelever);
            this.initpanel();
            return;
        }// end function

        public function get friends() : Array
        {
            var _loc_2:* = 0;
            var _loc_1:* = new Array();
            if (this.friendarr != null)
            {
                _loc_2 = 0;
                while (_loc_2 < this.friendarr.length)
                {
                    
                    _loc_1.push(this.friendarr[_loc_2].name);
                    _loc_2++;
                }
            }
            return _loc_1;
        }// end function

        private function initpanel() : void
        {
            this.mainpanel = new Sprite();
            this.addChild(this.mainpanel);
            this.topbtn = new ButtonBar(this, 15, 25);
            this.topbtn.addTab(Config.language("FriendUI", 2), this.friendpanel);
            this.topbtn.addTab(Config.language("FriendUI", 3), this.enemypanel);
            if (!Config._switchMobage)
            {
                this.topbtn.addTab(Config.language("FriendUI", 4), this.blackpanel);
            }
            this.firsortobj = {online:1};
            var _loc_1:* = new Shape();
            _loc_1.graphics.lineStyle(0);
            _loc_1.graphics.moveTo(8, 324);
            _loc_1.graphics.lineTo(292, 324);
            addChild(_loc_1);
            return;
        }// end function

        override public function open(event:MouseEvent = null)
        {
            super.open();
            this.topbtn.selectpage = 0;
            this.friendpanel();
            return;
        }// end function

        private function friendpanel(event:MouseEvent = null) : void
        {
            var _loc_4:* = null;
            this.removeallchild(this.mainpanel);
            if (Config._switchMobage)
            {
                _loc_4 = [{datafield:"name", label:Config.language("FriendUI", 5), len:120}, {datafield:"level", label:Config.language("FriendUI", 6), len:80}, {datafield:"jobname", label:Config.language("FriendUI", 7), len:80}];
            }
            else
            {
                _loc_4 = [{datafield:"name", label:Config.language("FriendUI", 5), len:90}, {datafield:"level", label:Config.language("FriendUI", 6), len:50}, {datafield:"jobname", label:Config.language("FriendUI", 7), len:50}, {datafield:"online", label:Config.language("FriendUI", 8), len:90, childmc:"manualbar"}];
            }
            this.datalist = new DataGridUI(_loc_4, this.mainpanel, 10, 48, 280, 300);
            if (this.friendarr != null)
            {
                this.infoarray = this.friendarr;
            }
            else
            {
                this.infoarray = [];
            }
            this.pageupdown();
            this.datalist.dataProvider = this.temppagearr;
            this.datalist.addEventListener(DataGridEvent.ROW_SELECT, this.selectfrow);
            this.datalist.addEventListener(DataGridEvent.CLOMN_SORT, this.friendsort);
            var _loc_2:* = new PushButton(this.mainpanel, 205, 330, Config.language("FriendUI", 9), this.adfnamefuc);
            _loc_2.width = 80;
            var _loc_3:* = new CheckBox(this.mainpanel, 15, 337, Config.language("FriendUI", 10));
            this.firsortobj.online = 1;
            if (this.firsortobj.online == 1)
            {
                _loc_3.selected = false;
            }
            else
            {
                _loc_3.selected = true;
            }
            _loc_3.addEventListener(MouseEvent.CLICK, Config.create(this.showonline, _loc_3));
            return;
        }// end function

        private function blackpanel(event:MouseEvent = null) : void
        {
            this.removeallchild(this.mainpanel);
            var _loc_2:* = [{datafield:"name", label:Config.language("FriendUI", 5), len:120}, {datafield:"level", label:Config.language("FriendUI", 6), len:80}, {datafield:"jobname", label:Config.language("FriendUI", 7), len:80}];
            this.datalist = new DataGridUI(_loc_2, this.mainpanel, 10, 48, 280, 300);
            if (this.blackarr != null)
            {
                this.infoarray = this.blackarr;
            }
            else
            {
                this.infoarray = [];
            }
            this.pageupdown();
            this.datalist.dataProvider = this.temppagearr;
            this.datalist.addEventListener(DataGridEvent.ROW_SELECT, this.selecthrow);
            this.datalist.addEventListener(DataGridEvent.CLOMN_SORT, this.friendsort);
            var _loc_3:* = new PushButton(this.mainpanel, 205, 330, Config.language("FriendUI", 11), this.adblackfuc);
            _loc_3.width = 80;
            var _loc_4:* = new CheckBox(this.mainpanel, 15, 337, Config.language("FriendUI", 10));
            this.firsortobj.online = 1;
            if (this.firsortobj.online == 1)
            {
                _loc_4.selected = false;
            }
            else
            {
                _loc_4.selected = true;
            }
            _loc_4.addEventListener(MouseEvent.CLICK, Config.create(this.showonline, _loc_4));
            return;
        }// end function

        private function enemypanel(event:MouseEvent = null) : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = null;
            this.removeallchild(this.mainpanel);
            var _loc_2:* = [{datafield:"name", label:Config.language("FriendUI", 5), len:90}, {datafield:"level", label:Config.language("FriendUI", 6), len:45}, {datafield:"jobname", label:Config.language("FriendUI", 7), len:50}, {datafield:"killdate", label:Config.language("FriendUI", 12), len:95}];
            this.datalist = new DataGridUI(_loc_2, this.mainpanel, 10, 48, 280, 300);
            this.datalist.addEventListener(DataGridEvent.ROW_SELECT, this.selecterow);
            this.datalist.addEventListener(DataGridEvent.CLOMN_SORT, this.friendsort);
            if (this.enemyarr != null)
            {
                this.infoarray = this.enemyarr;
            }
            else
            {
                this.infoarray = [];
            }
            if (this.topbtn.selectpage == 1)
            {
                this.temppagearr = [];
                this.pagetotal = (this.enemyarr.length - 1) / this.allpg + 1;
                if (this.ii >= this.pagetotal)
                {
                    this.ii = this.pagetotal;
                }
                if (this.enemyarr.length <= this.allpg)
                {
                    this.temppagearr = this.enemyarr;
                }
                else
                {
                    _loc_4 = this.allpg * (this.ii - 1);
                    while (_loc_4 < this.allpg * this.ii)
                    {
                        
                        if (this.enemyarr[_loc_4] != null)
                        {
                            this.temppagearr.push(this.enemyarr[_loc_4]);
                        }
                        else
                        {
                            break;
                        }
                        _loc_4++;
                    }
                }
                this.tabel.text = this.ii + "/" + this.pagetotal;
                this.datalist.dataProvider = this.temppagearr;
            }
            this.pageupdown();
            this.datalist.dataProvider = this.temppagearr;
            if (!Config._switchMobage)
            {
                _loc_5 = new PushButton(this.mainpanel, 205, 330, Config.language("FriendUI", 13), this.ademfuc);
                _loc_5.width = 80;
            }
            var _loc_3:* = new CheckBox(this.mainpanel, 15, 337, Config.language("FriendUI", 10));
            this.firsortobj.online = 1;
            if (this.firsortobj.online == 1)
            {
                _loc_3.selected = false;
            }
            else
            {
                _loc_3.selected = true;
            }
            _loc_3.addEventListener(MouseEvent.CLICK, Config.create(this.showonline, _loc_3));
            return;
        }// end function

        private function backenemylist(event:SocketEvent) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_2:* = event.data;
            this.enemyarr = new Array();
            var _loc_3:* = _loc_2.readByte();
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = new Date();
                _loc_6 = new Object();
                _loc_6.id = _loc_2.readUnsignedInt();
                _loc_7 = _loc_2.readUnsignedShort();
                _loc_6.name = _loc_2.readUTFBytes(_loc_7);
                _loc_6.onlinenotice = _loc_2.readByte();
                _loc_8 = _loc_2.readUnsignedInt();
                _loc_5.setTime(_loc_8 * 1000);
                _loc_6.killdate = _loc_5.getFullYear() + "-" + int((_loc_5.getMonth() + 1)) + "-" + _loc_5.getDate();
                _loc_6.online = _loc_2.readByte();
                _loc_6.job = _loc_2.readByte();
                _loc_6.jobname = Config._jobTitleMap[_loc_6.job];
                _loc_6.level = _loc_2.readUnsignedShort();
                if (_loc_6.online == 0)
                {
                    _loc_6.textcolor = 6710886;
                }
                else
                {
                    _loc_6.textcolor = 0;
                }
                this.enemyarr.push(_loc_6);
                _loc_4++;
            }
            return;
        }// end function

        private function ademfuc(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            if (this.empanel != null)
            {
                if (this.empanel.parent == null)
                {
                    this.empanel.open();
                }
            }
            else
            {
                this.empanel = new Window(this.container, this.x + 20, this.y + 50);
                this.empanel.title = Config.language("FriendUI", 14);
                this.empanel.resize(200, 120);
                _loc_2 = new Label(this.empanel, 10, 40, Config.language("FriendUI", 15));
                _loc_3 = new InputText(this.empanel, 60, 40);
                _loc_3.width = 80;
                _loc_4 = new PushButton(this.empanel, 20, 80, Config.language("FriendUI", 16), Config.create(this.sendAddEnemyname, _loc_3));
                _loc_4.width = 60;
                _loc_5 = new PushButton(this.empanel, 120, 80, Config.language("FriendUI", 17), this.closeem);
                _loc_5.width = 60;
                this.empanel.open();
                _loc_3.focus = true;
            }
            return;
        }// end function

        private function closeem(event:MouseEvent) : void
        {
            this.empanel.close();
            return;
        }// end function

        public function sendAddEnemyname(event:MouseEvent, param2:InputText) : void
        {
            if (param2.text == "")
            {
                Config.message(Config.language("FriendUI", 18));
            }
            else if (param2.text == Config.player.name)
            {
                Config.message(Config.language("FriendUI", 19), 2);
            }
            else
            {
                this.sendAddEnemy(param2.text);
                this.empanel.close();
            }
            return;
        }// end function

        public function sendAddEnemy(param1:String) : void
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_RELATION_ADD);
            _loc_2.add8(3);
            _loc_2.addUTF(param1);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function personchart(event:TextEvent, param2:String)
        {
            this.flaglook = false;
            Config.ui._chatUI.whisperTo(param2);
            return;
        }// end function

        private function adfnamefuc(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            if (this.subpanel != null)
            {
                if (this.subpanel.parent == null)
                {
                    this.subpanel.open();
                }
            }
            else
            {
                this.subpanel = new Window(this.container, this.x + 20, this.y + 50);
                this.subpanel.title = Config.language("FriendUI", 20);
                this.subpanel.resize(200, 120);
                _loc_2 = new Label(this.subpanel, 10, 40, Config.language("FriendUI", 15));
                _loc_3 = new InputText(this.subpanel, 60, 40);
                _loc_3.width = 80;
                _loc_4 = new PushButton(this.subpanel, 20, 80, Config.language("FriendUI", 21), Config.create(this.addfindname, _loc_3));
                _loc_4.width = 60;
                _loc_5 = new PushButton(this.subpanel, 120, 80, Config.language("FriendUI", 17), this.closesub);
                _loc_5.width = 60;
                this.subpanel.open();
                _loc_3.focus = true;
            }
            return;
        }// end function

        private function closesub(event:MouseEvent) : void
        {
            this.subpanel.close();
            return;
        }// end function

        private function addfindname(event:MouseEvent, param2:InputText) : void
        {
            if (param2.text == "")
            {
                Config.message(Config.language("FriendUI", 18));
            }
            else
            {
                this.addFriend(param2.text);
                this.subpanel.close();
            }
            return;
        }// end function

        public function addFriend(param1:String) : void
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_RELATION_ADD);
            _loc_2.add8(1);
            _loc_2.addUTF(param1);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function getrequest(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            var _loc_4:* = _loc_2.readUnsignedShort();
            var _loc_5:* = _loc_2.readUTFBytes(_loc_4);
            var _loc_6:* = new Object();
            new Object().type = 1;
            _loc_6.fname = _loc_5;
            _loc_6.title = Config.language("FriendUI", 22);
            _loc_6.msg = Config.language("FriendUI", 23, _loc_5);
            _loc_6.btns = [Config.language("FriendUI", 24), Config.language("FriendUI", 25)];
            _loc_6.funcs = [this.sendokmsg, this.sendcancelmsg];
            _loc_6.d = {rename:_loc_5, friendId:_loc_3};
            if (Config.disturbMode)
            {
                ListTip.addList(_loc_6);
            }
            else
            {
                AlertUI.alert(Config.language("FriendUI", 22), Config.language("FriendUI", 23, _loc_5), [Config.language("FriendUI", 24), Config.language("FriendUI", 25)], [this.sendokmsg, this.sendcancelmsg], {rename:_loc_5, friendId:_loc_3}, false, true, false, null, true);
            }
            return;
        }// end function

        private function backinventrefuse(event:SocketEvent)
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readByte();
            var _loc_4:* = _loc_2.readUnsignedShort();
            var _loc_5:* = _loc_2.readUTFBytes(_loc_4);
            if (_loc_3 == 1)
            {
                Config.message(Config.language("FriendUI", 26, _loc_5));
            }
            else if (_loc_3 == 2)
            {
                Config.message(Config.language("FriendUI", 27, _loc_5));
            }
            return;
        }// end function

        private function sendokmsg(param1) : void
        {
            trace(param1.rename);
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_FRIEND_APPLY_RESULT);
            _loc_2.add8(0);
            _loc_2.add32(param1.friendId);
            _loc_2.addUTF(param1.rename);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function sendcancelmsg(param1) : void
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_FRIEND_APPLY_RESULT);
            _loc_2.add8(1);
            _loc_2.add32(param1.friendId);
            _loc_2.addUTF(param1.rename);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function getinfor(event:TextEvent, param2:int) : void
        {
            if (this.infor != null)
            {
                this.infor.close();
            }
            if (param2 == 1)
            {
                this.infor = new FriendInfor(this.friendarr[int(event.text)]);
            }
            else
            {
                this.infor = new FriendInfor(this.blackarr[int(event.text)]);
            }
            this.infor.x = this.x - this.infor.width;
            this.infor.y = this.mouseY;
            Config.ui.addChild(this.infor);
            this.infor.addEventListener(FriendEvent.DEL_FRIEND, this.senddelfriend);
            this.infor.addEventListener(FriendEvent.ADD_BLACK, this.sendaddblack);
            return;
        }// end function

        private function senddelfriend(event:MouseEvent, param2:int) : void
        {
            trace(param2, "*************");
            var _loc_3:* = new DataSet();
            _loc_3.addHead(CONST_ENUM.C2G_RELATION_DEL);
            _loc_3.add8(1);
            _loc_3.add32(param2);
            ClientSocket.send(_loc_3);
            return;
        }// end function

        private function senddelblack(param1, param2:int) : void
        {
            var _loc_3:* = new DataSet();
            _loc_3.addHead(CONST_ENUM.C2G_RELATION_DEL);
            _loc_3.add8(2);
            _loc_3.add32(param2);
            ClientSocket.send(_loc_3);
            return;
        }// end function

        public function sendaddblack(event:MouseEvent, param2:String) : void
        {
            trace("sendaddblack", param2);
            var _loc_3:* = new DataSet();
            _loc_3.addHead(CONST_ENUM.C2G_RELATION_ADD);
            _loc_3.add8(2);
            _loc_3.addUTF(param2);
            ClientSocket.send(_loc_3);
            return;
        }// end function

        private function adblackfuc(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            if (this.blpanel != null)
            {
                if (this.blpanel.parent == null)
                {
                    this.blpanel.open();
                }
            }
            else
            {
                this.blpanel = new Window(this.container, this.x + 20, this.y + 50);
                this.blpanel.title = Config.language("FriendUI", 28);
                this.blpanel.resize(200, 120);
                _loc_2 = new Label(this.blpanel, 10, 40, Config.language("FriendUI", 15));
                _loc_3 = new InputText(this.blpanel, 60, 40);
                _loc_3.width = 80;
                _loc_4 = new PushButton(this.blpanel, 20, 80, Config.language("FriendUI", 29), Config.create(this.sendAddblackname, _loc_3));
                _loc_4.width = 70;
                _loc_5 = new PushButton(this.blpanel, 120, 80, Config.language("FriendUI", 17), this.closebl);
                _loc_5.width = 60;
                this.blpanel.open();
                _loc_3.focus = true;
            }
            return;
        }// end function

        private function closebl(event:MouseEvent) : void
        {
            this.blpanel.close();
            return;
        }// end function

        public function sendAddblackname(event:MouseEvent, param2:InputText) : void
        {
            if (param2.text == "")
            {
                Config.message(Config.language("FriendUI", 18));
            }
            else
            {
                this.addhei(param2.text);
                this.blpanel.close();
            }
            return;
        }// end function

        public function addhei(param1:String) : void
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_RELATION_ADD);
            _loc_2.add8(2);
            _loc_2.addUTF(param1);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function dodelfriend() : void
        {
            trace("dodelfriend");
            var _loc_1:* = this.delRelationId;
            trace(this.friendarr.length);
            var _loc_2:* = 0;
            while (_loc_2 < this.friendarr.length)
            {
                
                if (_loc_1 == int(this.friendarr[_loc_2].id))
                {
                    this.friendarr.splice(_loc_2, 1);
                    break;
                }
                _loc_2++;
            }
            this.sortflist(3, true);
            if (this.infor != null)
            {
                this.infor.close();
            }
            return;
        }// end function

        private function dodelblack() : void
        {
            var _loc_2:* = 0;
            var _loc_1:* = this.delRelationId;
            _loc_2 = 0;
            while (_loc_2 < this.blackarr.length)
            {
                
                if (_loc_1 == int(this.blackarr[_loc_2].id))
                {
                    this.blackarr.splice(_loc_2, 1);
                    break;
                }
                _loc_2++;
            }
            if (this.topbtn.selectpage == 2)
            {
                this.temppagearr = [];
                this.pagetotal = (this.blackarr.length - 1) / this.allpg + 1;
                if (this.ii >= this.pagetotal)
                {
                    this.ii = this.pagetotal;
                }
                else
                {
                    this.ii = 1;
                }
                if (this.blackarr.length <= this.allpg)
                {
                    this.temppagearr = this.blackarr;
                }
                else
                {
                    _loc_2 = this.allpg * (this.ii - 1);
                    while (_loc_2 < this.allpg * this.ii)
                    {
                        
                        if (this.blackarr[_loc_2] != null)
                        {
                            this.temppagearr.push(this.blackarr[_loc_2]);
                        }
                        else
                        {
                            break;
                        }
                        _loc_2++;
                    }
                }
                this.tabel.text = this.ii + "/" + this.pagetotal;
                this.datalist.dataProvider = this.temppagearr;
            }
            return;
        }// end function

        private function changonline(param1:String, param2:int) : void
        {
            var _loc_3:* = 0;
            if (this.friendarr != null)
            {
                _loc_3 = 0;
                while (_loc_3 < this.friendarr.length)
                {
                    
                    if (this.friendarr[_loc_3].name == param1)
                    {
                        this.friendarr[_loc_3].online = param2;
                        if (param2 == 0)
                        {
                            this.friendarr[_loc_3].textcolor = 6710886;
                        }
                        else
                        {
                            this.friendarr[_loc_3].textcolor = 0;
                        }
                        break;
                    }
                    _loc_3++;
                }
                this.sortflist(3, true);
            }
            return;
        }// end function

        private function emychangeonline(param1:String, param2:int) : void
        {
            var _loc_3:* = 0;
            while (_loc_3 < this.enemyarr.length)
            {
                
                if (this.enemyarr[_loc_3].name == param1)
                {
                    this.enemyarr[_loc_3].online = param2;
                    if (param2 == 0)
                    {
                        this.enemyarr[_loc_3].textcolor = 6710886;
                    }
                    else
                    {
                        this.enemyarr[_loc_3].textcolor = 0;
                    }
                    break;
                }
                _loc_3++;
            }
            this.sortflist(3, true);
            return;
        }// end function

        private function order(param1:Object, param2:Object)
        {
            var _loc_3:* = int(param1.online);
            var _loc_4:* = int(param2.online);
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

        private function handleDropDownClick1(param1:int, param2:Object) : void
        {
            switch(param1)
            {
                case 0:
                {
                    Config.ui._teamUI.inviteTeam(param2.id);
                    break;
                }
                case 1:
                {
                    Config.ui._gangs.inviteguild(param2.name);
                    break;
                }
                case 2:
                {
                    Config.ui._mailpanel.sendmailshow(null, param2.name);
                    Config.ui._mailpanel.open();
                    break;
                }
                case 3:
                {
                    Config.ui._equippanel.sendequip(param2.id);
                    break;
                }
                case 4:
                {
                    Config.ui._friendUI.sendAddEnemy(param2.name);
                    break;
                }
                case 5:
                {
                    AlertUI.alert(Config.language("FriendUI", 30), Config.language("FriendUI", 31, param2.name), [Config.language("FriendUI", 24), Config.language("FriendUI", 33)], [Config.create(this.sendaddblack, param2.name), null]);
                    break;
                }
                case 6:
                {
                    Config.ui._friendUI.addFriend(param2.name);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function selectfrow(event:DataGridEvent) : void
        {
            var _loc_2:* = null;
            if (this.flaglook)
            {
                if (Config._switchMobage)
                {
                    _loc_2 = [Config.language("FriendUI", 62), Config.language("FriendUI", 34), Config.language("FriendUI", 35), Config.language("FriendUI", 37), Config.language("FriendUI", 38), Config.language("FriendUI", 40)];
                }
                else
                {
                    _loc_2 = [Config.language("FriendUI", 62), Config.language("FriendUI", 34), Config.language("FriendUI", 35), Config.language("FriendUI", 36), Config.language("FriendUI", 37), Config.language("FriendUI", 38), Config.language("FriendUI", 39), Config.language("FriendUI", 40)];
                }
                DropDown.dropDown(_loc_2, Config.create(this.handleDropDownClick, event.rowobj));
            }
            this.flaglook = true;
            return;
        }// end function

        private function handleDropDownClick(param1:int, param2:Object) : void
        {
            if (Config._switchMobage)
            {
                if (param1 > 1)
                {
                    param1++;
                }
                if (param1 > 4)
                {
                    param1++;
                }
            }
            switch(param1)
            {
                case 0:
                {
                    trace(param2.id);
                    if (Config.ui._giveflower.todaysendnum < 5)
                    {
                        Config.ui._giveflower.open();
                        Config.ui._giveflower.flowerplayerid = param2.id;
                        Config.ui._giveflower.flowerplayername = param2.name;
                    }
                    else
                    {
                        Config.message(Config.language("FriendUI", 63));
                    }
                    break;
                }
                case 1:
                {
                    Config.ui._teamUI.inviteTeam(param2.id);
                    break;
                }
                case 2:
                {
                    Config.ui._gangs.inviteguild(param2.name);
                    break;
                }
                case 3:
                {
                    Config.ui._mailpanel.sendmailshow(null, param2.name);
                    Config.ui._mailpanel.open();
                    break;
                }
                case 4:
                {
                    Config.ui._equippanel.sendequip(param2.id);
                    break;
                }
                case 5:
                {
                    Config.ui._friendUI.sendAddEnemy(param2.name);
                    break;
                }
                case 6:
                {
                    AlertUI.alert(Config.language("FriendUI", 30), Config.language("FriendUI", 31, param2.name), [Config.language("FriendUI", 24), Config.language("FriendUI", 33)], [Config.create(this.sendaddblack, param2.name), null]);
                    break;
                }
                case 7:
                {
                    trace("haoyouid", param2.id);
                    AlertUI.alert(Config.language("FriendUI", 30), Config.language("FriendUI", 41, param2.name), [Config.language("FriendUI", 24), Config.language("FriendUI", 33)], [Config.create(this.senddelfriend, param2.id), null]);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function friendsort(event:DataGridEvent) : void
        {
            this.sortflist(event.selectIndex, event.rowobj.sort);
            return;
        }// end function

        private function showonline(event:MouseEvent, param2:CheckBox) : void
        {
            if (param2.selected)
            {
                this.firsortobj.online = 0;
            }
            else
            {
                this.ii = 1;
                this.firsortobj.online = 1;
            }
            this.sortflist(3, true);
            return;
        }// end function

        private function sortflist(param1:int, param2:Boolean) : void
        {
            var _loc_4:* = null;
            var _loc_6:* = 0;
            var _loc_3:* = "";
            var _loc_5:* = new Array();
            if (this.firsortobj.online == 1)
            {
                _loc_5 = this.infoarray;
            }
            else
            {
                _loc_6 = 0;
                while (_loc_6 < this.infoarray.length)
                {
                    
                    if (this.infoarray[_loc_6].online == 1)
                    {
                        _loc_5.push(this.infoarray[_loc_6]);
                    }
                    _loc_6++;
                }
            }
            switch(param1)
            {
                case 0:
                {
                    _loc_3 = "name";
                    if (param2)
                    {
                        _loc_4 = [Array.DESCENDING, Array.DESCENDING | Array.NUMERIC];
                    }
                    else
                    {
                        _loc_4 = ["", Array.DESCENDING | Array.NUMERIC];
                    }
                    break;
                }
                case 1:
                {
                    _loc_3 = "level";
                    if (param2)
                    {
                        _loc_4 = [Array.DESCENDING | Array.NUMERIC, Array.DESCENDING | Array.NUMERIC];
                    }
                    else
                    {
                        _loc_4 = [Array.NUMERIC, Array.DESCENDING | Array.NUMERIC];
                    }
                    break;
                }
                case 2:
                {
                    _loc_3 = "job";
                    if (param2)
                    {
                        _loc_4 = [Array.DESCENDING | Array.NUMERIC, Array.DESCENDING | Array.NUMERIC];
                    }
                    else
                    {
                        _loc_4 = [Array.NUMERIC, Array.DESCENDING | Array.NUMERIC];
                    }
                    break;
                }
                case 3:
                {
                    if (this.topbtn.selectpage == 0)
                    {
                        _loc_3 = "online";
                    }
                    else if (this.topbtn.selectpage == 1)
                    {
                        _loc_3 = "killdate1";
                    }
                    if (param2)
                    {
                        _loc_4 = [Array.DESCENDING | Array.NUMERIC, Array.DESCENDING | Array.NUMERIC];
                    }
                    else
                    {
                        _loc_4 = [Array.NUMERIC, Array.DESCENDING | Array.NUMERIC];
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            _loc_5.sortOn([_loc_3, "online"], _loc_4);
            if (this._opening)
            {
                this.temppagearr = [];
                this.pagetotal = (_loc_5.length - 1) / this.allpg + 1;
                if (this.ii >= this.pagetotal)
                {
                    this.ii = this.pagetotal;
                }
                if (_loc_5.length <= this.allpg)
                {
                    this.temppagearr = _loc_5;
                }
                else
                {
                    _loc_6 = this.allpg * (this.ii - 1);
                    while (_loc_6 < this.allpg * this.ii)
                    {
                        
                        if (_loc_5[_loc_6] != null)
                        {
                            this.temppagearr.push(_loc_5[_loc_6]);
                        }
                        else
                        {
                            break;
                        }
                        _loc_6++;
                    }
                }
                this.tabel.text = this.ii + "/" + this.pagetotal;
                this.datalist.dataProvider = this.temppagearr;
                trace(this.temppagearr.length, "temppagearr", param1);
            }
            return;
        }// end function

        private function selecterow(event:DataGridEvent) : void
        {
            var _loc_2:* = null;
            if (Config._switchMobage)
            {
                _loc_2 = [Config.language("FriendUI", 43), Config.language("FriendUI", 44), Config.language("FriendUI", 46)];
            }
            else
            {
                _loc_2 = [Config.language("FriendUI", 42), Config.language("FriendUI", 43), Config.language("FriendUI", 44), Config.language("FriendUI", 45), Config.language("FriendUI", 46)];
            }
            DropDown.dropDown(_loc_2, Config.create(this.emClick, event.rowobj));
            return;
        }// end function

        private function emClick(param1:int, param2:Object) : void
        {
            if (Config._switchMobage)
            {
                param1++;
                if (param1 > 2)
                {
                    param1++;
                }
            }
            switch(param1)
            {
                case 0:
                {
                    Config.ui._chatUI.whisperTo(param2.name);
                    break;
                }
                case 1:
                {
                    Config.ui._mailpanel.sendmailshow(null, param2.name);
                    Config.ui._mailpanel.open();
                    break;
                }
                case 2:
                {
                    Config.ui._equippanel.sendequip(param2.id);
                    break;
                }
                case 3:
                {
                    AlertUI.alert(Config.language("FriendUI", 30), Config.language("FriendUI", 31, param2.name), [Config.language("FriendUI", 24), Config.language("FriendUI", 33)], [Config.create(this.sendaddblack, param2.name), null]);
                    break;
                }
                case 4:
                {
                    AlertUI.alert(Config.language("FriendUI", 30), Config.language("FriendUI", 47, param2.name), [Config.language("FriendUI", 24), Config.language("FriendUI", 33)], [Config.create(this.senddelenemy, param2.id), null]);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function senddelenemy(event:MouseEvent, param2:int) : void
        {
            var _loc_3:* = new DataSet();
            _loc_3.addHead(CONST_ENUM.C2G_RELATION_DEL);
            _loc_3.add8(3);
            _loc_3.add32(param2);
            ClientSocket.send(_loc_3);
            return;
        }// end function

        private function backdelenemy() : void
        {
            var _loc_2:* = 0;
            var _loc_1:* = this.delRelationId;
            _loc_2 = 0;
            while (_loc_2 < this.enemyarr.length)
            {
                
                if (_loc_1 == this.enemyarr[_loc_2].id)
                {
                    this.enemyarr.splice(_loc_2, 1);
                    break;
                }
                _loc_2++;
            }
            this.temppagearr = [];
            this.pagetotal = (this.enemyarr.length - 1) / this.allpg + 1;
            if (this.ii >= this.pagetotal)
            {
                this.ii = this.pagetotal;
            }
            else
            {
                this.ii = 1;
            }
            if (this.enemyarr.length <= this.allpg)
            {
                this.temppagearr = this.enemyarr;
            }
            else
            {
                _loc_2 = this.allpg * (this.ii - 1);
                while (_loc_2 < this.allpg * this.ii)
                {
                    
                    if (this.enemyarr[_loc_2] != null)
                    {
                        this.temppagearr.push(this.enemyarr[_loc_2]);
                    }
                    else
                    {
                        break;
                    }
                    _loc_2++;
                }
            }
            this.tabel.text = this.ii + "/" + this.pagetotal;
            this.datalist.dataProvider = this.temppagearr;
            return;
        }// end function

        private function selecthrow(event:DataGridEvent) : void
        {
            var _loc_2:* = [Config.language("FriendUI", 48)];
            DropDown.dropDown(_loc_2, Config.create(this.senddelblack, event.rowobj.id));
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

        private function removeallchild(param1:Sprite) : void
        {
            while (param1.numChildren > 0)
            {
                
                param1.removeChildAt((param1.numChildren - 1));
            }
            return;
        }// end function

        private function initDraw1()
        {
            var _loc_1:* = 0;
            var _loc_2:* = undefined;
            var _loc_3:* = null;
            this._slotArray = [];
            _loc_1 = 1;
            while (_loc_1 < 11)
            {
                
                this._slotArray[_loc_1] = new InvSlot(_loc_1, 32);
                this.lookinfopanel.addChild(this._slotArray[_loc_1]);
                this._slotArray[_loc_1].bg = Config.findUI("charui")["icon" + _loc_1];
                _loc_1++;
            }
            var _loc_4:* = 30;
            var _loc_5:* = 180;
            var _loc_6:* = 40;
            var _loc_7:* = 40;
            this._slotArray[1].x = _loc_4;
            this._slotArray[1].y = _loc_6 + _loc_7 * 3;
            this._slotArray[2].x = _loc_4;
            this._slotArray[2].y = _loc_6;
            this._slotArray[3].x = _loc_4;
            this._slotArray[3].y = _loc_6 + _loc_7;
            this._slotArray[4].x = _loc_4;
            this._slotArray[4].y = _loc_6 + _loc_7 * 2;
            this._slotArray[5].x = _loc_5;
            this._slotArray[5].y = _loc_6 + _loc_7 * 3;
            this._slotArray[6].x = _loc_4;
            this._slotArray[6].y = _loc_6 + _loc_7 * 4;
            this._slotArray[7].x = _loc_5;
            this._slotArray[7].y = _loc_6 + _loc_7;
            this._slotArray[8].x = _loc_5;
            this._slotArray[8].y = _loc_6 + _loc_7 * 2;
            this._slotArray[9].x = _loc_5;
            this._slotArray[9].y = _loc_6;
            this._slotArray[10].x = _loc_5;
            this._slotArray[10].y = _loc_6 + _loc_7 * 4;
            return;
        }// end function

        private function pageupdown()
        {
            var _loc_3:* = 0;
            var _loc_1:* = new PushButton(this.mainpanel, 98, 330, "<", this.create(this.goheadinfo, 2));
            var _loc_2:* = new PushButton(this.mainpanel, 170, 330, ">", this.create(this.goheadinfo, 3));
            _loc_1.width = 30;
            _loc_2.width = 30;
            this.tabel = Config.getSimpleTextField();
            this.tabel.defaultTextFormat = new TextFormat(null, 16, Style.WINDOW_FONT, true);
            this.pagetotal = (this.infoarray.length - 1) / this.allpg + 1;
            if (this.pagetotal == 0)
            {
                this.ii = 0;
            }
            else
            {
                this.ii = 1;
            }
            this.tabel.text = this.ii + "/" + this.pagetotal;
            this.tabel.x = 128;
            this.tabel.y = 330;
            this.tabel.width = 42;
            this.tabel.autoSize = TextFieldAutoSize.CENTER;
            this.mainpanel.addChild(this.tabel);
            this.temppagearr = [];
            if (this.infoarray.length <= this.allpg)
            {
                this.temppagearr = this.infoarray;
            }
            else
            {
                _loc_3 = 0;
                while (_loc_3 < this.allpg)
                {
                    
                    this.temppagearr.push(this.infoarray[_loc_3]);
                    _loc_3++;
                }
            }
            return;
        }// end function

        private function goheadinfo(event:MouseEvent, param2:int)
        {
            var _loc_4:* = 0;
            this.temppagearr = [];
            var _loc_3:* = [];
            trace(this.firsortobj.online);
            if (this.firsortobj.online == 0)
            {
                _loc_4 = 0;
                while (_loc_4 < this.infoarray.length)
                {
                    
                    if (this.infoarray[_loc_4].online == 1)
                    {
                        _loc_3.push(this.infoarray[_loc_4]);
                    }
                    _loc_4++;
                }
            }
            else
            {
                _loc_3 = this.infoarray;
            }
            this.pagetotal = (_loc_3.length - 1) / this.allpg + 1;
            if (param2 == 2)
            {
                if (this.ii > 1)
                {
                    var _loc_5:* = this;
                    var _loc_6:* = this.ii - 1;
                    _loc_5.ii = _loc_6;
                    if (this.ii == 1)
                    {
                        _loc_4 = 0;
                        while (_loc_4 < this.allpg)
                        {
                            
                            this.temppagearr.push(_loc_3[_loc_4]);
                            _loc_4++;
                        }
                    }
                    else
                    {
                        _loc_4 = (this.ii - 1) * this.allpg;
                        while (_loc_4 < this.ii * this.allpg)
                        {
                            
                            this.temppagearr.push(_loc_3[_loc_4]);
                            _loc_4++;
                        }
                    }
                    this.datalist.dataProvider = this.temppagearr;
                }
            }
            else if (param2 == 3)
            {
                if (this.ii < this.pagetotal)
                {
                    var _loc_5:* = this;
                    var _loc_6:* = this.ii + 1;
                    _loc_5.ii = _loc_6;
                    if (this.ii == this.pagetotal)
                    {
                        _loc_4 = (this.pagetotal - 1) * this.allpg;
                        while (_loc_4 < _loc_3.length)
                        {
                            
                            this.temppagearr.push(_loc_3[_loc_4]);
                            _loc_4++;
                        }
                    }
                    else
                    {
                        _loc_4 = (this.ii - 1) * this.allpg;
                        while (_loc_4 < this.ii * this.allpg)
                        {
                            
                            this.temppagearr.push(_loc_3[_loc_4]);
                            _loc_4++;
                        }
                    }
                    this.datalist.dataProvider = this.temppagearr;
                }
            }
            this.tabel.text = this.ii + "/" + this.pagetotal;
            return;
        }// end function

        public function judgefriend(param1:int) : int
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            if (this.blackarr != null)
            {
                _loc_2 = 0;
                while (_loc_2 < this.blackarr.length)
                {
                    
                    if (this.blackarr[_loc_2].id == param1)
                    {
                        _loc_3 = 3;
                        return _loc_3;
                    }
                    _loc_2++;
                }
            }
            if (this.enemyarr != null)
            {
                _loc_2 = 0;
                while (_loc_2 < this.enemyarr.length)
                {
                    
                    if (this.enemyarr[_loc_2].id == param1)
                    {
                        _loc_3 = 2;
                        return _loc_3;
                    }
                    _loc_2++;
                }
            }
            if (this.friendarr != null)
            {
                _loc_2 = 0;
                while (_loc_2 < this.friendarr.length)
                {
                    
                    if (this.friendarr[_loc_2].id == param1)
                    {
                        _loc_3 = 1;
                        return _loc_3;
                    }
                    _loc_2++;
                }
            }
            return _loc_3;
        }// end function

        public function judgeblakname(param1:String) : int
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            if (this.blackarr != null)
            {
                _loc_2 = 0;
                while (_loc_2 < this.blackarr.length)
                {
                    
                    if (this.blackarr[_loc_2].name == param1)
                    {
                        _loc_3 = 3;
                        return _loc_3;
                    }
                    _loc_2++;
                }
            }
            if (this.enemyarr != null)
            {
                _loc_2 = 0;
                while (_loc_2 < this.enemyarr.length)
                {
                    
                    if (this.enemyarr[_loc_2].name == param1)
                    {
                        _loc_3 = 2;
                        return _loc_3;
                    }
                    _loc_2++;
                }
            }
            if (this.friendarr != null)
            {
                _loc_2 = 0;
                while (_loc_2 < this.friendarr.length)
                {
                    
                    if (this.friendarr[_loc_2].name == param1)
                    {
                        _loc_3 = 1;
                        return _loc_3;
                    }
                    _loc_2++;
                }
            }
            return _loc_3;
        }// end function

        private function addallrelation(event:SocketEvent)
        {
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = 0;
            var _loc_12:* = 0;
            var _loc_13:* = null;
            var _loc_2:* = event.data;
            var _loc_3:* = new Object();
            var _loc_4:* = _loc_2.readByte();
            _loc_3.online = _loc_2.readByte();
            var _loc_5:* = _loc_2.readUnsignedInt();
            var _loc_6:* = _loc_2.readUnsignedShort();
            var _loc_7:* = _loc_2.readUTFBytes(_loc_6);
            _loc_3.id = _loc_5;
            _loc_3.name = _loc_7;
            _loc_3.level = _loc_2.readUnsignedShort();
            _loc_3.job = _loc_2.readUnsignedShort();
            _loc_3.jobname = Config._jobTitleMap[_loc_3.job];
            var _loc_8:* = _loc_2.readUnsignedInt();
            if (_loc_3.online == 0)
            {
                _loc_3.textcolor = 6710886;
            }
            else
            {
                _loc_3.textcolor = 0;
            }
            if (_loc_4 == 1)
            {
                _loc_9 = new Sprite();
                _loc_9.x = 200;
                if (this.topbtn.selectpage == 0)
                {
                    this.mainpanel.addChild(_loc_9);
                }
                if (!Config._switchMobage)
                {
                    _loc_10 = new ClickLabel(_loc_9, 26, 2, Config.language("FriendUI", 42), Config.create(this.personchart, _loc_7), true);
                    _loc_10.clickColor([_loc_11, 0]);
                    _loc_3.tempc2 = _loc_10;
                }
                _loc_3.manualbar = _loc_9;
                if (_loc_3.online == 0)
                {
                    _loc_11 = 6710886;
                }
                else
                {
                    _loc_11 = 0;
                }
                this.friendarr.push(_loc_3);
                this.sortflist(3, true);
                Config.message(Config.language("FriendUI", 53));
            }
            else if (_loc_4 == 2)
            {
                this.blackarr.push(_loc_3);
                this.sortflist(3, true);
            }
            else if (_loc_4 == 3)
            {
                _loc_12 = 0;
                while (_loc_12 < this.enemyarr.length)
                {
                    
                    if (_loc_5 == int(this.enemyarr[_loc_12].id))
                    {
                        this.enemyarr.splice(_loc_12, 1);
                        break;
                    }
                    _loc_12++;
                }
                _loc_13 = new Date();
                _loc_13.setTime(_loc_8 * 1000);
                _loc_3.killdate1 = _loc_8;
                _loc_3.killdate = _loc_13.getFullYear() + "-" + int((_loc_13.getMonth() + 1)) + "-" + _loc_13.getDate();
                this.enemyarr.push(_loc_3);
                if (this.topbtn.selectpage == 1)
                {
                    this.temppagearr = [];
                    this.pagetotal = (this.enemyarr.length - 1) / this.allpg + 1;
                    if (this.enemyarr.length <= this.allpg)
                    {
                        this.temppagearr = this.enemyarr;
                    }
                    else
                    {
                        _loc_12 = 0;
                        while (_loc_12 < this.allpg)
                        {
                            
                            this.temppagearr.push(this.enemyarr[_loc_12]);
                            _loc_12++;
                        }
                    }
                    if (this.pagetotal == 0)
                    {
                        this.ii = 0;
                    }
                    else
                    {
                        this.ii = 1;
                    }
                    this.tabel.text = this.ii + "/" + this.pagetotal;
                    this.datalist.dataProvider = this.temppagearr;
                }
            }
            return;
        }// end function

        private function backallist(event:SocketEvent)
        {
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_10:* = undefined;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = 0;
            var _loc_14:* = null;
            this.friendarr = new Array();
            this.blackarr = new Array();
            this.enemyarr = new Array();
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedShort();
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = new Object();
                _loc_6 = _loc_2.readByte();
                _loc_5.online = _loc_2.readByte();
                _loc_7 = _loc_2.readUnsignedInt();
                _loc_8 = _loc_2.readUnsignedShort();
                _loc_9 = _loc_2.readUTFBytes(_loc_8);
                _loc_5.id = _loc_7;
                _loc_5.name = _loc_9;
                _loc_5.level = _loc_2.readUnsignedShort();
                _loc_5.job = _loc_2.readUnsignedShort();
                _loc_5.jobname = Config._jobTitleMap[_loc_5.job];
                _loc_10 = _loc_2.readUnsignedInt();
                if (_loc_5.online == 0)
                {
                    _loc_5.textcolor = 6710886;
                }
                else
                {
                    _loc_5.textcolor = 0;
                }
                if (_loc_6 == 1)
                {
                    _loc_11 = new Sprite();
                    _loc_11.x = 200;
                    if (this.topbtn.selectpage == 0)
                    {
                        this.mainpanel.addChild(_loc_11);
                    }
                    if (!Config._switchMobage)
                    {
                        _loc_12 = new ClickLabel(_loc_11, 26, 2, Config.language("FriendUI", 42), Config.create(this.personchart, _loc_9), true);
                        _loc_12.clickColor([_loc_13, 0]);
                        _loc_5.tempc2 = _loc_12;
                    }
                    _loc_5.manualbar = _loc_11;
                    if (_loc_5.online == 0)
                    {
                        _loc_13 = 6710886;
                    }
                    else
                    {
                        _loc_13 = 0;
                    }
                    this.friendarr.push(_loc_5);
                }
                else if (_loc_6 == 2)
                {
                    this.blackarr.push(_loc_5);
                }
                else if (_loc_6 == 3)
                {
                    trace("仇人是否在在线", _loc_5.online);
                    _loc_14 = new Date();
                    _loc_14.setTime(_loc_10 * 1000);
                    _loc_5.killdate1 = _loc_10;
                    _loc_5.killdate = _loc_14.getFullYear() + "-" + int((_loc_14.getMonth() + 1)) + "-" + _loc_14.getDate();
                    this.enemyarr.push(_loc_5);
                }
                _loc_4++;
            }
            return;
        }// end function

        private function delallrelation(event:SocketEvent)
        {
            var _loc_2:* = event.data;
            this.delRelationType = _loc_2.readByte();
            this.delRelationId = _loc_2.readUnsignedInt();
            if (this.delRelationType == 1)
            {
                this.dodelfriend();
            }
            else if (this.delRelationType == 2)
            {
                this.dodelblack();
            }
            else if (this.delRelationType == 3)
            {
                this.backdelenemy();
            }
            return;
        }// end function

        private function noticeonline(event:SocketEvent)
        {
            var _loc_6:* = 0;
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readByte();
            var _loc_4:* = _loc_2.readUnsignedShort();
            var _loc_5:* = _loc_2.readUTFBytes(_loc_4);
            if (_loc_3 == 1)
            {
                if (this.friendarr != null)
                {
                    _loc_6 = 0;
                    while (_loc_6 < this.friendarr.length)
                    {
                        
                        if (_loc_5 == this.friendarr[_loc_6].name)
                        {
                            this.friendarr[_loc_6].online = 1;
                            this.friendarr[_loc_6].textcolor = 0;
                            if (!Config._switchMobage)
                            {
                                this.friendarr[_loc_6].tempc2.clickColor([0, 0]);
                            }
                            break;
                        }
                        _loc_6++;
                    }
                }
                Config.message(Config.language("FriendUI", 54, _loc_5));
            }
            else if (_loc_3 == 3)
            {
                if (this.enemyarr != null)
                {
                    _loc_6 = 0;
                    while (_loc_6 < this.enemyarr.length)
                    {
                        
                        if (_loc_5 == this.enemyarr[_loc_6].name)
                        {
                            this.enemyarr[_loc_6].online = 1;
                            this.enemyarr[_loc_6].textcolor = 0;
                            break;
                        }
                        _loc_6++;
                    }
                }
                Config.message(Config.language("FriendUI", 55, _loc_5));
            }
            return;
        }// end function

        private function noticeoffline(event:SocketEvent)
        {
            var _loc_6:* = 0;
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readByte();
            var _loc_4:* = _loc_2.readUnsignedShort();
            var _loc_5:* = _loc_2.readUTFBytes(_loc_4);
            if (_loc_3 == 1)
            {
                _loc_6 = 0;
                while (_loc_6 < this.friendarr.length)
                {
                    
                    if (_loc_5 == this.friendarr[_loc_6].name)
                    {
                        this.friendarr[_loc_6].textcolor = 6710886;
                        this.friendarr[_loc_6].online = 0;
                        if (!Config._switchMobage)
                        {
                            this.friendarr[_loc_6].tempc2.clickColor([6710886, 0]);
                        }
                        break;
                    }
                    _loc_6++;
                }
                Config.message(Config.language("FriendUI", 56, _loc_5));
            }
            else if (_loc_3 == 3)
            {
                _loc_6 = 0;
                while (_loc_6 < this.enemyarr.length)
                {
                    
                    if (_loc_5 == this.enemyarr[_loc_6].name)
                    {
                        this.enemyarr[_loc_6].textcolor = 6710886;
                        this.enemyarr[_loc_6].online = 0;
                        break;
                    }
                    _loc_6++;
                }
                Config.message(Config.language("FriendUI", 57, _loc_5));
            }
            return;
        }// end function

        private function updatelever(event:SocketEvent) : void
        {
            var _loc_6:* = 0;
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readByte();
            var _loc_4:* = _loc_2.readUnsignedInt();
            var _loc_5:* = _loc_2.readUnsignedShort();
            if (_loc_3 == 1)
            {
                _loc_6 = 0;
                while (_loc_6 < this.friendarr.length)
                {
                    
                    if (_loc_4 == this.friendarr[_loc_6].id)
                    {
                        this.friendarr[_loc_6].level = _loc_5;
                        break;
                    }
                    _loc_6++;
                }
            }
            else if (_loc_3 == 3)
            {
                _loc_6 = 0;
                while (_loc_6 < this.enemyarr.length)
                {
                    
                    if (_loc_4 == this.enemyarr[_loc_6].id)
                    {
                        this.enemyarr[_loc_6].level = _loc_5;
                        break;
                    }
                    _loc_6++;
                }
            }
            return;
        }// end function

    }
}
