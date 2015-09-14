package payment
{
    import resource.*;

    public class PaymentManager extends Object
    {
        private var _loader:XmlLoader;
        private var _bCreated:Boolean;
        private var _aPaymentStep:Array;
        private var _idObj:Object;
        private static var _instance:PaymentManager = null;

        public function PaymentManager()
        {
            this._aPaymentStep = [];
            this._idObj = new Object();
            return;
        }// end function

        public function get bCreated() : Boolean
        {
            return this._bCreated;
        }// end function

        public function loadData() : void
        {
            this._loader = new XmlLoader();
            this._loader.load(ResourcePath.PARAMETER_PATH + "PaymentStepList.xml", this.cbLoadComplete, false);
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
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            for each (_loc_2 in param1.Data)
            {
                
                _loc_3 = new PaymentStep();
                _loc_3.setXml(_loc_2);
                this._aPaymentStep.push(_loc_3);
                _loc_4 = this._idObj[_loc_3.id];
                if (_loc_4 == null)
                {
                    _loc_4 = new Array();
                    this._idObj[_loc_3.id] = _loc_4;
                }
                _loc_4.push(_loc_3);
            }
            this._loader.release();
            this._loader = null;
            this._bCreated = true;
            return;
        }// end function

        public function getInstantCrownBySecond(param1:int) : int
        {
            var _loc_2:* = searchStep(this.getPaymentStepTable(PaymentStep.ID_INSTANT_CROWN), param1);
            return _loc_2 ? (_loc_2.value) : (0);
        }// end function

        public function getInstantCrownBySecondCmp(param1:uint, param2:uint) : int
        {
            if (param1 <= param2)
            {
                return this.getInstantCrownBySecond(0);
            }
            return this.getInstantCrownBySecond(param1 - param2);
        }// end function

        public function getInstantLearningNumBySecond(param1:int) : int
        {
            var _loc_2:* = searchStep(this.getPaymentStepTable(PaymentStep.ID_INSTANT_INSTANT_LEARNING), param1);
            return _loc_2 ? (_loc_2.value) : (0);
        }// end function

        public function getInstantLearningNumBySecondCmp(param1:uint, param2:uint) : int
        {
            if (param1 <= param2)
            {
                return this.getInstantLearningNumBySecond(0);
            }
            return this.getInstantLearningNumBySecond(param1 - param2);
        }// end function

        public function getPaymentStepTable(param1:int) : Array
        {
            var _loc_2:* = this._idObj[param1];
            if (_loc_2 != null)
            {
                return _loc_2;
            }
            return [];
        }// end function

        public static function getInstance() : PaymentManager
        {
            if (_instance == null)
            {
                _instance = new PaymentManager;
            }
            return _instance;
        }// end function

        public static function searchStep(param1:Array, param2:int) : PaymentStep
        {
            var _loc_3:* = null;
            var _loc_4:* = param1.length - 1;
            while (_loc_4 >= 0)
            {
                
                _loc_3 = param1[_loc_4];
                if (_loc_3.jadge < param2)
                {
                    return _loc_3;
                }
                _loc_4 = _loc_4 - 1;
            }
            return _loc_3;
        }// end function

        public static function searchIdx(param1:Array, param2:int) : int
        {
            var _loc_3:* = null;
            var _loc_4:* = param1.length - 1;
            while (_loc_4 >= 0)
            {
                
                _loc_3 = param1[_loc_4];
                if (_loc_3.jadge < param2)
                {
                    return _loc_4;
                }
                _loc_4 = _loc_4 - 1;
            }
            return _loc_3 == null ? (-1) : (0);
        }// end function

    }
}
