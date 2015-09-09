package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import lovefox.socket.*;
    import lovefox.unit.*;

    public class Suitfit extends Window
    {
        private var slot1:CloneSlot;
        private var slot2:CloneSlot;
        private var labName1:Label;
        private var labName2:Label;
        private var labName3:Label;
        private var lab1:Label;
        private var lab2:Label;
        private var itemKey:int;
        private var suitId:int;
        private var position:int;
        private var pb:PushButton;
        private var itemSubtype:int;
        private var itemkeyArr:Array;
        private var euipname:Array;

        public function Suitfit(param1:DisplayObjectContainer = null, param2:Number = 0, param3:Number = 0)
        {
            super(param1, param2, param3);
            resize(360, 404);
            this.init();
            return;
        }// end function

        override public function close()
        {
            if (this.slot1.item != null)
            {
                this.slot1.item = null;
            }
            if (this.slot2.item != null)
            {
                this.slot2.item.destroy();
            }
            super.close();
            return;
        }// end function

        private function init()
        {
            this.title = Config.language("Suitfit", 1);
            var _loc_1:* = new Sprite();
            _loc_1.graphics.beginFill(16777215, 0.5);
            _loc_1.graphics.drawRoundRect(15, 60, 330, 104, 5);
            _loc_1.graphics.endFill();
            this.addChild(_loc_1);
            this.slot1 = new CloneSlot(0, 30);
            this.addChild(this.slot1);
            this.slot1.x = 25;
            this.slot1.y = 72;
            this.slot1.addEventListener("sglClick", this.handleSlotClick);
            this.slot1.addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
            this.slot1.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
            this.slot2 = new CloneSlot(0, 30);
            this.addChild(this.slot2);
            this.slot2.x = 25;
            this.slot2.y = 124;
            this.slot2.addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
            this.slot2.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
            new Label(this, 70, 70, Config.language("Suitfit", 2));
            new Label(this, 70, 122, Config.language("Suitfit", 3));
            this.lab1 = new Label(this, 70, 90);
            this.lab2 = new Label(this, 70, 142);
            this.labName1 = new Label(this, 15, 30);
            this.labName2 = new Label(this, 15, 175);
            this.labName3 = new Label(this, 210, 175);
            this.labName1.html = true;
            this.labName2.html = true;
            this.labName3.html = true;
            this.pb = new PushButton(this, 100, 369, Config.language("Suitfit", 4), this.sendsuit);
            this.pb.width = 140;
            this.euipname = [Config.language("Suitfit", 5), Config.language("Suitfit", 6), Config.language("Suitfit", 7), Config.language("Suitfit", 8), Config.language("Suitfit", 9), Config.language("Suitfit", 10), Config.language("Suitfit", 11), Config.language("Suitfit", 12), Config.language("Suitfit", 13), Config.language("Suitfit", 14), Config.language("Suitfit", 15)];
            return;
        }// end function

        public function getSuitname(param1:Item)
        {
            var _loc_2:* = 0;
            if (this.slot1.item != null)
            {
                this.slot1.item = null;
            }
            if (this.slot2.item != null)
            {
                this.slot2.item.destroy();
            }
            this.itemkeyArr = new Array();
            this.itemkeyArr = String(param1._itemData.functionKey).split("|");
            this.itemSubtype = int(param1._itemData.subType);
            this.itemKey = 0;
            this.suitId = int(param1._itemData.suitID);
            this.position = int(param1._position);
            if (this.itemSubtype > 9)
            {
                _loc_2 = this.itemSubtype - 10;
            }
            else
            {
                _loc_2 = this.itemSubtype + 1;
            }
            this.lab1.text = Config.language("Suitfit", 16, param1._itemData.reqLevel, this.euipname[_loc_2]);
            this.lab2.text = Config.language("Suitfit", 17, Config._outfit[this.suitId].suitName, this.euipname[_loc_2]);
            this.labName1.text = "<font color=\'" + Style.FONT_Green + "\'>" + param1._itemData.name + "</font>";
            this.labName2.text = this.outfitInfo();
            this.labName3.text = this.outfitpro();
            return;
        }// end function

        private function handleSlotClick(event:MouseEvent)
        {
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_2:* = event.currentTarget;
            var _loc_3:* = false;
            if (Holder.item == null)
            {
                if (_loc_2.item != null)
                {
                    _loc_2.item = null;
                    if (this.slot2.item != null)
                    {
                        this.slot2.item.destroy();
                    }
                    this.labName2.text = this.outfitInfo();
                }
            }
            else
            {
                _loc_4 = 0;
                while (_loc_4 < this.itemkeyArr.length)
                {
                    
                    if (this.itemkeyArr[_loc_4] == int(Holder.item._itemData.id))
                    {
                        _loc_3 = true;
                        this.itemKey = int(Holder.item._itemData.id);
                        _loc_2.item = Holder.item;
                        _loc_2.item._position = Holder.item._position;
                        Holder.item._drawer[Holder.item._position].item = Holder.item;
                        Holder.item = null;
                        if (this.slot2.item != null)
                        {
                            this.slot2.item.destroy();
                        }
                        _loc_5 = Item.newItem(Config._itemMap[this.itemKey], 0, 0, UNIT_TYPE_ENUM.TYPEID_ITEMCLONE, 0);
                        _loc_5._itemData.suitID = this.suitId;
                        _loc_5._itemData.addEffect = _loc_2.item._itemData.addEffect;
                        _loc_5._itemData.finegrade = _loc_2.item._itemData.finegrade;
                        _loc_5._itemData.qual = _loc_2.item._itemData.qual;
                        _loc_5._itemData.binding = _loc_2.item._itemData.binding;
                        trace("slot.item._itemData.finegrade", _loc_2.item._itemData.finegrade, _loc_5._itemData.finegrade);
                        if (_loc_2.item._itemData.gem != null)
                        {
                            _loc_5._itemData.gem = _loc_2.item._itemData.gem;
                        }
                        _loc_5.display();
                        this.slot2.item = _loc_5;
                        this.labName2.text = this.outfitInfo(this.itemKey);
                        break;
                    }
                    _loc_4 = _loc_4 + 1;
                }
                if (!_loc_3)
                {
                    Config.message(Config.language("Suitfit", 18, this.lab1.text));
                }
            }
            return;
        }// end function

        private function handleSlotOver(event:MouseEvent)
        {
            var _loc_3:* = null;
            var _loc_2:* = event.currentTarget;
            if (_loc_2.item != null)
            {
                Holder.showInfo(_loc_2.item.outputInfo(), new Rectangle(_loc_2.x + this.x, _loc_2.y + this.y, _loc_2._size, _loc_2._size), false, 0, 250, _loc_2.item.star);
                if (int(_loc_2.item._itemData.suitID) > 0 && int(_loc_2.item._itemData.type) != 18)
                {
                    _loc_3 = _loc_2.parent.localToGlobal(new Point(_loc_2.x, _loc_2.y));
                    Holder.showRightInfo(_loc_2.item.outfitInfo(1), new Rectangle(_loc_3.x, _loc_3.y, _loc_2._size, _loc_2._size));
                }
            }
            return;
        }// end function

        private function handleSlotOut(event:MouseEvent)
        {
            Holder.closeInfo();
            return;
        }// end function

        private function outfitInfo(param1:int = 0) : String
        {
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = 0;
            var _loc_2:* = false;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = "";
            var _loc_7:* = Config._outfit[this.suitId];
            _loc_6 = _loc_6 + ("<font color=\'" + Style.FONT_Green + "\'>" + _loc_7.suitName + Config.language("Item", 73));
            _loc_6 = _loc_6 + ("0 / " + _loc_7.suitMaxNumber + "");
            _loc_6 = _loc_6 + "</font>\n";
            var _loc_8:* = 0;
            var _loc_9:* = String(_loc_7.suit1).split(":");
            _loc_5 = 0;
            while (_loc_5 < _loc_9.length)
            {
                
                _loc_8 = int(_loc_9[_loc_5]);
                break;
                _loc_5 = _loc_5 + 1;
            }
            if (_loc_8 > 0)
            {
                if (Config.player.job == 1)
                {
                    _loc_4 = 0;
                }
                else if (Config.player.job == 4)
                {
                    _loc_4 = 1;
                }
                else
                {
                    _loc_4 = 2;
                }
                _loc_10 = Style.FONT_Gray;
                if (this.itemSubtype == 10)
                {
                    _loc_4 = 0;
                    _loc_10 = Style.FONT_Green;
                }
                else if (this.itemSubtype == 11)
                {
                    _loc_4 = 1;
                    _loc_10 = Style.FONT_Green;
                }
                else if (this.itemSubtype == 12)
                {
                    _loc_4 = 2;
                    _loc_10 = Style.FONT_Green;
                }
                if (param1 != 0)
                {
                    if (Config._itemMap[param1].subType == 10 || Config._itemMap[param1].subType == 11 || Config._itemMap[param1].subType == 12)
                    {
                        _loc_6 = _loc_6 + ("\n<font color=\'" + _loc_10 + "\'>" + _loc_7.suitName + Config._itemMap[param1].name + "</font>");
                    }
                    else
                    {
                        _loc_6 = _loc_6 + ("\n<font color=\'" + _loc_10 + "\'>" + _loc_7.suitName + " - " + this.euipname[_loc_4] + "</font>");
                    }
                }
                else
                {
                    _loc_6 = _loc_6 + ("\n<font color=\'" + _loc_10 + "\'>" + _loc_7.suitName + " - " + this.euipname[_loc_4] + "</font>");
                }
            }
            _loc_5 = 2;
            while (_loc_5 < 15)
            {
                
                _loc_11 = String(_loc_7["suit" + _loc_5]).split(":");
                _loc_12 = 0;
                while (_loc_12 < _loc_11.length)
                {
                    
                    _loc_3 = _loc_11[_loc_12];
                    break;
                    _loc_12 = _loc_12 + 1;
                }
                if (_loc_3 > 0)
                {
                    _loc_10 = Style.FONT_Gray;
                    _loc_4 = int(Config._itemMap[_loc_3].subType);
                    trace(_loc_4);
                    if (this.itemSubtype == _loc_4)
                    {
                        _loc_10 = Style.FONT_Green;
                    }
                    if (_loc_4 == 7)
                    {
                        if (_loc_2)
                        {
                            _loc_2 = false;
                            _loc_10 = Style.FONT_Gray;
                        }
                        else
                        {
                            _loc_2 = true;
                        }
                    }
                    if (param1 != 0)
                    {
                        if (Config._itemMap[param1].subType == _loc_4)
                        {
                            _loc_6 = _loc_6 + ("\n<font color=\'" + _loc_10 + "\'>" + _loc_7.suitName + Config._itemMap[param1].name + "</font>");
                        }
                        else
                        {
                            _loc_6 = _loc_6 + ("\n<font color=\'" + _loc_10 + "\'>" + _loc_7.suitName + " - " + this.euipname[(_loc_4 + 1)] + "</font>");
                        }
                    }
                    else
                    {
                        _loc_6 = _loc_6 + ("\n<font color=\'" + _loc_10 + "\'>" + _loc_7.suitName + " - " + this.euipname[(_loc_4 + 1)] + "</font>");
                    }
                }
                _loc_5 = _loc_5 + 1;
            }
            return _loc_6;
        }// end function

        private function outfitpro() : String
        {
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_1:* = Config._replace1;
            var _loc_2:* = "";
            var _loc_3:* = Config._outfit[this.suitId];
            _loc_2 = _loc_2 + ("<font color=\'" + Style.FONT_Green + "\'>" + Config.language("Item", 74) + "</font>\n\n");
            _loc_4 = 1;
            while (_loc_4 < 10)
            {
                
                if (_loc_3["amount" + _loc_4] > 0)
                {
                    _loc_5 = Style.FONT_Gray;
                    _loc_2 = _loc_2 + Config.language("Item", 75, _loc_5, _loc_3["amount" + _loc_4]);
                    _loc_6 = String(_loc_3["effect" + _loc_4 + "_s"]);
                    _loc_7 = _loc_6.split(";");
                    _loc_8 = 0;
                    while (_loc_8 < _loc_7.length)
                    {
                        
                        _loc_9 = String(Config._itemPropMap[int(_loc_7[_loc_8].split(",")[0])].prop).replace(_loc_1, _loc_7[_loc_8].split(",")[1]);
                        if (_loc_8 > 0)
                        {
                            _loc_9 = "        " + _loc_9;
                        }
                        _loc_2 = _loc_2 + (_loc_9 + "\n");
                        _loc_8 = _loc_8 + 1;
                    }
                }
                _loc_4 = _loc_4 + 1;
            }
            _loc_4 = 1;
            while (_loc_4 < 11)
            {
                
                if (_loc_3["skillId" + _loc_4] > 0)
                {
                    _loc_2 = _loc_2 + ("\n<font color=\'" + Style.FONT_Green + "\'>套装技能</font>");
                    break;
                }
                _loc_4 = _loc_4 + 1;
            }
            _loc_4 = 1;
            while (_loc_4 < 11)
            {
                
                if (_loc_3["skillId" + _loc_4] > 0)
                {
                    _loc_2 = _loc_2 + ("\n" + _loc_4 + "件: " + Config._skillMap[_loc_3["skillId" + _loc_4]].description);
                }
                _loc_4 = _loc_4 + 1;
            }
            return _loc_2;
        }// end function

        private function sendsuit(event:MouseEvent)
        {
            if (this.slot1.item != null)
            {
                if (this.slot1.item._itemData.suitID != 0)
                {
                    this.pb.enabled = false;
                    AlertUI.alert(Config.language("Suitfit", 19), Config.language("Suitfit", 20), [Config.language("Suitfit", 21), Config.language("Suitfit", 22)], [this.suresendsuit, this.cansel]);
                }
                else
                {
                    this.suresendsuit();
                }
            }
            return;
        }// end function

        private function suresendsuit(param1 = null)
        {
            this.pb.enabled = true;
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_LOAD_SUIT_RUNE);
            _loc_2.add16(this.position);
            _loc_2.add16(this.slot1.item._position);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function cansel(param1)
        {
            this.pb.enabled = true;
            return;
        }// end function

        public function backsuss()
        {
            this.close();
            Config.message(Config.language("Suitfit", 23));
            return;
        }// end function

    }
}
