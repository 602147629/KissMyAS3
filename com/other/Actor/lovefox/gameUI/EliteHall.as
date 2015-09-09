package lovefox.gameUI
{
    import lovefox.socket.*;

    public class EliteHall extends Object
    {
        public var _opening:Boolean = false;

        public function EliteHall()
        {
            this.initsocket();
            return;
        }// end function

        private function initsocket() : void
        {
            return;
        }// end function

        public function npcTalkElite(param1:int, param2:Array, param3:Function = null) : void
        {
            param2.push({label:Config.language("EliteHall", 1), handler:this.sendelitein, closeflag:true, order:4});
            return;
        }// end function

        public function leftNpcTalkElite(param1:int, param2:Array, param3:Function = null) : void
        {
            param2.push({label:Config.language("EliteHall", 2), handler:this.sendeliteout, closeflag:true});
            return;
        }// end function

        public function sendelitein(param1 = null) : void
        {
            if (Config.player.level < 35)
            {
                AlertUI.alert(Config.language("EliteHall", 3), Config.language("EliteHall", 4), [Config.language("EliteHall", 5)]);
                return;
            }
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_ELITE_IN);
            _loc_2.add32(Npc._npcId);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function sendeliteout(param1 = null)
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_ELITE_OUT);
            _loc_2.add32(Npc._npcId);
            ClientSocket.send(_loc_2);
            return;
        }// end function

    }
}
