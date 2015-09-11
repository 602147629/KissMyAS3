package haxegame.se
{
    import flash.*;
    import haxegame.save.*;
    import haxegame.se._BgmPlayer.*;

    public class BgmPlayer extends Object
    {
        public var record:Record;
        public var latestPlay:LATEST_PLAY;
        public var bgm2Played:Boolean;
        public var bgm1Played:Boolean;
        public static var instance:BgmPlayer;

        public function BgmPlayer() : void
        {
            var _loc_1:* = null as Record;
            if (Boot.skip_constructor)
            {
                return;
            }
            if (Record.instance == null)
            {
                _loc_1 = new Record();
                Record.instance = _loc_1;
                record = _loc_1;
            }
            else
            {
                record = Record.instance;
            }
            latestPlay = LATEST_PLAY.BGM1;
            return;
        }// end function

        public function stop() : void
        {
            if (bgm1Played)
            {
                SoundMixer.stopBgm1();
                bgm1Played = false;
            }
            else if (bgm2Played)
            {
                SoundMixer.stopBgm2();
                bgm2Played = false;
            }
            return;
        }// end function

        public function playFromStop() : void
        {
            var _loc_1:* = latestPlay;
            switch(_loc_1.index) branch count is:<1>[15, 26] default offset is:<11>;
            ;
            play1();
            ;
            play2();
            return;
        }// end function

        public function play2() : void
        {
            if (record.isBgmOn())
            {
                SoundMixer.playBgm2();
                bgm2Played = true;
            }
            latestPlay = LATEST_PLAY.BGM2;
            return;
        }// end function

        public function play1() : void
        {
            if (record.isBgmOn())
            {
                SoundMixer.playBgm1();
                bgm1Played = true;
            }
            latestPlay = LATEST_PLAY.BGM1;
            return;
        }// end function

        public static function getInstance() : BgmPlayer
        {
            var _loc_1:* = null as BgmPlayer;
            if (BgmPlayer.instance == null)
            {
                _loc_1 = new BgmPlayer();
                BgmPlayer.instance = _loc_1;
                return _loc_1;
            }
            else
            {
                return BgmPlayer.instance;
            }
        }// end function

    }
}
