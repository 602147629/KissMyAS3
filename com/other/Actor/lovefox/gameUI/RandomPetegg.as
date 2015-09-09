package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import lovefox.gui.*;
    import lovefox.socket.*;
    import lovefox.unit.*;

    public class RandomPetegg extends Window
    {
        private var _extractDict:Dictionary;
        private var _panel:Sprite;
        private var _machinePanel:Sprite;
        private var _pbtnpanelone:Sprite;
        private var _pbtnpanelten:Sprite;
        private var f1:Boolean;
        private var posx1:int = 0;
        private var _slotItemarr:Array;
        private var _buttonGClips:Array;
        private var _labnum:Label;
        private var pushbtnOne:PushButton;
        private var pushbtnTen:PushButton;
        private var petitemArr:Array;
        private var _numpos:int = 0;
        private var _gclip:GClip;
        private var _eggclip:GClip;
        private var _eggclipstop:int = 0;
        private var _alertnum:int;

        public function RandomPetegg(param1:DisplayObjectContainer = null)
        {
            this._extractDict = new Dictionary(true);
            this._buttonGClips = [];
            super(param1);
            resize(470, 25);
            this.initpanel();
            this.initSocket();
            return;
        }// end function

        override public function open(event:MouseEvent = null)
        {
            super.open();
            this._labnum.text = Config.language("RandomPetegg", 1, Config.ui._charUI.getItemAmount(898013));
            Config.ui._charUI.removeEventListener("itemchange", this.itemchange);
            Config.ui._charUI.addEventListener("itemchange", this.itemchange);
            this.addeggpbtn();
            this._eggclip.gotoAndStop(0);
            if (Config.ui._charUI.getItemAmount(898013) >= 4)
            {
                this.pushbtnOne.enabled = true;
                if (Config.ui._charUI.getItemAmount(898013) >= 10)
                {
                    this.pushbtnTen.enabled = true;
                }
                else
                {
                    this.pushbtnTen.enabled = false;
                }
            }
            else
            {
                this.pushbtnOne.enabled = false;
                this.pushbtnTen.enabled = false;
            }
            return;
        }// end function

        override public function close()
        {
            this.removeitemspr();
            this.removechildgclip();
            if (this._eggclip != null)
            {
                if (this._eggclip.parent != null)
                {
                    this._eggclip.parent.removeChild(this._eggclip);
                }
                this._eggclip.destroy();
            }
            super.close();
            return;
        }// end function

        private function initSocket() : void
        {
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_NIUDAN_ITEMS, this.getegg);
            return;
        }// end function

        private function initpanel() : void
        {
            var _loc_2:* = null;
            this.title = Config.language("RandomPetegg", 2);
            this._panel = new Sprite();
            this._panel.x = -12;
            this.addChild(this._panel);
            var _loc_1:* = new Bitmap();
            _loc_1.bitmapData = Config.findsysUI("petegg/bg", 517, 355);
            _loc_1.x = -10;
            _loc_1.y = 22;
            this._panel.addChild(_loc_1);
            this._machinePanel = new Sprite();
            this._panel.addChild(this._machinePanel);
            _loc_2 = new Bitmap();
            _loc_2.bitmapData = Config.findsysUI("petegg/machine", 175, 253);
            _loc_2.x = 0;
            _loc_2.y = 48;
            this._machinePanel.addChild(_loc_2);
            var _loc_3:* = new Bitmap();
            _loc_3.bitmapData = Config.findsysUI("petegg/coin", 16, 16);
            _loc_3.x = 25;
            _loc_3.y = 294;
            this._panel.addChild(_loc_3);
            var _loc_4:* = new Bitmap();
            new Bitmap().bitmapData = Config.findsysUI("petegg/coin", 16, 16);
            _loc_4.x = 105;
            _loc_4.y = 294;
            this._panel.addChild(_loc_4);
            var _loc_5:* = new Label(this._panel, 45, 294, " x 4");
            var _loc_6:* = new Label(this._panel, 120, 294, " x 40");
            this._pbtnpanelone = new Sprite();
            this._pbtnpanelone.x = 20;
            this._pbtnpanelone.y = 314;
            this._panel.addChild(this._pbtnpanelone);
            this._pbtnpanelten = new Sprite();
            this._pbtnpanelten.x = 98;
            this._pbtnpanelten.y = 314;
            this._panel.addChild(this._pbtnpanelten);
            this._pbtnpanelone.addEventListener(MouseEvent.ROLL_OVER, this.handlebtnOver1);
            this._pbtnpanelten.addEventListener(MouseEvent.ROLL_OVER, this.handlebtnOver2);
            this._pbtnpanelone.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
            this._pbtnpanelten.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
            this.pushbtnOne = new PushButton(this._pbtnpanelone, 0, 0, Config.language("RandomPetegg", 3), this.randomOne);
            this.pushbtnTen = new PushButton(this._pbtnpanelten, 0, 0, Config.language("RandomPetegg", 4), this.randomTen);
            this.pushbtnOne.enabled = false;
            this.pushbtnTen.enabled = false;
            this.pushbtnOne.width = 60;
            this.pushbtnTen.width = 60;
            this.pushbtnTen.setTable("table38", "table37");
            var _loc_7:* = new Label(this._panel, 164, 115);
            new Label(this._panel, 164, 115).html = true;
            _loc_7.text = Config.language("RandomPetegg", 5);
            var _loc_8:* = new Bitmap();
            new Bitmap().bitmapData = Config.findsysUI("petegg/coin", 16, 16);
            _loc_8.x = 220;
            _loc_8.y = 190;
            this._panel.addChild(_loc_8);
            this._labnum = new Label(this._panel, 240, 190);
            this.addslot();
            return;
        }// end function

        private function rotatn(event:Event)
        {
            this._eggclipstop = this._eggclipstop + 15;
            if (this._eggclipstop >= 360)
            {
                this._eggclip.gotoAndStop(0);
                this._eggclipstop = 0;
                this._eggclip.removeEventListener(Event.ENTER_FRAME, this.rotatn);
                this._machinePanel.removeEventListener(Event.ENTER_FRAME, this.movemachine);
                this._machinePanel.addEventListener(Event.ENTER_FRAME, this.movemachine);
            }
            return;
        }// end function

        private function getegg(event:SocketEvent) : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = null;
            this.petitemArr = new Array();
            var _loc_2:* = event.data.readUnsignedByte();
            this.removeitemspr();
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = event.data.readUnsignedInt();
                _loc_5 = Item.newItem(Config._itemMap[_loc_4], 0, 0, UNIT_TYPE_ENUM.TYPEID_ITEMCLONE, 0);
                if (this._slotItemarr[_loc_3] != null)
                {
                    this.petitemArr.push(_loc_5);
                }
                _loc_3++;
            }
            this._eggclip.gotoAndPlay(0, false);
            this._eggclip.removeEventListener(Event.ENTER_FRAME, this.rotatn);
            this._eggclip.addEventListener(Event.ENTER_FRAME, this.rotatn);
            return;
        }// end function

        private function movemachine(event:Event) : void
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = 0;
            if (this.f1)
            {
                this.posx1 = this.posx1 + 5;
                this._machinePanel.x = this._machinePanel.x + 5;
                if (this.posx1 >= 10)
                {
                    this.f1 = false;
                }
            }
            else if (this.posx1 > 0)
            {
                this.posx1 = this.posx1 - 5;
                this._machinePanel.x = this._machinePanel.x - 5;
                if (this.posx1 == 0)
                {
                    this.f1 = false;
                    var _loc_5:* = this;
                    var _loc_6:* = this._numpos + 1;
                    _loc_5._numpos = _loc_6;
                    if (this._numpos >= 3)
                    {
                        this._numpos = 0;
                        this._machinePanel.removeEventListener(Event.ENTER_FRAME, this.movemachine);
                        _loc_4 = 0;
                        while (_loc_4 < this.petitemArr.length)
                        {
                            
                            _loc_2 = _loc_4 % 5 * 42 + 215;
                            _loc_3 = int(_loc_4 / 5) * 45 + 215;
                            this.extract(_loc_2, _loc_3, _loc_4);
                            _loc_4++;
                        }
                    }
                }
            }
            else
            {
                this.posx1 = this.posx1 - 5;
                this._machinePanel.x = this._machinePanel.x - 5;
                if (this.posx1 <= -10)
                {
                    this.f1 = true;
                }
            }
            return;
        }// end function

        private function randomOne(event:MouseEvent) : void
        {
            if (Config.ui._bagUI.getMinEmptySlot() == null)
            {
                AlertUI.remove(this._alertnum);
                this._alertnum = AlertUI.alert(Config.language("RandomPetegg", 6), Config.language("RandomPetegg", 7, 1), [Config.language("RandomPetegg", 8)]);
                return;
            }
            if (Config.ui._charUI.getItemAmount(898013) < 4)
            {
                Config.message(Config.language("RandomPetegg", 9));
                return;
            }
            this.pushbtnOne.enabled = false;
            this.pushbtnTen.enabled = false;
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_NIUDAN);
            ClientSocket.send(_loc_2);
            this.removeitemspr();
            this.removechildgclip();
            return;
        }// end function

        private function randomTen(event:MouseEvent) : void
        {
            if (Config.ui._bagUI.bagremainNum < 10)
            {
                AlertUI.alert(Config.language("RandomPetegg", 6), Config.language("RandomPetegg", 7, 10), [Config.language("RandomPetegg", 8)]);
                return;
            }
            if (Config.ui._charUI.getItemAmount(898013) < 40)
            {
                Config.message(Config.language("RandomPetegg", 9));
                return;
            }
            this.pushbtnOne.enabled = false;
            this.pushbtnTen.enabled = false;
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_NIUDAN_NEN);
            ClientSocket.send(_loc_2);
            this.removeitemspr();
            this.removechildgclip();
            return;
        }// end function

        private function addslot()
        {
            var _loc_2:* = null;
            this._slotItemarr = [];
            var _loc_1:* = 0;
            while (_loc_1 < 10)
            {
                
                _loc_2 = new CloneSlot(0, 32);
                _loc_2.x = _loc_1 % 5 * 42 + 215;
                _loc_2.y = int(_loc_1 / 5) * 45 + 215;
                this._panel.addChild(_loc_2);
                this._slotItemarr.push(_loc_2);
                _loc_2.addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
                _loc_2.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
                _loc_1++;
            }
            return;
        }// end function

        private function extract(param1:int, param2:int, param3:int = 0)
        {
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = new Point(75, 265);
            var _loc_7:* = new Point(param1, param2);
            var _loc_8:* = Math.random() * 200 + 300;
            var _loc_9:* = Math.random() * 50 + 50;
            var _loc_10:* = Math.PI * 2 * Math.random();
            var _loc_11:* = new GClip("peteggline");
            new GClip("peteggline").x = 75;
            _loc_11.y = 265;
            _loc_11.visible = 0.8;
            this._panel.addChild(_loc_11);
            var _loc_12:* = [];
            _loc_4 = 0;
            while (_loc_4 < 3)
            {
                
                _loc_5 = new GClip("peteggline");
                _loc_5.x = 75;
                _loc_5.y = 265;
                _loc_5.visible = 0.8;
                this._panel.addChild(_loc_5);
                _loc_12.push(_loc_5);
                _loc_4 = _loc_4 + 1;
            }
            _loc_4 = 0;
            while (_loc_4 < 9)
            {
                
                _loc_5 = new GClip("peteggline");
                _loc_5.x = 75;
                _loc_5.y = 265;
                _loc_5.visible = 0.8;
                this._panel.addChild(_loc_5);
                _loc_12.push(_loc_5);
                _loc_4 = _loc_4 + 1;
            }
            this._extractDict[_loc_11] = {arr:_loc_12, target:_loc_7, speed:_loc_8, angle:_loc_10, acc:_loc_9, decay:0.9};
            this.extractLoop(null, _loc_11);
            _loc_11.addEventListener(Event.ENTER_FRAME, this.extractLoop);
            _loc_11.name = String(param3);
            return;
        }// end function

        private function extractLoop(param1 = null, param2 = null)
        {
            var obj:*;
            var sprt:*;
            var _n:*;
            var i:*;
            var targetAngle:*;
            var angleOff:*;
            var xSpeed:*;
            var ySpeed:*;
            var distance:*;
            var event:* = param1;
            var mc:* = param2;
            if (Config.paused)
            {
                return;
            }
            try
            {
                if (event != null)
                {
                    sprt = event.target;
                }
                else
                {
                    sprt = mc;
                }
                obj = this._extractDict[sprt];
                targetAngle = Math.atan2(obj.target.y - sprt.y, obj.target.x - sprt.x);
                angleOff = targetAngle - obj.angle;
                if (angleOff > Math.PI)
                {
                    angleOff = angleOff - Math.PI * 2;
                }
                else if (angleOff < -Math.PI)
                {
                    angleOff = angleOff + Math.PI * 2;
                }
                angleOff = Math.abs(angleOff) / Math.PI;
                xSpeed = Math.cos(obj.angle) * obj.speed + Math.cos(targetAngle) * obj.acc * (1 - angleOff);
                ySpeed = Math.sin(obj.angle) * obj.speed + Math.sin(targetAngle) * obj.acc * (1 - angleOff);
                obj.angle = Math.atan2(ySpeed, xSpeed);
                obj.speed = Math.sqrt(Math.pow(xSpeed, 2) + Math.pow(ySpeed, 2));
                obj.speed = obj.speed * obj.decay;
                distance = Math.sqrt(Math.pow(obj.target.y - sprt.y, 2) + Math.pow(obj.target.x - sprt.x, 2));
                if (distance > obj.speed / 30)
                {
                    obj.arr[0].x = sprt.x;
                    obj.arr[0].y = sprt.y;
                    sprt.x = sprt.x + Math.cos(obj.angle) * obj.speed / 30;
                    sprt.y = sprt.y + Math.sin(obj.angle) * obj.speed / 30;
                    i;
                    while (i < obj.arr.length)
                    {
                        
                        obj.arr[i].x = obj.arr[(i - 1)].x;
                        obj.arr[i].y = obj.arr[(i - 1)].y;
                        i = (i + 1);
                    }
                }
                else
                {
                    sprt.destroy();
                    if (sprt.parent != null)
                    {
                        sprt.parent.removeChild(sprt);
                    }
                    i;
                    while (i < obj.arr.length)
                    {
                        
                        obj.arr[i].destroy();
                        if (obj.arr[i].parent != null)
                        {
                            obj.arr[i].parent.removeChild(obj.arr[i]);
                        }
                        i = (i + 1);
                    }
                    sprt.removeEventListener(Event.ENTER_FRAME, this.extractLoop);
                    delete this._extractDict[sprt];
                    this.pushbtnOne.enabled = true;
                    this.pushbtnTen.enabled = true;
                    if (this.petitemArr[parseInt(sprt.name)] != null)
                    {
                        this.petitemArr[parseInt(sprt.name)].display();
                        this._slotItemarr[parseInt(sprt.name)].item = this.petitemArr[parseInt(sprt.name)];
                        if (int(this._slotItemarr[parseInt(sprt.name)].item._itemData.nameColor) == 3)
                        {
                            this._gclip = new GClip("activeborder");
                            this._gclip.x = this._slotItemarr[parseInt(sprt.name)].x - 32;
                            this._gclip.y = this._slotItemarr[parseInt(sprt.name)].y - 32;
                            this._panel.addChild(this._gclip);
                            this._buttonGClips.push(this._gclip);
                        }
                    }
                }
            }
            catch (e)
            {
                event.target.removeEventListener(Event.ENTER_FRAME, extractLoop);
            }
            return;
        }// end function

        private function itemchange(param1) : void
        {
            if (this._opening)
            {
                this._labnum.text = Config.language("RandomPetegg", 1, Config.ui._charUI.getItemAmount(898013));
                if (Config.ui._charUI.getItemAmount(898013) >= 4)
                {
                    this.pushbtnOne.enabled = true;
                    if (Config.ui._charUI.getItemAmount(898013) >= 10)
                    {
                        this.pushbtnTen.enabled = true;
                    }
                    else
                    {
                        this.pushbtnTen.enabled = false;
                    }
                }
                else
                {
                    this.pushbtnOne.enabled = false;
                    this.pushbtnTen.enabled = false;
                }
            }
            return;
        }// end function

        private function removeitemspr()
        {
            var _loc_1:* = 0;
            if (this._slotItemarr[0] != null)
            {
                if (this._slotItemarr[0].item != null)
                {
                    _loc_1 = 0;
                    while (_loc_1 < this._slotItemarr.length)
                    {
                        
                        if (this._slotItemarr[_loc_1].item != null)
                        {
                            this._slotItemarr[_loc_1].item.destroy();
                            this._slotItemarr[_loc_1].item = null;
                        }
                        else
                        {
                            break;
                        }
                        _loc_1++;
                    }
                }
            }
            return;
        }// end function

        private function addeggpbtn() : void
        {
            this.removechildgclip();
            this._eggclip = GClip.newGClip("pbtntwelve");
            this._eggclip.x = 70;
            this._eggclip.y = 221;
            this._eggclip.mouseChildren = false;
            this._eggclip.mouseEnabled = false;
            this._machinePanel.addChild(this._eggclip);
            this._machinePanel.addChild(this._eggclip);
            return;
        }// end function

        private function removechildgclip() : void
        {
            var _loc_1:* = 0;
            while (_loc_1 < this._buttonGClips.length)
            {
                
                if (this._buttonGClips[_loc_1].parent != null)
                {
                    this._buttonGClips[_loc_1].parent.removeChild(this._buttonGClips[_loc_1]);
                }
                this._buttonGClips[_loc_1].destroy();
                _loc_1 = _loc_1 + 1;
            }
            this._buttonGClips = [];
            return;
        }// end function

        private function handleSlotOver(event:Event) : void
        {
            var _loc_2:* = event.currentTarget;
            if (_loc_2.item != null)
            {
                Holder.showInfo(_loc_2.item.outputInfo(), new Rectangle(_loc_2.x + this.x, _loc_2.y + this.y, _loc_2._size, _loc_2._size), false, 0, 250);
            }
            return;
        }// end function

        private function handleSlotOut(event:MouseEvent) : void
        {
            Holder.closeInfo();
            return;
        }// end function

        private function handlebtnOver1(event:Event) : void
        {
            var _loc_2:* = event.currentTarget;
            if (!this.pushbtnOne.enabled)
            {
                Holder.showInfo(Config.language("RandomPetegg", 9), new Rectangle(_loc_2.x + this.x, _loc_2.y + this.y, 80, 25), false, 0, 250);
            }
            return;
        }// end function

        private function handlebtnOver2(event:Event) : void
        {
            var _loc_2:* = event.currentTarget;
            if (!this.pushbtnTen.enabled)
            {
                Holder.showInfo(Config.language("RandomPetegg", 9), new Rectangle(_loc_2.x + this.x, _loc_2.y + this.y, 80, 25), false, 0, 250);
            }
            return;
        }// end function

        public function addListNpcTalk(param1:int, param2:Array, param3:Function = null) : void
        {
            param2.push({label:Config.language("RandomPetegg", 10), handler:this.addTaskFind, closeflag:true});
            return;
        }// end function

        private function addTaskFind(event:TextEvent) : void
        {
            this.open();
            Config.ui._dialogue.closedialogue();
            return;
        }// end function

    }
}
