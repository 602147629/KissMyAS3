package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import lovefox.component.*;
    import lovefox.socket.*;

    public class MailRead extends Sprite
    {
        private var _mailobj:Object;
        private var _slotArray:Array;
        private var checkbtn:CheckBox;
        private var mosp:Sprite;

        public function MailRead(param1:int)
        {
            this.sendgetitem(param1);
            this.init();
            return;
        }// end function

        private function init() : void
        {
            this._slotArray = new Array();
            this.mosp = new Sprite();
            this.addChild(this.mosp);
            return;
        }// end function

        public function showLetter(param1:Object) : void
        {
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = null;
            var _loc_16:* = null;
            this._mailobj = param1;
            var _loc_2:* = new Shape();
            this.addChild(_loc_2);
            _loc_2.graphics.beginFill(16777215, 0.5);
            _loc_2.graphics.drawRoundRect(0, 10, 380, 20, 4);
            _loc_2.graphics.drawRoundRect(0, 35, 380, 20, 4);
            _loc_2.graphics.drawRoundRect(0, 60, 380, 120, 4);
            _loc_2.graphics.endFill();
            var _loc_3:* = 10;
            var _loc_4:* = new Label(this, 5, _loc_3, Config.language("MailRead", 1, this._mailobj.name));
            new Label(this, 5, _loc_3, Config.language("MailRead", 1, this._mailobj.name)).textColor = 3355443;
            if (this._mailobj.typeflag == 0)
            {
                _loc_9 = new ClickLabel(this, 150, _loc_3, Config.language("MailRead", 2), Config.create(this.addfuc, this._mailobj.name));
                _loc_9.clickColor([26367, 6837142]);
            }
            var _loc_5:* = new Label(this, 320, _loc_3, this._mailobj.sendtime);
            new Label(this, 320, _loc_3, this._mailobj.sendtime).textColor = 3355443;
            _loc_3 = _loc_3 + 25;
            var _loc_6:* = new Label(this, 5, _loc_3, Config.language("MailRead", 3, this._mailobj.titlelabel.text));
            new Label(this, 5, _loc_3, Config.language("MailRead", 3, this._mailobj.titlelabel.text)).textColor = 3355443;
            _loc_6.tf.selectable = true;
            _loc_3 = _loc_3 + 25;
            if (this._mailobj.typeflag == 0)
            {
                _loc_10 = new Label(this, 5, _loc_3, Config._codeWords[WordsType.TYPEID_MAIL][12]);
                _loc_10.textColor = 12323637;
                _loc_3 = _loc_3 + 20;
            }
            var _loc_7:* = new MailTextAreaUI(this, 0, _loc_3, 375, 100);
            new MailTextAreaUI(this, 0, _loc_3, 375, 100).mytext.selectable = true;
            _loc_7.text = DescriptionTranslate.translate(DescriptionTranslate.transSystem(this._mailobj.letter), _loc_7.mytext);
            if (this._mailobj.typeflag == 0)
            {
                _loc_3 = _loc_3 + 110;
            }
            else
            {
                _loc_3 = _loc_3 + 125;
            }
            if (this._mailobj.attachflag > 0)
            {
                _loc_10 = new Label(this, 0, _loc_3, Config.language("MailRead", 4));
                this.checkbtn = new CheckBox(null, 290, _loc_3 + 10, Config.language("MailRead", 5));
                this.checkbtn.selected = true;
                if (this._mailobj.itemflag > 0)
                {
                    _loc_12 = new CloneSlot(0, 30);
                    this.mosp.addChild(_loc_12);
                    _loc_12.x = 40;
                    _loc_12.y = _loc_3;
                    _loc_12.addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
                    _loc_12.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
                    this._slotArray.push(_loc_12);
                    if (this._mailobj.hasOwnProperty("item"))
                    {
                        if (this._mailobj.item != null)
                        {
                            this._slotArray[0].item = this._mailobj.item;
                        }
                    }
                }
                if (this._mailobj.type == 1)
                {
                    _loc_13 = new Label(this.mosp, 100, _loc_3 + 5, Config.language("MailRead", 6, this._mailobj.money));
                    this.checkbtn.selected = false;
                    this.mosp.addChild(this.checkbtn);
                    _loc_14 = new PushButton(this.mosp, 20, 225, Config.language("MailRead", 7), this.clickbounce);
                    _loc_14.width = 60;
                }
                else if (this._mailobj.money > 0)
                {
                    _loc_15 = new Label(this.mosp, 100, _loc_3 + 5, Config.language("MailRead", 8, this._mailobj.money));
                }
                _loc_11 = new PushButton(this.mosp, 210, _loc_3 + 5, Config.language("MailRead", 9), this.clickattchment);
                _loc_11.width = 60;
            }
            if (this._mailobj.typeflag == 0)
            {
                _loc_16 = new PushButton(this, 195, 225, Config.language("MailRead", 10), this.tomail);
                _loc_16.width = 60;
            }
            var _loc_8:* = new PushButton(this, 115, 225, Config.language("MailRead", 11), this.backlist);
            new PushButton(this, 115, 225, Config.language("MailRead", 11), this.backlist).width = 60;
            return;
        }// end function

        private function addfuc(event:TextEvent, param2:String) : void
        {
            Config.ui._friendUI.addFriend(param2);
            return;
        }// end function

        private function sendgetitem(param1:int) : void
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_MAIL_READ);
            _loc_2.add32(param1);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function clickattchment(event:MouseEvent) : void
        {
            if (this._mailobj.pickflag == 0)
            {
                if (this.checkbtn.selected)
                {
                    if (this._mailobj.type == 2)
                    {
                        if (Config.player.money4 >= this._mailobj.money)
                        {
                            if (Config.ui._bagUI.bagfull())
                            {
                                Config.message(Config._codeWords[WordsType.TYPEID_MAIL][13]);
                                return;
                            }
                            this.getattchment();
                        }
                        else
                        {
                            Config.message(Config._codeWords[WordsType.TYPEID_MAIL][7]);
                        }
                    }
                    else
                    {
                        this.getattchment();
                    }
                }
                else
                {
                    AlertUI.alert(Config.language("MailRead", 12), Config.language("MailRead", 13), [Config.language("MailRead", 14)]);
                }
            }
            return;
        }// end function

        private function clickbounce(event:MouseEvent) : void
        {
            AlertUI.alert(Config.language("MailRead", 12), Config.language("MailRead", 15), [Config.language("MailRead", 14), Config.language("MailRead", 16)], [this.sendBounce]);
            return;
        }// end function

        private function sendBounce(param1 = null) : void
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_SEND_RETOUR);
            _loc_2.add32(this._mailobj.id);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function getattchment(event:MouseEvent = null) : void
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_TAKE_ATTACH);
            _loc_2.add32(this._mailobj.id);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        public function getattachback() : void
        {
            this._mailobj.read = 1;
            this._mailobj.attachflag = 0;
            this._mailobj.itemflag = 0;
            this._mailobj.readicon.bitmapData = Config.ui._mailpanel.getmailpanel.getmairead(this._mailobj.read, this._mailobj.attachflag).bitmapData;
            this.removeallchild(this.mosp);
            return;
        }// end function

        private function tomail(event:MouseEvent) : void
        {
            var _loc_2:* = new MailEvent(MailEvent.TO_MAIL, true);
            var _loc_3:* = new Object();
            _loc_3.tomailname = this._mailobj.name;
            if (String(this._mailobj.titlelabel.text).length < 20)
            {
                _loc_3.mailTitle = Config.language("MailRead", 17, this._mailobj.titlelabel.text);
            }
            else
            {
                _loc_3.mailTitle = this._mailobj.titlelabel.text;
            }
            _loc_2.data = _loc_3;
            this.dispatchEvent(_loc_2);
            return;
        }// end function

        private function backlist(event:MouseEvent) : void
        {
            var _loc_2:* = new MailEvent(MailEvent.CLOSE_READ);
            this.dispatchEvent(_loc_2);
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
                if (int(_loc_2.item._itemData.suitID) > 0 && int(_loc_2.item._itemData.type) != 18)
                {
                    _loc_3 = _loc_2.parent.localToGlobal(new Point(_loc_2.x, _loc_2.y));
                    Holder.showRightInfo(_loc_2.item.outfitInfo(1), new Rectangle(_loc_3.x, _loc_3.y, _loc_2._size, _loc_2._size));
                }
            }
            return;
        }// end function

        private function handleSlotOut(param1)
        {
            Holder.closeInfo();
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
