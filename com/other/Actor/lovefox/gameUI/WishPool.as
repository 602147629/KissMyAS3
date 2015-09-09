package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.utils.*;
    import lovefox.socket.*;

    public class WishPool extends Sprite
    {
        private var lab:Label;

        public function WishPool()
        {
            this.initsocket();
            return;
        }// end function

        private function initsocket() : void
        {
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_VOW, this.backwishing);
            return;
        }// end function

        public function clickAccept()
        {
            var _loc_1:* = null;
            if (Config.player.money4 >= 500)
            {
                _loc_1 = new DataSet();
                _loc_1.addHead(CONST_ENUM.C2G_VOW);
                _loc_1.add32(Npc._npcId);
                ClientSocket.send(_loc_1);
            }
            else
            {
                Config.message(Config.language("WishPool", 1));
            }
            return;
        }// end function

        private function backwishing(event:SocketEvent)
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            Config.message(Config.language("WishPool", 2, _loc_3));
            return;
        }// end function

        private function backwishsuss(event:SocketEvent)
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            return;
        }// end function

    }
}
