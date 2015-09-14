package player
{

    public class PlayerWord extends Object
    {
        private var _id:int;
        private var _scene:int;
        private var _message:String;
        private var _partnerId:int;

        public function PlayerWord()
        {
            return;
        }// end function

        public function get id() : int
        {
            return this._id;
        }// end function

        public function get scene() : int
        {
            return this._scene;
        }// end function

        public function get message() : String
        {
            return this._message;
        }// end function

        public function get partnerId() : int
        {
            return this._partnerId;
        }// end function

        public function setXml(param1:XML) : void
        {
            this._id = param1.id;
            this._scene = param1.scene;
            this._message = param1.message;
            this._partnerId = Constant.EMPTY_ID;
            if (String(param1.partnerId) != "")
            {
                this._partnerId = int(param1.partnerId);
            }
            return;
        }// end function

    }
}
