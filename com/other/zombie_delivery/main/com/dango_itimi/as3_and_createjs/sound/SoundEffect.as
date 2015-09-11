package com.dango_itimi.as3_and_createjs.sound
{
    import flash.*;

    public class SoundEffect extends Object
    {
        public var volume:Number;
        public var pan:Number;
        public var mainFunction:Function;
        public var loop:int;
        public var intervalFrame:int;
        public var interval:int;
        public var id:String;

        public function SoundEffect(param1:String = undefined, param2:int = 0, param3:Number = 0, param4:Number = 0, param5:int = 0) : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            id = param1;
            intervalFrame = param2;
            volume = param3;
            pan = param4;
            loop = param5;
            interval = 0;
            mainFunction = finish;
            return;
        }// end function

        public function stop() : void
        {
            interval = 0;
            mainFunction = finish;
            return;
        }// end function

        public function run() : void
        {
            mainFunction();
            return;
        }// end function

        public function playChild() : void
        {
            return;
        }// end function

        public function play() : void
        {
            if (interval > 0)
            {
                return;
            }
            playChild();
            interval = intervalFrame;
            mainFunction = decrementInterval;
            return;
        }// end function

        public function isFinished() : Boolean
        {
            return Reflect.compareMethods(mainFunction, finish);
        }// end function

        public function finish() : void
        {
            return;
        }// end function

        public function decrementInterval() : void
        {
            if (interval > 0)
            {
                (interval - 1);
            }
            else
            {
                mainFunction = finish;
            }
            return;
        }// end function

    }
}
