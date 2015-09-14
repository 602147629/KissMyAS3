package message
{
    import flash.utils.*;
    import resource.*;
    import utility.*;

    public class MessageManager extends Object
    {
        private var _bCreated:Boolean;
        private var _loader:XmlLoader;
        private var _aMessage:Dictionary;
        private static var _instance:MessageManager = null;

        public function MessageManager()
        {
            var _loc_1:* = null;
            var _loc_2:* = 0;
            var _loc_3:* = null;
            this._aMessage = new Dictionary(true);
            for each (_loc_1 in MessageList.aMessage)
            {
                
                _loc_2 = _loc_1.id;
                _loc_3 = StringTools.xmlLineToStringLine(_loc_1.mess);
                this._aMessage[_loc_2] = _loc_3;
            }
            return;
        }// end function

        public function get bCreated() : Boolean
        {
            return this._bCreated;
        }// end function

        public function loadData() : void
        {
            this._loader = new XmlLoader();
            this._loader.load(ResourcePath.PARAMETER_PATH + "MessageList.xml", this.cbLoadComplete, false);
            return;
        }// end function

        public function isLoaded() : Boolean
        {
            if (this._loader != null)
            {
                return this._loader.bLoaded;
            }
            return false;
        }// end function

        private function cbLoadComplete(param1:XML) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_2:* = uint(param1.Ver);
            for each (_loc_3 in param1.Data)
            {
                
                _loc_4 = _loc_3.id;
                _loc_5 = StringTools.xmlLineToStringLine(_loc_3.mess);
                this._aMessage[_loc_4] = _loc_5;
            }
            this._loader.release();
            this._loader = null;
            this._bCreated = true;
            return;
        }// end function

        public function getMessage(param1:int) : String
        {
            if (this._aMessage.hasOwnProperty(param1))
            {
                return this._aMessage[param1];
            }
            return "";
        }// end function

        public static function getInstance() : MessageManager
        {
            if (_instance == null)
            {
                _instance = new MessageManager;
            }
            return _instance;
        }// end function

    }
}
