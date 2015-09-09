package lovefox.sound
{
    import flash.media.*;
    import lovefox.buffer.*;

    public class SoundManager extends Object
    {
        private static var _on:Boolean = true;
        private static var _playingSoundStack:Object = {};

        public function SoundManager()
        {
            return;
        }// end function

        public static function play(param1)
        {
            var _loc_3:* = null;
            var _loc_2:* = SoundLoader.pick(param1);
            if (_loc_2 != null)
            {
                if (_on && Config.stageFocus && _playingSoundStack[param1] != true)
                {
                    _loc_2.play();
                    _playingSoundStack[param1] = true;
                    setTimeout(releaseSndPlay, 100, param1);
                }
            }
            else
            {
                _loc_3 = new SoundLoader();
                _loc_3.addEventListener(Event.COMPLETE, handleSoundComplete);
                _loc_3.load([param1]);
            }
            return;
        }// end function

        private static function handleSoundComplete(param1)
        {
            var _loc_3:* = null;
            var _loc_2:* = SoundLoader(param1.target);
            _loc_2.removeEventListener(Event.COMPLETE, handleSoundComplete);
            if (_loc_2._urlArray != null && _loc_2._urlArray.length > 0)
            {
                _loc_3 = SoundLoader.pick(_loc_2._urlArray[0]);
                if (_loc_3 != null)
                {
                    if (_on && Config.stageFocus && _playingSoundStack[_loc_2._urlArray[0]] != true)
                    {
                        _loc_3.play();
                        _playingSoundStack[_loc_2._urlArray[0]] = true;
                        setTimeout(releaseSndPlay, 100, _loc_2._urlArray[0]);
                    }
                }
            }
            return;
        }// end function

        private static function releaseSndPlay(param1)
        {
            delete _playingSoundStack[param1];
            return;
        }// end function

        public static function set musicOn(param1:Boolean) : void
        {
            Music.on = param1;
            return;
        }// end function

        public static function get musicOn() : Boolean
        {
            return Music.on;
        }// end function

        public static function set musicBack(param1:Boolean) : void
        {
            Music.back = param1;
            return;
        }// end function

        public static function get musicBack() : Boolean
        {
            return Music.back;
        }// end function

        public static function set soundOn(param1:Boolean) : void
        {
            _on = param1;
            return;
        }// end function

        public static function get soundOn() : Boolean
        {
            return _on;
        }// end function

        public static function set on(param1:Boolean) : void
        {
            _on = param1;
            Music.on = _on;
            return;
        }// end function

        public static function get on() : Boolean
        {
            return _on;
        }// end function

    }
}
