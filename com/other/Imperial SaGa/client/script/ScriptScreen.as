package script
{

    public class ScriptScreen extends Object
    {
        private var _screen:int;
        private var _aScriptMain:Array;
        private var _bRelease:Boolean;
        public static const SCREEN_HOME:int = 1;
        public static const SCREEN_QUEST:int = 2;
        public static const SCREEN_QUEST_PAYMENT_EVENT:int = 3;
        public static const SCREEN_FACILITY:int = 4;
        public static const SCREEN_EMPEROR_SELECT:int = 5;
        public static const SCREEN_ENDING:int = 6;
        public static const SCREEN_SPECIAL:int = 7;
        public static const SCREEN_QUEST_EVENT:int = 8;

        public function ScriptScreen(param1:int, param2:Boolean)
        {
            this._screen = param1;
            this._bRelease = param2;
            this._aScriptMain = [];
            return;
        }// end function

        public function get screen() : int
        {
            return this._screen;
        }// end function

        public function get aScriptMain() : Array
        {
            return this._aScriptMain;
        }// end function

        public function get bRelease() : Boolean
        {
            return this._bRelease;
        }// end function

        public function release() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aScriptMain)
            {
                
                _loc_1.release();
            }
            this._aScriptMain = null;
            return;
        }// end function

        public function addScriptMain(param1:ScriptMain) : void
        {
            this._aScriptMain.push(param1);
            return;
        }// end function

    }
}
