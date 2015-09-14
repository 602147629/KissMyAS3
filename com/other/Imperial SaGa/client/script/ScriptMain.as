package script
{
    import flash.utils.*;

    public class ScriptMain extends Object
    {
        private var _scriptId:int;
        private var _triggerId:int;
        private var _squareId:int;
        private var _aFlagAnd:Array;
        private var _aFlagOr:Array;
        private var _aFlagOff:Array;
        private var _aQuestFlagAnd:Array;
        private var _aQuestFlagOr:Array;
        private var _aQuestFlagOff:Array;
        private var _commandBinary:ByteArray;
        private var _bScriptEnd:Boolean;
        private var _bPayment:Boolean;
        private var _chapter:int;
        private var _progress:int;
        private var _aEmperorId:Array;

        public function ScriptMain()
        {
            this._aFlagAnd = [];
            this._aFlagOr = [];
            this._aFlagOff = [];
            this._aQuestFlagAnd = [];
            this._aQuestFlagOr = [];
            this._aQuestFlagOff = [];
            this._aEmperorId = [];
            this._bPayment = false;
            return;
        }// end function

        public function get scriptId() : int
        {
            return this._scriptId;
        }// end function

        public function get triggerId() : int
        {
            return this._triggerId;
        }// end function

        public function get squareId() : int
        {
            return this._squareId;
        }// end function

        public function get aFlagAnd() : Array
        {
            return this._aFlagAnd.concat();
        }// end function

        public function get aFlagOr() : Array
        {
            return this._aFlagOr.concat();
        }// end function

        public function get aFlagOff() : Array
        {
            return this._aFlagOff.concat();
        }// end function

        public function get aQuestFlagAnd() : Array
        {
            return this._aQuestFlagAnd.concat();
        }// end function

        public function get aQuestFlagOr() : Array
        {
            return this._aQuestFlagOr.concat();
        }// end function

        public function get aQuestFlagOff() : Array
        {
            return this._aQuestFlagOff.concat();
        }// end function

        public function get bScriptEnd() : Boolean
        {
            return this._bScriptEnd;
        }// end function

        public function set bScriptEnd(param1:Boolean) : void
        {
            this._bScriptEnd = param1;
            return;
        }// end function

        public function get bPayment() : Boolean
        {
            return this._bPayment;
        }// end function

        public function set bPayment(param1:Boolean) : void
        {
            this._bPayment = param1;
            return;
        }// end function

        public function get chapter() : int
        {
            return this._chapter;
        }// end function

        public function get progress() : int
        {
            return this._progress;
        }// end function

        public function get aEmperorId() : Array
        {
            return this._aEmperorId;
        }// end function

        public function release() : void
        {
            this._commandBinary.clear();
            return;
        }// end function

        public function setXmlInformation(param1:XML) : void
        {
            this._scriptId = param1.scrId;
            return;
        }// end function

        public function setXmlStartUp(param1:XML) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            this._triggerId = param1.triggerId;
            this._squareId = param1.squareId;
            this._chapter = param1.chapter != undefined ? (param1.chapter) : (-1);
            this._progress = param1.progress != undefined ? (param1.progress) : (-1);
            for each (_loc_2 in param1.flagAnd.children())
            {
                
                _loc_9 = new ScriptComParamFlag();
                _loc_9.setParam(_loc_2);
                this._aFlagAnd.push(_loc_9);
            }
            for each (_loc_3 in param1.flagOr.children())
            {
                
                _loc_10 = new ScriptComParamFlag();
                _loc_10.setParam(_loc_3);
                this._aFlagOr.push(_loc_10);
            }
            for each (_loc_4 in param1.flagOff.children())
            {
                
                _loc_11 = new ScriptComParamFlag();
                _loc_11.setParam(_loc_4);
                this._aFlagOr.push(_loc_11);
            }
            for each (_loc_5 in param1.questFlagAnd.children())
            {
                
                this._aQuestFlagAnd.push(int(_loc_5));
            }
            for each (_loc_6 in param1.questFlagOr.children())
            {
                
                this._aQuestFlagOr.push(int(_loc_6));
            }
            for each (_loc_7 in param1.questFlagOff.children())
            {
                
                this._aQuestFlagOff.push(int(_loc_7));
            }
            for each (_loc_8 in param1.emperorId.children())
            {
                
                this._aEmperorId.push(int(_loc_8));
            }
            return;
        }// end function

        public function setCommandToBinary(param1:XMLList) : void
        {
            var _loc_2:* = param1.toXMLString();
            this._commandBinary = new ByteArray();
            this._commandBinary.writeUTFBytes(_loc_2);
            this._commandBinary.position = 0;
            return;
        }// end function

        public function getCommandXmlList() : XMLList
        {
            this._commandBinary.position = 0;
            return new XMLList(this._commandBinary.readUTFBytes(this._commandBinary.length));
        }// end function

        public function init() : void
        {
            this._bScriptEnd = false;
            return;
        }// end function

        public function setSquareId(param1:int) : void
        {
            this._squareId = param1;
            return;
        }// end function

    }
}
