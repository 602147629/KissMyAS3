package lovefox.gameUI
{
    import flash.display.*;
    import flash.text.*;
    import lovefox.component.*;
    import lovefox.game.*;
    import lovefox.unit.*;

    public class CloneSlot extends Slot
    {
        private var _skill:Skill;
        private var _item:Item;
        public var _icon:Bitmap;
        private var _amountTxt:TextField;
        private var _nameshow:Boolean = false;
        private var _namelabel:ClickLabel;
        private var _iconsp:Sprite;
        private var _BorderShow:Boolean = true;
        public var _buffSkillId:Object;

        public function CloneSlot(param1, param2 = 32)
        {
            super(param1, param2);
            this.init();
            return;
        }// end function

        override public function init()
        {
            super.init();
            this._iconsp = _container;
            this._icon = new Bitmap();
            this._iconsp.addChild(this._icon);
            addChild(_cdShape);
            this._amountTxt = Config.getSimpleTextField();
            this._amountTxt.autoSize = TextFieldAutoSize.RIGHT;
            this._amountTxt.textColor = 16777215;
            this._amountTxt.y = _size - 16;
            this._amountTxt.x = _size - 5;
            this._amountTxt.filters = [new GlowFilter(0, 1, 3, 3, 10)];
            addChild(this._amountTxt);
            this._namelabel = new ClickLabel(null, 0, this._size + 5, "", this.finditem);
            this._namelabel.html = true;
            this._namelabel.clickColor([39423, 16544]);
            addChild(_selectMask);
            return;
        }// end function

        override public function set bg(param1)
        {
            super.bg = param1;
            addChild(this._iconsp);
            addChild(_cdShape);
            addChild(this._amountTxt);
            return;
        }// end function

        public function get item()
        {
            return this._item;
        }// end function

        private function handleItemAmount(param1)
        {
            this._amountTxt.text = param1.target.amount;
            return;
        }// end function

        private function handleItemnumstr(param1)
        {
            this._amountTxt.text = param1.target.numstr;
            this._amountTxt.textColor = param1.target.numstrcolor;
            return;
        }// end function

        public function set amount(param1)
        {
            this._amountTxt.text = param1;
            return;
        }// end function

        public function set item(param1:Item)
        {
            var _loc_2:* = undefined;
            if (this._item != null)
            {
                this._item.removeEventListener("amount", this.handleItemAmount);
                this._item.removeEventListener("numstrs", this.handleItemnumstr);
                this._item.removeEventListener("destroy", this.handleItemDestroy);
            }
            this._item = param1;
            if (this._item != null)
            {
                this._item.addEventListener("amount", this.handleItemAmount);
                this._item.addEventListener("numstrs", this.handleItemnumstr);
                this._item.addEventListener("destroy", this.handleItemDestroy);
                switch(int(this._item._itemData.nameColor))
                {
                    case 0:
                    {
                        setColorBorder(null);
                        break;
                    }
                    case 1:
                    {
                        setColorBorder(Style.FONT_1int_Blue, Style.FONT_1int_Blue - 50);
                        break;
                    }
                    case 2:
                    {
                        setColorBorder(Style.FONT_2int_Purple, Style.FONT_2int_Purple - 50);
                        break;
                    }
                    case 3:
                    {
                        setColorBorder(Style.FONT_3int_Orange, Style.FONT_3int_Orange - 50);
                        break;
                    }
                    case 4:
                    {
                        setColorBorder(Style.FONT_4int_Gold, Style.FONT_3int_Orange - 50);
                        break;
                    }
                    case 5:
                    {
                        setColorBorder(Style.FONT_Sint_Equip, Style.FONT_Sint_Equip - 50);
                        break;
                    }
                    case 6:
                    {
                        setColorBorder(Style.FONT_6int_Yellow, Style.FONT_6int_Yellow - 50);
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                if (this._item._itemData.type == 4 && (this._item._itemData.subType == 11 || this._item._itemData.subType == 12 || this._item._itemData.subType == 13))
                {
                    if (this._item._itemData.finegrade > 0 && this._item._itemData.finegrade < 10)
                    {
                        setColorBorder(Style.FONT_1int_Blue, Style.FONT_1int_Blue - 50);
                    }
                    else if (this._item._itemData.finegrade >= 10 && this._item._itemData.finegrade < 20)
                    {
                        setColorBorder(Style.FONT_2int_Purple, Style.FONT_2int_Purple - 50);
                    }
                    else if (this._item._itemData.finegrade >= 20 && this._item._itemData.finegrade < 30)
                    {
                        setColorBorder(Style.FONT_3int_Orange, Style.FONT_3int_Orange - 50);
                    }
                    else if (this._item._itemData.finegrade >= 30 && this._item._itemData.finegrade < 40)
                    {
                        setColorBorder(Style.FONT_4int_Gold, Style.FONT_4int_Gold - 50);
                    }
                    else if (this._item._itemData.finegrade >= 40 && this._item._itemData.finegrade < 50)
                    {
                        setColorBorder(Style.FONT_5int_Green, Style.FONT_5int_Green - 50);
                    }
                    else if (this._item._itemData.finegrade >= 50 && this._item._itemData.finegrade < 60)
                    {
                        setColorBorder(15626495, 15626495 - 50);
                    }
                    else if (this._item._itemData.finegrade == 60)
                    {
                        setColorBorder(16711680, 16711680 - 50);
                    }
                }
                if (!this._BorderShow)
                {
                    setColorBorder(null);
                }
                if (this._item._itemData.suitID > 0)
                {
                    setColorBorder(Style.FONT_5int_Green, Style.FONT_5int_Green - 50);
                }
                if (_bg != null)
                {
                    _bg.visible = false;
                }
            }
            if (this._item != null)
            {
                this.skill = null;
                this.buttonMode = true;
                this._icon.bitmapData = this._item._iconBmpd;
                if (this._item.amount > 1)
                {
                    this._amountTxt.text = "" + this._item.amount;
                }
                else
                {
                    this._amountTxt.text = "";
                }
                if (param1._petObj.maxFlag)
                {
                    this._item.amount = "★";
                }
                if (this._item.numstr != "")
                {
                    this._amountTxt.text = this._item.numstr;
                    this._amountTxt.textColor = this._item.numstrcolor;
                }
                if (this.nameshow)
                {
                    this._namelabel.text = Config.language("CloneSlot", 1);
                    this._namelabel.x = (this._size - this._namelabel.width) / 2;
                    this.addChild(this._namelabel);
                    this.addEventListener(MouseEvent.CLICK, this.finditem);
                }
            }
            else
            {
                this.buttonMode = false;
                this._icon.bitmapData = null;
                this._amountTxt.text = "";
                this._namelabel.text = "";
                if (this._namelabel.parent != null)
                {
                    this.removeChild(this._namelabel);
                }
                setColorBorder(null);
                if (_bg != null)
                {
                    _bg.visible = true;
                }
            }
            return;
        }// end function

        public function set skillId(param1)
        {
            this.skill = Skill.getSkill(param1);
            return;
        }// end function

        public function set skill(param1:Skill)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            this._skill = param1;
            if (this._skill != null)
            {
                this.item = null;
                this._icon.bitmapData = this._skill.getDisplay().bitmapData;
            }
            else
            {
                this._icon.bitmapData = null;
            }
            if (this._skill != null)
            {
                this.buttonMode = true;
                _loc_3 = new Date();
                setCd(Math.max(0, Skill._cdStack[param1._skillData.id] - _loc_3.getTime()), Skill._cdMaxStack[param1._skillData.id]);
                if (_bg != null)
                {
                    _bg.visible = false;
                }
            }
            else
            {
                this.buttonMode = false;
                setCd(0);
                if (this.item == null)
                {
                    if (_bg != null)
                    {
                        _bg.visible = true;
                    }
                }
            }
            return;
        }// end function

        public function get skill()
        {
            return this._skill;
        }// end function

        private function handleItemDestroy(param1)
        {
            this.item = null;
            return;
        }// end function

        public function get nameshow() : Boolean
        {
            return this._nameshow;
        }// end function

        public function set nameshow(param1:Boolean) : void
        {
            this._nameshow = param1;
            return;
        }// end function

        public function get iconsp() : Sprite
        {
            return this._iconsp;
        }// end function

        private function finditem(param1) : void
        {
            trace(this._item._data.id);
            Config.ui._monsterIndexUI.searchItem(this._item._data.id);
            return;
        }// end function

        override public function lock()
        {
            super.lock();
            this.color = 10066329;
            return;
        }// end function

        override public function unlock()
        {
            super.unlock();
            this.color = null;
            return;
        }// end function

        public function set BorderShow(param1:Boolean) : void
        {
            this._BorderShow = param1;
            if (!param1)
            {
                setColorBorder(null);
            }
            return;
        }// end function

        public function figLevel(param1:String) : void
        {
            this._amountTxt.text = param1;
            return;
        }// end function

    }
}
