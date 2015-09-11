package herovsdragon.game.se
{
    import flash.media.*;
    import herovsdragon.game.loader.*;

    public class BGM extends Object
    {
        private var bgmLoader:BgmLoader;
        private var bgm:Sound;
        private var soundChannel:SoundChannel;

        public function BGM(param1:BgmLoader)
        {
            this.bgmLoader = param1;
            this.bgm = param1.getBgmSound();
            return;
        }// end function

        public function play() : void
        {
            this.soundChannel = this.bgm.play(0, 60000);
            this.soundChannel.soundTransform = new SoundTransform(0.8);
            return;
        }// end function

        public function stop() : void
        {
            this.soundChannel.stop();
            return;
        }// end function

    }
}
