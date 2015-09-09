package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import lovefox.socket.*;
    import lovefox.unit.*;

    public class QQVipPanel extends Window
    {
        private var qqvipBtn:Sprite;
        private var qq8:Bitmap;
        private var qq9:Bitmap;
        private var qq10:Bitmap;
        private var vbtn:Bitmap;
        private var vybtn:Bitmap;
        private var awardObj:Object;

        public function QQVipPanel(param1:DisplayObjectContainer)
        {
            this.awardObj = {q3:0, q4:0, q5:0};
            super(param1);
            this.initpanel();
            this.initSocket();
            return;
        }// end function

        private function initSocket() : void
        {
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_QQ_VIPINFO, this.initQQInfo);
            return;
        }// end function

        private function initpanel() : void
        {
            var _loc_2:* = null;
            var _loc_5:* = null;
            var _loc_6:* = undefined;
            var _loc_7:* = 0;
            var _loc_9:* = null;
            var _loc_11:* = null;
            var _loc_13:* = undefined;
            var _loc_14:* = null;
            var _loc_15:* = null;
            var _loc_16:* = null;
            var _loc_17:* = null;
            var _loc_18:* = null;
            var _loc_19:* = null;
            var _loc_20:* = null;
            var _loc_21:* = null;
            var _loc_22:* = null;
            var _loc_23:* = null;
            this.title = Config.language("QQVipPanel", 1);
            resize(540, 450);
            var _loc_1:* = new Shape();
            _loc_1.graphics.beginFill(13545363);
            _loc_1.graphics.drawRoundRect(10, 28, 520, 40, 5);
            _loc_1.graphics.beginFill(14798782);
            _loc_1.graphics.drawRoundRect(10, 70, 320, 320, 2);
            _loc_1.graphics.drawRoundRect(335, 70, 195, 120, 2);
            _loc_1.graphics.drawRoundRect(335, 195, 195, 195, 2);
            _loc_1.graphics.endFill();
            this.addChild(_loc_1);
            _loc_2 = new Sprite();
            this.addChild(_loc_2);
            _loc_2.buttonMode = true;
            _loc_2.addEventListener(MouseEvent.CLICK, Config.create(this.openQQPay, 1));
            _loc_2.addEventListener(MouseEvent.ROLL_OVER, this.overQQBtn);
            _loc_2.addEventListener(MouseEvent.ROLL_OUT, this.outQQBtn);
            this.vbtn = new Bitmap();
            _loc_2.addChild(this.vbtn);
            _loc_2.x = 410;
            _loc_2.y = 30;
            var _loc_3:* = new Bitmap();
            this.addChild(_loc_3);
            _loc_3.bitmapData = Config.findsysUI("headui/qq5", 326, 16);
            _loc_3.x = 50;
            _loc_3.y = 40;
            var _loc_4:* = new Label(this, 20, 75, Config.language("QQVipPanel", 2));
            new Label(this, 20, 75, Config.language("QQVipPanel", 2)).html = true;
            _loc_5 = [];
            for (_loc_6 in Config._qqVipItem)
            {
                
                if (int(Config._qqVipItem[_loc_6].type) == 1)
                {
                    _loc_5.push(Config._qqVipItem[_loc_6]);
                }
            }
            _loc_5.sortOn("propId", Array.NUMERIC);
            _loc_7 = 0;
            while (_loc_7 < _loc_5.length)
            {
                
                _loc_20 = new Bitmap();
                this.addChild(_loc_20);
                _loc_20.bitmapData = Config.findsysUI("headui/h" + int((_loc_7 + 1)), 24, 17);
                _loc_20.x = 20;
                _loc_20.y = 35 * _loc_7 + 100;
                _loc_21 = new CloneSlot(4, 32);
                _loc_21.x = 60;
                _loc_21.y = 35 * _loc_7 + 100;
                _loc_21.addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
                _loc_21.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
                this.addChild(_loc_21);
                _loc_21.scaleX = 0.8;
                _loc_21.scaleY = 0.8;
                _loc_22 = Item.newItem(Config._itemMap[_loc_5[_loc_7].propId], 0, 0, UNIT_TYPE_ENUM.TYPEID_ITEMCLONE, 0);
                _loc_22.display();
                _loc_21.item = _loc_22;
                _loc_23 = new Label(this, 100, 35 * _loc_7 + 100, _loc_5[_loc_7].description);
                _loc_7 = _loc_7 + 1;
            }
            var _loc_8:* = new Label(this, 340, 75, Config.language("QQVipPanel", 3));
            new Label(this, 340, 75, Config.language("QQVipPanel", 3)).html = true;
            _loc_9 = new Bitmap();
            this.addChild(_loc_9);
            _loc_9.bitmapData = Config.findsysUI("headui/qq3", 128, 57);
            _loc_9.x = 360;
            _loc_9.y = 110;
            var _loc_10:* = new Label(this, 340, 200, Config.language("QQVipPanel", 4));
            new Label(this, 340, 200, Config.language("QQVipPanel", 4)).html = true;
            _loc_11 = new CloneSlot(4, 32);
            _loc_11.x = 410;
            _loc_11.y = 250;
            _loc_11.addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
            _loc_11.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
            this.addChild(_loc_11);
            _loc_11.scaleX = 1.5;
            _loc_11.scaleY = 1.5;
            var _loc_12:* = 98990;
            for (_loc_13 in Config._qqVipItem)
            {
                
                if (int(Config._qqVipItem[_loc_13].type) == 2)
                {
                    _loc_12 = int(Config._qqVipItem[_loc_13].propId);
                    break;
                }
            }
            _loc_14 = Item.newItem(Config._itemMap[_loc_12], 0, 0, UNIT_TYPE_ENUM.TYPEID_ITEMCLONE, 0);
            _loc_14.display();
            _loc_11.item = _loc_22;
            _loc_15 = new Sprite();
            this.addChild(_loc_15);
            _loc_15.buttonMode = true;
            _loc_15.addEventListener(MouseEvent.CLICK, Config.create(this.openQQPay, 2));
            _loc_15.addEventListener(MouseEvent.ROLL_OVER, this.overQQBtn);
            _loc_15.addEventListener(MouseEvent.ROLL_OUT, this.outQQBtn);
            this.vybtn = new Bitmap();
            _loc_15.addChild(this.vybtn);
            _loc_15.x = 360;
            _loc_15.y = 320;
            _loc_16 = new Sprite();
            this.addChild(_loc_16);
            _loc_16.buttonMode = true;
            _loc_16.addEventListener(MouseEvent.CLICK, Config.create(this.openQQPay, 3));
            _loc_16.addEventListener(MouseEvent.ROLL_OVER, this.overQQBtn);
            _loc_16.addEventListener(MouseEvent.ROLL_OUT, this.outQQBtn);
            this.qq8 = new Bitmap();
            _loc_16.addChild(this.qq8);
            _loc_16.x = 30;
            _loc_16.y = 400;
            _loc_17 = new Sprite();
            this.addChild(_loc_17);
            _loc_17.buttonMode = true;
            _loc_17.addEventListener(MouseEvent.CLICK, Config.create(this.openQQPay, 4));
            _loc_17.addEventListener(MouseEvent.ROLL_OVER, this.overQQBtn);
            _loc_17.addEventListener(MouseEvent.ROLL_OUT, this.outQQBtn);
            this.qq9 = new Bitmap();
            _loc_17.addChild(this.qq9);
            _loc_17.x = 210;
            _loc_17.y = 400;
            _loc_18 = new Sprite();
            this.addChild(_loc_18);
            _loc_18.buttonMode = true;
            _loc_18.addEventListener(MouseEvent.CLICK, Config.create(this.openQQPay, 5));
            _loc_18.addEventListener(MouseEvent.ROLL_OVER, this.overQQBtn);
            _loc_18.addEventListener(MouseEvent.ROLL_OUT, this.outQQBtn);
            this.qq10 = new Bitmap();
            _loc_18.addChild(this.qq10);
            _loc_18.x = 360;
            _loc_18.y = 400;
            this.qqvipBtn = new Sprite();
            this.qqvipBtn.buttonMode = true;
            this.qqvipBtn.addEventListener(MouseEvent.CLICK, Config.create(this.openQQPay, 6));
            this.qqvipBtn.addEventListener(MouseEvent.ROLL_OVER, this.overQQBtn);
            this.qqvipBtn.addEventListener(MouseEvent.ROLL_OUT, this.outQQBtn);
            _loc_19 = new Bitmap();
            this.qqvipBtn.addChild(_loc_19);
            _loc_19.bitmapData = Config.findsysUI("headui/qq14", 61, 54);
            this.qqvipBtn.mouseEnabled = true;
            if (Config._lanVersion == LanVersion.QQ_ZH_CN)
            {
                Config.ui._radar.addChild(this.qqvipBtn);
            }
            this.reSetXY();
            return;
        }// end function

        public function reSetXY(param1:Boolean = false) : void
        {
            if (param1)
            {
                this.qqvipBtn.x = -350;
                this.qqvipBtn.y = 40;
            }
            else
            {
                this.qqvipBtn.x = -285;
                this.qqvipBtn.y = 40;
            }
            return;
        }// end function

        private function overQQBtn(event:Event) : void
        {
            event.target.filters = [Style.GREENLIGHT];
            return;
        }// end function

        private function outQQBtn(event:Event) : void
        {
            event.target.filters = [];
            return;
        }// end function

        public function openQQPay(event:MouseEvent = null, param2:int = 1) : void
        {
            var _loc_3:* = null;
            switch(param2)
            {
                case 1:
                {
                    Config.ui._shopmail.openvipPay();
                    break;
                }
                case 2:
                {
                    Config.ui._shopmail.openVipYear();
                    break;
                }
                case 3:
                {
                    _loc_3 = new DataSet();
                    _loc_3.addHead(CONST_ENUM.C2G_QQ_GIFT);
                    _loc_3.add8(1);
                    ClientSocket.send(_loc_3);
                    break;
                }
                case 4:
                {
                    _loc_3 = new DataSet();
                    _loc_3.addHead(CONST_ENUM.C2G_QQ_GIFT);
                    _loc_3.add8(2);
                    ClientSocket.send(_loc_3);
                    break;
                }
                case 5:
                {
                    _loc_3 = new DataSet();
                    _loc_3.addHead(CONST_ENUM.C2G_QQ_GIFT);
                    _loc_3.add8(3);
                    ClientSocket.send(_loc_3);
                    break;
                }
                case 6:
                {
                    this.switchOpen();
                    break;
                }
                default:
                {
                    break;
                }
            }
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

        public function initVipItem(param1:int, param2:int) : void
        {
            switch(param1)
            {
                case 3:
                {
                    if (Config._QQInfo.is_yellow_vip && param2 == 0)
                    {
                        this.qq8.bitmapData = Config.findsysUI("headui/qq8", 144, 28);
                        this.qq8.parent.mouseEnabled = true;
                    }
                    else
                    {
                        this.qq8.bitmapData = Config.findsysUI("headui/qq11", 144, 28);
                        this.qq8.parent.mouseEnabled = false;
                    }
                    this.awardObj.q3 = param2;
                    break;
                }
                case 4:
                {
                    if (Config._QQInfo.is_yellow_vip && param2 == 0)
                    {
                        this.qq9.bitmapData = Config.findsysUI("headui/qq9", 119, 28);
                        this.qq9.parent.mouseEnabled = true;
                    }
                    else
                    {
                        this.qq9.bitmapData = Config.findsysUI("headui/qq12", 119, 28);
                        this.qq9.parent.mouseEnabled = false;
                    }
                    this.awardObj.q4 = param2;
                    break;
                }
                case 5:
                {
                    if (Config._QQInfo.is_yellow_year_vip && param2 == 0)
                    {
                        this.qq10.bitmapData = Config.findsysUI("headui/qq10", 119, 28);
                        this.qq10.parent.mouseEnabled = true;
                    }
                    else
                    {
                        this.qq10.bitmapData = Config.findsysUI("headui/qq13", 119, 28);
                        this.qq10.parent.mouseEnabled = false;
                    }
                    this.awardObj.q5 = param2;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function initQQInfo(event:SocketEvent) : void
        {
            Config._QQInfo.is_yellow_vip = Boolean(event.data.readByte());
            Config._QQInfo.yellow_level = event.data.readByte();
            Config._QQInfo.is_yellow_year_vip = Boolean(event.data.readByte());
            Config._QQInfo.yellow_top = Boolean(event.data.readByte());
            this.setQQyellow();
            Config.ui._shopmail.setYeVip();
            Config.ui._bagUI.setYeVip();
            return;
        }// end function

        private function setQQyellow() : void
        {
            if (Config._QQInfo.is_yellow_vip)
            {
                this.vbtn.bitmapData = Config.findsysUI("headui/qq1", 110, 34);
            }
            else
            {
                this.vbtn.bitmapData = Config.findsysUI("headui/qq2", 114, 34);
            }
            if (Config._QQInfo.is_yellow_year_vip)
            {
                this.vybtn.bitmapData = Config.findsysUI("headui/qq7", 136, 32);
            }
            else
            {
                this.vybtn.bitmapData = Config.findsysUI("headui/qq6", 136, 32);
            }
            this.initVipItem(3, this.awardObj.q3);
            this.initVipItem(4, this.awardObj.q4);
            this.initVipItem(5, this.awardObj.q5);
            return;
        }// end function

    }
}
