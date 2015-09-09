package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import lovefox.game.*;
    import lovefox.unit.*;

    public class QuickUI extends Sprite
    {
        private var _spMode:uint = 0;
        public var _mouseSlot:CloneSlot;
        private var _mouseTip:Label;
        public var _restSlot:ButtonSlot;
        private var _restTip:Label;
        public var _quickSlot:Array;
        public var _slotRow0:Array;
        public var _slotRow1:Array;
        public var _quickTip:Array;
        public var _quickSlotNumber:Object = 18;
        private var _holderBuff:Object;
        private var _slotList:SlotList;
        public var _goldhandSlot:CloneSlot;
        public var _picksoulSlot:CloneSlot;
        public var _pethandSlot:CloneSlot;
        public var _pethandLayer:Sprite;
        public var _picksoulLayer:Sprite;
        public var _soulUI:SoulUI;
        private var _tempContentBuff:Array;
        private var _rowBtn:PushButton;
        private var _lineBtn:PushButton;
        private var _rowLock:Boolean = false;
        private var _rowMode:Object = 0;
        private var _lineMode:Object = 0;
        private var _rowCount:Object = 0;
        public static var FARM:uint = 0;
        public static var WOLF:uint = 1;
        public static var _lock:Boolean = false;
        public static var _ready:Boolean = false;

        public function QuickUI()
        {
            this._quickSlot = [];
            this._slotRow0 = [];
            this._slotRow1 = [];
            this._quickTip = [];
            this.init();
            this.cacheAsBitmap = true;
            return;
        }// end function

        public function openWolf()
        {
            this._spMode = WOLF;
            this.openSp();
            this._quickSlot[0].content = Skill.getSkill(Number(Config.player.attackMode.id));
            this._mouseSlot.skill = this._quickSlot[0].content;
            this._quickSlot[1].content = 80121;
            this._quickSlot[2].content = 80118;
            this._quickSlot[3].content = 80206;
            this._quickSlot[4].content = 80207;
            this._quickSlot[5].content = 80208;
            this._quickSlot[6].content = 80209;
            this._quickSlot[7].content = 80210;
            this._quickSlot[8].content = 80200;
            this._quickSlot[10].content = 80201;
            this._quickSlot[11].content = 80202;
            this._quickSlot[12].content = 80203;
            this._quickSlot[13].content = 80204;
            this._quickSlot[14].content = 80205;
            this._lineMode = 0;
            this.changeLine(null, true);
            return;
        }// end function

        public function closeWolf()
        {
            this.closeSp();
            this._quickSlot[0].content = Skill.getSkill(Config.player.attackMode.id);
            this._quickSlot[9].content = Skill.getSkill(Config.player.attackMode.id);
            return;
        }// end function

        public function openFarm()
        {
            this._spMode = FARM;
            this.openSp();
            this._quickSlot[0].content = 80118;
            this._quickSlot[1].content = 80119;
            this._quickSlot[2].content = 80120;
            this._lineMode = 1;
            this.changeLine(null, true);
            return;
        }// end function

        public function closeFarm()
        {
            this.closeSp();
            return;
        }// end function

        private function openSp()
        {
            var _loc_1:* = undefined;
            _lock = true;
            this._tempContentBuff = [];
            _loc_1 = 0;
            while (_loc_1 < this._quickSlotNumber)
            {
                
                this._tempContentBuff[_loc_1] = this._quickSlot[_loc_1].content;
                this._quickSlot[_loc_1].content = null;
                _loc_1 = _loc_1 + 1;
            }
            return;
        }// end function

        private function closeSp()
        {
            var _loc_1:* = undefined;
            if (this._tempContentBuff != null)
            {
                _loc_1 = 0;
                while (_loc_1 < this._quickSlotNumber)
                {
                    
                    this._quickSlot[_loc_1].content = this._tempContentBuff[_loc_1];
                    _loc_1 = _loc_1 + 1;
                }
            }
            _lock = false;
            return;
        }// end function

        public function testPropSlot()
        {
            var _loc_1:* = undefined;
            _loc_1 = 0;
            while (_loc_1 < this._quickSlot.length)
            {
                
                if (this._quickSlot[_loc_1]._itemId != null)
                {
                    this._quickSlot[_loc_1].testItemId();
                }
                _loc_1 = _loc_1 + 1;
            }
            return;
        }// end function

        public function changeRow(param1 = null)
        {
            var _loc_2:* = undefined;
            if (!this._rowLock)
            {
                this._rowMode = 1 - this._rowMode;
                this._rowLock = true;
                this._rowCount = 0;
                Config.startLoop(this.changeRowLoop);
                if (this._rowMode == 0)
                {
                    _loc_2 = 0;
                    while (_loc_2 < this._slotRow0.length)
                    {
                        
                        addChild(this._slotRow0[_loc_2]);
                        _loc_2 = _loc_2 + 1;
                    }
                }
                else if (this._rowMode == 1)
                {
                    _loc_2 = 0;
                    while (_loc_2 < this._slotRow1.length)
                    {
                        
                        addChild(this._slotRow1[_loc_2]);
                        _loc_2 = _loc_2 + 1;
                    }
                }
            }
            return;
        }// end function

        public function changeLine(param1 = null, param2 = false)
        {
            var _loc_3:* = undefined;
            if (!_lock && !this._rowLock || param2)
            {
                this._lineMode = 1 - this._lineMode;
                this._rowLock = true;
                this._rowCount = 0;
                Config.startLoop(this.changeRowLoop);
                if (this._rowMode == 0)
                {
                    _loc_3 = 0;
                    while (_loc_3 < this._slotRow0.length)
                    {
                        
                        addChild(this._slotRow0[_loc_3]);
                        _loc_3 = _loc_3 + 1;
                    }
                }
                else if (this._rowMode == 1)
                {
                    _loc_3 = 0;
                    while (_loc_3 < this._slotRow1.length)
                    {
                        
                        addChild(this._slotRow1[_loc_3]);
                        _loc_3 = _loc_3 + 1;
                    }
                }
                if (this._lineMode == 0)
                {
                    this._lineBtn.setStyle(Config.findUI("quickui").button0);
                    TweenLite.to(this._pethandLayer, 0.3, {x:this._pethandLayer.x, y:-80});
                    this._goldhandSlot.visible = true;
                    this._picksoulSlot.visible = true;
                    this._soulUI.visible = true;
                    this._lineBtn.tip = Config.language("QuickUI", 1);
                }
                else
                {
                    this._lineBtn.setStyle(Config.findUI("quickui").button2);
                    TweenLite.to(this._pethandLayer, 0.3, {x:this._pethandLayer.x, y:-120});
                    this._goldhandSlot.visible = false;
                    this._picksoulSlot.visible = false;
                    this._soulUI.visible = false;
                    this._lineBtn.tip = Config.language("QuickUI", 2);
                }
            }
            return;
        }// end function

        private function changeRowLoop(param1)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            this._rowCount = this._rowCount + 2;
            if (this._rowMode == 0)
            {
                if (this._lineMode == 0)
                {
                    _loc_3 = -42;
                    _loc_4 = 2;
                }
                else
                {
                    _loc_3 = -42;
                    _loc_4 = -76;
                }
            }
            else if (this._lineMode == 0)
            {
                _loc_3 = 2;
                _loc_4 = -42;
            }
            else
            {
                _loc_3 = -76;
                _loc_4 = -42;
            }
            var _loc_5:* = true;
            var _loc_6:* = Number.MAX_VALUE;
            _loc_2 = 0;
            while (_loc_2 < this._slotRow0.length)
            {
                
                if (this._rowCount > _loc_2)
                {
                    if (Math.abs(this._slotRow0[_loc_2].y - _loc_3) > 1)
                    {
                        this._slotRow0[_loc_2].y = (_loc_3 - this._slotRow0[_loc_2].y) / 2 + this._slotRow0[_loc_2].y;
                        _loc_5 = false;
                    }
                    else
                    {
                        this._slotRow0[_loc_2].y = _loc_3;
                    }
                }
                else
                {
                    _loc_5 = false;
                }
                if (_loc_2 == 4)
                {
                    _loc_6 = Math.min(this._slotRow0[_loc_2].y - 11, _loc_6);
                }
                _loc_2 = _loc_2 + 1;
            }
            _loc_2 = 0;
            while (_loc_2 < this._slotRow1.length)
            {
                
                if (this._rowCount > _loc_2)
                {
                    if (Math.abs(this._slotRow1[_loc_2].y - _loc_4) > 1)
                    {
                        this._slotRow1[_loc_2].y = (_loc_4 - this._slotRow1[_loc_2].y) / 2 + this._slotRow1[_loc_2].y;
                        _loc_5 = false;
                    }
                    else
                    {
                        this._slotRow1[_loc_2].y = _loc_4;
                    }
                }
                else
                {
                    _loc_5 = false;
                }
                if (_loc_2 == 4)
                {
                    _loc_6 = Math.min(this._slotRow1[_loc_2].y - 11, _loc_6);
                }
                _loc_2 = _loc_2 + 1;
            }
            this._lineBtn.y = _loc_6;
            if (_loc_5)
            {
                this._rowLock = false;
                Config.stopLoop(this.changeRowLoop);
            }
            return;
        }// end function

        public function init()
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            mouseEnabled = false;
            var _loc_1:* = new Table("table6");
            _loc_1.y = -22;
            _loc_1.resize(406);
            addChild(_loc_1);
            this._mouseSlot = new CloneSlot(32);
            this._mouseSlot.x = 15;
            this._mouseSlot.y = -46;
            this._mouseSlot.bg = Config.findIconURL("s00000");
            addChild(this._mouseSlot);
            this._mouseSlot.addEventListener("sglClick", this.handleMouseSlotClick);
            this._mouseSlot.addEventListener("up", this.handleMouseSlotClick);
            this._mouseSlot.addEventListener("drag", this.handleMouseSlotDrag);
            this._mouseTip = new Label(this, 17, -16, Config.language("QuickUI", 3));
            this._mouseTip.textColor = Style.WHITE_FONT;
            this._mouseTip.tip = Config.language("QuickUI", 4);
            var _loc_5:* = 56;
            _loc_2 = 0;
            while (_loc_2 < this._quickSlotNumber)
            {
                
                if (_loc_2 % 9 == 0)
                {
                    _loc_5 = 56;
                }
                this._quickSlot[_loc_2] = new QuickSlot(_loc_2, 30, this._quickSlot);
                addChild(this._quickSlot[_loc_2]);
                this._quickSlot[_loc_2].x = _loc_5;
                if (_loc_2 < 9)
                {
                    this._slotRow0.push(this._quickSlot[_loc_2]);
                    this._quickSlot[_loc_2].y = -42;
                }
                else
                {
                    this._slotRow1.push(this._quickSlot[_loc_2]);
                    this._quickSlot[_loc_2].y = 2;
                }
                this._quickSlot[_loc_2].addEventListener("sglClick", this.handleSlotClick);
                this._quickSlot[_loc_2].addEventListener("drag", this.handleSlotDrag);
                this._quickSlot[_loc_2].addEventListener("up", this.handleSlotClick);
                this._quickSlot[_loc_2].addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
                this._quickSlot[_loc_2].addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
                if (_loc_2 < 9)
                {
                    this._quickTip[_loc_2] = Config.getSimpleTextField();
                    this._quickTip[_loc_2].text = String((_loc_2 + 1));
                    this._quickTip[_loc_2].x = _loc_5 + 10;
                    this._quickTip[_loc_2].y = -14;
                    this._quickTip[_loc_2].textColor = Style.WHITE_FONT;
                    addChild(this._quickTip[_loc_2]);
                }
                _loc_5 = _loc_5 + 34;
                _loc_2 = _loc_2 + 1;
            }
            this._restSlot = new ButtonSlot(30);
            this._restSlot.setIcon("s00025");
            addChild(this._restSlot);
            this._restSlot.x = _loc_5;
            this._restSlot.y = -42;
            this._restSlot.addEventListener("sglClick", this.handleRest);
            this._restTip = new Label(this, _loc_5 + 9, -14, "Z");
            this._restTip.textColor = Style.WHITE_FONT;
            this._restTip.tip = Config.language("QuickUI", 5);
            this._slotList = new SlotList(this, this._mouseSlot);
            this._slotList.addEventListener(Event.CHANGE, this.handleSlotListChange);
            this._slotList.x = 15;
            this._slotList.y = -90;
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_QUICKBAR_SEND, this.handleQuickSend);
            this._pethandSlot = new CloneSlot(0, 32);
            this._pethandSlot.addEventListener(MouseEvent.CLICK, this.handleEntertainClick);
            this._pethandSlot.addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
            this._pethandSlot.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
            this._goldhandSlot = new CloneSlot(0, 32);
            this._goldhandSlot.x = 81;
            this._goldhandSlot.y = -80;
            this._goldhandSlot.addEventListener(MouseEvent.CLICK, this.handleEntertainClick);
            this._picksoulSlot = new CloneSlot(0, 32);
            this._picksoulSlot.addEventListener(MouseEvent.CLICK, this.handleEntertainClick);
            this._goldhandSlot.addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
            this._goldhandSlot.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
            this._picksoulSlot.addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOverSoul);
            this._picksoulSlot.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
            this._picksoulLayer = new Sprite();
            this._picksoulLayer.addChild(this._picksoulSlot);
            this._picksoulLayer.x = 123;
            this._picksoulLayer.y = -80;
            this._pethandLayer = new Sprite();
            this._pethandLayer.x = 370;
            this._pethandLayer.y = -80;
            this._pethandSlot.x = 370;
            this._pethandSlot.y = -80;
            this._soulUI = new SoulUI(this, this._picksoulLayer.x - 2, this._picksoulLayer.y - 2);
            this._rowBtn = new PushButton(this, 394, -42, "", this.changeRow, Config.findUI("quickui").button1);
            this._rowBtn.width = 40;
            this._rowBtn.overshow = true;
            this._rowBtn.tip = Config.language("QuickUI", 6);
            this._lineBtn = new PushButton(this, 191, -53, "", this.changeLine, Config.findUI("quickui").button2);
            this._lineBtn.width = 40;
            this._lineBtn.overshow = true;
            this._lineBtn.tip = Config.language("QuickUI", 1);
            this._lineBtn.setStyle(Config.findUI("quickui").button0);
            return;
        }// end function

        public function openPetSlot() : void
        {
            addChild(this._pethandLayer);
            if (this._pethandSlot.parent == null)
            {
                addChild(this._pethandSlot);
            }
            return;
        }// end function

        public function closePetSlot() : void
        {
            if (this._pethandLayer.parent != null)
            {
                this.removeChild(this._pethandLayer);
            }
            if (this._pethandSlot.parent != null)
            {
                this.removeChild(this._pethandSlot);
            }
            return;
        }// end function

        public function openGoldhand()
        {
            addChild(this._goldhandSlot);
            return;
        }// end function

        public function openPicksoul()
        {
            addChild(this._picksoulLayer);
            if (this._soulUI.parent == this)
            {
                addChild(this._soulUI);
            }
            GuideUI.testDoId(29, this._picksoulSlot);
            return;
        }// end function

        public function showPickGuide() : void
        {
            if (this._picksoulSlot.stage != null)
            {
                GuideUI.doId(29, this._picksoulSlot);
            }
            else
            {
                Config.message(Config.language("QuickUI", 8));
            }
            return;
        }// end function

        public function showGoldGuide() : void
        {
            if (this._goldhandSlot.stage != null)
            {
                GuideUI.doId(29, this._goldhandSlot);
            }
            else
            {
                Config.message(Config.language("QuickUI", 9));
            }
            return;
        }// end function

        public function closeGoldhand()
        {
            if (this._goldhandSlot.parent != null)
            {
                this._goldhandSlot.parent.removeChild(this._goldhandSlot);
            }
            return;
        }// end function

        public function closePicksoul()
        {
            if (this._picksoulLayer.parent != null)
            {
                this._picksoulLayer.parent.removeChild(this._picksoulLayer);
            }
            return;
        }// end function

        private function handleEntertainClick(param1)
        {
            param1.currentTarget.skill.select();
            return;
        }// end function

        private function handleSlotListChange(param1)
        {
            this._mouseSlot.skill = this._slotList._selectedItem;
            this.mouseSlotSend();
            this._slotList.close();
            return;
        }// end function

        public function freshSlotList()
        {
            var _loc_1:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_2:* = [];
            var _loc_3:* = false;
            for (_loc_1 in Skill._skillMap)
            {
                
                _loc_3 = true;
                _loc_4 = Skill._skillMap[_loc_1];
                _loc_5 = Config.player;
                if (Skill._skillMap[_loc_1]._skillData.targetType == 2 && (Skill._skillMap[_loc_1].level > 0 || Config.player != null && Skill._skillMap[_loc_1]._data == Config.player.attackMode))
                {
                    _loc_2.push(Skill._skillMap[_loc_1]);
                }
            }
            if (_loc_3)
            {
                _loc_2.unshift(0);
                this._slotList.itemList = _loc_2;
            }
            return;
        }// end function

        private function handleMouseSlotClick(param1)
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (!_lock)
            {
                _loc_2 = param1.currentTarget;
                if (Holder.other is Skill)
                {
                    _loc_3 = Holder.other;
                    if (_loc_3._skillData.targetType == 2)
                    {
                        _loc_2.skill = _loc_3;
                        Holder.other = null;
                        if (Holder.data != null)
                        {
                            Holder.data.skill = _loc_3;
                            Holder.data = null;
                        }
                        this.mouseSlotSend();
                    }
                }
                else
                {
                    this._slotList.switchOpen();
                }
            }
            return;
        }// end function

        public function mouseSlotSend()
        {
            var _loc_1:* = undefined;
            if (!_lock)
            {
                _loc_1 = new DataSet();
                _loc_1.addHead(CONST_ENUM.C2G_QUICKBAR_ADD);
                _loc_1.add8(1);
                _loc_1.add8(10);
                if (this._mouseSlot.skill != null)
                {
                    _loc_1.add32(this._mouseSlot.skill._skillData.id);
                }
                else
                {
                    _loc_1.add32(0);
                }
                ClientSocket.send(_loc_1);
            }
            return;
        }// end function

        private function handleMouseSlotDrag(param1)
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            if (!_lock)
            {
                _loc_2 = param1.currentTarget;
                if (Holder.item == null)
                {
                    if (_loc_2.skill != null)
                    {
                        Holder.other = {obj:_loc_2.skill, bmpd:_loc_2.skill.getIcon()};
                        _loc_2.skill = null;
                        _loc_6 = new DataSet();
                        _loc_6.addHead(CONST_ENUM.C2G_QUICKBAR_REMOVE);
                        _loc_6.add8(10);
                        ClientSocket.send(_loc_6);
                    }
                }
            }
            return;
        }// end function

        private function handleRest(param1)
        {
            if (!Config.player.resting)
            {
                Config.player.startRest();
            }
            else
            {
                Config.player.stopRest();
            }
            return;
        }// end function

        private function mianbtnfuc(event:MouseEvent) : void
        {
            Config.player.startRest();
            return;
        }// end function

        private function switchOpenUI(param1, param2) : void
        {
            if (param2 != null)
            {
                param2.switchOpen();
            }
            return;
        }// end function

        private function handleSlotClick(param1)
        {
            var _loc_3:* = null;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_2:* = param1.currentTarget;
            if (Holder.other is Skill)
            {
                _loc_4 = _loc_2.content;
                _loc_2.content = Holder.other;
                if (!(_loc_2._id == 0 || _loc_2._id == 9))
                {
                    this.setSlotContentToHolder(_loc_4, _loc_2);
                }
                else
                {
                    Holder.other = null;
                    Holder.item = null;
                }
                _loc_5 = _loc_2.testSkillId();
                _loc_5.push(_loc_2);
                _loc_6 = 0;
                while (_loc_6 < _loc_5.length)
                {
                    
                    _loc_5[_loc_6].sendAdd();
                    _loc_6 = _loc_6 + 1;
                }
                if (GuideUI.testId(172))
                {
                    GuideUI.doId(172);
                }
            }
            else if (Holder.item != null && !(_loc_2._id == 0 || _loc_2._id == 9))
            {
                if (Holder.item._drawer == Config.ui._charUI._slotArray)
                {
                    _loc_4 = _loc_2.content;
                    _loc_2.content = Holder.item;
                    _loc_3 = Holder.item;
                    this.setSlotContentToHolder(_loc_4, _loc_2);
                    _loc_3._drawer[_loc_3._position].item = _loc_3;
                    if (_loc_3._itemData.id == 10111)
                    {
                        GuideUI.testDoId(202, _loc_2);
                    }
                }
            }
            else if (Holder.other != null && !(_loc_2._id == 0 || _loc_2._id == 9))
            {
                if (Holder.other.type == UNIT_TYPE_ENUM.TYPEID_ITEM)
                {
                    _loc_4 = _loc_2.content;
                    _loc_2.item = Holder.other.id;
                    this.setSlotContentToHolder(_loc_4, _loc_2);
                    if (_loc_2.item == 10111)
                    {
                        GuideUI.testDoId(202, _loc_2);
                    }
                }
            }
            else
            {
                _loc_2.handleMouseDown();
            }
            return;
        }// end function

        private function setSlotContentToHolder(param1, param2)
        {
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            if (param1 is Skill)
            {
                Holder.other = {obj:param1, bmpd:param1.getIcon()};
                Holder.data = param2;
            }
            else if (param1 is Number)
            {
                if (Config._itemMap[param1] != null)
                {
                    _loc_3 = Config._itemMap[param1];
                }
                _loc_4 = Config.findIcon(Item.getXmlIcon(_loc_3));
                Holder.other = {obj:{type:UNIT_TYPE_ENUM.TYPEID_ITEM, id:param1, slot:param2}, bmpd:_loc_4};
                Holder.data = param2;
            }
            else
            {
                Holder.other = null;
                Holder.item = null;
            }
            return;
        }// end function

        private function handleSlotDrag(param1)
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            if (!_lock)
            {
                _loc_2 = param1.currentTarget;
                if (Holder.item == null)
                {
                    if (!(_loc_2._id == 0 || _loc_2._id == 9))
                    {
                        if (_loc_2.skill != null)
                        {
                            Holder.other = {obj:_loc_2.skill, bmpd:_loc_2.skill.getIcon()};
                            Holder.data = _loc_2;
                            _loc_2.skill = null;
                        }
                        else if (_loc_2.item != null)
                        {
                            if (Config._itemMap[_loc_2.item] != null)
                            {
                                _loc_5 = Config._itemMap[_loc_2.item];
                            }
                            _loc_4 = Config.findIcon(Item.getXmlIcon(_loc_5));
                            Holder.other = {obj:{type:UNIT_TYPE_ENUM.TYPEID_ITEM, id:_loc_2.item, slot:_loc_2}, bmpd:_loc_4};
                            _loc_2.item = null;
                            Holder.data = _loc_2;
                        }
                    }
                    else if (_loc_2.skill != null)
                    {
                        Holder.other = {obj:_loc_2.skill, bmpd:_loc_2.skill.getIcon()};
                        Holder.data = _loc_2;
                        if (Config.player != null && _loc_2.skill._id != Number(Config.player.attackMode.id))
                        {
                            _loc_2.skill = Skill.getSkill(Number(Config.player.attackMode.id));
                        }
                    }
                }
            }
            else
            {
                Config.message(Config.language("QuickUI", 7));
            }
            return;
        }// end function

        private function handleSlotOut(param1)
        {
            Holder.closeInfo();
            return;
        }// end function

        private function handleSlotOverSoul(param1)
        {
            var _loc_2:* = param1.currentTarget;
            var _loc_3:* = "<font color=\'#FF9E3E\'><b>" + _loc_2.skill._skillData.name + "</b></font>";
            if (Skill.picksoulTimeStd == 3)
            {
                _loc_3 = _loc_3 + ("\n\n" + Config.language("Skill", 31));
            }
            else
            {
                _loc_3 = _loc_3 + ("\n\n" + Config.language("Skill", 32));
            }
            Holder.showInfo(_loc_3, new Rectangle(_loc_2.x + _loc_2.parent.x + _loc_2.parent.parent.x, _loc_2.y + _loc_2.parent.y + _loc_2.parent.parent.y, _loc_2._size, _loc_2._size), true, 0, 220);
            return;
        }// end function

        private function handleSlotOver(param1)
        {
            var _loc_2:* = param1.currentTarget;
            if (_loc_2.item != null)
            {
                if (Config._itemMap[_loc_2.item].description == null)
                {
                    Holder.showInfo(Config._itemMap[_loc_2.item].name + "", new Rectangle(_loc_2.x + _loc_2.parent.x + _loc_2.parent.parent.x, _loc_2.y + _loc_2.parent.y + _loc_2.parent.parent.y, _loc_2._size, _loc_2._size), true);
                }
                else
                {
                    Holder.showInfo(Config._itemMap[_loc_2.item].name + "\n<font color=\'#28d0e4\'>" + Config._itemMap[_loc_2.item].description + "</font>", new Rectangle(_loc_2.x + _loc_2.parent.x + _loc_2.parent.parent.x, _loc_2.y + _loc_2.parent.y + _loc_2.parent.parent.y, _loc_2._size, _loc_2._size), true);
                }
            }
            else if (_loc_2.skill != null)
            {
                Holder.showInfo(_loc_2.skill.outputInfoSimple(), new Rectangle(_loc_2.x + _loc_2.parent.x + _loc_2.parent.parent.x, _loc_2.y + _loc_2.parent.y + _loc_2.parent.parent.y, _loc_2._size, _loc_2._size), true, 0, 220);
            }
            return;
        }// end function

        private function handleQuickSend(param1)
        {
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            var _loc_2:* = param1.data;
            var _loc_3:* = _loc_2.readByte();
            _loc_4 = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = _loc_2.readByte();
                _loc_6 = _loc_2.readByte();
                _loc_7 = _loc_2.readUnsignedInt();
                if (_loc_5 < 10)
                {
                    if (_loc_6 == 0)
                    {
                        if (_loc_5 == 1)
                        {
                            this._quickSlot[(_loc_5 - 1)].skill = Skill.getSkill(Number(Config.player.attackMode.id));
                        }
                        else
                        {
                            this._quickSlot[(_loc_5 - 1)].content = null;
                        }
                    }
                    else if (_loc_6 == 2)
                    {
                        if (_loc_5 == 1)
                        {
                            this._quickSlot[(_loc_5 - 1)].skill = Skill.getSkill(Number(Config.player.attackMode.id));
                        }
                        else if (_loc_7 != 0)
                        {
                            this._quickSlot[(_loc_5 - 1)].setId(_loc_7);
                        }
                    }
                    else if (_loc_6 == 1)
                    {
                        if (_loc_7 != 0)
                        {
                            if (Skill._skillMap[_loc_7] != null)
                            {
                                if (_lock)
                                {
                                    this._tempContentBuff[(_loc_5 - 1)] = Skill._skillMap[_loc_7];
                                }
                                else
                                {
                                    this._quickSlot[(_loc_5 - 1)].skill = Skill._skillMap[_loc_7];
                                }
                            }
                            else
                            {
                                this._quickSlot[(_loc_5 - 1)]._buffSkillId = _loc_7;
                            }
                        }
                    }
                }
                else if (_loc_5 == 10)
                {
                    if (_loc_6 == 0)
                    {
                        this._mouseSlot.skill = null;
                    }
                    else if (_loc_6 == 1)
                    {
                        if (_loc_7 != 0)
                        {
                            if (Skill._skillMap[_loc_7] != null)
                            {
                                this._mouseSlot.skill = Skill._skillMap[_loc_7];
                            }
                            else
                            {
                                this._mouseSlot._buffSkillId = _loc_7;
                            }
                        }
                    }
                }
                else if (_loc_5 > 10)
                {
                    if (_loc_6 == 0)
                    {
                        if (_loc_5 == 11)
                        {
                            this._quickSlot[_loc_5 - 2].skill = Skill.getSkill(Number(Config.player.attackMode.id));
                        }
                        else
                        {
                            this._quickSlot[_loc_5 - 2].content = null;
                        }
                    }
                    else if (_loc_6 == 2)
                    {
                        if (_loc_5 == 11)
                        {
                            this._quickSlot[_loc_5 - 2].skill = Skill.getSkill(Number(Config.player.attackMode.id));
                        }
                        else if (_loc_7 != 0)
                        {
                            this._quickSlot[_loc_5 - 2].setId(_loc_7);
                        }
                    }
                    else if (_loc_6 == 1)
                    {
                        if (_loc_7 != 0)
                        {
                            if (Skill._skillMap[_loc_7] != null)
                            {
                                if (_lock)
                                {
                                    this._tempContentBuff[_loc_5 - 2] = Skill._skillMap[_loc_7];
                                }
                                else
                                {
                                    this._quickSlot[_loc_5 - 2].skill = Skill._skillMap[_loc_7];
                                }
                            }
                            else
                            {
                                this._quickSlot[_loc_5 - 2]._buffSkillId = _loc_7;
                            }
                        }
                    }
                }
                _loc_4 = _loc_4 + 1;
            }
            _ready = true;
            return;
        }// end function

        public function checkQuick(param1)
        {
            var _loc_2:* = undefined;
            _loc_2 = 0;
            while (_loc_2 < this._quickSlotNumber)
            {
                
                if (this._quickSlot[_loc_2]._buffSkillId == param1._skillData.id)
                {
                    if (_lock)
                    {
                        this._tempContentBuff[_loc_2] = param1;
                    }
                    else
                    {
                        this._quickSlot[_loc_2].skill = param1;
                    }
                    this._quickSlot[_loc_2]._buffSkillId = null;
                }
                _loc_2 = _loc_2 + 1;
            }
            if (this._mouseSlot._buffSkillId == param1._skillData.id)
            {
                this._mouseSlot.skill = param1;
                this._mouseSlot._buffSkillId = null;
            }
            return;
        }// end function

        public function handleItemCd(param1, param2)
        {
            var _loc_3:* = undefined;
            _loc_3 = 0;
            while (_loc_3 < this._quickSlotNumber)
            {
                
                if (this._quickSlot[_loc_3]._relatedId == param1)
                {
                    this._quickSlot[_loc_3].setCd(param2, Item._cdMaxStack[param1]);
                }
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

        public function handleSkillCd(param1, param2)
        {
            var _loc_3:* = undefined;
            _loc_3 = 0;
            while (_loc_3 < this._quickSlotNumber)
            {
                
                if (this._quickSlot[_loc_3].skill != null)
                {
                    if (this._quickSlot[_loc_3].skill._skillData.id == param1)
                    {
                        this._quickSlot[_loc_3].setCd(param2, Skill._cdMaxStack[param1]);
                    }
                }
                _loc_3 = _loc_3 + 1;
            }
            if (this._goldhandSlot.skill != null)
            {
                if (this._goldhandSlot.skill._skillData.id == param1)
                {
                    this._goldhandSlot.setCd(param2, Skill._cdMaxStack[param1]);
                }
            }
            if (this._picksoulSlot.skill != null)
            {
                if (this._picksoulSlot.skill._skillData.id == param1)
                {
                    this._picksoulSlot.setCd(param2, Skill._cdMaxStack[param1]);
                }
            }
            if (this._mouseSlot.skill != null)
            {
                if (this._mouseSlot.skill._skillData.id == param1)
                {
                    this._mouseSlot.setCd(param2, Skill._cdMaxStack[param1]);
                }
            }
            if (this._pethandSlot.skill != null)
            {
                if (this._pethandSlot.skill._skillData.id == param1)
                {
                    this._pethandSlot.setCd(param2, Skill._cdMaxStack[param1]);
                }
            }
            Config.ui._petPanel.setSkillCd(param1, param2);
            return;
        }// end function

        public function findBlankSlot(param1, param2 = 0)
        {
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            if (this._rowMode == 0)
            {
                _loc_5 = 1;
                _loc_6 = 9;
            }
            else
            {
                _loc_5 = 10;
                _loc_6 = 18;
            }
            if (param2 == 0)
            {
                _loc_4 = [];
                _loc_3 = _loc_5;
                while (_loc_3 < _loc_6)
                {
                    
                    if (this._quickSlot[_loc_3].content == null)
                    {
                        _loc_4.push(this._quickSlot[_loc_3]);
                        if (_loc_4.length >= param1)
                        {
                            return _loc_4;
                        }
                    }
                    else if (_loc_4.length > 0)
                    {
                        _loc_4 = [];
                    }
                    _loc_3 = _loc_3 + 1;
                }
                if (_loc_4.length == 0)
                {
                    _loc_3 = _loc_6 - param1;
                    while (_loc_3 < _loc_6)
                    {
                        
                        _loc_4.push(this._quickSlot[_loc_3]);
                        _loc_3 = _loc_3 + 1;
                    }
                    return _loc_4;
                }
            }
            else if (param2 == 1)
            {
                _loc_4 = [];
                _loc_3 = _loc_6 - 1;
                while (_loc_3 >= _loc_5)
                {
                    
                    if (this._quickSlot[_loc_3].content == null)
                    {
                        _loc_4.push(this._quickSlot[_loc_3]);
                        if (_loc_4.length >= param1)
                        {
                            return _loc_4;
                        }
                    }
                    else if (_loc_4.length > 0)
                    {
                        _loc_4 = [];
                    }
                    _loc_3 = _loc_3 - 1;
                }
                if (_loc_4.length == 0)
                {
                    _loc_3 = _loc_6 - param1;
                    while (_loc_3 < _loc_6)
                    {
                        
                        _loc_4.push(this._quickSlot[_loc_3]);
                        _loc_3 = _loc_3 + 1;
                    }
                    return _loc_4;
                }
            }
            return;
        }// end function

        public function handleKey(param1)
        {
            if (this._rowMode == 0)
            {
                this._quickSlot[param1].handleMouseDown();
            }
            else
            {
                this._quickSlot[param1 + 9].handleMouseDown();
            }
            return;
        }// end function

        public function setAttackMode(param1, param2)
        {
            if (param1 == null)
            {
                if (this._mouseSlot.skill != null && (param2 == null || this._mouseSlot.skill._id == Number(param2.id)))
                {
                    if (!(_lock && this._spMode == FARM))
                    {
                        this._mouseSlot.skill = null;
                    }
                }
                if (!(_lock && this._spMode == FARM))
                {
                    if (param2 == null || this._quickSlot[0].skill == null || this._quickSlot[0].skill._id == Number(param2.id))
                    {
                        this._quickSlot[0].skill = null;
                    }
                    if (param2 == null || this._quickSlot[9].skill == null || this._quickSlot[9].skill._id == Number(param2.id))
                    {
                        this._quickSlot[9].skill = null;
                    }
                }
            }
            else
            {
                if (this._mouseSlot.skill != null && (param2 == null || this._mouseSlot.skill._id == Number(param2.id)))
                {
                    if (!(_lock && this._spMode == FARM))
                    {
                        this._mouseSlot.skill = Skill.getSkill(Number(param1.id));
                    }
                }
                if (!(_lock && this._spMode == FARM))
                {
                    if (param2 == null || this._quickSlot[0].skill == null || this._quickSlot[0].skill._id == Number(param2.id))
                    {
                        this._quickSlot[0].skill = Skill.getSkill(Number(param1.id));
                    }
                    if (param2 == null || this._quickSlot[9].skill == null || this._quickSlot[9].skill._id == Number(param2.id))
                    {
                        this._quickSlot[9].skill = Skill.getSkill(Number(param1.id));
                    }
                }
                this.checkQuick(Skill.getSkill(Number(param1.id)));
            }
            return;
        }// end function

        public function removeQuickSkill(param1)
        {
            var _loc_2:* = undefined;
            if (this._mouseSlot.skill != null && this._mouseSlot.skill._id == param1)
            {
                this._mouseSlot.skill = null;
            }
            _loc_2 = 0;
            while (_loc_2 < this._quickSlot.length)
            {
                
                if (this._quickSlot[_loc_2].skill != null && this._quickSlot[_loc_2].skill._id == param1)
                {
                    if ((_loc_2 == 0 || _loc_2 == 10) && (Config.player != null && Config.player.attackMode != null))
                    {
                        this._quickSlot[0].skill = Skill.getSkill(Number(Config.player.attackMode.id));
                    }
                    else
                    {
                        this._quickSlot[_loc_2].skill = null;
                    }
                    this._quickSlot[_loc_2].sendAdd();
                    return;
                }
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

    }
}
