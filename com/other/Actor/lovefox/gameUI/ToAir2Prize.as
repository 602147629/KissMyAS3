package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;
    import lovefox.socket.*;

    public class ToAir2Prize extends Window
    {
        private var _floorlab:Label;
        private var _timeslab:Label;
        private var labeldesc1:TextField;
        private var labeldesc2:TextField;
        private var labeldesc3:TextField;
        private var labeldesc4:TextField;
        private var labeldesc5:TextField;
        private var _enalert:Object;
        private var _countvalue2:int = 0;
        private var _countvalue3:int = 0;

        public function ToAir2Prize(param1:DisplayObjectContainer = null)
        {
            super(param1);
            this.init();
            this.socket();
            return;
        }// end function

        private function socket()
        {
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_SKYTOWER2_REWARD_COUNT, this.backprize2);
            return;
        }// end function

        private function init()
        {
            var _loc_4:* = null;
            this.x = 150;
            this.y = 50;
            resize(400, 250);
            var _loc_1:* = new Shape();
            _loc_1.graphics.lineStyle(1, 7689037);
            _loc_1.graphics.moveTo(5, 55);
            _loc_1.graphics.lineTo(395, 55);
            this.addChild(_loc_1);
            var _loc_2:* = new Shape();
            _loc_2.graphics.beginFill(16777215, 0.4);
            _loc_2.graphics.drawRoundRect(10, 120, 120, 110, 9);
            _loc_2.graphics.drawRoundRect(140, 120, 120, 110, 9);
            _loc_2.graphics.drawRoundRect(270, 120, 120, 110, 9);
            _loc_2.graphics.endFill();
            this.addChild(_loc_2);
            this._floorlab = new Label(this, 10, 65, Config.language("ToAir2Prize", 2));
            this._floorlab.html = true;
            this._timeslab = new Label(this, 10, 90);
            this._timeslab.html = true;
            var _loc_3:* = new PushButton(this, 110, 62, Config.language("ToAir2Prize", 3), this.sendenter);
            _loc_3.setTable("table18", "table31");
            _loc_3.width = 60;
            _loc_3.textColor = Style.GOLD_FONT;
            this.labeldesc1 = Config.getSimpleTextField();
            this.labeldesc1.autoSize = TextFieldAutoSize.CENTER;
            this.labeldesc1.x = 10;
            this.labeldesc1.y = 180;
            this.labeldesc1.width = 120;
            this.addChild(this.labeldesc1);
            this.labeldesc2 = Config.getSimpleTextField();
            this.labeldesc2.autoSize = TextFieldAutoSize.CENTER;
            this.labeldesc2.x = 140;
            this.labeldesc2.y = 130;
            this.labeldesc2.width = 120;
            this.addChild(this.labeldesc2);
            this.labeldesc3 = Config.getSimpleTextField();
            this.labeldesc3.autoSize = TextFieldAutoSize.CENTER;
            this.labeldesc3.x = 140;
            this.labeldesc3.y = 180;
            this.labeldesc3.width = 120;
            this.addChild(this.labeldesc3);
            this.labeldesc4 = Config.getSimpleTextField();
            this.labeldesc4.autoSize = TextFieldAutoSize.CENTER;
            this.labeldesc4.x = 270;
            this.labeldesc4.y = 130;
            this.labeldesc4.width = 120;
            this.addChild(this.labeldesc4);
            this.labeldesc5 = Config.getSimpleTextField();
            this.labeldesc5.autoSize = TextFieldAutoSize.CENTER;
            this.labeldesc5.x = 270;
            this.labeldesc5.y = 180;
            this.labeldesc5.width = 120;
            this.addChild(this.labeldesc5);
            _loc_4 = new Label(this, 50, 130, Config.language("ToAir2Prize", 4));
            var _loc_5:* = 0;
            while (_loc_5 < 3)
            {
                
                _loc_4 = new Label(this, 42 + _loc_5 * 130, 160, Config.language("ToAir2Prize", 5));
                _loc_5 = _loc_5 + 1;
            }
            var _loc_6:* = new PushButton(this, 40, 200, Config.language("ToAir2Prize", 6), Config.create(this.getgiftexpSend, 1));
            new PushButton(this, 40, 200, Config.language("ToAir2Prize", 6), Config.create(this.getgiftexpSend, 1)).setTable("table18", "table31");
            _loc_6.textColor = Style.GOLD_FONT;
            _loc_6.width = 60;
            var _loc_7:* = new PushButton(this, 170, 200, Config.language("ToAir2Prize", 7), Config.create(this.getgiftexpSend, 2));
            new PushButton(this, 170, 200, Config.language("ToAir2Prize", 7), Config.create(this.getgiftexpSend, 2)).setTable("table18", "table31");
            _loc_7.textColor = Style.GOLD_FONT;
            _loc_7.width = 60;
            var _loc_8:* = new PushButton(this, 300, 200, Config.language("ToAir2Prize", 8), Config.create(this.getgiftexpSend, 3));
            new PushButton(this, 300, 200, Config.language("ToAir2Prize", 8), Config.create(this.getgiftexpSend, 3)).setTable("table18", "table31");
            _loc_8.textColor = Style.GOLD_FONT;
            _loc_8.width = 60;
            return;
        }// end function

        override public function open(event:MouseEvent = null)
        {
            super.open();
            this.x = (Config.ui._width - this.width) / 2;
            this.y = (Config.ui._height - this.height) / 2;
            this.title = Config.language("ToAir2Prize", 1);
            this._floorlab.text = Config.language("ToAir2Prize", 9, Style.FONT_Red, Config.ui._toAirPanel._floor);
            this._timeslab.text = Config.language("ToAir2Prize", 14, Style.FONT_Red, this._count2);
            var _loc_2:* = int(Config.ui._toAirPanel._floor) - 101;
            this.setprize(_loc_2);
            return;
        }// end function

        private function sendenter(event:MouseEvent)
        {
            var _loc_3:* = null;
            if (Config.ui._teamUI.getTeamArr().length > 0)
            {
                Config.message(Config.language("ToAirPanel", 9));
                return;
            }
            var _loc_2:* = 0;
            if (Config.ui._toAirPanel._floor > 300)
            {
                _loc_2 = Config.ui._toAirPanel.count4;
            }
            else if (Config.ui._toAirPanel._floor > 200)
            {
                _loc_2 = Config.ui._toAirPanel.count3;
            }
            else if (Config.ui._toAirPanel._floor > 100)
            {
                _loc_2 = Config.ui._toAirPanel.count2;
            }
            if (_loc_2 > 0)
            {
                _loc_3 = new DataSet();
                if (Config.ui._toAirPanel._floor > 300)
                {
                    _loc_3.addHead(CONST_ENUM.C2G_ENTER_SKYTOWER4);
                    _loc_3.add16(Config.ui._toAirPanel._floor);
                }
                else if (Config.ui._toAirPanel._floor > 200)
                {
                    _loc_3.addHead(CONST_ENUM.C2G_ENTER_SKYTOWER3);
                    _loc_3.add16(Config.ui._toAirPanel._floor);
                }
                else
                {
                    _loc_3.addHead(CONST_ENUM.C2G_ENTER_SKYTOWER2);
                    _loc_3.add8(Config.ui._toAirPanel._floor);
                }
                ClientSocket.send(_loc_3);
            }
            else
            {
                Config.message(Config.language("ToAirPanel", 1));
            }
            return;
        }// end function

        private function getgiftexpSend(event:MouseEvent, param2:uint)
        {
            var _loc_3:* = null;
            if (this._enalert != null)
            {
                AlertUI.remove(this._enalert);
            }
            if (param2 == 2 || param2 == 3)
            {
                _loc_3 = "";
                if (param2 == 2)
                {
                    _loc_3 = Config.language("ToAir2Prize", 10, this.labeldesc2.htmlText, this.labeldesc3.text);
                }
                else
                {
                    _loc_3 = Config.language("ToAir2Prize", 11, this.labeldesc4.htmlText, this.labeldesc5.text);
                }
                this._enalert = AlertUI.alert(Config.language("EnergyPanel", 13), _loc_3, [Config.language("EnergyPanel", 14), Config.language("EnergyPanel", 15)], [Config.create(this.sendalert, param2)]);
            }
            else
            {
                this.sendalert(null, param2);
            }
            return;
        }// end function

        private function sendalert(param1, param2)
        {
            var _loc_3:* = new DataSet();
            _loc_3.addHead(CONST_ENUM.C2G_SKYTOWER2_GET_REWARD);
            _loc_3.add8(param2);
            ClientSocket.send(_loc_3);
            return;
        }// end function

        private function setprize(param1:int) : void
        {
            var _loc_2:* = Config.coinShow(Config._toair2prize[param1].experienceValue * Config._toair2prize[param1].rate1);
            var _loc_3:* = Config.coinShow(Config._toair2prize[param1].experienceValue * Config._toair2prize[param1].rate2);
            this.labeldesc1.htmlText = Config.coinShow(Config._toair2prize[param1].experienceValue);
            this.labeldesc2.htmlText = Config.language("ToAir2Prize", 12, Config.coinShow(Config._toair2prize[param1].gameMoney));
            this.labeldesc3.htmlText = _loc_2;
            this.labeldesc4.htmlText = Config.language("ToAir2Prize", 13, Config.coinShow(Config._toair2prize[param1].gold));
            this.labeldesc5.htmlText = _loc_3;
            return;
        }// end function

        private function backprize2(event:SocketEvent)
        {
            var _loc_2:* = event.data;
            this._count2 = _loc_2.readUnsignedByte();
            this._timeslab.text = Config.language("ToAir2Prize", 14, Style.FONT_Red, this._count2);
            return;
        }// end function

        private function set _count2(param1:int)
        {
            this._countvalue2 = param1;
            return;
        }// end function

        private function get _count2() : int
        {
            return this._countvalue2;
        }// end function

    }
}
