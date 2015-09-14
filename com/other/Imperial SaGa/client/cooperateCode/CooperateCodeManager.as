package cooperateCode
{

    public class CooperateCodeManager extends Object
    {
        private var _aCooperateCode:Array;
        private static var _instance:CooperateCodeManager = null;

        public function CooperateCodeManager()
        {
            this._aCooperateCode = [];
            return;
        }// end function

        public function get aCooperateCode() : Array
        {
            return this._aCooperateCode.concat();
        }// end function

        public function get cooperateCodeNum() : int
        {
            return this._aCooperateCode.length;
        }// end function

        public function setCooperateCode(param1:Array) : void
        {
            this._aCooperateCode = param1.concat();
            return;
        }// end function

        public function addCooperateCode(param1:CooperateCodeInformation) : void
        {
            this._aCooperateCode.push(param1);
            return;
        }// end function

        public static function getInstance() : CooperateCodeManager
        {
            if (_instance == null)
            {
                _instance = new CooperateCodeManager;
            }
            return _instance;
        }// end function

    }
}
