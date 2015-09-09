package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;
    import lovefox.socket.*;
    import lovefox.unit.*;

    public class EquipMentPanel extends Window
    {
        private var _slotArray:Array;
        private var _infoLB:Label;
        private var _playerid:Object;
        private var _playerLevel:int = -1;
        private var _playerJobID:int = -1;
        private var _sampleClip:UnitClip;

        public function EquipMentPanel(param1)
        {
            this._slotArray = [];
            super(param1);
            resize(200, 280);
            this.initDraw();
            this.initpanel();
            return;
        }// end function

        private function initDraw() : void
        {
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.SMSG_EQUIP_LIST, this.getequip);
            return;
        }// end function

        private function initpanel() : void
        {
            this._infoLB = new Label(this, Math.floor((_width - 100) / 2), 40);
            this._infoLB.autoSize = false;
            this._infoLB.height = 40;
            this._infoLB.width = 100;
            this._infoLB.html = true;
            var _loc_1:* = 0;
            while (_loc_1 < 14)
            {
                
                this._slotArray[_loc_1] = new CloneSlot(0, 30);
                this.addChild(this._slotArray[_loc_1]);
                this._slotArray[_loc_1].addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
                this._slotArray[_loc_1].addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
                this._slotArray[_loc_1].bg = Config.findUI("charui")["icon" + (_loc_1 + 1)];
                _loc_1 = _loc_1 + 1;
            }
            var _loc_2:* = 10;
            var _loc_3:* = 158;
            var _loc_4:* = 30;
            var _loc_5:* = 40;
            this._slotArray[0].x = _loc_2;
            this._slotArray[0].y = _loc_4 + _loc_5 * 3;
            this._slotArray[1].x = _loc_2;
            this._slotArray[1].y = _loc_4;
            this._slotArray[2].x = _loc_2;
            this._slotArray[2].y = _loc_4 + _loc_5;
            this._slotArray[3].x = _loc_2;
            this._slotArray[3].y = _loc_4 + _loc_5 * 2;
            this._slotArray[4].x = _loc_3;
            this._slotArray[4].y = _loc_4 + _loc_5 * 3;
            this._slotArray[5].x = _loc_2;
            this._slotArray[5].y = _loc_4 + _loc_5 * 4;
            this._slotArray[6].x = _loc_3;
            this._slotArray[6].y = _loc_4 + _loc_5;
            this._slotArray[7].x = _loc_3;
            this._slotArray[7].y = _loc_4 + _loc_5 * 2;
            this._slotArray[8].x = _loc_3;
            this._slotArray[8].y = _loc_4;
            this._slotArray[9].x = _loc_3;
            this._slotArray[9].y = _loc_4 + _loc_5 * 4;
            this._slotArray[10].x = 70;
            this._slotArray[10].y = _loc_4 + _loc_5 * 5;
            this._slotArray[11].x = 30;
            this._slotArray[11].y = _loc_4 + _loc_5 * 5;
            this._slotArray[12].x = 110;
            this._slotArray[12].y = _loc_4 + _loc_5 * 5;
            this._slotArray[13].x = 150;
            this._slotArray[13].y = _loc_4 + _loc_5 * 5;
            this._sampleClip = UnitClip.newUnitClip();
            this._sampleClip.changeStateTo("idle");
            this._sampleClip.changeDirectionTo(1);
            this._sampleClip.x = _width / 2;
            this._sampleClip.y = 200;
            addChild(this._sampleClip);
            return;
        }// end function

        private function handleSlotOver(param1)
        {
            var _loc_3:* = null;
            var _loc_2:* = param1.currentTarget;
            if (_loc_2.item != null)
            {
                Holder.showInfo(_loc_2.item.outputInfo(), new Rectangle(_loc_2.x + _loc_2.parent.x, _loc_2.y + _loc_2.parent.y, _loc_2._size, _loc_2._size), false, 0, 250);
                if (int(_loc_2.item._itemData.suitID) > 0)
                {
                    _loc_3 = _loc_2.parent.localToGlobal(new Point(_loc_2.x, _loc_2.y));
                    Holder.showRightInfo(this.showothersuit(_loc_2.item), new Rectangle(_loc_3.x, _loc_3.y, _loc_2._size, _loc_2._size));
                }
            }
            return;
        }// end function

        private function handleSlotOut(param1)
        {
            Holder.closeInfo();
            return;
        }// end function

        private function showothersuit(param1:Item) : String
        {
            var _loc_8:* = null;
            var _loc_10:* = 0;
            var _loc_12:* = null;
            var _loc_13:* = 0;
            var _loc_14:* = null;
            var _loc_15:* = null;
            var _loc_16:* = null;
            var _loc_17:* = 0;
            var _loc_18:* = null;
            var _loc_2:* = Config._replace1;
            var _loc_3:* = "";
            var _loc_4:* = Config._outfit[param1._itemData.suitID];
            var _loc_5:* = [Config.language("EquipMentPanel", 3), Config.language("EquipMentPanel", 4), Config.language("EquipMentPanel", 5), Config.language("EquipMentPanel", 6), Config.language("EquipMentPanel", 7), Config.language("EquipMentPanel", 8), Config.language("EquipMentPanel", 9), Config.language("EquipMentPanel", 10), Config.language("EquipMentPanel", 11), Config.language("EquipMentPanel", 12), Config.language("EquipMentPanel", 13)];
            _loc_3 = _loc_3 + ("<font color=\'" + Style.FONT_Green + "\'>" + _loc_4.suitName + Config.language("Item", 73));
            _loc_3 = _loc_3 + (this.getsuitum(param1._itemData.suitID) + " / " + _loc_4.suitMaxNumber);
            _loc_3 = _loc_3 + "</font>\n";
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            _loc_8 = String(_loc_4.suit1).split(":");
            var _loc_9:* = 0;
            _loc_10 = 0;
            while (_loc_10 < _loc_8.length)
            {
                
                _loc_9 = int(_loc_8[_loc_10]);
                break;
                _loc_10 = _loc_10 + 1;
            }
            if (Config.player.job == 1)
            {
                _loc_6 = 0;
            }
            else if (Config.player.job == 4)
            {
                _loc_6 = 1;
            }
            else
            {
                _loc_6 = 2;
            }
            if (_loc_9 > 0)
            {
                _loc_12 = Style.FONT_Gray;
                _loc_13 = 0;
                while (_loc_13 < _loc_8.length)
                {
                    
                    if (this.checksuitid(_loc_8[_loc_13], param1._itemData.suitID))
                    {
                        _loc_12 = Style.FONT_Green;
                        break;
                    }
                    _loc_13 = _loc_13 + 1;
                }
                if (_loc_12 == Style.FONT_Green)
                {
                    _loc_3 = _loc_3 + ("\n<font color=\'" + _loc_12 + "\'>" + _loc_4.suitName + Config._itemMap[int(_loc_8[_loc_13])].name + "</font>");
                }
                else
                {
                    _loc_3 = _loc_3 + ("\n<font color=\'" + _loc_12 + "\'>" + _loc_4.suitName + " - " + _loc_5[_loc_6] + "</font>");
                }
            }
            _loc_10 = 2;
            while (_loc_10 < 15)
            {
                
                _loc_14 = String(_loc_4["suit" + _loc_10]).split(":");
                _loc_13 = 0;
                while (_loc_13 < _loc_14.length)
                {
                    
                    _loc_7 = int(_loc_14[_loc_13]);
                    break;
                    _loc_13 = _loc_13 + 1;
                }
                if (_loc_7 > 0)
                {
                    _loc_6 = Config._itemMap[_loc_7].subType;
                    _loc_12 = Style.FONT_Gray;
                    _loc_13 = 0;
                    while (_loc_13 < _loc_14.length)
                    {
                        
                        if (this.checksuitid(_loc_14[_loc_13], param1._itemData.suitID, _loc_10))
                        {
                            _loc_12 = Style.FONT_Green;
                            break;
                        }
                        _loc_13 = _loc_13 + 1;
                    }
                    if (_loc_12 == Style.FONT_Green)
                    {
                        _loc_3 = _loc_3 + ("\n<font color=\'" + _loc_12 + "\'>" + _loc_4.suitName + Config._itemMap[int(_loc_14[_loc_13])].name + "</font>");
                    }
                    else
                    {
                        _loc_3 = _loc_3 + ("\n<font color=\'" + _loc_12 + "\'>" + _loc_4.suitName + " - " + _loc_5[(_loc_6 + 1)] + "</font>");
                    }
                }
                _loc_10 = _loc_10 + 1;
            }
            _loc_3 = _loc_3 + ("\n\n<font color=\'" + Style.FONT_Green + "\'>" + Config.language("Item", 74) + "</font>\n");
            var _loc_11:* = 1;
            while (_loc_11 < 10)
            {
                
                if (_loc_4["amount" + _loc_11] > 0)
                {
                    _loc_15 = Style.FONT_Gray;
                    if (this.getsuitum(param1._itemData.suitID) >= _loc_4["amount" + _loc_11])
                    {
                        _loc_15 = Style.FONT_Green;
                    }
                    _loc_3 = _loc_3 + Config.language("Item", 75, _loc_15, _loc_4["amount" + _loc_11]);
                    _loc_16 = String(_loc_4["effect" + _loc_11 + "_s"]);
                    _loc_8 = _loc_16.split(";");
                    _loc_17 = 0;
                    while (_loc_17 < _loc_8.length)
                    {
                        
                        _loc_18 = String(Config._itemPropMap[int(_loc_8[_loc_17].split(",")[0])].prop).replace(_loc_2, _loc_8[_loc_17].split(",")[1]);
                        if (_loc_17 > 0)
                        {
                            _loc_18 = "        " + _loc_18;
                        }
                        _loc_3 = _loc_3 + (_loc_18 + "\n");
                        _loc_17 = _loc_17 + 1;
                    }
                    _loc_3 = _loc_3 + "</font>";
                }
                _loc_11 = _loc_11 + 1;
            }
            return _loc_3;
        }// end function

        private function getsuitum(param1) : int
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            while (_loc_3 < this._slotArray.length)
            {
                
                if (this._slotArray[_loc_3].item != null)
                {
                    if (this._slotArray[_loc_3].item._itemData.suitID == param1)
                    {
                        _loc_2++;
                    }
                }
                _loc_3++;
            }
            return _loc_2;
        }// end function

        private function checksuitid(param1, param2, param3 = 1) : Boolean
        {
            var _loc_4:* = false;
            var _loc_5:* = 0;
            while (_loc_5 < this._slotArray.length)
            {
                
                if (param3 == 7 || param3 == 8)
                {
                    if (this._slotArray[_loc_5].item != null)
                    {
                        if (param3 == (_loc_5 + 1) && this._slotArray[_loc_5].item._itemData.id == param1 && this._slotArray[_loc_5].item._itemData.suitID == param2)
                        {
                            _loc_4 = true;
                            break;
                        }
                    }
                }
                else if (this._slotArray[_loc_5].item != null)
                {
                    if (this._slotArray[_loc_5].item._itemData.id == param1 && this._slotArray[_loc_5].item._itemData.suitID == param2)
                    {
                        _loc_4 = true;
                        break;
                    }
                }
                _loc_5++;
            }
            return _loc_4;
        }// end function

        public function sendequip(param1:int) : void
        {
            var _loc_2:* = Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_PLAYER, param1);
            this._playerLevel = -1;
            this._playerJobID = -1;
            if (_loc_2 != null)
            {
                this._playerLevel = _loc_2.level;
                this._playerJobID = _loc_2.job;
            }
            var _loc_3:* = new DataSet();
            _loc_3.addHead(CONST_ENUM.CMSG_EQUIP_LIST);
            _loc_3.add32(param1);
            ClientSocket.send(_loc_3);
            return;
        }// end function

        private function getequip(event:SocketEvent) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = undefined;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            _loc_2 = 0;
            while (_loc_2 < this._slotArray.length)
            {
                
                if (this._slotArray[_loc_2].item != null)
                {
                    this._slotArray[_loc_2].item.destroy();
                    this._slotArray[_loc_2].item = null;
                }
                _loc_2 = _loc_2 + 1;
            }
            var _loc_4:* = event.data;
            this.open();
            var _loc_5:* = _loc_4.readUnsignedInt();
            var _loc_6:* = _loc_4.readUnsignedShort();
            var _loc_7:* = _loc_4.readUTFBytes(_loc_6);
            var _loc_8:* = _loc_4.readByte();
            title = "" + _loc_7 + Config.language("EquipMentPanel", 1);
            _loc_2 = 0;
            while (_loc_2 < _loc_8)
            {
                
                _loc_9 = _loc_4.readUnsignedShort();
                _loc_10 = Item.createItemByBytes(_loc_4, 0, UNIT_TYPE_ENUM.TYPEID_ITEM);
                _loc_10.display();
                this._slotArray[_loc_9 - 1001].item = _loc_10;
                _loc_2 = _loc_2 + 1;
            }
            if (this._playerLevel != -1)
            {
                this._infoLB.text = "<p align=\'center\'><font size=\'14\'><b>" + _loc_7 + "</b></font>\n" + Config.language("CharUI", 15, this._playerLevel, Config._jobTitleMap[this._playerJobID]) + "</p>";
            }
            else
            {
                this._infoLB.text = "<p align=\'center\'><font size=\'14\'><b>" + _loc_7 + "</b></font></p>";
            }
            this._playerid = _loc_5;
            Config.startLoop(this.subHandlePlayerRedraw);
            return;
        }// end function

        private function subHandlePlayerRedraw(param1 = null)
        {
            Config.stopLoop(this.subHandlePlayerRedraw);
            var _loc_2:* = Unit.getPlayerlist()[this._playerid];
            if (_loc_2 != null && _loc_2._img != null)
            {
                if (_loc_2._img.ready)
                {
                    this._sampleClip.visible = true;
                    this._sampleClip.clone(_loc_2._img);
                    return;
                }
            }
            this._sampleClip.visible = false;
            return;
        }// end function

        override public function open(event:MouseEvent = null)
        {
            super.open(event);
            if (this._sampleClip != null)
            {
                this._sampleClip.wakeAnimation();
            }
            return;
        }// end function

        override public function close()
        {
            super.close();
            if (this._sampleClip != null)
            {
                this._sampleClip.sleepAnimation();
            }
            return;
        }// end function

    }
}
