package herovsdragon.game.se
{
    import flash.media.*;

    public class SoundEffect extends Object
    {
        private var mainFunction:Function;
        private var sound:Sound;
        private var interval:uint = 0;
        private var INTERVAL_FRAME:uint;
        private var volume:Number;

        public function SoundEffect(param1:Class, param2:uint, param3:Number)
        {
            this.volume = param3;
            this.sound = new param1 as Sound;
            this.INTERVAL_FRAME = param2;
            this.mainFunction = this.end;
            return;
        }// end function

        public function run() : void
        {
            this.mainFunction();
            return;
        }// end function

        private function end() : void
        {
            return;
        }// end function

        public function isEnd() : Boolean
        {
            return this.mainFunction == this.end;
        }// end function

        public function playSound() : void
        {
            if (this.interval > 0)
            {
                return;
            }
            var _loc_1:* = this.sound.play();
            _loc_1.soundTransform = new SoundTransform(this.volume);
            this.interval = this.INTERVAL_FRAME;
            this.mainFunction = this.decrementInterval;
            return;
        }// end function

        private function decrementInterval() : void
        {
            if (this.interval > 0)
            {
                var _loc_1:* = this;
                var _loc_2:* = this.interval - 1;
                _loc_1.interval = _loc_2;
            }
            else
            {
                this.mainFunction = this.end;
            }
            return;
        }// end function

    }
}
