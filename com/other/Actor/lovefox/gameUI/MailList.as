package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import flash.utils.*;
    import lovefox.component.*;
    import lovefox.socket.*;
    import lovefox.unit.*;

    public class MailList extends Sprite
    {
        private var readpanel:MailRead;
        private var mailarr:Array;
        private var pagenum:uint = 7;
        private var page:uint = 1;
        private var allpage:int = 1;
        private var _slotArray:Array;
        private var maildata:DataGridUI;
        private var miancheck:CheckBox;
        private var delmailbtn:PushButton;
        private var upbtn:PushButton;
        private var downbtn:PushButton;
        private var pagelabel:TextField;
        private var typeflag:int;
        private var mailBmpd:BitmapData;

        public function MailList()
        {
            this.initsocket();
            this.initpanel();
            return;
        }// end function

        public function initsocket() : void
        {
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_MAIL_LIST, this.getmailist);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_TAKE_ATTACH, this.getitemback);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_MAIL_READ, this.seachitemback);
            return;
        }// end function

        private function initpanel() : void
        {
            this.mailBmpd = BitmapLoader.pick(String(Config.findUI("mailui").readicon.dir));
            this.miancheck = new CheckBox(null, 5, 5, "", this.selectchange);
            var _loc_1:* = [{datafield:"id", label:"", len:30, topmc:this.miancheck, childmc:"check"}, {datafield:"read", label:Config.language("MailList", 1), len:30, childmc:"readicon"}, {datafield:"name", label:Config.language("MailList", 2), len:70}, {datafield:"titlelabel", label:Config.language("MailList", 3), len:150, childmc:"titlelabel"}, {datafield:"showendtime", label:Config.language("MailList", 4), len:100}];
            this.maildata = new DataGridUI(_loc_1, null, 0, 5, 380, 200);
            this.delmailbtn = new PushButton(null, 30, 225, Config.language("MailList", 5), this.delletter);
            this.delmailbtn.width = 60;
            this.upbtn = new PushButton(null, 160, 225, "<", Config.create(this.pageclick, -1));
            this.upbtn.width = 30;
            this.downbtn = new PushButton(null, 232, 225, ">", Config.create(this.pageclick, 1));
            this.downbtn.width = 30;
            this.pagelabel = Config.getSimpleTextField();
            this.pagelabel.defaultTextFormat = new TextFormat(null, 16, Style.WINDOW_FONT, true);
            this.pagelabel.x = 190;
            this.pagelabel.y = 225;
            this.pagelabel.width = 42;
            this.pagelabel.autoSize = TextFieldAutoSize.CENTER;
            this.showlist();
            return;
        }// end function

        private function pageclick(event:MouseEvent, param2:int) : void
        {
            if (param2 + this.page > 0 && param2 + this.page <= this.allpage)
            {
                this.sendmailliet(this.typeflag, param2 + this.page);
            }
            return;
        }// end function

        public function showlist(event:Event = null) : void
        {
            this.removeallchild(this);
            this.miancheck.selected = false;
            this.addChild(this.maildata);
            this.addChild(this.delmailbtn);
            this.addChild(this.upbtn);
            this.addChild(this.downbtn);
            this.addChild(this.pagelabel);
            return;
        }// end function

        private function selectchange(event:MouseEvent) : void
        {
            if (this.mailarr == null)
            {
                return;
            }
            var _loc_2:* = 0;
            while (_loc_2 < this.mailarr.length)
            {
                
                this.mailarr[_loc_2].check.selected = this.miancheck.selected;
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        private function getmailist(event:SocketEvent) : void
        {
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            this.mailarr = new Array();
            var _loc_2:* = event.data;
            this.allpage = _loc_2.readUnsignedShort();
            this.page = int(_loc_2.readUnsignedShort());
            var _loc_3:* = _loc_2.readByte();
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_6 = new Object();
                _loc_6.id = _loc_2.readUnsignedInt();
                _loc_6.type = _loc_2.readByte();
                _loc_7 = _loc_2.readShort();
                _loc_6.name = _loc_2.readUTFBytes(_loc_7);
                _loc_8 = _loc_2.readShort();
                _loc_6.title = _loc_2.readUTFBytes(_loc_8);
                if (_loc_6.type < 3 && Config._switchMobage)
                {
                    _loc_6.title = _loc_6.name + "からのメール";
                }
                _loc_6.endtime = _loc_2.readUnsignedInt();
                _loc_6.read = _loc_2.readByte();
                _loc_6.attachflag = _loc_2.readByte();
                _loc_6.retourflag = _loc_2.readByte();
                _loc_6.check = new CheckBox(null, 10, 5);
                _loc_6.check.x = 30;
                if (_loc_6.readicon != null)
                {
                    if (_loc_6.readicon.bitmapData != null)
                    {
                        _loc_6.readicon.bitmapData.dispose();
                    }
                }
                _loc_6.readicon = this.getmairead(_loc_6.read, _loc_6.attachflag);
                this.mailarr.push(_loc_6);
                _loc_4 = _loc_4 + 1;
            }
            var _loc_5:* = 0;
            while (_loc_5 < _loc_3)
            {
                
                this.setmaillist(_loc_5);
                _loc_5 = _loc_5 + 1;
            }
            this.maildata.dataProvider = this.mailarr;
            if (this.allpage == 0)
            {
                this.allpage = 1;
            }
            this.pagelabel.text = this.page + "/" + this.allpage;
            this.miancheck.selected = false;
            this.showlist();
            return;
        }// end function

        public function getmairead(param1:int, param2:int) : Bitmap
        {
            var _loc_4:* = null;
            var _loc_3:* = this.mailBmpd;
            if (param1 == 0)
            {
                _loc_4 = new Rectangle(0, 0, 15, 11);
            }
            else
            {
                _loc_4 = new Rectangle(15, 0, 15, 11);
            }
            var _loc_5:* = new Point(0, 0);
            var _loc_6:* = 15;
            if (param2 == 1)
            {
                _loc_6 = 25;
            }
            var _loc_7:* = new BitmapData(_loc_6, 11);
            new BitmapData(_loc_6, 11).copyPixels(_loc_3, _loc_4, _loc_5);
            if (param2 == 1)
            {
                _loc_7.copyPixels(_loc_3, new Rectangle(30, 0, 10, 11), new Point(15, 0));
            }
            var _loc_8:* = new Bitmap();
            new Bitmap().bitmapData = _loc_7;
            _loc_8.x = (30 - _loc_8.width) / 2;
            _loc_8.y = 5;
            return _loc_8;
        }// end function

        private function order(param1:Object, param2:Object) : Number
        {
            var _loc_3:* = int(param1.sortsendtime);
            var _loc_4:* = int(param2.sortsendtime);
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

        public function sendmailliet(param1:int = 0, param2:int = 1) : void
        {
            this.typeflag = param1;
            var _loc_3:* = new DataSet();
            _loc_3.addHead(CONST_ENUM.C2G_MAIL_LIST);
            _loc_3.add8(param1);
            _loc_3.add16(param2);
            _loc_3.add8(this.pagenum);
            ClientSocket.send(_loc_3);
            return;
        }// end function

        private function setmaillist(param1:uint) : void
        {
            if (param1 >= this.mailarr.length)
            {
                return;
            }
            if (this.mailarr[param1].type > 3)
            {
                this.mailarr[param1].name = Config.language("MailList", 8);
            }
            var _loc_2:* = "";
            this.mailarr[param1].title = DescriptionTranslate.transSystem(this.mailarr[param1].title);
            if (this.mailarr[param1].type == 0 || this.mailarr[param1].type == 1 || this.mailarr[param1].type == 2)
            {
                _loc_2 = this.mailarr[param1].title;
            }
            else
            {
                _loc_2 = String(this.mailarr[param1].title);
            }
            if (this.mailarr[param1].retourflag == 1)
            {
                _loc_2 = Config.language("MailList", 9, _loc_2);
            }
            var _loc_3:* = new Date();
            this.mailarr[param1].textendtime = Math.ceil(this.mailarr[param1].endtime / (3600 * 24));
            this.mailarr[param1].showendtime = Config.language("MailList", 10, this.mailarr[param1].textendtime);
            var _loc_4:* = 10040064;
            if (this.mailarr[param1].read == 1)
            {
                _loc_4 = Style.WINDOW_FONT;
            }
            if (this.mailarr[param1].textendtime <= 3)
            {
                _loc_4 = 16724736;
            }
            var _loc_5:* = new ClickLabel(null, 0, 0, _loc_2, Config.create(this.readmail, this.mailarr[param1]), true, 150);
            new ClickLabel(null, 0, 0, _loc_2, Config.create(this.readmail, this.mailarr[param1]), true, 150).clickColor([_loc_4, 6837142]);
            this.mailarr[param1].titlelabel = _loc_5;
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

        private function readmail(param1, param2:Object) : void
        {
            this.removeallchild(this);
            this.readpanel = new MailRead(param2.id);
            this.addChild(this.readpanel);
            this.readpanel.addEventListener(MailEvent.CLOSE_READ, this.showlist);
            return;
        }// end function

        private function checkdel(param1 = null) : void
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_MAIL_DELETE);
            _loc_2.add8(this.typeflag);
            _loc_2.add16(this.page);
            _loc_2.add8(this.pagenum);
            var _loc_3:* = 0;
            var _loc_4:* = int((this.mailarr.length - 1));
            while (_loc_4 >= 0)
            {
                
                if (this.mailarr[_loc_4].check.selected)
                {
                    _loc_3++;
                }
                _loc_4 = _loc_4 - 1;
            }
            _loc_2.add8(_loc_3);
            var _loc_5:* = int((this.mailarr.length - 1));
            while (_loc_5 >= 0)
            {
                
                if (this.mailarr[_loc_5].check.selected)
                {
                    _loc_2.add32(this.mailarr[_loc_5].id);
                }
                _loc_5 = _loc_5 - 1;
            }
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function itemmaildel(param1) : void
        {
            var _loc_2:* = true;
            var _loc_3:* = int((this.mailarr.length - 1));
            while (_loc_3 >= 0)
            {
                
                if (this.mailarr[_loc_3].check.selected)
                {
                    if (this.mailarr[_loc_3].attachflag > 0)
                    {
                        _loc_2 = false;
                        AlertUI.alert(Config.language("MailList", 11), Config.language("MailList", 12), [Config.language("MailList", 13), Config.language("MailList", 14)], [this.checkdel]);
                        return;
                    }
                }
                _loc_3 = _loc_3 - 1;
            }
            if (_loc_2)
            {
                this.checkdel();
            }
            return;
        }// end function

        private function delletter(event:MouseEvent) : void
        {
            if (this.mailarr == null)
            {
                return;
            }
            var _loc_2:* = int((this.mailarr.length - 1));
            while (_loc_2 >= 0)
            {
                
                if (this.mailarr[_loc_2].check.selected)
                {
                    AlertUI.alert(Config.language("MailList", 11), Config.language("MailList", 15), [Config.language("MailList", 13), Config.language("MailList", 14)], [this.itemmaildel]);
                    break;
                }
                _loc_2 = _loc_2 - 1;
            }
            return;
        }// end function

        private function getitemback(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            var _loc_4:* = 0;
            while (_loc_4 < this.mailarr.length)
            {
                
                if (this.mailarr[_loc_4].id == _loc_3)
                {
                    this.mailarr[_loc_4].item = null;
                    this.mailarr[_loc_4].money = 0;
                    this.mailarr[_loc_4].attachflag = 0;
                    this.mailarr[_loc_4].pickflag = 1;
                    this.mailarr[_loc_4].itemflag = 0;
                    break;
                }
                _loc_4 = _loc_4 + 1;
            }
            if (this.readpanel != null)
            {
                this.readpanel.getattachback();
            }
            return;
        }// end function

        public function sendItemBack() : void
        {
            if (this.readpanel != null)
            {
                this.readpanel.getattachback();
            }
            return;
        }// end function

        private function seachitemback(event:SocketEvent) : void
        {
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            var _loc_4:* = 0;
            while (_loc_4 < this.mailarr.length)
            {
                
                if (this.mailarr[_loc_4].id == _loc_3)
                {
                    this.mailarr[_loc_4].type = _loc_2.readByte();
                    this.mailarr[_loc_4].typeflag = this.typeflag;
                    _loc_5 = _loc_2.readShort();
                    this.mailarr[_loc_4].name = _loc_2.readUTFBytes(_loc_5);
                    if (this.mailarr[_loc_4].type > 3)
                    {
                        this.mailarr[_loc_4].name = Config.language("MailList", 8);
                    }
                    _loc_6 = _loc_2.readShort();
                    this.mailarr[_loc_4].title = _loc_2.readUTFBytes(_loc_6);
                    _loc_7 = _loc_2.readShort();
                    this.mailarr[_loc_4].letter = _loc_2.readUTFBytes(_loc_7);
                    this.mailarr[_loc_4].money = _loc_2.readUnsignedInt();
                    this.mailarr[_loc_4].sendtime = _loc_2.readUnsignedInt();
                    this.mailarr[_loc_4].read = _loc_2.readByte();
                    this.mailarr[_loc_4].pickflag = _loc_2.readByte();
                    this.mailarr[_loc_4].retourflag = _loc_2.readByte();
                    this.mailarr[_loc_4].itemflag = _loc_2.readByte();
                    if (this.mailarr[_loc_4].readicon != null)
                    {
                        if (this.mailarr[_loc_4].readicon.bitmapData != null)
                        {
                            this.mailarr[_loc_4].readicon.bitmapData.dispose();
                        }
                    }
                    this.mailarr[_loc_4].readicon.bitmapData = this.getmairead(1, this.mailarr[_loc_4].attachflag).bitmapData;
                    Config.ui._radar.setmail(false);
                    _loc_8 = new Date();
                    _loc_8.setTime(this.mailarr[_loc_4].sendtime * 1000);
                    this.mailarr[_loc_4].sendtime = _loc_8.getFullYear() + "-" + int((_loc_8.getMonth() + 1)) + "-" + _loc_8.getDate();
                    if (this.mailarr[_loc_4].itemflag == 1)
                    {
                        _loc_9 = Item.createItemByBytes(_loc_2, 0, UNIT_TYPE_ENUM.TYPEID_ITEMCLONE);
                        _loc_9.display();
                        this.mailarr[_loc_4].item = _loc_9;
                    }
                    if (this.readpanel != null)
                    {
                        this.readpanel.showLetter(this.mailarr[_loc_4]);
                    }
                    break;
                }
                _loc_4 = _loc_4 + 1;
            }
            return;
        }// end function

    }
}
