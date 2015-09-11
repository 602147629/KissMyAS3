package com.dango_itimi.as3.sound
{
    import com.dango_itimi.as3_and_createjs.sound.*;
    import flash.*;
    import flash.media.*;

    public class SoundEffectMapForFlash extends SoundEffectMap
    {

        public function SoundEffectMapForFlash() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            return;
        }// end function

        public function registerInstance(param1:String, param2:Sound, param3:Object = undefined, param4:Object = undefined, param5:Object = undefined, param6:Object = undefined) : String
        {
            if (param3 == null)
            {
                param3 = 5;
            }
            if (param4 == null)
            {
                param4 = 1;
            }
            if (param5 == null)
            {
                param5 = 0;
            }
            var _loc_7:* = new SoundEffectForFlash(param1, param3, param4, param5, param6);
            _loc_7.sound = param2;
            soundEffectMap.set(param1, _loc_7);
            return param1;
        }// end function

        public function register(param1:Class, param2:Object = undefined, param3:Object = undefined, param4:Object = undefined, param5:Object = undefined) : String
        {
            if (param2 == null)
            {
                param2 = 5;
            }
            if (param3 == null)
            {
                param3 = 1;
            }
            if (param4 == null)
            {
                param4 = 0;
            }
            var _loc_6:* = Type.getClassName(param1);
            var _loc_7:* = new SoundEffectForFlash(_loc_6, param2, param3, param4, param5);
            _loc_7.sound = Type.createInstance(param1, []);
            soundEffectMap.set(_loc_6, _loc_7);
            return _loc_6;
        }// end function

    }
}
