package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import lovefox.component.*;
    import lovefox.socket.*;
    import lovefox.unit.*;

    public class ActivPrize extends Window
    {
        private var panel:Sprite;
        private var topTxt:Label;
        private var startTxt:Label;
        private var prizeTxt:Label;
        private var pointTxt:Label;
        private var ReceivTxt:Label;
        private var arr:Array;
        public var oldplayer:Boolean = false;

        public function ActivPrize(param1:DisplayObjectContainer = null, param2:Number = 0, param3:Number = 0)
        {
            super(param1, param2, param3);
            resize(400, 350);
            this.initsocket();
            this.init();
            return;
        }// end function

        private function initsocket()
        {
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_MONEYGIFTCFG_LIST, this.activelist);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_MONEYGIFT_QUERY, this.activequeck);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_OLDUSER_BONUS, this.prizeItem);
            return;
        }// end function

        private function init()
        {
            this.title = Config.language("ActivPrize", 1);
            this.panel = new Sprite();
            this.addChild(this.panel);
            this.activelistopen();
            return;
        }// end function

        private function activelist(param1)
        {
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_2:* = param1.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            this.removeallchild(this.panel);
            this.arr = new Array();
            var _loc_4:* = new CanvasUI(this.panel, 10, 170, 375, 175);
            var _loc_5:* = 0;
            while (_loc_5 < _loc_3)
            {
                
                _loc_6 = new Object();
                _loc_6.actId = _loc_2.readUnsignedInt();
                _loc_7 = _loc_2.readUnsignedShort();
                _loc_6.startTime = _loc_2.readUTFBytes(_loc_7);
                _loc_8 = _loc_2.readUnsignedShort();
                _loc_6.endTime = _loc_2.readUTFBytes(_loc_8);
                _loc_9 = _loc_2.readUnsignedShort();
                _loc_6.expireTime = _loc_2.readUTFBytes(_loc_9);
                _loc_6.needMoney = _loc_2.readUnsignedInt();
                _loc_6.itemId = _loc_2.readUnsignedInt();
                _loc_6.itemCount = _loc_2.readUnsignedInt();
                _loc_6.itemIdF = _loc_2.readUnsignedInt();
                _loc_6.itemCountF = _loc_2.readUnsignedInt();
                _loc_6.status = _loc_2.readByte();
                _loc_10 = _loc_2.readUnsignedShort();
                _loc_6.name = _loc_2.readUTFBytes(_loc_10);
                this.arr.push(_loc_6);
                _loc_5 = _loc_5 + 1;
            }
            return;
        }// end function

        public function getactiveId() : Array
        {
            var _loc_4:* = undefined;
            var _loc_5:* = null;
            var _loc_6:* = false;
            var _loc_7:* = 0;
            if (this.arr == null)
            {
                return [];
            }
            trace(this.arr.length);
            var _loc_1:* = new Array();
            var _loc_2:* = new Array();
            var _loc_3:* = 0;
            while (_loc_3 < this.arr.length)
            {
                
                _loc_4 = String(this.arr[_loc_3].actId).substring(0, String(this.arr[_loc_3].actId).length - 2);
                _loc_5 = this.arr[_loc_3].name;
                if (_loc_1.length == 0)
                {
                    _loc_1.push(_loc_4);
                    _loc_2.push({_name:_loc_5, _id:_loc_4});
                }
                else
                {
                    _loc_6 = false;
                    _loc_7 = 0;
                    while (_loc_7 < _loc_1.length)
                    {
                        
                        if (_loc_4 == _loc_1[_loc_7])
                        {
                            _loc_6 = true;
                            break;
                        }
                        _loc_7 = _loc_7 + 1;
                    }
                    if (!_loc_6)
                    {
                        _loc_1.push(_loc_4);
                        _loc_2.push({_name:this.arr[_loc_3].name, _id:_loc_4});
                    }
                }
                _loc_3 = _loc_3 + 1;
            }
            return _loc_2;
        }// end function

        private function activelistopen()
        {
            var _loc_1:* = new Shape();
            _loc_1.graphics.lineStyle(1, 7689037);
            _loc_1.graphics.moveTo(10, 130);
            _loc_1.graphics.lineTo(390, 130);
            this.panel.addChild(_loc_1);
            this.topTxt = new Label(null, 15, 28);
            this.topTxt.html = true;
            this.startTxt = new Label(null, 15, 48);
            this.startTxt.html = true;
            this.prizeTxt = new Label(null, 15, 68);
            this.prizeTxt.html = true;
            this.pointTxt = new Label(null, 15, 140);
            this.pointTxt.html = true;
            return;
        }// end function

        private function getgift(event:MouseEvent, param2:uint)
        {
            var _loc_3:* = event.currentTarget;
            _loc_3.enabled = false;
            _loc_3.label = Config.language("ActivPrize", 2);
            var _loc_4:* = new DataSet();
            new DataSet().addHead(CONST_ENUM.C2G_MONEYGIFT_GET);
            _loc_4.add32(param2);
            ClientSocket.send(_loc_4);
            return;
        }// end function

        private function activequeck(event:SocketEvent)
        {
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = 0;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = null;
            var _loc_16:* = undefined;
            var _loc_17:* = undefined;
            var _loc_2:* = false;
            var _loc_3:* = event.data;
            var _loc_4:* = _loc_3.readUnsignedInt();
            var _loc_5:* = _loc_3.readUnsignedInt();
            var _loc_6:* = new Array();
            this.removeallchild(this.panel);
            var _loc_7:* = new CanvasUI(this.panel, 10, 170, 375, 175);
            var _loc_8:* = 0;
            while (_loc_8 < _loc_5)
            {
                
                _loc_10 = new Object();
                _loc_10.actId = _loc_3.readUnsignedInt();
                _loc_10.getflag = _loc_3.readByte();
                _loc_6.push(_loc_10);
                _loc_8 = _loc_8 + 1;
            }
            _loc_6.sortOn("actId", Array.NUMERIC);
            var _loc_9:* = 0;
            while (_loc_9 < _loc_6.length)
            {
                
                _loc_11 = new Sprite();
                _loc_11.graphics.beginFill(16777215, 0.5);
                _loc_11.graphics.drawRoundRect(10, 0, 355, 30, 5);
                _loc_11.y = _loc_9 * 35;
                _loc_12 = 0;
                while (_loc_12 < this.arr.length)
                {
                    
                    if (this.arr[_loc_12].actId == _loc_6[_loc_9].actId)
                    {
                        break;
                    }
                    _loc_12 = _loc_12 + 1;
                }
                if (Config.player.sex == 1)
                {
                    _loc_14 = new Item(Config._itemMap[this.arr[_loc_12].itemId], 0, 0, UNIT_TYPE_ENUM.TYPEID_ITEMCLONE, 0);
                    _loc_13 = _loc_14.outputInfo();
                }
                else
                {
                    _loc_14 = new Item(Config._itemMap[this.arr[_loc_12].itemIdF], 0, 0, UNIT_TYPE_ENUM.TYPEID_ITEMCLONE, 0);
                    _loc_13 = _loc_14.outputInfo();
                }
                _loc_11.addEventListener(MouseEvent.ROLL_OVER, Config.create(this.handleActiveOver, _loc_13));
                _loc_11.addEventListener(MouseEvent.ROLL_OUT, this.handleActiveOut);
                this.ReceivTxt = new Label(_loc_11, 15, 8);
                this.ReceivTxt.html = true;
                if (Config.player.sex == 1)
                {
                    if (Config._lanVersion == LanVersion.QQ_ZH_CN)
                    {
                        this.ReceivTxt.text = Config.language("ActivPrize", 17, Style.FONT_3_Orange, this.arr[_loc_12].needMoney, Style.FONT_3_Orange, Config._itemMap[this.arr[_loc_12].itemId].name, this.arr[_loc_12].itemCount);
                    }
                    else
                    {
                        this.ReceivTxt.text = Config.language("ActivPrize", 3, Style.FONT_3_Orange, this.arr[_loc_12].needMoney, Style.FONT_3_Orange, Config._itemMap[this.arr[_loc_12].itemId].name, this.arr[_loc_12].itemCount);
                    }
                }
                else if (Config._lanVersion == LanVersion.QQ_ZH_CN)
                {
                    this.ReceivTxt.text = Config.language("ActivPrize", 17, Style.FONT_3_Orange, this.arr[_loc_12].needMoney, Style.FONT_3_Orange, Config._itemMap[this.arr[_loc_12].itemIdF].name, this.arr[_loc_12].itemCountF);
                }
                else
                {
                    this.ReceivTxt.text = Config.language("ActivPrize", 3, Style.FONT_3_Orange, this.arr[_loc_12].needMoney, Style.FONT_3_Orange, Config._itemMap[this.arr[_loc_12].itemIdF].name, this.arr[_loc_12].itemCountF);
                }
                trace(this.arr[_loc_12].itemCountF);
                if (_loc_6[_loc_9].getflag == 0)
                {
                    _loc_15 = new PushButton(_loc_11, 300, 5, Config.language("ActivPrize", 6), Config.create(this.getgift, _loc_6[_loc_9].actId));
                    _loc_15.enabled = true;
                }
                else if (_loc_6[_loc_9].getflag == 1)
                {
                    _loc_15 = new PushButton(_loc_11, 300, 5, Config.language("ActivPrize", 7));
                    _loc_15.enabled = false;
                }
                else if (_loc_6[_loc_9].getflag == 2)
                {
                    _loc_15 = new PushButton(_loc_11, 300, 5, Config.language("ActivPrize", 8));
                    _loc_15.enabled = false;
                }
                else if (_loc_6[_loc_9].getflag == 3)
                {
                    _loc_15 = new PushButton(_loc_11, 300, 5, Config.language("ActivPrize", 9));
                    _loc_15.enabled = false;
                }
                _loc_15.width = 60;
                _loc_7.addChildUI(_loc_11);
                if (!_loc_2)
                {
                    _loc_2 = true;
                    this.panel.addChild(this.topTxt);
                    this.panel.addChild(this.startTxt);
                    this.panel.addChild(this.prizeTxt);
                    this.panel.addChild(this.pointTxt);
                    _loc_16 = String(this.arr[_loc_12].actId).substr(String(this.arr[_loc_12].actId).length - 2, 1);
                    trace(this.arr[_loc_12].actId, _loc_16);
                    if (parseInt(_loc_16) == 1)
                    {
                        _loc_17 = Config.language("ActivPrize", 10);
                    }
                    else
                    {
                        _loc_17 = Config.language("ActivPrize", 11);
                    }
                    this.topTxt.text = Config.language("ActivPrize", 12, Style.FONT_3_Orange, _loc_17);
                    this.startTxt.text = Config.language("ActivPrize", 14, "<font color=\'" + Style.FONT_3_Orange + "\'>" + this.arr[_loc_12].startTime + " - " + this.arr[_loc_12].endTime + "</font>");
                    this.prizeTxt.text = Config.language("ActivPrize", 15, "<font color=\'" + Style.FONT_3_Orange + "\'>" + this.arr[_loc_12].startTime + " - " + this.arr[_loc_12].expireTime + "</font>");
                    this.pointTxt.text = Config.language("ActivPrize", 16, Style.FONT_3_Orange, _loc_17, _loc_4);
                }
                _loc_9 = _loc_9 + 1;
            }
            if (_loc_2)
            {
                open();
            }
            return;
        }// end function

        private function handleActiveOver(param1, param2:String)
        {
            Holder.showInfo(param2, new Rectangle(Config.stage.mouseX, Config.stage.mouseY + 10), false, 1, 200);
            return;
        }// end function

        private function handleActiveOut(param1)
        {
            Holder.closeInfo();
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

        private function prizeItem(param1)
        {
            var _loc_2:* = param1.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            var _loc_4:* = _loc_2.readUnsignedInt();
            this.oldplayer = true;
            return;
        }// end function

        public function backpirzerr(param1)
        {
            this.oldplayer = false;
            if (param1 == 0)
            {
                Config.message("领取成功");
            }
            else
            {
                Config.message("不满足领取条件");
            }
            return;
        }// end function

    }
}
