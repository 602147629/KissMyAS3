package trainingRoom
{
    import playerList.*;

    public class KumiteListPlayerData extends ListPlayerData
    {
        private var _kumitePlayerData:TrainingRoomKumitePlayerData;

        public function KumiteListPlayerData(param1:TrainingRoomKumitePlayerData)
        {
            super(null, param1.playerId);
            this._kumitePlayerData = param1;
            return;
        }// end function

        public function get kumitePlayerData() : TrainingRoomKumitePlayerData
        {
            return this._kumitePlayerData;
        }// end function

    }
}
