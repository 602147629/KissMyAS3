package playerList
{
    import player.*;

    public class ListPlayerData extends Object
    {
        private var _info:PlayerInformation;
        private var _personal:PlayerPersonal;

        public function ListPlayerData(param1:PlayerPersonal, param2:int = 0)
        {
            this._personal = param1;
            this._info = PlayerManager.getInstance().getPlayerInformation(this._personal ? (this._personal.playerId) : (param2));
            return;
        }// end function

        public function get info() : PlayerInformation
        {
            return this._info;
        }// end function

        public function get personal() : PlayerPersonal
        {
            return this._personal;
        }// end function

    }
}
