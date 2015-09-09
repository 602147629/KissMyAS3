package lovefox.gameUI
{
    import flash.display.*;
    import lovefox.game.*;
    import lovefox.socket.*;

    public class DualSlot extends Slot
    {
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

        public function DualSlot(param1, param2)
        {
            super(param1, param2);
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
                this.buttonMode = true;
                this.item = null;
                this.skill = param1;
            }
            else if (param1 != null)
            {
                this.buttonMode = true;
                this.skill = null;
                this.item = param1;
            }
            else
            {
                this.buttonMode = false;
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
                this.skill = null;
                if (Config._itemMap[param1] != null)
                {
                    _loc_3 = Config._itemMap[param1];
                }
                _loc_2 = Config.findIcon(Item.getXmlIcon(_loc_3));
                this._icon.bitmapData = _loc_2;
                this._itemId = param1;
                this._relatedId = Number(_loc_3.relatedId);
                _loc_4 = new Date();
                setCd(Math.max(0, Item._cdStack[this._relatedId] - _loc_4.getTime()), Item._cdMaxStack[this._relatedId]);
                this.testItemId();
            }
            else
            {
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
                this.buttonMode = true;
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
                this.buttonMode = false;
                this.setId(0);
            }
            return;
        }// end function

        public function testItemId()
        {
            if (this.item == null)
            {
                this._amountTxt.text = "";
            }
            else
            {
                this._amountTxt.text = Config.ui._charUI.getItemAmount(this._itemId);
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
                this._skill._slot = null;
            }
            this._skill = param1;
            if (this._skill != null)
            {
                this.buttonMode = true;
                this.setId(0);
                this._img = this._skill.getDisplay();
                _container.addChild(this._img);
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
            }
            else
            {
                this.buttonMode = false;
                setCd(0);
            }
            return;
        }// end function

    }
}
