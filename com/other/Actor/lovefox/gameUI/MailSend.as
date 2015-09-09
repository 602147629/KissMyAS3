package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import lovefox.socket.*;

    public class MailSend extends Sprite
    {
        public var _attachmentArray:Array;
        private var tomail:String = "";
        private var attacharr:Array;
        private var paycoin:CheckBoxUI;
        private var sendpanel:Sprite;
        private var toAddressCB:ComboBox;
        private var title:InputText;
        private var letterText:Text;
        private var payNS:InputText;
        private var mail_a:CheckBox;
        private var mail_b:CheckBox;

        public function MailSend()
        {
            this.initpanel();
            return;
        }// end function

        private function initpanel() : void
        {
            var _loc_1:* = undefined;
            var _loc_3:* = undefined;
            this.sendpanel = new Sprite();
            this.addChild(this.sendpanel);
            _loc_1 = new Label(this, 5, 10, Config.language("MailSend", 1));
            var _loc_2:* = new Label(this, 5, 40, Config.language("MailSend", 2));
            this.title = new InputText(this, 60, 40);
            this.title.width = 300;
            this.title.maxChars = 12;
            _loc_1 = new Label(this, 5, 70, Config.language("MailSend", 3));
            this.letterText = new Text(this, 60, 70);
            this.letterText.width = 300;
            this.letterText.height = 100;
            this.letterText.tf.maxChars = 100;
            if (Config._switchMobage)
            {
                _loc_2.parent.removeChild(_loc_2);
                this.title.parent.removeChild(this.title);
                _loc_1.parent.removeChild(_loc_1);
                this.letterText.parent.removeChild(this.letterText);
                this.title.text = " ";
                this.letterText.text = " ";
            }
            _loc_1 = new Label(this, 5, 180, Config.language("MailSend", 4));
            this._attachmentArray = [];
            _loc_3 = 0;
            while (_loc_3 < 1)
            {
                
                this._attachmentArray[_loc_3] = new CloneSlot(_loc_3);
                this._attachmentArray[_loc_3].y = 180;
                this._attachmentArray[_loc_3].x = _loc_3 * 40 + 60;
                this._attachmentArray[_loc_3].addEventListener("sglClick", this.handleSlotClick);
                this._attachmentArray[_loc_3].addEventListener("drag", this.handleSlotClick);
                this._attachmentArray[_loc_3].addEventListener("dblClick", this.handleSlotDoubleClick);
                this._attachmentArray[_loc_3].addEventListener("up", this.handleSlotUp);
                this._attachmentArray[_loc_3].addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
                this._attachmentArray[_loc_3].addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
                addChild(this._attachmentArray[_loc_3]);
                _loc_3 = _loc_3 + 1;
            }
            _loc_1 = new Label(this, 100, 175, Config.language("MailSend", 5));
            _loc_1 = new Label(this, 100, 195, Config.language("MailSend", 6));
            this.payNS = new InputText(this, 170, 185, "0");
            this.payNS.restrict = "0-9";
            this.payNS.maxChars = 9;
            this.payNS.width = 110;
            this.payNS._tf.addEventListener(Event.CHANGE, this.changeShow);
            this.mail_a = new CheckBox(this, 300, 180, Config.language("MailSend", 7), Config.create(this.checksendmode, 0));
            this.mail_b = new CheckBox(this, 300, 200, Config.language("MailSend", 8), Config.create(this.checksendmode, 1));
            var _loc_4:* = new PushButton(this, 60, 225, Config.language("MailSend", 9), this.sendmail);
            new PushButton(this, 60, 225, Config.language("MailSend", 9), this.sendmail).width = 80;
            this.toAddressCB = new ComboBox(this, 60, 10);
            this.toAddressCB.width = 300;
            this.toAddressCB.labelWidth = 40;
            this.toAddressCB.label = Config.language("MailSend", 10);
            this.toAddressCB.rows = 4;
            this.toAddressCB.list.selectable = false;
            this.toAddressCB.tf.maxChars = 16;
            this.refreshFriends();
            return;
        }// end function

        public function refashsend() : void
        {
            if (!Config._switchMobage)
            {
                this.title.text = "";
                this.letterText.text = "";
            }
            this.payNS.text = "0";
            this.mail_a.selected = false;
            this.mail_b.selected = false;
            return;
        }// end function

        public function refreshFriends()
        {
            var _loc_1:* = Config.ui._friendUI.friends;
            var _loc_2:* = [];
            var _loc_3:* = 0;
            while (_loc_3 < _loc_1.length)
            {
                
                _loc_2.push({label:_loc_1[_loc_3]});
                _loc_3 = _loc_3 + 1;
            }
            this.toAddressCB.setItems(_loc_2);
            return;
        }// end function

        private function handleSlotUp(param1)
        {
            var _loc_2:* = param1.currentTarget;
            if (Holder.item != null)
            {
                this.clickSlot(_loc_2);
            }
            return;
        }// end function

        private function handleSlotClick(param1)
        {
            var _loc_2:* = param1.currentTarget;
            this.clickSlot(_loc_2);
            return;
        }// end function

        private function clickSlot(param1:CloneSlot)
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (Holder.item == null)
            {
                if (param1.item != null)
                {
                    _loc_3 = param1.item._drawer[param1.item._position];
                    _loc_3.unlock();
                    param1.item = null;
                }
            }
            else if (Holder.item._drawer == Config.ui._charUI._slotArray)
            {
                if (Holder.item._itemData.binding == 1)
                {
                    Config.message(Config._codeWords[WordsType.TYPEID_MAIL][1]);
                    return;
                }
                if (Config.ui._charUI.getPosite(Holder.item._position) == 2)
                {
                    Config.message(Config._codeWords[WordsType.TYPEID_MAIL][2]);
                    return;
                }
                if (param1.item != null)
                {
                    _loc_3 = param1.item._drawer[param1.item._position];
                    _loc_3.unlock();
                    param1.item = null;
                }
                _loc_3 = Holder.item._drawer[Holder.item._position];
                _loc_3.lock();
                _loc_3.item = Holder.item;
                param1.item = Holder.item;
                Holder.item = null;
            }
            return;
        }// end function

        private function handleSlotDoubleClick(param1)
        {
            var _loc_2:* = param1.currentTarget;
            if (_loc_2.item != null)
            {
                Config.ui._charUI.useItem(_loc_2.item);
            }
            return;
        }// end function

        private function handleSlotOver(param1)
        {
            var _loc_3:* = null;
            var _loc_2:* = param1.currentTarget;
            if (_loc_2.item != null)
            {
                _loc_3 = localToGlobal(new Point(_loc_2.x, _loc_2.y));
                Holder.showInfo(_loc_2.item.outputInfo(), new Rectangle(_loc_3.x, _loc_3.y, _loc_2._size, _loc_2._size));
            }
            return;
        }// end function

        private function handleSlotOut(param1)
        {
            Holder.closeInfo();
            return;
        }// end function

        private function sendmail(event:MouseEvent) : void
        {
            var _loc_2:* = undefined;
            if (this.toAddressCB.value == "")
            {
                Config.message(Config._codeWords[WordsType.TYPEID_MAIL][3]);
                return;
            }
            if (this.letterText.text == "")
            {
                Config.message(Config._codeWords[WordsType.TYPEID_MAIL][4]);
                return;
            }
            if (this.title.text == "")
            {
                this.title.text = Config.language("MailSend", 11);
            }
            if (this._attachmentArray[0].item != null)
            {
                if (this.mail_a.selected || this.mail_b.selected)
                {
                    if (this.mail_b.selected)
                    {
                        if (int(this.payNS.text) == 0)
                        {
                            Config.message(Config._codeWords[WordsType.TYPEID_MAIL][5]);
                            return;
                        }
                    }
                }
                else
                {
                    Config.message(Config._codeWords[WordsType.TYPEID_MAIL][6]);
                    return;
                }
            }
            else if (int(this.payNS.text) != 0)
            {
                if (this.mail_a.selected)
                {
                    if (Config.player.money4 < int(this.payNS.text))
                    {
                        Config.message(Config._codeWords[WordsType.TYPEID_MAIL][7]);
                        return;
                    }
                }
                else
                {
                    if (this.mail_b.selected)
                    {
                        Config.message(Config._codeWords[WordsType.TYPEID_MAIL][8]);
                        return;
                    }
                    Config.message(Config._codeWords[WordsType.TYPEID_MAIL][9]);
                    return;
                }
            }
            else
            {
                if (this.mail_a.selected)
                {
                    Config.message(Config._codeWords[WordsType.TYPEID_MAIL][10]);
                    return;
                }
                if (this.mail_b.selected)
                {
                    Config.message(Config._codeWords[WordsType.TYPEID_MAIL][11]);
                    return;
                }
            }
            var _loc_3:* = new DataSet();
            _loc_3.addHead(CONST_ENUM.C2G_SEND_MAIL);
            if (this.mail_a.selected)
            {
                _loc_3.add8(0);
            }
            else if (this.mail_b.selected)
            {
                _loc_3.add8(1);
            }
            else
            {
                _loc_3.add8(0);
            }
            _loc_3.addUTF(this.toAddressCB.value);
            if (Config._switchMobage)
            {
                _loc_3.addUTF(" ");
                _loc_3.addUTF(" ");
            }
            else
            {
                _loc_3.addUTF(this.title.text);
                _loc_3.addUTF(this.letterText.text);
            }
            _loc_3.add32(int(this.payNS.text));
            if (this._attachmentArray[0].item != null)
            {
                _loc_3.add16(this._attachmentArray[0].item._position);
            }
            else
            {
                _loc_3.add16(0);
            }
            trace("邮件发送");
            ClientSocket.send(_loc_3);
            return;
        }// end function

        public function getrequest(param1:uint) : void
        {
            trace("邮件发送返回");
            switch(param1)
            {
                case 0:
                {
                    Billboard.show(Config.language("MailSend", 12));
                    Config.ui._mailpanel.showsend(Config.language("MailSend", 13), this.toAddressCB.value);
                    this.refashsend();
                    break;
                }
                default:
                {
                    Config.message(Config._codeWords[WordsType.TYPEID_ERR][param1]);
                    Config.ui._mailpanel.showsend(Config._codeWords[WordsType.TYPEID_ERR][param1], this.toAddressCB.value);
                    break;
                    break;
                }
            }
            return;
        }// end function

        public function handleMouseDown() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_5:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            while (_loc_4 < this._attachmentArray.length)
            {
                
                if (this._attachmentArray[_loc_4].hitTestPoint(Config.stage.mouseX, Config.stage.mouseY))
                {
                    _loc_1 = this._attachmentArray[_loc_4];
                    _loc_3 = _loc_4;
                    break;
                }
                _loc_4 = _loc_4 + 1;
            }
            if (_loc_1 != null)
            {
                if (Holder.item == null)
                {
                    if (_loc_1.item != null)
                    {
                        _loc_5 = _loc_1.item._position;
                        Config.ui._charUI.itemunlock(_loc_5);
                        _loc_1.item = null;
                    }
                }
                else
                {
                    if (Holder.item._drawer == Config.ui._charUI._slotArray)
                    {
                        if (_loc_1.item != null)
                        {
                            Config.ui._charUI.itemunlock(_loc_1.item._position);
                        }
                        _loc_1.item = Holder.item;
                        Config.ui._charUI.itemlock(_loc_1.item._position);
                    }
                    Holder.item._drawer[Holder.item._position].item = Holder.item;
                    Holder.item = null;
                }
            }
            return;
        }// end function

        public function handleMouseMove() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            while (_loc_4 < this._attachmentArray.length)
            {
                
                if (this._attachmentArray[_loc_4].hitTestPoint(Config.stage.mouseX, Config.stage.mouseY))
                {
                    _loc_1 = this._attachmentArray[_loc_4];
                    _loc_3 = _loc_4;
                    break;
                }
                _loc_4 = _loc_4 + 1;
            }
            if (_loc_1 != null)
            {
                if (_loc_1.item != null)
                {
                    Holder.showInfo(_loc_1.item.outputInfo(), new Rectangle(_loc_1.x + x, _loc_1.y + y, _loc_1._size, _loc_1._size));
                }
                else
                {
                    Holder.closeInfo();
                }
            }
            else
            {
                Holder.closeInfo();
            }
            return;
        }// end function

        private function backwritesend(event:MouseEvent) : void
        {
            var _loc_2:* = new MailEvent(MailEvent.TO_MAIL, true);
            this.dispatchEvent(_loc_2);
            return;
        }// end function

        private function gotomaillist(event:MouseEvent) : void
        {
            var _loc_2:* = new MailEvent(MailEvent.TO_MAILLIST, true);
            this.dispatchEvent(_loc_2);
            return;
        }// end function

        public function settomail(param1:String) : void
        {
            this.toAddressCB.value = param1;
            return;
        }// end function

        public function setmailTitle(param1:String) : void
        {
            this.title.text = param1;
            return;
        }// end function

        private function checksendmode(event:MouseEvent, param2:int) : void
        {
            if (param2 == 0)
            {
                if (this.mail_a.selected)
                {
                    if (this.mail_b.selected)
                    {
                        this.mail_b.selected = false;
                    }
                }
            }
            else if (this.mail_b.selected)
            {
                if (this.mail_a.selected)
                {
                    this.mail_a.selected = false;
                }
            }
            return;
        }// end function

        public function itemunlock() : void
        {
            var _loc_1:* = null;
            if (this._attachmentArray.length > 0)
            {
                if (this._attachmentArray[0].item != null)
                {
                    _loc_1 = this._attachmentArray[0].item._drawer[this._attachmentArray[0].item._position];
                    _loc_1.unlock();
                    this._attachmentArray[0].item = null;
                }
            }
            return;
        }// end function

        public function changeShow(event:Event) : void
        {
            if (String(this.payNS.text).length > 0)
            {
                if (String(this.payNS.text).substr(0, 1) == "0")
                {
                    this.payNS.text = "1";
                }
            }
            return;
        }// end function

    }
}
