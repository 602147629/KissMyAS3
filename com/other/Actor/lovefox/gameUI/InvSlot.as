package lovefox.gameUI
{
    import flash.text.*;
    import lovefox.unit.*;

    public class InvSlot extends Slot
    {
        public var _item:Item;
        private var _amountTxt:TextField;

        public function InvSlot(param1, param2 = 32)
        {
            super(param1, param2);
            this.init();
            return;
        }// end function

        override public function init()
        {
            super.init();
            this._amountTxt = Config.getSimpleTextField();
            this._amountTxt.autoSize = TextFieldAutoSize.RIGHT;
            this._amountTxt.textColor = 16777215;
            this._amountTxt.y = _size - 16;
            this._amountTxt.x = _size - 5;
            this._amountTxt.filters = [new GlowFilter(0, 1, 3, 3, 10)];
            addChild(this._amountTxt);
            return;
        }// end function

        override public function lock()
        {
            super.lock();
            this.color = 10066329;
            this.dispatchEvent(new Event("lockchange"));
            return;
        }// end function

        override public function unlock()
        {
            super.unlock();
            this.color = null;
            this.dispatchEvent(new Event("lockchange"));
            return;
        }// end function

        public function set item(param1)
        {
            var _loc_2:* = this._item;
            if (this._item != null)
            {
                this._item.removeEventListener("destroy", this.handleItemDestroy);
            }
            this._item = param1;
            if (this._item != null)
            {
                this._item.addEventListener("destroy", this.handleItemDestroy);
            }
            if (this._item != null)
            {
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
                if (this._item._itemData.suitID > 0)
                {
                    setColorBorder(Style.FONT_5int_Green, Style.FONT_5int_Green - 50);
                }
                this.buttonMode = true;
                if (_bg != null)
                {
                    _bg.visible = false;
                }
                this._item._position = _id;
                if (this._item.cd > 0)
                {
                    setCd(this._item.cd, Item._cdMaxStack[Number(this._item._itemData.relatedId)]);
                }
                if (this._item._icon.parent != null)
                {
                    this._item._icon.parent.removeChild(this._item._icon);
                }
                _container.addChild(this._item._icon);
                if (this.item._petObj.maxFlag)
                {
                    this._item.amount = "★";
                }
            }
            else
            {
                setColorBorder(null);
                this.buttonMode = false;
                this._amountTxt.text = "";
                if (_bg != null)
                {
                    _bg.visible = true;
                }
                if (_loc_2 != null)
                {
                    if (_loc_2._icon.parent == this)
                    {
                        _container.removeChild(_loc_2._icon);
                    }
                }
                setCd(0);
                pdUpFlag = false;
            }
            this.dispatchEvent(new Event(Event.CHANGE));
            return;
        }// end function

        private function handleItemDestroy(param1)
        {
            this.item = null;
            this.unlock();
            return;
        }// end function

        public function get item()
        {
            return this._item;
        }// end function

    }
}
