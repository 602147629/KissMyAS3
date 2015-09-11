package com.dango_itimi.as3.sound
{
    import com.dango_itimi.as3_and_createjs.sound.*;
    import flash.*;
    import flash.media.*;

    public class SoundEffectForFlash extends SoundEffect
    {
        public var soundChannel:SoundChannel;
        public var sound:Sound;

        public function SoundEffectForFlash(param1:String = undefined, param2:int = 0, param3:Number = 0, param4:Number = 0, param5:int = 0) : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            super(param1, param2, param3, param4, param5);
            return;
        }// end function

        override public function stop() : void
        {
            soundChannel.stop();
            stop();
            return;
        }// end function

        public function setSound(param1:Sound) : void
        {
            sound = param1;
            return;
        }// end function

        override public function playChild() : void
        {
            soundChannel = sound.play(0, loop);
            soundChannel.soundTransform = new SoundTransform(volume, pan);
            return;
        }// end function

    }
}
