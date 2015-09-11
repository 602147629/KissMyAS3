package com.dango_itimi.as3_and_createjs.sound
{
    import flash.*;
    import haxe.ds.*;

    public class SoundEffectMap extends Object
    {
        public var soundEffectMap:IMap;
        public var playingSoundEffectMap:IMap;
        public var mute:Boolean;

        public function SoundEffectMap() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            playingSoundEffectMap = new StringMap();
            soundEffectMap = new StringMap();
            mute = false;
            return;
        }// end function

        public function stop(param1:String) : void
        {
            var _loc_2:* = soundEffectMap.get(param1);
            _loc_2.stop();
            if ("$" + param1 in playingSoundEffectMap.h)
            {
                playingSoundEffectMap.remove(param1);
            }
            return;
        }// end function

        public function run() : void
        {
            var _loc_2:* = null as String;
            var _loc_3:* = null as SoundEffect;
            var _loc_1:* = playingSoundEffectMap.keys();
            
            if (_loc_1.hasNext())
            {
                _loc_2 = _loc_1.next();
                _loc_3 = playingSoundEffectMap.get(_loc_2);
                _loc_3.run();
                if (_loc_3.isFinished())
                {
                    playingSoundEffectMap.remove(_loc_2);
                }
                ;
            }
            return;
        }// end function

        public function play(param1:String) : void
        {
            if (mute)
            {
                return;
            }
            if ("$" + param1 in playingSoundEffectMap.h)
            {
                return;
            }
            var _loc_2:* = soundEffectMap.get(param1);
            _loc_2.play();
            playingSoundEffectMap.set(param1, _loc_2);
            return;
        }// end function

    }
}
