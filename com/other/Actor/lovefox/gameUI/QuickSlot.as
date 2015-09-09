package lovefox.gameUI
{
    import flash.display.*;
    import lovefox.game.*;
    import lovefox.socket.*;

    public class QuickSlot extends Slot
    {
        public var _group:Object;
        public var _icon:Bitmap;
        public var _skill:Skill;
        private var _img:Object;
        public var _buffSkillId:Object;
        public var _itemId:Object;
        private var _amountTxt:Object;
        public var _relatedId:Object;
        private var _changedArray:Object;
        private static var _skillSlotArray:Object = [];
        private static var _selectedSkill:Object;
        private static var _selectedSlot:Object;

        public function QuickSlot(param1, param2, param3)
        {
            super(param1, param2);
            this._group = param3;
            _skillSlotArray.push(this);
            this.init();
            return;
        }// end function

        override public function init()
        {
            super.init();
            _container.x = 0;
            _container.y = 0;
            _cdShape.x = _container.x;
            _cdShape.y = _container.y;
            this._icon = new Bitmap();
            _container.addChild(this._icon);
            this._amountTxt = Config.getSimpleTextField();
            this._amountTxt.autoSize = TextFieldAutoSize.RIGHT;
            this._amountTxt.textColor = 16777215;
            this._amountTxt.y = _size - 16;
            this._amountTxt.x = _size - 5;
            this._amountTxt.filters = [new GlowFilter(0, 1, 3, 3, 10)];
            addChild(this._amountTxt);
            return;
        }// end function

        public function set content(param1)
        {
            if (param1 is Skill)
            {
                this.item = null;
                this.skill = param1;
            }
            else if (param1 != null)
            {
                this.skill = null;
                this.item = param1;
            }
            else
            {
                this.skill = null;
                this.item = null;
            }
            return;
        }// end function

        public function get content()
        {
            if (this.skill != null)
            {
                return this.skill;
            }
            if (this.item != null)
            {
                return this.item;
            }
            return null;
        }// end function

        public function setId(param1)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            if (param1 > 0)
            {
                this.buttonMode = true;
                this._itemId = param1;
                this.skill = null;
                if (Config._itemMap[param1] != null)
                {
                    _loc_3 = Config._itemMap[param1];
                }
                _loc_2 = Config.findIcon(Item.getXmlIcon(_loc_3));
                this._icon.bitmapData = _loc_2;
                this._relatedId = Number(_loc_3.relatedId);
                _loc_4 = new Date();
                setCd(Math.max(0, Item._cdStack[this._relatedId] - _loc_4.getTime()), Item._cdMaxStack[this._relatedId]);
                this.testItemId();
            }
            else
            {
                if (this._skill == null)
                {
                    this.buttonMode = false;
                }
                this._icon.bitmapData = null;
                this._itemId = null;
                this._amountTxt.text = "";
                this._relatedId = null;
                setCd(0);
            }
            return;
        }// end function

        public function get item()
        {
            return this._itemId;
        }// end function

        public function set item(param1)
        {
            var _loc_2:* = undefined;
            if (this._icon.bitmapData != null)
            {
                this._icon.bitmapData.dispose();
            }
            if (param1 != null)
            {
                if (param1 is Item)
                {
                    this.setId(param1._itemData.baseID);
                }
                else
                {
                    this.setId(param1);
                }
            }
            else
            {
                this.setId(0);
            }
            this.sendAdd();
            return;
        }// end function

        public function sendAdd()
        {
            var _loc_1:* = undefined;
            if (!QuickUI._lock && QuickUI._ready)
            {
                if (this._skill != null)
                {
                    trace("C2G_QUICKBAR_ADD1111", (_id + 1), (_id + 1), this._skill._skillData.id);
                    _loc_1 = new DataSet();
                    _loc_1.addHead(CONST_ENUM.C2G_QUICKBAR_ADD);
                    _loc_1.add8(1);
                    if (_id < 9)
                    {
                        _loc_1.add8((_id + 1));
                    }
                    else
                    {
                        _loc_1.add8(_id + 2);
                    }
                    _loc_1.add32(this._skill._skillData.id);
                    ClientSocket.send(_loc_1);
                }
                else if (this._itemId != null)
                {
                    trace("C2G_QUICKBAR_ADD2222", _id, this._itemId);
                    _loc_1 = new DataSet();
                    _loc_1.addHead(CONST_ENUM.C2G_QUICKBAR_ADD);
                    _loc_1.add8(2);
                    if (_id < 9)
                    {
                        _loc_1.add8((_id + 1));
                    }
                    else
                    {
                        _loc_1.add8(_id + 2);
                    }
                    _loc_1.add32(this._itemId);
                    ClientSocket.send(_loc_1);
                }
                else
                {
                    _loc_1 = new DataSet();
                    _loc_1.addHead(CONST_ENUM.C2G_QUICKBAR_REMOVE);
                    if (_id < 9)
                    {
                        _loc_1.add8((_id + 1));
                    }
                    else
                    {
                        _loc_1.add8(_id + 2);
                    }
                    ClientSocket.send(_loc_1);
                }
            }
            return;
        }// end function

        public function testItemId()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            _loc_2 = 0;
            this._changedArray = [];
            _loc_1 = 0;
            while (_loc_1 < this._group.length)
            {
                
                if (_loc_1 == _id)
                {
                }
                else if (this._group[_loc_1]._itemId == this._itemId)
                {
                    this._group[_loc_1].item = null;
                    this._changedArray.push(this._group[_loc_1]);
                }
                _loc_1 = _loc_1 + 1;
            }
            this._amountTxt.text = Config.ui._charUI.getItemAmount(this._itemId);
            return;
        }// end function

        public function useItem()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            _loc_1 = 0;
            while (_loc_1 < Config.ui._charUI._itemArray.length)
            {
                
                _loc_3 = Config.ui._charUI._itemArray[_loc_1];
                if (_loc_3._itemData.baseID == this._itemId)
                {
                    if (_loc_2 == null || _loc_2.amount > _loc_3.amount)
                    {
                        _loc_2 = _loc_3;
                    }
                }
                _loc_1 = _loc_1 + 1;
            }
            if (_loc_2 != null)
            {
                Config.ui._charUI.useItem(_loc_2);
            }
            return;
        }// end function

        public function get skill() : Skill
        {
            return this._skill;
        }// end function

        public function set skill(param1)
        {
            var _loc_2:* = null;
            var _loc_3:* = undefined;
            if (this._img != null)
            {
                _container.removeChild(this._img);
                this._img = null;
            }
            if (this._skill != null)
            {
                this._skill.removeEventListener("select", this.handleSkillSelect);
                this._skill.removeEventListener("unselect", this.handleSkillUnselect);
                this._skill._slot = null;
                selected = false;
            }
            this._skill = param1;
            if (this._skill != null)
            {
                this.buttonMode = true;
                this.setId(0);
                this._img = this._skill.getDisplay();
                _container.addChild(this._img);
                this._skill.addEventListener("select", this.handleSkillSelect);
                this._skill.addEventListener("unselect", this.handleSkillUnselect);
                if (Skill.selectedSkill == this._skill)
                {
                    selected = true;
                }
                else
                {
                    selected = false;
                }
                _loc_3 = new Date();
                setCd(Math.max(0, Skill._cdStack[param1._skillData.id] - _loc_3.getTime()), Skill._cdMaxStack[param1._skillData.id]);
                this._skill._slot = this;
            }
            else
            {
                if (this._itemId == null)
                {
                    this.buttonMode = false;
                }
                setCd(0);
            }
            this.sendAdd();
            return;
        }// end function

        public function testSkillId()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = [];
            _loc_1 = 1;
            while (_loc_1 < this._group.length)
            {
                
                if (_loc_1 == _id || _loc_1 == 9)
                {
                }
                else if (this._group[_loc_1].skill != null)
                {
                    if (this._group[_loc_1].skill._skillData.id == this.skill._skillData.id)
                    {
                        this._group[_loc_1].skill = null;
                        _loc_2.push(this._group[_loc_1]);
                    }
                }
                _loc_1 = _loc_1 + 1;
            }
            return _loc_2;
        }// end function

        private function handleSkillSelect(param1)
        {
            selected = true;
            return;
        }// end function

        private function handleSkillUnselect(param1)
        {
            selected = false;
            return;
        }// end function

        public function handleMouseDown()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = undefined;
            if ((_id == 0 || _id == 9) && this.skill != null && Config.player != null && this.skill._id == Number(Config.player.attackMode.id))
            {
                _loc_1 = Config.player.tracingTarget;
                if (_loc_1 != null)
                {
                    _loc_2 = Config.player.attackMode.camp;
                    if (_loc_2 == 2 || _loc_2 == 3 || _loc_2 == 0 && _loc_1.testPk() || _loc_2 == 1 && !_loc_1.testPk())
                    {
                        Config.player.target = _loc_1;
                    }
                }
            }
            else if (this.skill != null)
            {
                this.skill.select();
            }
            else if (this.item != null)
            {
                this.useItem();
            }
            return;
        }// end function

        public static function set selectedSkill(param1)
        {
            _selectedSkill = param1;
            if (_selectedSkill == null)
            {
                if (_selectedSlot != null)
                {
                    _selectedSlot.unSelect();
                    _selectedSlot = null;
                }
            }
            return;
        }// end function

        public static function get selectedSkill()
        {
            return _selectedSkill;
        }// end function

    }
}
