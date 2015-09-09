package lovefox.sound
{
    import flash.media.*;
    import flash.net.*;

    public class Music extends Object
    {
        private static var _on:Boolean = true;
        private static var _back:Boolean = false;
        private static var _currURL:String;
        private static var _currSound:Sound;
        private static var _currSoundChannel:SoundChannel;
        private static var _oriList:Array;
        private static var _list:Array;
        private static var _listIndex:int = 0;
        private static var _maxVolume:Number = 1;
        private static var _testing:Boolean = false;
        private static var _testSound:Sound;
        private static var _testSoundChannel:SoundChannel;
        private static var _testSuc:Function;
        private static var _testFail:Function;
        private static var _testTimeoutTimer:Number;
        private static var _testFlag:Boolean = false;

        public function Music()
        {
            return;
        }// end function

        public static function testMusic(param1, param2, param3, param4:Boolean = false)
        {
            var _loc_5:* = null;
            stopTestMusic();
            _testing = true;
            _testSuc = param2;
            _testFail = param3;
            _testFlag = false;
            on = on;
            if (param4)
            {
                _loc_5 = new URLRequest(param1);
            }
            else
            {
                _loc_5 = new URLRequest(Config.sourceURL + param1);
            }
            _testSound = new Sound(_loc_5);
            _testSound.addEventListener(IOErrorEvent.IO_ERROR, handleTestSoundError);
            clearTimeout(_testTimeoutTimer);
            _testTimeoutTimer = setTimeout(testTimeout, 5000);
            var _loc_6:* = new SoundTransform(_maxVolume);
            _testSoundChannel = _testSound.play(0, 1, _loc_6);
            _testSoundChannel.addEventListener(Event.SOUND_COMPLETE, handleTestSoundComplete);
            Config.startLoop(testChannelLoop);
            return;
        }// end function

        private static function handleTestSoundComplete(param1)
        {
            param1.target.removeEventListener(Event.SOUND_COMPLETE, handleTestSoundComplete);
            if (_testFlag)
            {
                stopTestMusic();
            }
            return;
        }// end function

        private static function testChannelLoop(param1)
        {
            if (_testSoundChannel.position > 0)
            {
                clearTestMusic();
                if (_testSuc != null)
                {
                    _testSuc();
                }
            }
            return;
        }// end function

        private static function testTimeout()
        {
            _testFlag = true;
            clearTestMusic();
            if (_testSound != null)
            {
                _testSound.removeEventListener(IOErrorEvent.IO_ERROR, handleTestSoundError);
            }
            if (_testSoundChannel != null)
            {
                _testSoundChannel.removeEventListener(Event.SOUND_COMPLETE, handleTestSoundComplete);
            }
            if (_testFail != null)
            {
                _testFail();
            }
            return;
        }// end function

        private static function handleTestSoundError(param1)
        {
            _testFlag = true;
            clearTestMusic();
            param1.target.removeEventListener(IOErrorEvent.IO_ERROR, handleTestSoundError);
            trace("handleSoundError");
            if (_testFail != null)
            {
                _testFail();
            }
            return;
        }// end function

        private static function clearTestMusic()
        {
            Config.stopLoop(testChannelLoop);
            clearTimeout(_testTimeoutTimer);
            if (_testSound != null)
            {
                _testSound.removeEventListener(IOErrorEvent.IO_ERROR, handleTestSoundError);
            }
            if (_testSoundChannel != null)
            {
                _testSoundChannel.removeEventListener(Event.SOUND_COMPLETE, handleTestSoundComplete);
            }
            return;
        }// end function

        public static function stopTestMusic()
        {
            _testing = false;
            clearTestMusic();
            if (_testSound != null)
            {
                _testSound.removeEventListener(IOErrorEvent.IO_ERROR, handleTestSoundError);
                try
                {
                    _testSound.close();
                }
                catch (e)
                {
                }
                _testSound = null;
            }
            if (_testSoundChannel != null)
            {
                _testSoundChannel.removeEventListener(Event.SOUND_COMPLETE, handleTestSoundComplete);
                _testSoundChannel.stop();
                _testSoundChannel = null;
            }
            on = on;
            return;
        }// end function

        public static function playList(param1:Array, param2 = false, param3 = false)
        {
            if (_oriList != param1 || param2)
            {
                _oriList = param1;
                _list = AdvMath.randomOrder(_oriList);
                _listIndex = 0;
                play(_list[_listIndex], true, param3);
            }
            return;
        }// end function

        public static function play(param1, param2 = false, param3:Boolean = false)
        {
            var url:*;
            var urlReq:URLRequest;
            var sndTrans:SoundTransform;
            var urll:* = param1;
            var list:* = param2;
            var fullUrl:* = param3;
            try
            {
                if (!list)
                {
                    _list = null;
                }
                if (_currSound != null)
                {
                    _currSound.removeEventListener(IOErrorEvent.IO_ERROR, handleSoundError);
                }
                if (_currSoundChannel != null)
                {
                    _currSoundChannel.removeEventListener(Event.SOUND_COMPLETE, handleSoundComplete);
                }
                url = String(urll).toLowerCase();
                if (url != _currURL || _list != null && list && _list.length == 1)
                {
                    stop();
                    _currURL = url;
                    if (fullUrl)
                    {
                        urlReq = new URLRequest(url);
                    }
                    else
                    {
                        urlReq = new URLRequest(Config.sourceURL + url);
                    }
                    sndTrans = new SoundTransform(0);
                    _currSound = new Sound(urlReq);
                    _currSound.addEventListener(IOErrorEvent.IO_ERROR, handleSoundError);
                    if (_list != null)
                    {
                        _currSoundChannel = _currSound.play(0, 1, sndTrans);
                    }
                    else
                    {
                        _currSoundChannel = _currSound.play(0, int.MAX_VALUE, sndTrans);
                    }
                    if (_on && (Config.stageFocus || _back) && !_testing)
                    {
                        TweenLite.to(_currSoundChannel, 2, {volume:_maxVolume});
                    }
                }
                if (_list != null)
                {
                    if (_currSoundChannel != null)
                    {
                        _currSoundChannel.addEventListener(Event.SOUND_COMPLETE, handleSoundComplete);
                    }
                }
                else
                {
                    _oriList = null;
                }
            }
            catch (e)
            {
            }
            return;
        }// end function

        private static function handleSoundComplete(param1)
        {
            param1.target.removeEventListener(Event.SOUND_COMPLETE, handleSoundComplete);
            if (_list != null)
            {
                var _loc_3:* = _listIndex + 1;
                _listIndex = _loc_3;
                if (_listIndex >= _list.length)
                {
                    _listIndex = 0;
                }
                play(_list[_listIndex], true);
            }
            return;
        }// end function

        private static function handleSoundError(param1)
        {
            trace("Music IO_ERROR");
            return;
        }// end function

        private static function onComplete(param1)
        {
            var snd:* = param1;
            try
            {
                snd.close();
            }
            catch (e)
            {
            }
            snd;
            return;
        }// end function

        public static function stop()
        {
            if (_currURL != null)
            {
                _currURL = null;
                TweenLite.to(_currSoundChannel, 2, {volume:0, onComplete:onComplete, onCompleteParams:[_currSound]});
                _currSound = null;
                _currSoundChannel = null;
            }
            return;
        }// end function

        public static function set on(param1:Boolean) : void
        {
            _on = param1;
            if (_on && (Config.stageFocus || _back) && !_testing)
            {
                if (_currSoundChannel != null)
                {
                    TweenLite.to(_currSoundChannel, 2, {volume:_maxVolume});
                }
            }
            else if (_currSoundChannel != null)
            {
                TweenLite.to(_currSoundChannel, 2, {volume:0});
            }
            return;
        }// end function

        public static function get on() : Boolean
        {
            return _on;
        }// end function

        public static function set back(param1:Boolean) : void
        {
            _back = param1;
            on = on;
            return;
        }// end function

        public static function get back() : Boolean
        {
            return _back;
        }// end function

    }
}
