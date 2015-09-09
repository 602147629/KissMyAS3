package lovefox.activeUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;
    import lovefox.component.*;
    import lovefox.gameUI.*;
    import lovefox.socket.*;
    import lovefox.unit.*;

    public class NationalDayPanel extends Window
    {
        private var inforObj:Object;
        private var slotObj:Object;
        private var typeObj:Object;
        private var cavPanel:CanvasUI;
        private var cavbg:Shape;
        private var t2:Label;
        private var t3:Label;

        public function NationalDayPanel(param1:DisplayObjectContainer)
        {
            this.inforObj = {};
            this.slotObj = {};
            this.typeObj = {};
            super(param1);
            this.initpanel();
            this.initsocket();
            return;
        }// end function

        private function initsocket() : void
        {
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_EXCHANGE_CFG, this.exChange);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_EXCHANGE_INFO, this.exChangeInfo);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_EXCHANGE_UPDATE, this.exChangeUpdate);
            return;
        }// end function

        private function initpanel() : void
        {
            this.title = Config.language("NationalDayPanel", 1);
            resize(400, 370);
            var _loc_1:* = new Label(this, 10, 34);
            _loc_1.html = true;
            _loc_1.text = Config.language("NationalDayPanel", 2);
            this.t2 = new Label(this, 10, 55);
            this.t2.html = true;
            this.t3 = new Label(this, 10, 75);
            this.t3.html = true;
            this.cavPanel = new CanvasUI(this, 10, 120, 380, 100);
            this.cavbg = new Shape();
            return;
        }// end function

        private function handleSlotOver(param1)
        {
            var _loc_2:* = param1.currentTarget;
            var _loc_3:* = _loc_2.parent.localToGlobal(new Point(_loc_2.x, _loc_2.y));
            if (_loc_2.item != null)
            {
                Holder.showInfo(_loc_2.item.outputInfo(), new Rectangle(_loc_3.x, _loc_3.y, _loc_2._size, _loc_2._size), false, 0, 200);
            }
            return;
        }// end function

        private function handleSlotOut(param1)
        {
            Holder.closeInfo();
            return;
        }// end function

        private function exChange(event:SocketEvent) : void
        {
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = 0;
            var _loc_12:* = 0;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = null;
            var _loc_16:* = null;
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            var _loc_4:* = 150;
            this.inforObj = {};
            var _loc_5:* = 0;
            while (_loc_5 < _loc_3)
            {
                
                _loc_6 = _loc_2.readUnsignedInt();
                _loc_7 = _loc_2.readUnsignedByte();
                _loc_8 = _loc_2.readUnsignedInt();
                this.typeObj[_loc_6] = _loc_8;
                if (_loc_7 == 1)
                {
                    if (this.inforObj[_loc_8] == null)
                    {
                        this.inforObj[_loc_8] = {};
                    }
                    this.inforObj[_loc_8][_loc_6] = {};
                    this.inforObj[_loc_8][_loc_6].id = _loc_6;
                    this.inforObj[_loc_8][_loc_6].status = _loc_7;
                    this.inforObj[_loc_8][_loc_6].actId = _loc_8;
                    this.inforObj[_loc_8][_loc_6].actName = _loc_2.readUTFBytes(_loc_2.readUnsignedShort());
                    this.inforObj[_loc_8][_loc_6].actDesc = _loc_2.readUTFBytes(_loc_2.readUnsignedShort());
                    this.inforObj[_loc_8][_loc_6].name = _loc_2.readUTFBytes(_loc_2.readUnsignedShort());
                    this.inforObj[_loc_8][_loc_6].startTime = _loc_2.readUTFBytes(_loc_2.readUnsignedShort());
                    this.inforObj[_loc_8][_loc_6].endTime = _loc_2.readUTFBytes(_loc_2.readUnsignedShort());
                    this.inforObj[_loc_8][_loc_6].npcId = _loc_2.readUnsignedInt();
                    this.inforObj[_loc_8][_loc_6].repeat = _loc_2.readUnsignedInt();
                    this.inforObj[_loc_8][_loc_6].dailyLimit = _loc_2.readUnsignedInt();
                    this.inforObj[_loc_8][_loc_6].cooldown = _loc_2.readUnsignedInt();
                    this.inforObj[_loc_8][_loc_6].count = _loc_2.readUnsignedInt();
                    _loc_9 = 0;
                    while (_loc_9 < this.inforObj[_loc_8][_loc_6].count)
                    {
                        
                        this.inforObj[_loc_8][_loc_6][_loc_9] = {};
                        this.inforObj[_loc_8][_loc_6][_loc_9].type = _loc_2.readUnsignedInt();
                        this.inforObj[_loc_8][_loc_6][_loc_9].targe = _loc_2.readUnsignedInt();
                        this.inforObj[_loc_8][_loc_6][_loc_9].para = _loc_2.readUnsignedInt();
                        if (this.inforObj[_loc_8][_loc_6][_loc_9].type == 1)
                        {
                            _loc_14 = new CloneSlot(_loc_6, 32);
                            this.inforObj[_loc_8][_loc_6][_loc_9].item = _loc_14;
                            _loc_14.addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
                            _loc_14.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
                            _loc_15 = Item.newItem(Config._itemMap[this.inforObj[_loc_8][_loc_6][_loc_9].targe], 0, 0, UNIT_TYPE_ENUM.TYPEID_ITEMCLONE, 0);
                            _loc_15.display();
                            _loc_14.item = _loc_15;
                            _loc_16 = String(_loc_6) + String(this.inforObj[_loc_8][_loc_6][_loc_9].targe);
                            this.slotObj[_loc_16] = {id:_loc_6, slot:_loc_14, itemId:this.inforObj[_loc_8][_loc_6][_loc_9].targe, num:this.inforObj[_loc_8][_loc_6][_loc_9].para};
                        }
                        else if (this.inforObj[_loc_8][_loc_6][_loc_9].type == 2)
                        {
                            this.inforObj[_loc_8][_loc_6][_loc_9].item = new Label(null, 0, 0, Config.language("NationalDayPanel", 3, this.inforObj[_loc_8][_loc_6][_loc_9].targe));
                        }
                        else if (this.inforObj[_loc_8][_loc_6][_loc_9].type == 3)
                        {
                            this.inforObj[_loc_8][_loc_6][_loc_9].item = new Label(null, 0, 0, Config.language("NationalDayPanel", 4, this.inforObj[_loc_8][_loc_6][_loc_9].targe));
                        }
                        _loc_9 = _loc_9 + 1;
                    }
                    this.inforObj[_loc_8][_loc_6].rewardIdM = _loc_2.readUnsignedInt();
                    this.inforObj[_loc_8][_loc_6].rewardCountM = _loc_2.readUnsignedInt();
                    this.inforObj[_loc_8][_loc_6].rewardIdF = _loc_2.readUnsignedInt();
                    this.inforObj[_loc_8][_loc_6].rewardCountF = _loc_2.readUnsignedInt();
                    this.inforObj[_loc_8][_loc_6].removeFlag = _loc_2.readUnsignedInt();
                    _loc_10 = new CloneSlot(1, 32);
                    this.inforObj[_loc_8][_loc_6].rewardItem = _loc_10;
                    _loc_10.addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
                    _loc_10.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
                    _loc_11 = this.inforObj[_loc_8][_loc_6].rewardIdF;
                    _loc_12 = this.inforObj[_loc_8][_loc_6].rewardCountF;
                    if (Config.player.sex == 1)
                    {
                        _loc_11 = this.inforObj[_loc_8][_loc_6].rewardIdM;
                        _loc_12 = this.inforObj[_loc_8][_loc_6].rewardCountM;
                    }
                    _loc_13 = Item.newItem(Config._itemMap[_loc_11], 0, 0, UNIT_TYPE_ENUM.TYPEID_ITEMCLONE, 0);
                    _loc_13.display();
                    _loc_13.amount = _loc_12;
                    _loc_10.item = _loc_13;
                    this.inforObj[_loc_8][_loc_6].btn = new PushButton(null, 300, _loc_10.y + 6, Config.language("NationalDayPanel", 5), Config.create(this.getRew, _loc_6, this.inforObj[_loc_8][_loc_6].npcId));
                    this.inforObj[_loc_8][_loc_6].btn.width = 60;
                    this.inforObj[_loc_8][_loc_6].t4 = new Label(null, 190, this.inforObj[_loc_8][_loc_6].btn.y, Config.language("NationalDayPanel", 6));
                }
                _loc_5 = _loc_5 + 1;
            }
            return;
        }// end function

        private function exChangeInfo(event:SocketEvent) : void
        {
            var _loc_5:* = 0;
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedShort();
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = _loc_2.readUnsignedInt();
                if (this.inforObj[this.typeObj[_loc_5]][_loc_5] != null)
                {
                    this.inforObj[this.typeObj[_loc_5]][_loc_5].totalCount = _loc_2.readUnsignedInt();
                    this.inforObj[this.typeObj[_loc_5]][_loc_5].todayCount = _loc_2.readUnsignedInt();
                    this.inforObj[this.typeObj[_loc_5]][_loc_5].lastTime = _loc_2.readUnsignedInt();
                    if (this.inforObj[this.typeObj[_loc_5]][_loc_5].todayCount < this.inforObj[this.typeObj[_loc_5]][_loc_5].dailyLimit || int(this.inforObj[this.typeObj[_loc_5]][_loc_5].dailyLimit) == 0)
                    {
                        this.inforObj[this.typeObj[_loc_5]][_loc_5].btn.enabled = true;
                    }
                    else
                    {
                        this.inforObj[this.typeObj[_loc_5]][_loc_5].btn.enabled = false;
                    }
                }
                _loc_4 = _loc_4 + 1;
            }
            return;
        }// end function

        private function exChangeUpdate(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            if (this.inforObj[this.typeObj[_loc_3]][_loc_3] != null)
            {
                this.inforObj[this.typeObj[_loc_3]][_loc_3].totalCount = _loc_2.readUnsignedInt();
                this.inforObj[this.typeObj[_loc_3]][_loc_3].todayCount = _loc_2.readUnsignedInt();
                this.inforObj[this.typeObj[_loc_3]][_loc_3].lastTime = _loc_2.readUnsignedInt();
                if (this.inforObj[this.typeObj[_loc_3]][_loc_3].todayCount < this.inforObj[this.typeObj[_loc_3]][_loc_3].dailyLimit || int(this.inforObj[this.typeObj[_loc_3]][_loc_3].dailyLimit) == 0)
                {
                    this.inforObj[this.typeObj[_loc_3]][_loc_3].btn.enabled = true;
                }
                else
                {
                    this.inforObj[this.typeObj[_loc_3]][_loc_3].btn.enabled = false;
                }
            }
            return;
        }// end function

        public function dayReset() : void
        {
            var _loc_1:* = undefined;
            var _loc_2:* = undefined;
            for (_loc_1 in this.inforObj)
            {
                
                for (_loc_2 in this.inforObj[_loc_1])
                {
                    
                    this.inforObj[_loc_1][_loc_2].todayCount = 0;
                    this.inforObj[_loc_1][_loc_2].btn.enabled = true;
                }
            }
            return;
        }// end function

        private function getRew(event:MouseEvent, param2:int, param3:int) : void
        {
            var _loc_4:* = new DataSet();
            new DataSet().addHead(CONST_ENUM.C2G_EXCHANGE);
            _loc_4.add32(param2);
            _loc_4.add32(Npc._npcId);
            ClientSocket.send(_loc_4);
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

        public function openPanel(param1 = null, param2:int = 1) : void
        {
            var _loc_3:* = undefined;
            var _loc_4:* = 0;
            var _loc_5:* = undefined;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_9:* = undefined;
            super.open();
            this.reshowItem();
            for (_loc_3 in this.inforObj[param2])
            {
                
                this.title = this.inforObj[param2][_loc_3].actName;
                this.t2.text = Config.language("NationalDayPanel", 7, this.inforObj[param2][_loc_3].startTime, this.inforObj[param2][_loc_3].endTime);
                this.t3.text = this.inforObj[param2][_loc_3].actDesc;
                break;
            }
            this.cavPanel.y = this.t3.y + this.t3.height + 5;
            this.cavPanel.height = this.height - this.cavPanel.y - 5;
            this.cavPanel.removeAllChildren();
            this.cavPanel.addChildUI(this.cavbg);
            this.cavbg.graphics.clear();
            this.cavbg.graphics.beginFill(16777215, 0.3);
            _loc_4 = 0;
            for (_loc_5 in this.inforObj[param2])
            {
                
                _loc_6 = [];
                _loc_7 = [];
                _loc_8 = 0;
                while (_loc_8 < this.inforObj[param2][_loc_5].count)
                {
                    
                    if (this.inforObj[param2][_loc_5][_loc_8].type == 1)
                    {
                        _loc_6.push(this.inforObj[param2][_loc_5][_loc_8]);
                    }
                    else
                    {
                        _loc_7.push(this.inforObj[param2][_loc_5][_loc_8]);
                    }
                    _loc_8 = _loc_8 + 1;
                }
                _loc_9 = 5;
                _loc_8 = 0;
                while (_loc_8 < _loc_7.length)
                {
                    
                    this.cavPanel.addChildUI(_loc_7[_loc_8].item);
                    _loc_7[_loc_8].item.x = 20;
                    _loc_7[_loc_8].item.y = _loc_4 + _loc_9;
                    _loc_9 = _loc_9 + 25;
                    _loc_8 = _loc_8 + 1;
                }
                _loc_8 = 0;
                while (_loc_8 < _loc_6.length)
                {
                    
                    this.cavPanel.addChildUI(_loc_6[_loc_8].item);
                    _loc_6[_loc_8].item.x = 20 + int(_loc_8 % 4) * 40;
                    _loc_6[_loc_8].item.y = _loc_4 + _loc_9 + int(_loc_8 / 4) * 40 + 10;
                    _loc_8 = _loc_8 + 1;
                }
                if (_loc_6.length > 0)
                {
                    _loc_9 = _loc_9 + (Math.ceil(_loc_8 / 4) * 40 + 10);
                }
                if (_loc_9 < 55)
                {
                    _loc_9 = 55;
                }
                this.cavPanel.addChildUI(this.inforObj[param2][_loc_5].rewardItem);
                this.inforObj[param2][_loc_5].rewardItem.x = 250;
                this.inforObj[param2][_loc_5].rewardItem.y = _loc_4 + (_loc_9 + 5 - this.inforObj[param2][_loc_5].rewardItem.height) / 2;
                this.cavPanel.addChildUI(this.inforObj[param2][_loc_5].btn);
                this.inforObj[param2][_loc_5].btn.x = 300;
                this.inforObj[param2][_loc_5].btn.y = _loc_4 + (_loc_9 + 5 - this.inforObj[param2][_loc_5].btn.height) / 2;
                this.cavPanel.addChildUI(this.inforObj[param2][_loc_5].t4);
                this.inforObj[param2][_loc_5].t4.x = 190;
                this.inforObj[param2][_loc_5].t4.y = _loc_4 + (_loc_9 + 5 - this.inforObj[param2][_loc_5].t4.height) / 2;
                this.cavbg.graphics.drawRoundRect(5, _loc_4, 390, _loc_9 + 5, 2);
                _loc_4 = _loc_4 + (_loc_9 + 15);
            }
            this.cavbg.graphics.endFill();
            return;
        }// end function

        public function reshowItem() : void
        {
            var _loc_1:* = undefined;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            if (this.stage != null)
            {
                for (_loc_1 in this.slotObj)
                {
                    
                    _loc_2 = Config.ui._charUI.getItemAmount(this.slotObj[_loc_1].itemId);
                    _loc_3 = this.slotObj[_loc_1].num;
                    if (this.slotObj[_loc_1].slot.item != null)
                    {
                        if (_loc_2 >= _loc_3)
                        {
                            this.slotObj[_loc_1].slot.item.numstrcolor = 2092116;
                        }
                        else
                        {
                            this.slotObj[_loc_1].slot.item.numstrcolor = 16777215;
                        }
                    }
                    this.slotObj[_loc_1].slot.item.numstr = _loc_2 + "/" + _loc_3;
                }
            }
            return;
        }// end function

        public function addNpcShow(param1:int, param2:Array, param3:Function = null) : void
        {
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            for (_loc_4 in this.inforObj)
            {
                
                for (_loc_5 in this.inforObj[_loc_4])
                {
                    
                    if (Config.now.getTime() >= this.realTime(this.inforObj[_loc_4][_loc_5].startTime).getTime() && Config.now.getTime() <= this.realTime(this.inforObj[_loc_4][_loc_5].endTime).getTime())
                    {
                        param2.push({label:this.inforObj[_loc_4][_loc_5].actName, handler:Config.create(this.openPanel, this.inforObj[_loc_4][_loc_5].actId), closeflag:true});
                    }
                    break;
                }
            }
            return;
        }// end function

    }
}
