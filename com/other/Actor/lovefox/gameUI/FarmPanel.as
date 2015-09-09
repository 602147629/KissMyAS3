package lovefox.gameUI
{
    import flash.events.*;
    import lovefox.socket.*;

    public class FarmPanel extends Object
    {
        private var menuArr:Array;
        public var _opening:Boolean = false;

        public function FarmPanel()
        {
            this.initsocket();
            return;
        }// end function

        private function initsocket() : void
        {
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_CARNIVAL_IN, this.backformin);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_CARNIVAL_OUT, this.backformout);
            return;
        }// end function

        public function npcTalk(param1:int, param2:Array, param3:Function = null) : void
        {
            param2.push({label:Config.language("FarmPanel", 1), handler:this.sendformin, closeflag:true, order:5});
            param2.push({label:Config.language("FarmPanel", 2), handler:Config.create(this.atvinfor, 3), closeflag:true, order:3});
            param2.push({label:Config.language("FarmPanel", 3), handler:Config.create(this.atvinfor, 2), closeflag:true, order:2});
            param2.push({label:Config.language("FarmPanel", 4), handler:Config.create(this.atvinfor, 1), closeflag:true, order:1});
            param2.sortOn("order", Array.DESCENDING);
            this.menuArr = param2;
            return;
        }// end function

        public function leftNpcTalk(param1:int, param2:Array, param3:Function = null) : void
        {
            param2.push({label:Config.language("FarmPanel", 5), handler:this.sendformout, closeflag:true});
            return;
        }// end function

        private function atvinfor(event:TextEvent, param2) : void
        {
            var _loc_3:* = null;
            if (param2 == 1)
            {
                _loc_3 = Config._activMap[4].information;
            }
            else if (param2 == 2)
            {
                _loc_3 = Config._activMap[7].information;
            }
            else if (param2 == 3)
            {
                _loc_3 = Config._activMap[3].information;
            }
            Config.ui._dialogue.showdialog(60007, _loc_3, this.menuArr);
            return;
        }// end function

        private function enterfarm(event:TextEvent) : void
        {
            return;
        }// end function

        public function sendformin(param1 = null) : void
        {
            if (!Config.ui._petPanel.petflag)
            {
                Config.message(Config.language("FarmPanel", 6));
                return;
            }
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_CARNIVAL_IN);
            _loc_2.add32(Npc._npcId);
            ClientSocket.send(_loc_2);
            trace("G2C_CARNIVAL_IN", Npc._npcId);
            return;
        }// end function

        private function backformin(event:SocketEvent) : void
        {
            var _loc_2:* = event.data.readUnsignedByte();
            trace("backformin", _loc_2);
            trace("农场开始");
            this._opening = true;
            Config.ui._quickUI.openFarm();
            return;
        }// end function

        private function sendformout(param1 = null) : void
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_CARNIVAL_OUT);
            _loc_2.add32(Npc._npcId);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function backformout(event:SocketEvent) : void
        {
            var _loc_2:* = event.data.readUnsignedByte();
            switch(_loc_2)
            {
                case 0:
                {
                    trace("农场离开");
                    this._opening = false;
                    Config.ui._quickUI.closeFarm();
                    break;
                }
                case 1:
                {
                    Config.message(Config.language("FarmPanel", 7));
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

    }
}
