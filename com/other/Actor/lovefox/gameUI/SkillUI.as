package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;
    import lovefox.component.*;
    import lovefox.game.*;
    import lovefox.socket.*;

    public class SkillUI extends Window
    {
        private var _jobSkillMap:Object;
        private var _learnedSkillMap:Object;
        private var _itemSkillMap:Object;
        private var _btnDict:Dictionary;
        private var _skillListArray:Array;
        private var _giftSkillListArray:Array;
        private var _infoTF:TextField;
        private var _selectedSlot:SkillUiSlot;
        private var _skillPanel:Panel;
        private var _skillMask:Shape;
        private var _skillContainer:Sprite;
        private var _skillLeftBtn:PushButton;
        private var _skillRightBtn:PushButton;
        private var _skillPage:uint = 0;
        private var _skillPageMax:uint = 0;
        private var _skillSlotMap:Object;
        private var _updateBtn1:Object;
        private var _updateMouseX:Object;
        private var _updateBtnPre:Object;
        private var _updateBtnPreX:Object;
        private var _needPoint:Object;
        private var _updateAlertId:Object;
        private var menubar:ButtonBar;
        private var mainpanel:Sprite;
        private var giftpanel:Sprite;
        private var giftcanvas:CanvasUI;
        private var giftlistarr:Array;
        private var templistarr:Array;
        private var giftspobj:Object;
        private var giftpoint:int = 0;
        private var giftpoint1:int = 0;
        private var giftpoint2:int = 0;
        private var giftpoint3:int = 0;
        private var gexplevel:int;
        private var _firstGiftSlot:GiftSkill;
        private var initpanelflag:Boolean = false;
        private var _levelupAlertID:int = -1;
        public static var _ready:Object = false;

        public function SkillUI(param1)
        {
            this._jobSkillMap = [];
            this._learnedSkillMap = [];
            this._itemSkillMap = [];
            this._skillListArray = [];
            this._giftSkillListArray = [];
            this._skillSlotMap = {};
            super(param1);
            title = Config.language("SkillUI", 1);
            resize(660, 350);
            this.initDraw();
            return;
        }// end function

        public function initDraw()
        {
            var _loc_1:* = undefined;
            this._updateBtn1 = new PushButton(null, 0, 0, "", null, Config.findUI("skillui").button1);
            this.mainpanel = new Sprite();
            this.addChild(this.mainpanel);
            _loc_1 = 0;
            while (_loc_1 < 3)
            {
                
                this._skillListArray[_loc_1] = new List(null, 4 + 217 * _loc_1, 46);
                this._skillListArray[_loc_1].roundCorner = 0;
                if (_loc_1 < 2)
                {
                    this._skillListArray[_loc_1].width = 216;
                }
                else
                {
                    this._skillListArray[_loc_1].width = 218;
                }
                this._skillListArray[_loc_1].height = 300;
                this._skillListArray[_loc_1].rowHeight = 50;
                this._skillListArray[_loc_1].selectable = false;
                this._skillListArray[_loc_1].color = 14995623;
                _loc_1 = _loc_1 + 1;
            }
            _loc_1 = 0;
            while (_loc_1 < 3)
            {
                
                this._giftSkillListArray[_loc_1] = new List(null, 4 + 217 * _loc_1, 46);
                this._giftSkillListArray[_loc_1].roundCorner = 0;
                if (_loc_1 < 2)
                {
                    this._giftSkillListArray[_loc_1].width = 216;
                }
                else
                {
                    this._giftSkillListArray[_loc_1].width = 218;
                }
                this._giftSkillListArray[_loc_1].height = 300;
                this._giftSkillListArray[_loc_1].rowHeight = 50;
                this._giftSkillListArray[_loc_1].selectable = false;
                this._giftSkillListArray[_loc_1].color = 14995623;
                _loc_1 = _loc_1 + 1;
            }
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_SKILL_LIST_QUERY, this.handleSkillItem);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_SKILL_UPDATE, this.handleSkillUpdate);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.SMSG_ENTERTAIN_CD, this.handleEntertainCd);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.SMSG_GOLDHANDS, this.handleGoldHands);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.SMSG_PICKSOUL_OPEN, this.handlePicksoul);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_SKILL_PRACTICE, this.handleSkillPractice);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_SKILL_BUYEXP, this.handleSkillBuy);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_SKILL_INNATE_COUNT, this.giftPointFuc);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_SKILL_INNATE_UPGRADE, this.giftUpdate);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_INNATE_LIST, this.giftList);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_SKILL_INNATE_CLEAR, this.washPoint);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_SKILL_INNATE_EXP, this.backgiftexp);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_SKILL_INNATE_ADD, this.backaddgiftexp);
            this.addEventListener(MouseEvent.CLICK, this.handleClick);
            this.menubar = new ButtonBar(this, 15, 25);
            this.menubar.addTab(Config.language("SkillUI", 1), Config.create(this.changepage, 0));
            this.giftpanel = new Sprite();
            this.giftlistarr = new Array();
            this.templistarr = new Array();
            this.giftcanvas = new CanvasUI(this.giftpanel, 0, 72, 595 + 60, 225);
            this.giftcanvas.addChildUI(this.giftbg());
            this.initgiftpanel();
            this.changepage();
            return;
        }// end function

        public function addGiftShow() : void
        {
            this.menubar.addTab(Config.language("SkillUI", 2), Config.create(this.changepage, 1));
            this.menubar.addTab(Config.language("SkillUI", 2) + Config.language("SkillUI", 1), Config.create(this.changepage, 2));
            return;
        }// end function

        public function selectGiftPage() : void
        {
            this.open();
            this.changepage(null, 1);
            return;
        }// end function

        private function changepage(event:MouseEvent = null, param2:int = 0) : void
        {
            var _loc_3:* = 0;
            this.removeallchild(this.mainpanel);
            if (param2 == 0)
            {
                _loc_3 = 0;
                while (_loc_3 < this._skillListArray.length)
                {
                    
                    this.mainpanel.addChild(this._skillListArray[_loc_3]);
                    _loc_3++;
                }
            }
            else if (param2 == 1)
            {
                this.mainpanel.addChild(this.giftpanel);
                GuideUI.testDoId(96, this.giftspobj.pointlabel);
                GuideUI.testDoId(119, this.giftspobj.pointlabel);
            }
            else if (param2 == 2)
            {
                _loc_3 = 0;
                while (_loc_3 < this._giftSkillListArray.length)
                {
                    
                    this.mainpanel.addChild(this._giftSkillListArray[_loc_3]);
                    _loc_3++;
                }
            }
            return;
        }// end function

        private function giftbg() : Sprite
        {
            var _loc_1:* = new Sprite();
            _loc_1.graphics.beginFill(10245421, 0.1);
            _loc_1.graphics.drawRoundRect(5, 0, 190 + 20, 500, 3);
            _loc_1.graphics.drawRoundRect(200 + 20, 0, 190 + 20, 500, 3);
            _loc_1.graphics.drawRoundRect(395 + 40, 0, 190 + 20, 500, 3);
            _loc_1.graphics.endFill();
            return _loc_1;
        }// end function

        private function handleClick(param1)
        {
            if (Holder.other != null && Holder.other is Skill)
            {
                Holder.other = null;
            }
            return;
        }// end function

        override public function testGuide()
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = null;
            var _loc_1:* = false;
            if (GuideUI.testId(17))
            {
                for (_loc_2 in this._skillSlotMap)
                {
                    
                    if (this._skillSlotMap[_loc_2].slot.skill.level > 0)
                    {
                        GuideUI.doId(17, this._skillSlotMap[_loc_2].slot);
                        _loc_1 = true;
                        break;
                    }
                }
                if (!_loc_1)
                {
                    setTimeout(this.guide17, 1000);
                }
            }
            else if (GuideUI.testId(39))
            {
                _loc_3 = "";
                _loc_6 = [];
                for (_loc_2 in this._skillSlotMap)
                {
                    
                    _loc_4 = this._skillSlotMap[_loc_2].slot.skill;
                    if (_loc_4.level > 0)
                    {
                        if (int(_loc_4.level) < 4)
                        {
                            _loc_5 = Config._skillMap[Number(_loc_4._skillData.baseId + "" + _loc_4.level)];
                        }
                        else
                        {
                            _loc_5 = Config._skillMap[int(_loc_4._skillData.baseId) * 100 + int(_loc_4.level) + 1 + 100000];
                        }
                        if (_loc_5 != null)
                        {
                            if (_loc_5.reqLevel <= Config.player.level)
                            {
                                GuideUI.doId(39, this._skillSlotMap[_loc_2].updateBtn);
                                break;
                            }
                        }
                    }
                }
            }
            else if (GuideUI.testId(95))
            {
                if (this.menubar.tabarr[1] != null)
                {
                    GuideUI.doId(95, this.menubar.tabarr[1]);
                }
                else
                {
                    setTimeout(this.guide95, 1000);
                }
            }
            else if (GuideUI.testId(170))
            {
                for (_loc_2 in this._skillSlotMap)
                {
                    
                    if (this._skillSlotMap[_loc_2].slot.skill.level > 0)
                    {
                        if (this._skillSlotMap[_loc_2].slot.skill._skillData.reqLevel == 10)
                        {
                            GuideUI.doId(170, this._skillSlotMap[_loc_2].slot);
                            _loc_1 = true;
                            break;
                        }
                    }
                }
                if (!_loc_1)
                {
                    setTimeout(this.guide170, 1000);
                }
            }
            else if (Config.player != null && Config.player.level >= 15 && GuideUI.testId(175))
            {
                for (_loc_2 in this._skillSlotMap)
                {
                    
                    if (this._skillSlotMap[_loc_2].slot.skill.level > 0)
                    {
                        if (this._skillSlotMap[_loc_2].slot.skill._skillData.reqLevel == 15)
                        {
                            GuideUI.doId(175, this._skillSlotMap[_loc_2].slot);
                            _loc_1 = true;
                            break;
                        }
                    }
                }
                if (!_loc_1)
                {
                    setTimeout(this.guide175, 1000);
                }
            }
            else if (GuideUI.testId(99))
            {
                if (this.menubar.tabarr[1] != null)
                {
                    GuideUI.doId(99, this.menubar.tabarr[1]);
                }
                else
                {
                    setTimeout(this.guide99, 1000);
                }
            }
            return;
        }// end function

        private function guide175()
        {
            var _loc_1:* = undefined;
            for (_loc_1 in this._skillSlotMap)
            {
                
                if (this._skillSlotMap[_loc_1].slot.skill.level > 0)
                {
                    if (this._skillSlotMap[_loc_1].slot.skill._skillData.reqLevel == 15)
                    {
                        GuideUI.doId(175, this._skillSlotMap[_loc_1].slot);
                        break;
                    }
                }
            }
            return;
        }// end function

        private function guide170()
        {
            var _loc_1:* = undefined;
            for (_loc_1 in this._skillSlotMap)
            {
                
                if (this._skillSlotMap[_loc_1].slot.skill.level > 0)
                {
                    if (this._skillSlotMap[_loc_1].slot.skill._skillData.reqLevel == 10)
                    {
                        GuideUI.doId(170, this._skillSlotMap[_loc_1].slot);
                        break;
                    }
                }
            }
            return;
        }// end function

        private function guide17()
        {
            var _loc_1:* = undefined;
            for (_loc_1 in this._skillSlotMap)
            {
                
                if (this._skillSlotMap[_loc_1].slot.skill.level > 0)
                {
                    GuideUI.doId(17, this._skillSlotMap[_loc_1].slot);
                    break;
                }
            }
            return;
        }// end function

        private function guide95()
        {
            GuideUI.doId(95, this.menubar.tabarr[1]);
            return;
        }// end function

        private function guide99()
        {
            GuideUI.doId(99, this.menubar.tabarr[1]);
            return;
        }// end function

        private function handleGoldHands(param1)
        {
            Skill.selectedSkill = null;
            var _loc_2:* = param1.data;
            var _loc_3:* = _loc_2.readByte();
            if (_loc_3 == 0)
            {
                var _loc_4:* = Skill;
                var _loc_5:* = Skill.goldhandTime + 1;
                _loc_4.goldhandTime = _loc_5;
                Skill._skillMap[Number(Skill._goldhandSkill.id)].cd = Math.max(Skill._skillMap[Number(Skill._goldhandSkill.id)].cd, 5 * 60000);
            }
            else if (_loc_3 == 1)
            {
                Config.message(Config.language("SkillUI", 3));
            }
            else if (_loc_3 == 2)
            {
                Config.message(Config.language("SkillUI", 4));
            }
            else if (_loc_3 == 3)
            {
                Config.message(Config.language("SkillUI", 5));
            }
            else if (_loc_3 == 4)
            {
                Config.message(Config.language("SkillUI", 6));
            }
            else if (_loc_3 == 5)
            {
                Config.message(Config.language("SkillUI", 7));
            }
            else if (_loc_3 == 6)
            {
                Config.message(Config.language("SkillUI", 8));
            }
            else if (_loc_3 == 7)
            {
                Config.message(Config.language("SkillUI", 9));
            }
            return;
        }// end function

        private function handlePicksoul(param1)
        {
            var _loc_2:* = param1.data;
            var _loc_3:* = _loc_2.readByte();
            if (_loc_3 == 0)
            {
                GuideUI.testDoId(125);
                var _loc_4:* = Skill;
                var _loc_5:* = Skill.picksoulTime + 1;
                _loc_4.picksoulTime = _loc_5;
                Skill._skillMap[Number(Skill._picksoulSkill.id)].cd = Math.max(Skill._skillMap[Number(Skill._picksoulSkill.id)].cd, 5 * 60000);
            }
            return;
        }// end function

        private function handleEntertainCd(param1)
        {
            var _loc_2:* = param1.data;
            var _loc_3:* = _loc_2.readUnsignedInt() * 1000;
            var _loc_4:* = _loc_2.readUnsignedInt() * 1000;
            var _loc_5:* = _loc_2.readUnsignedInt() * 1000;
            if (Skill._skillMap[Number(Skill._goldhandSkill.id)] != null)
            {
                if (_loc_3 > 0)
                {
                    Skill._skillMap[Number(Skill._goldhandSkill.id)].cdMax = 5 * 60000;
                }
                Skill._skillMap[Number(Skill._goldhandSkill.id)].cd = _loc_3;
                if (_loc_5 > 0)
                {
                    Skill._skillMap[Number(Skill._picksoulSkill.id)].cdMax = 5 * 60000;
                }
                Skill._skillMap[Number(Skill._picksoulSkill.id)].cd = _loc_5;
            }
            else
            {
                Skill._entertainCdStack = [_loc_3, _loc_4, _loc_5];
            }
            return;
        }// end function

        private function handleListChange(param1)
        {
            return;
        }// end function

        private function handleLearnSkill(param1)
        {
            var _loc_2:* = param1.currentTarget.data;
            var _loc_3:* = Number(_loc_2._skillData.baseId) * 10 + _loc_2.level;
            var _loc_4:* = new DataSet();
            new DataSet().addHead(CONST_ENUM.C2G_SKILL_UPDATE);
            _loc_4.add32(_loc_3);
            ClientSocket.send(_loc_4);
            return;
        }// end function

        public function testAllSkill()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = undefined;
            var _loc_3:* = null;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = null;
            var _loc_7:* = undefined;
            var _loc_8:* = undefined;
            var _loc_9:* = undefined;
            var _loc_10:* = undefined;
            var _loc_11:* = undefined;
            var _loc_12:* = undefined;
            var _loc_13:* = null;
            var _loc_14:* = undefined;
            var _loc_15:* = null;
            var _loc_16:* = null;
            var _loc_17:* = null;
            var _loc_18:* = null;
            for (_loc_1 in Config._itemMap)
            {
                
                if (Number(Config._itemMap[_loc_1].type) == 12)
                {
                    if (Config._skillMap[Number(Config._itemMap[_loc_1].skillId)].reqJob == Config.player.job)
                    {
                        Skill._skillBookMap[Number(Config._itemMap[_loc_1].skillId)] = _loc_1;
                    }
                }
                if (Number(Config._itemMap[_loc_1].type) == 24)
                {
                    if (Config._skillMap[Number(Config._itemMap[_loc_1].skillId)].reqJob == Config.player.job)
                    {
                        Skill._skillBookMap[Number(Config._itemMap[_loc_1].skillId)] = _loc_1;
                    }
                    if (Config._skillMap[Number(Config._itemMap[_loc_1].skillId + 1000)].reqJob == Config.player.job)
                    {
                        Skill._skillBookMap[Number(Config._itemMap[_loc_1].skillId + 1000)] = _loc_1;
                    }
                    if (Config._skillMap[Number(Config._itemMap[_loc_1].skillId + 2000)].reqJob == Config.player.job)
                    {
                        Skill._skillBookMap[Number(Config._itemMap[_loc_1].skillId + 2000)] = _loc_1;
                    }
                }
            }
            if (!_ready)
            {
                _loc_5 = [];
                _loc_4 = Skill._goldhandSkill;
                _loc_3 = new Skill(_loc_4);
                Config.ui._quickUI._goldhandSlot.skill = _loc_3;
                _loc_4 = Skill._picksoulSkill;
                _loc_3 = new Skill(_loc_4);
                Config.ui._quickUI._picksoulSlot.skill = _loc_3;
                _loc_4 = Skill._petPickSkill;
                _loc_3 = new Skill(_loc_4);
                if (Skill._entertainCdStack.length > 0)
                {
                    Skill._skillMap[Number(Skill._goldhandSkill.id)].cdMax = 5 * 60000;
                    Skill._skillMap[Number(Skill._picksoulSkill.id)].cdMax = 5 * 60000;
                    Skill._skillMap[Number(Skill._goldhandSkill.id)].cd = Skill._entertainCdStack[0];
                    Skill._skillMap[Number(Skill._picksoulSkill.id)].cd = Skill._entertainCdStack[2];
                }
                for (_loc_1 in Config._skillMap)
                {
                    
                    if (Config._skillMap[_loc_1].reqJob == Config.player.job)
                    {
                        if (this._itemSkillMap[Config._skillMap[_loc_1].baseId] == null)
                        {
                            _loc_4 = Config._skillMap[_loc_1];
                            _loc_3 = new Skill(Config._skillMap[_loc_1]);
                            this._jobSkillMap[_loc_4.baseId] = _loc_3;
                            if (this._learnedSkillMap[_loc_4.baseId] != null)
                            {
                                _loc_3.level = this._learnedSkillMap[_loc_4.baseId].level;
                                _loc_3.exp = this._learnedSkillMap[_loc_4.baseId].exp;
                                _loc_3.cd = this._learnedSkillMap[_loc_4.baseId].cd;
                                Config.ui._quickUI.checkQuick(_loc_3);
                            }
                            else
                            {
                                _loc_3.level = 0;
                                _loc_3.exp = 0;
                                _loc_3.cd = 0;
                            }
                            this._itemSkillMap[_loc_4.baseId] = {giftFlag:Number(_loc_4.giftFlag), skill:_loc_3, skillType:Number(_loc_4.skillType), level:Number(Config._skillMap[Number(_loc_4.baseId + "0")].reqLevel)};
                            _loc_5.push(this._itemSkillMap[_loc_4.baseId]);
                        }
                    }
                }
                _loc_5.sortOn(["giftFlag", "level", "skillType"], [Array.NUMERIC, Array.NUMERIC, Array.NUMERIC]);
                _loc_7 = [];
                _loc_8 = [];
                _loc_9 = [];
                _loc_10 = [];
                _loc_11 = [];
                _loc_12 = [];
                _loc_1 = 0;
                while (_loc_1 < _loc_5.length)
                {
                    
                    if (_loc_5[_loc_1].giftFlag == 0)
                    {
                        if (_loc_7.length < 6)
                        {
                            _loc_7.push(_loc_5[_loc_1]);
                        }
                        else if (_loc_8.length < 6)
                        {
                            _loc_8.push(_loc_5[_loc_1]);
                        }
                        else
                        {
                            _loc_9.push(_loc_5[_loc_1]);
                        }
                    }
                    else if (_loc_10.length < 6)
                    {
                        _loc_10.push(_loc_5[_loc_1]);
                    }
                    else if (_loc_11.length < 6)
                    {
                        _loc_11.push(_loc_5[_loc_1]);
                    }
                    else
                    {
                        _loc_12.push(_loc_5[_loc_1]);
                    }
                    _loc_1 = _loc_1 + 1;
                }
                _loc_7.length = 6;
                _loc_8.length = 6;
                _loc_9.length = 6;
                _loc_10.length = 6;
                _loc_11.length = 6;
                _loc_12.length = 6;
                _loc_2 = 0;
                while (_loc_2 < 6)
                {
                    
                    if (_loc_2 < 3)
                    {
                        if (_loc_2 == 0)
                        {
                            _loc_5 = _loc_7;
                        }
                        else if (_loc_2 == 1)
                        {
                            _loc_5 = _loc_8;
                        }
                        else if (_loc_2 == 2)
                        {
                            _loc_5 = _loc_9;
                        }
                        _loc_13 = this._skillListArray[_loc_2];
                    }
                    else
                    {
                        if (_loc_2 == 3)
                        {
                            _loc_5 = _loc_10;
                        }
                        else if (_loc_2 == 4)
                        {
                            _loc_5 = _loc_11;
                        }
                        else if (_loc_2 == 5)
                        {
                            _loc_5 = _loc_12;
                        }
                        _loc_13 = this._giftSkillListArray[_loc_2 - 3];
                    }
                    _loc_14 = _loc_13.setItems(_loc_5);
                    _loc_1 = 0;
                    while (_loc_1 < _loc_5.length)
                    {
                        
                        if (_loc_5[_loc_1] == null)
                        {
                            break;
                        }
                        _loc_6 = new SkillUiSlot(_loc_1, 32);
                        _loc_6.addEventListener("sglClick", this.handleSlotClick);
                        _loc_6.addEventListener("drag", this.handleSlotDrag);
                        _loc_6.addEventListener("dblClick", this.handleSlotDoubleClick);
                        _loc_6.addEventListener("up", this.handleSlotUp);
                        _loc_6.addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
                        _loc_6.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
                        _loc_6.x = 10;
                        _loc_6.y = 8;
                        _loc_5[_loc_1].slot = _loc_6;
                        _loc_6.skill = _loc_5[_loc_1].skill;
                        _loc_14[_loc_1].addChild(_loc_6);
                        _loc_6.level = _loc_6.skill.level;
                        if (_loc_6.skill._skillData.giftFlag == 0)
                        {
                            if (_loc_2 == 0 && _loc_1 == 0)
                            {
                                _loc_15 = this._updateBtn1;
                                _loc_15.x = 55;
                                _loc_15.y = 28;
                            }
                            else
                            {
                                _loc_15 = new PushButton(null, 55, 28, "", null, Config.findUI("skillui").button1);
                            }
                            _loc_15.overshow = true;
                            _loc_15.data = _loc_6.skill;
                            _loc_16 = new PushButton(null, 55 + 135 - 7, 28 - 10, "", null, Config.findUI("chatui").button1);
                            _loc_16.overshow = true;
                            _loc_16.data = _loc_6.skill;
                            _loc_16.visible = false;
                            _loc_18 = new ProgressBar(null, 55, 30);
                            _loc_18.gradientFillDirection = Math.PI;
                            _loc_18.roundCorner = 6;
                            _loc_18.width = 140;
                            _loc_18.color = 13369344;
                            _loc_18.subColor = 6684672;
                            _loc_18.maximum = _loc_6.skill.expMax;
                            _loc_18.value = 0;
                            _loc_18.tip = _loc_18.value + "/" + _loc_18.maximum;
                            _loc_15.x = _loc_18.x + Math.floor(_loc_18.width * _loc_18.value / _loc_18.maximum) - 7;
                        }
                        _loc_17 = new Label(null, 55, 5);
                        if (_loc_6.skill.level > 0)
                        {
                            if (Number(_loc_6.skill._skillData.giftFlag) == 1)
                            {
                                _loc_17.text = _loc_6.skill._skillData.name;
                            }
                            else
                            {
                                _loc_17.text = "Lv." + (_loc_6.skill.level - 1) + " " + _loc_6.skill._skillData.name;
                            }
                        }
                        else if (Number(_loc_6.skill._skillData.giftFlag) == 1)
                        {
                            _loc_17.text = Config.language("SkillUI", 12) + _loc_6.skill._skillData.name;
                        }
                        else
                        {
                            _loc_17.text = Config.language("SkillUI", 12) + _loc_6.skill._skillData.name;
                        }
                        this._skillSlotMap[_loc_6.skill._skillData.baseId] = {slot:_loc_6, levelupBtn:_loc_16, updateBtn:_loc_15, expBar:_loc_18, infoLB:_loc_17};
                        _loc_14[_loc_1].addChild(_loc_6);
                        if (_loc_6.skill._skillData.giftFlag == 0)
                        {
                            _loc_14[_loc_1].addChild(_loc_18);
                        }
                        _loc_14[_loc_1].addChild(_loc_17);
                        if (_loc_6.skill._skillData.giftFlag == 0)
                        {
                            _loc_14[_loc_1].addChild(_loc_15);
                            _loc_14[_loc_1].addChild(_loc_16);
                        }
                        if (_loc_6.skill._skillData.giftFlag == 0)
                        {
                            _loc_16.addEventListener(MouseEvent.CLICK, this.handleLevelup);
                            _loc_15.addEventListener(MouseEvent.MOUSE_DOWN, this.handleUpdateDown);
                            _loc_15.addEventListener(MouseEvent.ROLL_OVER, this.handleUpdateRollOver);
                            _loc_15.addEventListener(MouseEvent.ROLL_OUT, this.handleUpdateRollOut);
                        }
                        _loc_15 = null;
                        _loc_18 = null;
                        _loc_1 = _loc_1 + 1;
                    }
                    _loc_2 = _loc_2 + 1;
                }
                Config.ui._quickUI.freshSlotList();
                Config.ui._monsterIndexUI._setupPanel.freshSlotList();
                _ready = true;
            }
            setTimeout(this.testEntertain, 2000);
            return;
        }// end function

        private function handleLevelup(event:MouseEvent)
        {
            var _loc_3:* = 0;
            var _loc_2:* = event.currentTarget.data;
            if (_loc_2._skillData.SkillItemID != 0)
            {
                _loc_3 = Config.ui._charUI.getItemAmount(_loc_2._skillData.SkillItemID);
                AlertUI.remove(this._levelupAlertID);
                if (Config.map.id == 459 || Config.map.id == 491)
                {
                    this._levelupAlertID = AlertUI.alert(Config.language("SkillUI", 55), Config.language("SkillUI", 56), [Config.language("SkillUI", 21)]);
                }
                else
                {
                    this._levelupAlertID = AlertUI.alert(Config.language("SkillUI", 57), Config.language("SkillUI", 58, Config._itemMap[_loc_2._skillData.SkillItemID].name, _loc_3, _loc_2._skillData.SkillItemCount), [Config.language("SkillUI", 35), Config.language("SkillUI", 22)], [this.handleLevelupConfirm], _loc_2._skillData.id);
                    if (_loc_3 < _loc_2._skillData.SkillItemCount)
                    {
                        AlertUI._ui._btnArray[0].enabled = false;
                    }
                }
            }
            return;
        }// end function

        private function handleLevelupConfirm(param1) : void
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_SKILL_UPGRADE);
            _loc_2.add32(param1);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function handleUpdateRollOver(event:MouseEvent)
        {
            var _loc_2:* = event.currentTarget;
            var _loc_3:* = _loc_2.parent.localToGlobal(new Point(_loc_2.x, _loc_2.y));
            var _loc_4:* = new Rectangle(_loc_3.x, _loc_3.y, _loc_2.width, _loc_2.height);
            var _loc_5:* = _loc_2.data;
            var _loc_6:* = Number(_loc_5._skillData.branch);
            var _loc_7:* = Config.language("SkillUI", 13, _loc_6);
            Holder.showInfo(_loc_7, _loc_4, true);
            return;
        }// end function

        private function handleUpdateRollOut(event:MouseEvent)
        {
            Holder.closeInfo();
            return;
        }// end function

        private function handleUpdateMove(event:MouseEvent)
        {
            var _loc_16:* = undefined;
            var _loc_2:* = this._updateBtnPre.data;
            var _loc_3:* = _loc_2._skillData.baseId;
            var _loc_4:* = this._skillSlotMap[_loc_3].slot;
            var _loc_5:* = this._skillSlotMap[_loc_3].expBar;
            var _loc_6:* = this._skillSlotMap[_loc_3].updateBtn;
            var _loc_7:* = Config.stage.mouseX - this._updateMouseX;
            var _loc_8:* = _loc_5.x + Math.floor(_loc_5.width * _loc_5.value / _loc_5.maximum) - 7;
            var _loc_9:* = _loc_5.x + _loc_5.width - 7;
            var _loc_10:* = Math.max(_loc_8, Math.min(_loc_9, this._updateBtnPreX + _loc_7));
            this._updateBtnPre.x = _loc_10;
            var _loc_11:* = _loc_10 - _loc_5.x + 7 - Math.floor(_loc_5.width * _loc_5.value / _loc_5.maximum);
            var _loc_12:* = _loc_6.parent.localToGlobal(new Point(_loc_6.x, _loc_6.y));
            var _loc_13:* = new Rectangle(_loc_12.x, _loc_12.y, _loc_6.width, _loc_6.height);
            this._needPoint = Math.min(_loc_2.expMax - _loc_2.exp, Math.floor(_loc_11 / _loc_5.width * _loc_2.expMax));
            var _loc_14:* = Number(_loc_2._skillData.branch);
            var _loc_15:* = this._needPoint * _loc_14;
            if (this._needPoint * _loc_14 < Config.player.money3)
            {
                if (this._needPoint == _loc_2.expMax - _loc_2.exp)
                {
                    _loc_16 = Config.language("SkillUI", 14, _loc_15);
                }
                else if (this._needPoint == 0)
                {
                    _loc_16 = Config.language("SkillUI", 16, _loc_14);
                }
                else
                {
                    _loc_16 = Config.language("SkillUI", 17, _loc_15, this._needPoint);
                }
                Holder.showInfo(_loc_16, _loc_13, true);
            }
            else
            {
                this._needPoint = Math.min(_loc_2.expMax - _loc_2.exp, Math.floor(Config.player.money3 / _loc_14));
                _loc_15 = this._needPoint * _loc_14;
                _loc_11 = this._needPoint * _loc_5.width / _loc_2.expMax;
                _loc_10 = Math.floor(_loc_5.width * _loc_5.value / _loc_5.maximum) + _loc_11 - 7 + _loc_5.x;
                this._updateBtnPre.x = _loc_10;
                if (this._needPoint == _loc_2.expMax - _loc_2.exp)
                {
                    _loc_16 = Config.language("SkillUI", 14, _loc_15);
                }
                else if (this._needPoint == 0)
                {
                    _loc_16 = Config.language("SkillUI", 13, _loc_14);
                }
                else
                {
                    _loc_16 = Config.language("SkillUI", 17, _loc_15, this._needPoint);
                }
                Holder.showInfo(_loc_16, _loc_13, true);
            }
            event.updateAfterEvent();
            return;
        }// end function

        private function handleUpdateUp(event:MouseEvent)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            Holder.closeInfo();
            Config.stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.handleUpdateMove);
            Config.stage.removeEventListener(MouseEvent.MOUSE_UP, this.handleUpdateUp);
            Config.stage.removeEventListener(Event.MOUSE_LEAVE, this.handleUpdateUp);
            if (this._needPoint > 0)
            {
                _loc_2 = this._updateBtnPre.data;
                if (Config.map.id == 459 || Config.map.id == 491)
                {
                    this._updateAlertId = AlertUI.alert(Config.language("SkillUI", 55), Config.language("SkillUI", 56), [Config.language("SkillUI", 21)], [this.updateCancel], _loc_2, false, false);
                }
                else
                {
                    _loc_3 = Number(_loc_2._skillData.branch);
                    _loc_4 = this._needPoint * _loc_3;
                    _loc_5 = Config.language("SkillUI", 17, _loc_4, this._needPoint) + "\n<font color=\'#cc0000\'>" + _loc_2._skillData.name + "</font>";
                    this._updateAlertId = AlertUI.alert(Config.language("SkillUI", 20), _loc_5, [Config.language("SkillUI", 21), Config.language("SkillUI", 22)], [this.updateConfirm, this.updateCancel], _loc_2, false, false);
                }
                this._updateMouseX = null;
                this._updateBtnPre = null;
                this._updateBtnPreX = null;
            }
            return;
        }// end function

        private function updateConfirm(param1:Skill)
        {
            var _loc_2:* = Number(param1._skillData.branch);
            var _loc_3:* = this._needPoint * _loc_2;
            this.buyExp(param1._skillData.id, _loc_3);
            this.refreshInfo(param1._skillData.baseId);
            AlertUI.close();
            return;
        }// end function

        private function updateCancel(param1)
        {
            this.refreshInfo(param1._skillData.baseId);
            AlertUI.close();
            return;
        }// end function

        private function handleUpdateDown(event:MouseEvent)
        {
            AlertUI.remove(this._updateAlertId);
            this._updateAlertId = null;
            var _loc_2:* = event.currentTarget;
            Config.stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.handleUpdateMove);
            Config.stage.removeEventListener(MouseEvent.MOUSE_UP, this.handleUpdateUp);
            Config.stage.removeEventListener(Event.MOUSE_LEAVE, this.handleUpdateUp);
            Config.stage.addEventListener(MouseEvent.MOUSE_MOVE, this.handleUpdateMove);
            Config.stage.addEventListener(MouseEvent.MOUSE_UP, this.handleUpdateUp);
            Config.stage.addEventListener(Event.MOUSE_LEAVE, this.handleUpdateUp);
            this._updateMouseX = Config.stage.mouseX;
            this._updateBtnPre = _loc_2;
            this._updateBtnPreX = _loc_2.x;
            this._needPoint = 0;
            return;
        }// end function

        private function testEntertain()
        {
            if (Config.ui._taskpanel.getTaskState(101) == 3 && Skill.picksoulTime < 1)
            {
                Config.ui._quickUI.openPicksoul();
            }
            else if (Config.ui._taskpanel.getTaskState(32) == 3 && Skill.picksoulTime < Skill.picksoulTimeStd)
            {
                Config.ui._quickUI.openPicksoul();
            }
            if (Config.ui._taskpanel.getTaskState(53) == 3 && Skill.goldhandTime < 3)
            {
                Config.ui._quickUI.openGoldhand();
            }
            return;
        }// end function

        public function refreshAllSkillPanel()
        {
            var _loc_1:* = undefined;
            for (_loc_1 in this._skillSlotMap)
            {
                
                this.refreshInfo(_loc_1);
            }
            return;
        }// end function

        private function handleSkillPractice(param1)
        {
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = undefined;
            var _loc_11:* = undefined;
            var _loc_2:* = param1.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            var _loc_4:* = _loc_2.readUnsignedInt();
            var _loc_5:* = Number(Config._skillMap[_loc_3].baseId);
            if (this._skillSlotMap[_loc_5] != null)
            {
                _loc_6 = this._skillSlotMap[_loc_5].slot;
                _loc_7 = this._skillSlotMap[_loc_5].expBar;
                _loc_8 = this._skillSlotMap[_loc_5].levelupBtn;
                _loc_9 = this._skillSlotMap[_loc_5].updateBtn;
                _loc_10 = _loc_6.skill;
                _loc_10.exp = _loc_4;
                if (_loc_7 != null)
                {
                    _loc_7.value = _loc_10.exp;
                    _loc_7.tip = _loc_7.value + "/" + _loc_7.maximum;
                    _loc_9.x = _loc_7.x + Math.floor(_loc_7.width * _loc_7.value / _loc_7.maximum) - 7;
                    if (_loc_10._skillData.SkillItemID != 0)
                    {
                        if (int(_loc_10.level) < 4)
                        {
                            _loc_11 = Config._skillMap[Number(_loc_10._skillData.baseId + "" + _loc_6.skill.level)];
                        }
                        else
                        {
                            _loc_11 = Config._skillMap[int(_loc_10._skillData.baseId) * 100 + int(_loc_10.level) + 1 + 100000];
                        }
                        _loc_8.visible = false;
                        if (_loc_10.exp >= _loc_10.expMax)
                        {
                            if (_loc_11 != null)
                            {
                                _loc_8.visible = true;
                            }
                            _loc_9.visible = false;
                        }
                        else
                        {
                            _loc_9.visible = true;
                        }
                    }
                }
            }
            return;
        }// end function

        private function handleSkillItem(param1)
        {
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            var _loc_8:* = undefined;
            var _loc_9:* = undefined;
            var _loc_10:* = undefined;
            var _loc_11:* = undefined;
            var _loc_12:* = undefined;
            var _loc_13:* = undefined;
            var _loc_2:* = param1.data;
            _loc_3 = _loc_2.readUnsignedInt();
            var _loc_14:* = 0;
            while (_loc_14 < _loc_3)
            {
                
                _loc_4 = _loc_2.readUnsignedInt();
                _loc_13 = _loc_2.readUnsignedInt();
                _loc_6 = _loc_2.readUnsignedInt();
                _loc_5 = _loc_2.readUnsignedInt();
                _loc_12 = _loc_2.readUnsignedInt();
                _loc_9 = Config._skillMap[_loc_4];
                if (_loc_9 != null)
                {
                    _loc_11 = Number(_loc_9.level);
                    if (this._jobSkillMap[_loc_9.baseId] != null)
                    {
                        this._jobSkillMap[_loc_9.baseId].level = _loc_11;
                        this._jobSkillMap[_loc_9.baseId].exp = _loc_5;
                        this._jobSkillMap[_loc_9.baseId].cd = _loc_12;
                        Config.ui._quickUI.checkQuick(this._jobSkillMap[_loc_9.baseId]);
                    }
                    this._learnedSkillMap[_loc_9.baseId] = {level:_loc_11, exp:_loc_5, cd:_loc_12};
                }
                _loc_14 = _loc_14 + 1;
            }
            Config.ui._quickUI.freshSlotList();
            Config.ui._monsterIndexUI._setupPanel.freshSlotList();
            return;
        }// end function

        private function handleSkillUpdate(param1)
        {
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_2:* = param1.data;
            _loc_3 = _loc_2.readUnsignedInt();
            _loc_4 = _loc_2.readByte();
            if (_loc_3 == 0)
            {
                return;
            }
            if (_loc_4 == 1 || _loc_4 == 2 || _loc_4 == 4)
            {
                _loc_5 = Config._skillMap[_loc_3];
                if (_loc_5 != null && this._jobSkillMap[_loc_5.baseId] != null)
                {
                    this._jobSkillMap[_loc_5.baseId].level = Number(_loc_5.level);
                    this._jobSkillMap[_loc_5.baseId].checkSlot();
                    this._jobSkillMap[_loc_5.baseId].exp = 0;
                    this.refreshInfo(Number(_loc_5.baseId));
                }
                if (!Config.ui._elementUI.checkSkill(_loc_3))
                {
                    if (Config.player != null)
                    {
                        Config.player.addEffect("1173");
                    }
                    _loc_6 = String(_loc_5.name);
                    if (_loc_4 == 1)
                    {
                        BubbleUI.bubble(_loc_6 + Config.language("SkillUI", 23) + (Number(_loc_5.level) - 1) + Config.language("SkillUI", 24));
                        Config.ui._monsterIndexUI._setupPanel.freshSkillUpdate(_loc_5);
                    }
                    else if (_loc_4 == 2)
                    {
                        BubbleUI.bubble(Config.language("SkillUI", 25) + _loc_6);
                        if (this._skillSlotMap[Number(_loc_5.baseId)] != null)
                        {
                            _loc_7 = this._skillSlotMap[Number(_loc_5.baseId)].slot;
                            if (_loc_7.skill._skillData.skillType == 0 || _loc_7.skill._skillData.skillType == 4)
                            {
                                _loc_8 = Config.ui._quickUI.findBlankSlot(1);
                                if (_loc_8 != null && _loc_8.length > 0)
                                {
                                    _loc_9 = _loc_8[0];
                                    _loc_9.skill = _loc_7.skill;
                                }
                            }
                            Config.ui._monsterIndexUI._setupPanel.addAttackSlot(_loc_7.skill);
                            if (GuideUI.testId(16))
                            {
                                GuideUI.testDoId(16, Config.ui._systemUI._skillPB, Config.ui._skillUI);
                            }
                            else if (Number(_loc_5.reqLevel) == 10)
                            {
                                GuideUI.testDoId(169, Config.ui._systemUI._skillPB, Config.ui._skillUI);
                            }
                        }
                    }
                }
            }
            else if (_loc_4 == 0)
            {
                BubbleUI.bubble(Config.language("SkillUI", 26));
            }
            else if (_loc_4 == 3)
            {
                BubbleUI.bubble(Config.language("SkillUI", 27));
            }
            else if (_loc_4 == 5)
            {
                _loc_5 = Config._skillMap[_loc_3];
                if (_loc_5 != null && this._jobSkillMap[_loc_5.baseId] != null)
                {
                    this._jobSkillMap[_loc_5.baseId].level = 0;
                    this._jobSkillMap[_loc_5.baseId].checkSlot();
                    this._jobSkillMap[_loc_5.baseId].exp = 0;
                    this.refreshInfo(Number(_loc_5.baseId));
                }
                _loc_6 = String(_loc_5.name);
                Config.ui._quickUI.removeQuickSkill(_loc_3);
            }
            Config.ui._quickUI.freshSlotList();
            Config.ui._monsterIndexUI._setupPanel.freshSlotList();
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

        private function handleSlotDrag(param1)
        {
            var _loc_2:* = param1.currentTarget;
            this.dragSlot(_loc_2);
            return;
        }// end function

        private function handleSlotClick(param1)
        {
            var _loc_2:* = param1.currentTarget;
            this.dragSlot(_loc_2);
            return;
        }// end function

        private function clickSlot(param1)
        {
            if (this._selectedSlot != null)
            {
                this._selectedSlot.selected = false;
            }
            this._selectedSlot = param1;
            this._selectedSlot.selected = true;
            return;
        }// end function

        private function refreshInfo(param1)
        {
            var _loc_9:* = undefined;
            var _loc_2:* = this._skillSlotMap[param1].slot;
            var _loc_3:* = this._skillSlotMap[param1].updateBtn;
            var _loc_4:* = this._skillSlotMap[param1].levelupBtn;
            var _loc_5:* = this._skillSlotMap[param1].expBar;
            var _loc_6:* = this._skillSlotMap[param1].infoLB;
            var _loc_7:* = _loc_2.skill;
            var _loc_8:* = "";
            _loc_2.level = _loc_2.skill.level;
            if (_loc_2.skill.level > 0)
            {
                if (Number(_loc_2.skill._skillData.giftFlag) == 1)
                {
                    _loc_6.text = _loc_2.skill._skillData.name;
                }
                else
                {
                    _loc_6.text = "Lv." + (_loc_2.skill.level - 1) + " " + _loc_2.skill._skillData.name;
                }
            }
            else if (Number(_loc_2.skill._skillData.giftFlag) == 1)
            {
                _loc_6.text = Config.language("SkillUI", 12) + _loc_2.skill._skillData.name;
            }
            else
            {
                _loc_6.text = Config.language("SkillUI", 12) + _loc_2.skill._skillData.name;
            }
            if (_loc_5 != null)
            {
                if (int(_loc_7.level) < 4)
                {
                    _loc_9 = Config._skillMap[Number(_loc_2.skill._skillData.baseId + "" + _loc_2.skill.level)];
                }
                else
                {
                    _loc_9 = Config._skillMap[int(_loc_2.skill._skillData.baseId) * 100 + int(_loc_7.level) + 1 + 100000];
                }
                if (_loc_2.level == 0)
                {
                    if (_loc_3 != null)
                    {
                        _loc_3.visible = false;
                        _loc_5.visible = false;
                    }
                }
                else if (_loc_3 != null)
                {
                    _loc_5.visible = true;
                    if (_loc_9 != null)
                    {
                        if (Number(_loc_9.reqLevel) <= Config.player.level)
                        {
                            _loc_3.visible = true;
                        }
                        else
                        {
                            _loc_3.visible = false;
                        }
                    }
                    else
                    {
                        _loc_3.visible = false;
                    }
                    _loc_5.maximum = _loc_2.skill.expMax;
                    _loc_5.value = _loc_2.skill.exp;
                    _loc_5.tip = _loc_5.value + "/" + _loc_5.maximum;
                    _loc_3.x = _loc_5.x + Math.floor(_loc_5.width * _loc_5.value / _loc_5.maximum) - 7;
                    _loc_4.visible = false;
                    if (_loc_7._skillData.SkillItemID != 0)
                    {
                        if (_loc_7.exp >= _loc_7.expMax)
                        {
                            if (_loc_9 != null)
                            {
                                _loc_4.visible = true;
                            }
                            _loc_3.visible = false;
                        }
                    }
                }
            }
            return;
        }// end function

        private function handleSlotDoubleClick(param1)
        {
            return;
        }// end function

        private function handleSlotOver(param1)
        {
            var _loc_2:* = param1.currentTarget;
            if (_loc_2.skill != null)
            {
                Holder.showInfo(_loc_2.skill.outputInfo(), new Rectangle(_loc_2.x + _loc_2.parent.x + _loc_2.parent.parent.x + _loc_2.parent.parent.parent.x + _loc_2.parent.parent.parent.parent.x + _loc_2.parent.parent.parent.parent.parent.x, _loc_2.y + _loc_2.parent.y + _loc_2.parent.parent.y + _loc_2.parent.parent.parent.y + _loc_2.parent.parent.parent.parent.y + _loc_2.parent.parent.parent.parent.parent.y, _loc_2._size, _loc_2._size), false, 1, 220);
            }
            return;
        }// end function

        private function handleSlotOut(param1)
        {
            Holder.closeInfo();
            return;
        }// end function

        private function dragSlot(param1)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            if (param1 != null)
            {
                if (param1.skill != null)
                {
                    if (param1.skill.level == 0)
                    {
                    }
                    else if (param1.skill._skillData.skillType != 1)
                    {
                        _loc_6 = Config.ui._quickUI.findBlankSlot(1)[0];
                        if (GuideUI.testId(171))
                        {
                            GuideUI.doId(171, _loc_6);
                        }
                        else if (GuideUI.testId(176))
                        {
                            GuideUI.doId(176, _loc_6);
                        }
                        Holder.other = {bmpd:param1.skill._bmpd, obj:param1.skill};
                        Holder.data = null;
                    }
                }
            }
            else
            {
                super.handleMouseDown();
            }
            return;
        }// end function

        private function buyExp(param1, param2)
        {
            var _loc_3:* = new DataSet();
            _loc_3.addHead(CONST_ENUM.C2G_SKILL_BUYEXP);
            _loc_3.add32(param1);
            _loc_3.add32(param2);
            ClientSocket.send(_loc_3);
            return;
        }// end function

        private function handleSkillBuy(param1)
        {
            var _loc_2:* = param1.data;
            var _loc_3:* = _loc_2.readByte();
            if (_loc_3 != 0)
            {
                trace("handleSkillBuy", _loc_3);
            }
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

        private function initgiftpanel() : void
        {
            this.giftspobj = new Object();
            var _loc_1:* = new Shape();
            _loc_1.graphics.beginFill(16758354);
            _loc_1.graphics.lineStyle(0, 9199934, 1, true);
            _loc_1.graphics.drawRect(5, 50 - 3, 190 + 20, 25);
            _loc_1.graphics.drawRect(200 + 20, 50 - 3, 190 + 20, 25);
            _loc_1.graphics.drawRect(395 + 40, 50 - 3, 190 + 20, 25);
            _loc_1.graphics.beginFill(13545363);
            _loc_1.graphics.drawRoundRect(70, 320, 70, 18, 1);
            _loc_1.graphics.endFill();
            this.giftpanel.addChild(_loc_1);
            var _loc_2:* = new Label(this.giftpanel, 10, 55 - 3);
            _loc_2.html = true;
            this.giftspobj.point1label = _loc_2;
            var _loc_3:* = new Label(this.giftpanel, 205 + 20, 55 - 3);
            _loc_3.html = true;
            this.giftspobj.point2label = _loc_3;
            var _loc_4:* = new Label(this.giftpanel, 400 + 40, 55 - 3);
            new Label(this.giftpanel, 400 + 40, 55 - 3).html = true;
            this.giftspobj.point3label = _loc_4;
            var _loc_5:* = new Sprite();
            this.giftpanel.addChild(_loc_5);
            var _loc_6:* = new Label(this.giftpanel, 10, 300, Config.language("SkillUI", 28));
            this.giftspobj.glevel = _loc_6;
            var _loc_7:* = new ProgressBar(_loc_5, 90, 302);
            this.giftspobj.expbar = _loc_7;
            _loc_7.height = 13;
            _loc_7.width = 150;
            _loc_7.gradientFillDirection = Math.PI;
            _loc_7.roundCorner = 2;
            _loc_7.color = 15981107;
            _loc_7.subColor = 16750899;
            var _loc_8:* = new Label(this.giftpanel, 90, 300);
            new Label(this.giftpanel, 90, 300).filters = [new GlowFilter(16777215, 1, 2, 2, 10)];
            this.giftspobj.bartext = _loc_8;
            var _loc_9:* = new Label(this.giftpanel, 10, 320, Config.language("SkillUI", 29));
            var _loc_10:* = new Label(this.giftpanel, 80, 320, "25");
            this.giftspobj.pointlabel = _loc_10;
            _loc_10.textColor = 13244183;
            _loc_10.filters = [new GlowFilter(16049243, 1, 2, 2, 10)];
            _loc_10.x = 70 + (70 - _loc_10.width) / 2;
            var _loc_11:* = new PushButton(this.giftpanel, 180, 320, Config.language("SkillUI", 30), this.sendwash);
            new PushButton(this.giftpanel, 180, 320, Config.language("SkillUI", 30), this.sendwash).width = 50;
            return;
        }// end function

        public function setGiftList() : void
        {
            var _loc_2:* = undefined;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            this.giftspobj.point1label.text = this.getgname(1) + "\t\t<font color=\'#481008\'>" + Config.language("SkillUI", 31) + this.giftpoint1 + "</font>";
            this.giftspobj.point2label.text = this.getgname(2) + "\t\t<font color=\'#481008\'>" + Config.language("SkillUI", 31) + this.giftpoint2 + "</font>";
            this.giftspobj.point3label.text = this.getgname(3) + "\t\t<font color=\'#481008\'>" + Config.language("SkillUI", 31) + this.giftpoint3 + "</font>";
            this.giftspobj.pointlabel.text = this.giftpoint;
            this.giftspobj.pointlabel.x = 70 + (70 - this.giftspobj.pointlabel.width) / 2;
            this.giftlistarr = new Array();
            var _loc_1:* = Number.MAX_VALUE;
            for (_loc_2 in Config._giftSkillMap)
            {
                
                if (int(Config._giftSkillMap[_loc_2].reqJob) == Config.player.job)
                {
                    if (int(Config._giftSkillMap[_loc_2].level) == 1)
                    {
                        _loc_3 = new Object();
                        _loc_3.baseId = int(Config._giftSkillMap[_loc_2].baseId);
                        _loc_3.branch = int(Config._giftSkillMap[_loc_2].branch);
                        _loc_3.row = int(Config._giftSkillMap[_loc_2].row);
                        _loc_3.column = int(Config._giftSkillMap[_loc_2].column);
                        _loc_3.level = 0;
                        _loc_4 = 0;
                        while (_loc_4 < this.templistarr.length)
                        {
                            
                            if (this.templistarr[_loc_4].gid == _loc_3.baseId)
                            {
                                _loc_3.level = this.templistarr[_loc_4].glevel;
                                break;
                            }
                            _loc_4 = _loc_4 + 1;
                        }
                        this.giftlistarr.push(_loc_3);
                        this.showgift(_loc_3);
                        if (_loc_3.row < _loc_1)
                        {
                            _loc_1 = _loc_3.row;
                            this._firstGiftSlot = _loc_3.giftslot;
                        }
                    }
                }
            }
            this.initpanelflag = true;
            return;
        }// end function

        private function giftPointFuc(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            this.giftpoint = _loc_2.readUnsignedInt();
            this.giftpoint1 = _loc_2.readUnsignedInt();
            this.giftpoint2 = _loc_2.readUnsignedInt();
            this.giftpoint3 = _loc_2.readUnsignedInt();
            if (Config.player != null)
            {
                this.giftspobj.point1label.text = this.getgname(1) + "\t\t<font color=\'#481008\'>" + Config.language("SkillUI", 31) + this.giftpoint1 + "</font>";
                this.giftspobj.point2label.text = this.getgname(2) + "\t\t<font color=\'#481008\'>" + Config.language("SkillUI", 31) + this.giftpoint2 + "</font>";
                this.giftspobj.point3label.text = this.getgname(3) + "\t\t<font color=\'#481008\'>" + Config.language("SkillUI", 31) + this.giftpoint3 + "</font>";
                this.giftspobj.pointlabel.text = this.giftpoint;
                this.giftspobj.pointlabel.x = 70 + (70 - this.giftspobj.pointlabel.width) / 2;
            }
            return;
        }// end function

        public function sendGiftList() : void
        {
            var _loc_1:* = new DataSet();
            _loc_1.addHead(CONST_ENUM.C2G_INNATE_LIST);
            ClientSocket.send(_loc_1);
            return;
        }// end function

        private function giftList(event:SocketEvent) : void
        {
            var _loc_5:* = null;
            this.templistarr = new Array();
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = new Object();
                _loc_5.gid = _loc_2.readUnsignedInt();
                _loc_5.glevel = _loc_2.readUnsignedInt();
                this.templistarr.push(_loc_5);
                _loc_4 = _loc_4 + 1;
            }
            this.setGiftList();
            return;
        }// end function

        private function showgift(param1:Object) : void
        {
            var _loc_2:* = null;
            if (param1.giftslot != null)
            {
                this.giftcanvas.removeChildUI(_loc_2);
                _loc_2.removeEventListener("giftupdate", Config.create(this.learngift, param1.baseId));
            }
            _loc_2 = new GiftSkill(param1.baseId, 32);
            _loc_2.giftSkill = param1;
            this.giftcanvas.addChildUI(_loc_2);
            _loc_2.addEventListener("giftupdate", Config.create(this.learngift, param1.baseId));
            _loc_2.x = 50 + (param1.column - 1) * 90 + (param1.branch - 1) * 215;
            _loc_2.y = (param1.row - 1) * 45 + 10;
            param1.giftslot = _loc_2;
            return;
        }// end function

        private function sendwash(event:MouseEvent) : void
        {
            AlertUI.alert(Config.language("SkillUI", 32), Config.language("SkillUI", 33), [Config.language("SkillUI", 35), Config.language("SkillUI", 22)], [this.checkwash, null]);
            return;
        }// end function

        private function checkwash(param1) : void
        {
            var _loc_2:* = null;
            if (Config.ui._charUI.getItemAmount(820001) + Config.ui._charUI.getItemAmount(94402) > 0)
            {
                _loc_2 = new DataSet();
                _loc_2.addHead(CONST_ENUM.C2G_SKILL_INNATE_CLEAR);
                ClientSocket.send(_loc_2);
            }
            else
            {
                Config.message(Config.language("SkillUI", 36));
            }
            return;
        }// end function

        private function washPoint(event:SocketEvent) : void
        {
            var _loc_4:* = 0;
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedByte();
            if (_loc_3 == 0)
            {
                Config.message(Config.language("SkillUI", 37));
                _loc_4 = 0;
                while (_loc_4 < this.giftlistarr.length)
                {
                    
                    this.giftlistarr[_loc_4].level = 0;
                    this.giftlistarr[_loc_4].giftslot.level = this.giftlistarr[_loc_4].level;
                    _loc_4 = _loc_4 + 1;
                }
                Skill._giftReviseMap = {};
            }
            else
            {
                Config.message(Config.language("SkillUI", 38));
            }
            return;
        }// end function

        public function getgjobname(param1, param2:int = 1) : String
        {
            var _loc_3:* = null;
            var _loc_4:* = [Config.language("SkillUI", 39), Config.language("SkillUI", 40), Config.language("SkillUI", 41), Config.language("SkillUI", 42), Config.language("SkillUI", 43), Config.language("SkillUI", 44), Config.language("SkillUI", 45), Config.language("SkillUI", 46), Config.language("SkillUI", 47)];
            switch(param1)
            {
                case 1:
                {
                    _loc_3 = _loc_4[(param2 - 1)];
                    break;
                }
                case 4:
                {
                    _loc_3 = _loc_4[2 + param2];
                    break;
                }
                case 10:
                {
                    _loc_3 = _loc_4[5 + param2];
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_3;
        }// end function

        public function getgname(param1:int = 1) : String
        {
            var _loc_2:* = null;
            var _loc_3:* = [Config.language("SkillUI", 39), Config.language("SkillUI", 40), Config.language("SkillUI", 41), Config.language("SkillUI", 42), Config.language("SkillUI", 43), Config.language("SkillUI", 44), Config.language("SkillUI", 45), Config.language("SkillUI", 46), Config.language("SkillUI", 47)];
            switch(Config.player.job)
            {
                case 1:
                {
                    _loc_2 = _loc_3[(param1 - 1)];
                    break;
                }
                case 4:
                {
                    _loc_2 = _loc_3[2 + param1];
                    break;
                }
                case 10:
                {
                    _loc_2 = _loc_3[5 + param1];
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_2;
        }// end function

        public function getgiftpoint(param1:int = 0) : int
        {
            if (param1 == 0)
            {
                return this.giftpoint;
            }
            if (param1 == 1)
            {
                return this.giftpoint1;
            }
            if (param1 == 2)
            {
                return this.giftpoint2;
            }
            if (param1 == 3)
            {
                return this.giftpoint3;
            }
            return this.giftpoint;
        }// end function

        public function learngift(event:MouseEvent = null, param2:int = 0) : void
        {
            GuideUI.testDoId(98);
            var _loc_3:* = new DataSet();
            _loc_3.addHead(CONST_ENUM.C2G_SKILL_INNATE_UPGRADE);
            _loc_3.add32(param2);
            ClientSocket.send(_loc_3);
            return;
        }// end function

        private function giftUpdate(event:SocketEvent) : void
        {
            var _loc_6:* = 0;
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            var _loc_4:* = _loc_2.readUnsignedByte();
            var _loc_5:* = _loc_2.readUnsignedInt();
            switch(_loc_4)
            {
                case 0:
                {
                    _loc_6 = 0;
                    while (_loc_6 < this.giftlistarr.length)
                    {
                        
                        if (_loc_3 == this.giftlistarr[_loc_6].baseId)
                        {
                            this.giftlistarr[_loc_6].level = _loc_5;
                            this.giftlistarr[_loc_6].giftslot.level = _loc_5;
                            this.giftlistarr[_loc_6].giftslot.reSlotOver();
                        }
                        else
                        {
                            this.giftlistarr[_loc_6].giftslot.level = this.giftlistarr[_loc_6].level;
                        }
                        _loc_6 = _loc_6 + 1;
                    }
                    Config.message(Config.language("SkillUI", 48));
                    break;
                }
                case 1:
                {
                    Config.message(Config.language("SkillUI", 49));
                    break;
                }
                case 2:
                {
                    Config.message(Config.language("SkillUI", 50));
                    break;
                }
                case 3:
                {
                    Config.message(Config.language("SkillUI", 51));
                    break;
                }
                case 4:
                {
                    Config.message(Config.language("SkillUI", 52));
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function backgiftexp(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            var _loc_4:* = _loc_2.readUnsignedInt();
            var _loc_5:* = _loc_2.readUnsignedInt();
            this.giftpoint = _loc_2.readUnsignedInt();
            this.giftspobj.expbar.maximum = _loc_4;
            this.giftspobj.expbar.value = _loc_3;
            this.giftspobj.glevel.text = Config.language("SkillUI", 54) + _loc_5;
            this.giftspobj.bartext.text = _loc_3 + "/" + _loc_4;
            this.giftspobj.bartext.x = 90 + (150 - this.giftspobj.bartext.width) / 2;
            if (Config.player != null)
            {
                this.giftspobj.pointlabel.text = this.giftpoint;
                this.giftspobj.pointlabel.x = 70 + (70 - this.giftspobj.pointlabel.width) / 2;
            }
            return;
        }// end function

        private function backaddgiftexp(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            BubbleUI.bubble(Config.language("SkillUI", 53) + _loc_3, 16750848);
            Config.addHistory(Config.language("SkillUI", 53) + _loc_3);
            return;
        }// end function

    }
}
