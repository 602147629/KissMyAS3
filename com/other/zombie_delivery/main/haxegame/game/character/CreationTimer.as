package haxegame.game.character
{

    public class CreationTimer extends Object
    {
        public var waveCount:int;
        public var mainFunction:Function;
        public var intervalCount:int;
        public var creationOrder:Boolean;
        public var creationCount:int;
        public var characterTotal:int;
        public static var INTERVAL_RUSH:int;
        public static var INTERVAL_WAVE:int;
        public static var INTERVAL_AFTER_CREATION:int;
        public static var WAVE_TOTAL:int;

        public function CreationTimer() : void
        {
            return;
        }// end function

        public function run() : void
        {
            mainFunction();
            return;
        }// end function

        public function resetCreationOrder() : void
        {
            creationOrder = false;
            return;
        }// end function

        public function orderCreation() : void
        {
            creationOrder = true;
            (creationCount + 1);
            mainFunction = countAfterCreationInterval;
            return;
        }// end function

        public function isFinishedRush() : Boolean
        {
            return Reflect.compareMethods(mainFunction, finish);
        }// end function

        public function initializeToOrderCreation() : void
        {
            creationCount = 0;
            orderCreation();
            return;
        }// end function

        public function initialize(param1:int) : void
        {
            characterTotal = param1;
            intervalCount = 0;
            creationOrder = false;
            creationCount = 0;
            waveCount = 0;
            orderCreation();
            return;
        }// end function

        public function finish() : void
        {
            return;
        }// end function

        public function countWaveInterval() : void
        {
            (intervalCount + 1);
            if (intervalCount < 40)
            {
                return;
            }
            intervalCount = 0;
            (waveCount + 1);
            if (waveCount < 5)
            {
                mainFunction = initializeToOrderCreation;
            }
            else
            {
                mainFunction = countRushInterval;
            }
            return;
        }// end function

        public function countRushInterval() : void
        {
            (intervalCount + 1);
            if (intervalCount < 70)
            {
                return;
            }
            intervalCount = 0;
            mainFunction = finish;
            return;
        }// end function

        public function countAfterCreationInterval() : void
        {
            (intervalCount + 1);
            if (intervalCount < 20)
            {
                return;
            }
            intervalCount = 0;
            if (creationCount < characterTotal)
            {
                mainFunction = orderCreation;
            }
            else
            {
                mainFunction = countWaveInterval;
            }
            return;
        }// end function

    }
}
