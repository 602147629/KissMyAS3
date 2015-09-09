package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import lovefox.socket.*;

    public class PKrace extends Window
    {
        private var labstu:Label;
        private var labgra:Label;
        private var labmon:Label;
        private var signBtn:PushButton;

        public function PKrace(param1:DisplayObjectContainer = null, param2:Number = 0, param3:Number = 0)
        {
            super(param1, param2, param3);
            resize(200, 120);
            this.initpanel();
            this.initsocket();
            return;
        }// end function

        private function initpanel()
        {
            this.title = Config.language("PKrace", 1);
            this.labstu = new Label(this, 10, 25, Config.language("PKrace", 2));
            this.labstu.html = true;
            this.labgra = new Label(this, 10, 40, Config.language("PKrace", 3));
            this.labgra.html = true;
            this.labmon = new Label(this, 10, 55, Config.language("PKrace", 4));
            this.labmon.html = true;
            this.signBtn = new PushButton(this, 60, 80, Config.language("PKrace", 5), this.sendissign);
            this.signBtn.width = 80;
            return;
        }// end function

        private function initsocket()
        {
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_PK_ACTIVITY_BEG_SIGNUP, this.activebegin);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_PK_ACTIVITY_END_SIGNUP, this.activend);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_PK_ACTIVITY_GROUP_INFO, this.activeinfo);
            return;
        }// end function

        private function activebegin(event:SocketEvent)
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            var _loc_4:* = _loc_2.readUnsignedInt();
            var _loc_5:* = _loc_2.readUnsignedInt();
            return;
        }// end function

        private function activend(event:SocketEvent)
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readByte();
            return;
        }// end function

        private function activeinfo(event:SocketEvent)
        {
            if (!this._opening)
            {
                this.open();
            }
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedShort();
            var _loc_4:* = _loc_2.readUnsignedShort();
            var _loc_5:* = _loc_2.readByte();
            var _loc_6:* = _loc_2.readUnsignedInt();
            var _loc_7:* = _loc_2.readUnsignedInt();
            var _loc_8:* = _loc_2.readUnsignedInt();
            if (_loc_5 == 1)
            {
                this.labstu.text = Config.language("PKrace", 6);
                this.labmon.text = Config.language("PKrace", 7);
                this.signBtn.label = Config.language("PKrace", 8);
            }
            else
            {
                this.labstu.text = Config.language("PKrace", 9);
                this.labmon.text = Config.language("PKrace", 10, _loc_8);
                this.signBtn.label = Config.language("PKrace", 11);
            }
            this.labgra.text = Config.language("PKrace", 12, _loc_3, _loc_4, _loc_6, _loc_7);
            return;
        }// end function

        public function sendnosign()
        {
            var _loc_1:* = new DataSet();
            _loc_1.addHead(CONST_ENUM.C2G_PK_ACTIVITY_GROUP_INFO);
            ClientSocket.send(_loc_1);
            return;
        }// end function

        private function sendissign(event:MouseEvent)
        {
            var _loc_2:* = null;
            if (this.signBtn.label == Config.language("PKrace", 8))
            {
                this.close();
            }
            else
            {
                _loc_2 = new DataSet();
                _loc_2.addHead(CONST_ENUM.C2G_PK_ACTIVITY_REQUEST_SIGNUP);
                ClientSocket.send(_loc_2);
            }
            return;
        }// end function

        public function closewin()
        {
            this.close();
            Config.message(Config.language("PKrace", 13));
            return;
        }// end function

        public function sendenterPkmap(param1 = null)
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_PK_ACTIVITY_REQUEST_ENTER);
            ClientSocket.send(_loc_2);
            return;
        }// end function

    }
}
