package haxegame.se
{
    import com.dango_itimi.as3.sound.*;
    import flash.*;
    import flash.media.*;

    public class SoundMixerForFlash extends SoundMixer
    {

        public function SoundMixerForFlash() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            SoundMixer.soundEffectMap = new SoundEffectMapForFlash();
            return;
        }// end function

        override public function registerInstance(param1:Class, param2:Sound, param3:Object = undefined, param4:Object = undefined, param5:Object = undefined, param6:String = undefined, param7:Object = undefined, param8:Object = undefined, param9:Object = undefined) : String
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
            if (param6 == null)
            {
                param6 = "";
            }
            if (param7 == null)
            {
                param7 = 0;
            }
            if (param8 == null)
            {
                param8 = 0;
            }
            if (param9 == null)
            {
                param9 = 0;
            }
            return SoundMixer.soundEffectMap.registerInstance(Type.getClassName(param1), param2, param3, param4, param5, param9);
        }// end function

        override public function register(param1, param2:Object = undefined, param3:Object = undefined, param4:Object = undefined, param5:String = undefined, param6:Object = undefined, param7:Object = undefined, param8:Object = undefined) : String
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
            if (param5 == null)
            {
                param5 = "";
            }
            if (param6 == null)
            {
                param6 = 0;
            }
            if (param7 == null)
            {
                param7 = 0;
            }
            if (param8 == null)
            {
                param8 = 0;
            }
            return SoundMixer.soundEffectMap.register(param1, param2, param3, param4, param8);
        }// end function

    }
}
