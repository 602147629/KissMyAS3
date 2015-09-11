package herovsdragon.game.loader
{
    import com.dango_itimi.net.core.*;
    import com.dango_itimi.net.ctrl.*;
    import flash.net.*;

    public class BgmLoader extends Object
    {
        private var mainFunction:Function;
        private const BGM_MP3:String = "bgm.mp3";
        private var loadRunner:LoadRunner;

        public function BgmLoader()
        {
            var _loc_1:* = new URLRequest(this.BGM_MP3);
            this.loadRunner = new LoadRunner(new SoundLoader(_loc_1));
            return;
        }// end function

        public function initialize() : void
        {
            this.loadRunner.initializeLoaded();
            this.mainFunction = this.load;
            return;
        }// end function

        public function run() : void
        {
            this.mainFunction();
            return;
        }// end function

        private function load() : void
        {
            if (this.loadRunner.run())
            {
                this.mainFunction = this.end;
            }
            return;
        }// end function

        private function end() : void
        {
            return;
        }// end function

        public function checkFinished() : Boolean
        {
            return this.mainFunction == this.end;
        }// end function

        public function getBgmSound()
        {
            return this.loadRunner.getLoadData();
        }// end function

    }
}
