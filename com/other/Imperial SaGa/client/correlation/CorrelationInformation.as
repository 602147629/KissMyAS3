package correlation
{
    import player.*;

    public class CorrelationInformation extends Object
    {
        private var _playerId:int;
        private var _charaId:int;
        private var _rarity:int;
        private var _swf:String;

        public function CorrelationInformation()
        {
            this._playerId = 0;
            this._charaId = 0;
            this._rarity = 0;
            this._swf = "";
            return;
        }// end function

        public function setInfomation(param1:PlayerInformation) : void
        {
            this._playerId = param1.id;
            this._charaId = param1.characterId;
            this._rarity = param1.rarity;
            this._swf = param1.swf;
            return;
        }// end function

        public function get playerId() : int
        {
            return this._playerId;
        }// end function

        public function get charaId() : int
        {
            return this._charaId;
        }// end function

        public function get rarity() : int
        {
            return this._rarity;
        }// end function

        public function get swf() : String
        {
            return this._swf;
        }// end function

    }
}
