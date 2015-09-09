package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import lovefox.unit.*;

    public class ShopBuy extends Window
    {
        private var itemicon:CloneSlot;
        private var itemname:Label;
        private var itemprice:Label;
        private var allprice:Label;
        private var numinput:InputText;
        private var itemobj:Object;
        private var centerButton:PushButton;
        private var cancelButton:PushButton;
        private var QQprice:Label;
        private var qq4:Bitmap;
        private var _pnumbtn:NumericStepper;
        private var _vipprice:Boolean = false;

        public function ShopBuy(param1)
        {
            super(param1);
            resize(300, 220);
            this.initpanel();
            return;
        }// end function

        private function initpanel() : void
        {
            this.title = Config.language("ShopBuy", 1);
            this.itemicon = new CloneSlot(0, 30);
            this.addChild(this.itemicon);
            this.itemicon.x = 20;
            this.itemicon.y = 50;
            this.itemicon.addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
            this.itemicon.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
            this.itemname = new Label(this, 70, 50);
            this.itemprice = new Label(this, 70, 80);
            this._pnumbtn = new NumericStepper(this, 75, 110);
            this._pnumbtn.width = 120;
            this._pnumbtn.maximum = 999;
            this._pnumbtn.addEventListener(Event.CHANGE, this.checknum);
            this.allprice = new Label(this, 75, 140);
            this.centerButton = new PushButton(this, 110, 170, Config.language("ShopBuy", 2), this.create(this.itembuy, 1));
            this.centerButton.width = 60;
            this.QQprice = new Label(null, 75, 170);
            this.QQprice.textColor = 11344686;
            this.qq4 = new Bitmap();
            this.qq4.bitmapData = Config.findsysUI("headui/qq4", 22, 17);
            this.qq4.x = 50;
            this.qq4.y = 168;
            return;
        }// end function

        public function initdata(param1:Object, param2:Boolean = false) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            if (this.itemicon.item != null)
            {
                this.itemicon.item.destroy();
            }
            if (param2)
            {
                this._vipprice = true;
            }
            else
            {
                this._vipprice = false;
            }
            this.itemobj = param1;
            this.itemname.text = this.itemobj.item._itemData.name;
            trace(this.itemobj.item.amount);
            var _loc_3:* = Item.newItem(Config._itemMap[this.itemobj.id], 0, 0, UNIT_TYPE_ENUM.TYPEID_ITEMCLONE, 0);
            if (Config._itemMap[this.itemobj.id].type == 4 && Config._itemMap[this.itemobj.id].subType < 10)
            {
                if (int(Config._itemMap[this.itemobj.id].relatedId) > 0)
                {
                    _loc_4 = int(Config._itemMap[this.itemobj.id].relatedId).toString(2);
                    _loc_4 = "000000" + _loc_4;
                    _loc_4 = ("000000" + _loc_4).substring(_loc_4.length - 6, _loc_4.length);
                    _loc_5 = 0;
                    while (_loc_5 < 3)
                    {
                        
                        _loc_6 = new Object();
                        _loc_6.open = true;
                        _loc_6.id = 0;
                        _loc_6.type = parseInt(_loc_4.substr(_loc_5 * 2, 2), 2);
                        _loc_3._itemData.gem.push(_loc_6);
                        _loc_5 = _loc_5 + 1;
                    }
                }
            }
            _loc_3.display();
            this.itemicon.item = _loc_3;
            trace(Config.ui._shopmail.viprice);
            this.itemprice.text = Config.language("ShopBuy", 3) + this.coinname(this.itemobj.moneyflag) + ":" + Config.coinShow(int(this.vipprice / 100 * this.itemobj.goldcoin));
            this.allprice.text = Config.language("ShopBuy", 4) + this.coinname(this.itemobj.moneyflag) + ":" + Config.coinShow(int(this.vipprice / 100 * this.itemobj.goldcoin));
            this._pnumbtn.value = 1;
            if (Config._lanVersion == LanVersion.QQ_ZH_CN && this.itemobj.moneyflag == 1)
            {
                this.centerButton.y = 200;
                resize(300, 250);
                this.addChild(this.QQprice);
                this.addChild(this.qq4);
                this.QQprice.text = Config.language("ShopBuy", 22) + ":" + Config.coinShow(int(this.itemobj.goldcoin * 0.8)) + this.coinname(this.itemobj.moneyflag);
            }
            else
            {
                resize(300, 220);
                this.centerButton.y = 170;
                if (this.QQprice.parent != null)
                {
                    this.QQprice.parent.removeChild(this.QQprice);
                }
                if (this.qq4.parent != null)
                {
                    this.qq4.parent.removeChild(this.qq4);
                }
            }
            return;
        }// end function

        override public function open(event:MouseEvent = null)
        {
            super.open(event);
            return;
        }// end function

        private function changetext(param1) : void
        {
            this.allprice.text = Config.language("ShopBuy", 4) + this.coinname(this.itemobj.moneyflag) + ":" + Config.coinShow(int(this.vipprice / 100 * this.itemobj.goldcoin) * int(this._pnumbtn.value));
            if (Config._lanVersion == LanVersion.QQ_ZH_CN && this.itemobj.moneyflag == 1)
            {
                this.QQprice.text = Config.language("ShopBuy", 22) + ":" + Config.coinShow(Math.round(this.itemobj.goldcoin * int(this._pnumbtn.value) * 0.8)) + this.coinname(this.itemobj.moneyflag);
            }
            return;
        }// end function

        private function itembuy(event:MouseEvent, param2:int) : void
        {
            var _loc_3:* = true;
            switch(int(this.itemobj.moneyflag))
            {
                case 1:
                {
                    if (Config.player.money1 >= int(this.vipprice / 100 * this.itemobj.goldcoin) * int(this._pnumbtn.value))
                    {
                        Config.ui._shopmail.sendbuy(this.itemobj.id, int(this._pnumbtn.value), this.itemobj.viptype);
                        this.close();
                        _loc_3 = false;
                    }
                    break;
                }
                case 2:
                {
                    Config.ui._shopmail.sendbuygift(this.itemobj.id, int(this._pnumbtn.value));
                    this.close();
                    _loc_3 = false;
                    break;
                }
                case 3:
                {
                    if (Config.player.money3 >= this.itemobj.goldcoin * int(this._pnumbtn.value))
                    {
                        Config.ui._shopUI.sendbuy(this.itemobj.item._itemData.id, int(this._pnumbtn.value));
                        this.close();
                        _loc_3 = false;
                    }
                    break;
                }
                case 4:
                {
                    if (Config.player.money4 >= this.itemobj.goldcoin * int(this._pnumbtn.value))
                    {
                        Config.ui._shopUI.sendbuy(this.itemobj.item._itemData.id, int(this._pnumbtn.value));
                        this.close();
                        _loc_3 = false;
                    }
                    break;
                }
                case 5:
                case 10:
                {
                    Config.ui._shopUI.sendbuy(this.itemobj.item._itemData.id, int(this._pnumbtn.value));
                    this.close();
                    _loc_3 = false;
                    break;
                }
                case 6:
                {
                    Config.ui._blackmarket.sendsalebuy(this.itemobj.saleId, int(this._pnumbtn.value));
                    this.close();
                    _loc_3 = false;
                    break;
                }
                case 7:
                {
                    Config.ui._blackmarket.sendbuy(this.itemobj.item._itemData.id, int(this._pnumbtn.value));
                    this.close();
                    _loc_3 = false;
                    break;
                }
                case 12:
                {
                    Config.ui._shopUI.sendbuygilditem(this.itemobj.item._itemData.id, int(this._pnumbtn.value));
                    this.close();
                    _loc_3 = false;
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (_loc_3)
            {
                Config.message(this.coinname(this.itemobj.moneyflag) + Config.language("ShopBuy", 5));
            }
            return;
        }// end function

        private function create(param1:Function, ... args) : Function
        {
            args = new activation;
            var F:Boolean;
            var f:* = param1;
            var arg:* = args;
            F;
            var _f:* = function (param1) : void
            {
                var _loc_2:* = arg;
                if (!F)
                {
                    F = true;
                    _loc_2.unshift(param1);
                }
                f.apply(null, _loc_2);
                return;
            }// end function
            ;
            return ;
        }// end function

        private function handleSlotOver(param1)
        {
            var _loc_3:* = null;
            var _loc_2:* = param1.currentTarget;
            if (_loc_2.item != null)
            {
                _loc_3 = _loc_2.parent.localToGlobal(new Point(_loc_2.x, _loc_2.y));
                Holder.showInfo(_loc_2.item.outputInfo(), new Rectangle(_loc_3.x, _loc_3.y, _loc_2._size, _loc_2._size));
            }
            return;
        }// end function

        private function handleSlotOut(param1)
        {
            Holder.closeInfo();
            return;
        }// end function

        private function coinname(param1:int) : String
        {
            var _loc_2:* = null;
            switch(param1)
            {
                case 1:
                {
                    if (Config._lanVersion == LanVersion.QQ_ZH_CN)
                    {
                        _loc_2 = Config.language("ShopBuy", 23);
                    }
                    else
                    {
                        _loc_2 = Config.language("ShopBuy", 6);
                    }
                    break;
                }
                case 2:
                {
                    _loc_2 = Config.language("ShopBuy", 7);
                    break;
                }
                case 3:
                {
                    _loc_2 = Config.language("ShopBuy", 8);
                    break;
                }
                case 5:
                {
                    _loc_2 = Config.language("ShopBuy", 9);
                    break;
                }
                case 4:
                case 6:
                case 7:
                {
                    _loc_2 = Config.language("ShopBuy", 10);
                    break;
                }
                case 10:
                {
                    _loc_2 = Config.language("ShopBuy", 11);
                    break;
                }
                case 12:
                {
                    _loc_2 = Config.language("ShopBuy", 21);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_2;
        }// end function

        private function checknum(event:Event = null) : void
        {
            if (int(this._pnumbtn.value) > 999)
            {
                this._pnumbtn.value = 999;
            }
            this.allprice.text = Config.language("ShopBuy", 4) + this.coinname(this.itemobj.moneyflag) + ":" + Config.coinShow(int(this.vipprice / 100 * this.itemobj.goldcoin) * int(this._pnumbtn.value));
            switch(int(this.itemobj.moneyflag))
            {
                case 1:
                {
                    if (Config.player.money1 < int(this.vipprice / 100 * this.itemobj.goldcoin) * int(this._pnumbtn.value))
                    {
                        this._pnumbtn.value = Math.max(int(Config.player.money1 / int(this.vipprice / 100 * this.itemobj.goldcoin)), 1);
                        this.allprice.text = Config.language("ShopBuy", 4) + this.coinname(this.itemobj.moneyflag) + ":" + Config.coinShow(int(this.vipprice / 100 * this.itemobj.goldcoin) * int(this._pnumbtn.value));
                        Config.message(Config.language("ShopBuy", 12));
                        if (Config._lanVersion == LanVersion.QQ_ZH_CN)
                        {
                            this.QQprice.text = Config.language("ShopBuy", 22) + ":" + Config.coinShow(Math.round(this.itemobj.goldcoin * int(this._pnumbtn.value) * 0.8)) + this.coinname(this.itemobj.moneyflag);
                        }
                    }
                    break;
                }
                case 2:
                {
                    if (Config.player.money2 < this.itemobj.goldcoin * int(this._pnumbtn.value))
                    {
                        this._pnumbtn.value = Math.max(int(Config.player.money2 / this.itemobj.goldcoin), 1);
                        this.allprice.text = Config.language("ShopBuy", 4) + this.coinname(this.itemobj.moneyflag) + ":" + Config.coinShow(this.itemobj.goldcoin * int(this._pnumbtn.value));
                        Config.message(Config.language("ShopBuy", 13));
                    }
                    break;
                }
                case 3:
                {
                    if (Config.player.money3 < this.itemobj.goldcoin * int(this._pnumbtn.value))
                    {
                        this._pnumbtn.value = Math.max(int(Config.player.money3 / this.itemobj.goldcoin), 1);
                        this.allprice.text = Config.language("ShopBuy", 4) + this.coinname(this.itemobj.moneyflag) + ":" + Config.coinShow(this.itemobj.goldcoin * int(this._pnumbtn.value));
                        Config.message(Config.language("ShopBuy", 14));
                    }
                    break;
                }
                case 5:
                {
                    if (Config.player.instanceSore < this.itemobj.goldcoin * int(this._pnumbtn.value))
                    {
                        this._pnumbtn.value = Math.max(int(Config.player.instanceSore / this.itemobj.goldcoin), 1);
                        this.allprice.text = Config.language("ShopBuy", 4) + this.coinname(this.itemobj.moneyflag) + ":" + Config.coinShow(this.itemobj.goldcoin * int(this._pnumbtn.value));
                        Config.message(Config.language("ShopBuy", 15));
                    }
                    break;
                }
                case 4:
                case 7:
                {
                    if (Config.player.money4 < this.itemobj.goldcoin * int(this._pnumbtn.value))
                    {
                        this._pnumbtn.value = Math.max(int(Config.player.money4 / this.itemobj.goldcoin), 1);
                        this.allprice.text = Config.language("ShopBuy", 4) + this.coinname(this.itemobj.moneyflag) + ":" + Config.coinShow(this.itemobj.goldcoin * int(this._pnumbtn.value));
                        Config.message(Config.language("ShopBuy", 16));
                    }
                    break;
                }
                case 6:
                {
                    if (Config.player.money4 < this.itemobj.goldcoin * int(this._pnumbtn.value))
                    {
                        this._pnumbtn.value = Math.max(int(Config.player.money4 / this.itemobj.goldcoin), 1);
                        this.allprice.text = Config.language("ShopBuy", 4) + this.coinname(this.itemobj.moneyflag) + ":" + Config.coinShow(this.itemobj.goldcoin * int(this._pnumbtn.value));
                        Config.message(Config.language("ShopBuy", 16));
                    }
                    if (int(this._pnumbtn.value) > this.itemobj.item.amount)
                    {
                        this._pnumbtn.value = this.itemobj.item.amount;
                        this.allprice.text = Config.language("ShopBuy", 4) + this.coinname(this.itemobj.moneyflag) + ":" + Config.coinShow(this.itemobj.goldcoin * int(this._pnumbtn.value));
                        Config.message(Config.language("ShopBuy", 17));
                    }
                    break;
                }
                case 10:
                {
                    if (Config.player.honor < this.itemobj.goldcoin * int(this._pnumbtn.value))
                    {
                        this._pnumbtn.value = Math.max(int(Config.player.honor / this.itemobj.goldcoin), 1);
                        this.allprice.text = Config.language("ShopBuy", 4) + this.coinname(this.itemobj.moneyflag) + ":" + Config.coinShow(this.itemobj.goldcoin * int(this._pnumbtn.value));
                        Config.message(Config.language("ShopBuy", 18));
                    }
                    break;
                }
                case 12:
                {
                    if (int(this._pnumbtn.value) > this.itemobj.todaymax)
                    {
                        this._pnumbtn.value = this.itemobj.todaymax;
                        this.allprice.text = Config.language("ShopBuy", 4) + this.coinname(this.itemobj.moneyflag) + ":" + Config.coinShow(this.itemobj.goldcoin * int(this._pnumbtn.value));
                        Config.message(Config.language("ShopBuy", 20));
                    }
                    if (Config.player.gildCoin < this.itemobj.goldcoin * int(this._pnumbtn.value))
                    {
                        this._pnumbtn.value = Math.max(int(Config.player.gildCoin / this.itemobj.goldcoin), 1);
                        this.allprice.text = Config.language("ShopBuy", 4) + this.coinname(this.itemobj.moneyflag) + ":" + Config.coinShow(this.itemobj.goldcoin * int(this._pnumbtn.value));
                        Config.message(Config.language("ShopBuy", 19));
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function get vipprice() : int
        {
            if (this._vipprice && Config.ui._shopmail.vipLv != 0)
            {
                return Config.ui._shopmail.viprice;
            }
            return 100;
        }// end function

    }
}
