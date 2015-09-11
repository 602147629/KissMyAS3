package haxegame.tutorial._Tutorial
{
    import com.dango_itimi.as3_and_createjs.display.*;
    import com.dango_itimi.as3_and_createjs.event.*;
    import flash.*;
    import flash.display.*;
    import haxegame.save.*;
    import haxegame.se.*;
    import haxegame.tutorial.*;

    public class Scene2 extends Scene
    {
        public var view:View2;
        public static var MOVIE2_FRAME:int;
        public static var MOVIE3_FRAME_JAPANESE:int;
        public static var MOVIE3_FRAME_ENGLISH:int;

        public function Scene2(param1:IDisplayObjectContainer = undefined, param2:MouseEventChecker = undefined) : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            mouseEventChecker = param2;
            layer = param1;
            view = new View2();
            hideMovie(view.movie1);
            hideMovie(view.movie2);
            hideMovie(view.movie3);
            hideLanguage(view.japanese, view.english);
            return;
        }// end function

        public function switchMovie() : void
        {
            var _loc_2:* = null as Record;
            var _loc_1:* = language.getCurrentFrame();
            if (_loc_1 == 3)
            {
                hideMovie(view.movie1);
                showMovie(view.movie2);
            }
            else
            {
                if (_loc_1 == 6)
                {
                }
                if (!(Record.instance == null ? (_loc_2 = new Record(), Record.instance = _loc_2, _loc_2) : (Record.instance)).isJapaneseLanguage())
                {
                    if (_loc_1 == 5)
                    {
                    }
                }
                if (!(Record.instance == null ? (_loc_2 = new Record(), Record.instance = _loc_2, _loc_2) : (Record.instance)).isJapaneseLanguage())
                {
                    hideMovie(view.movie2);
                    showMovie(view.movie3);
                }
            }
            return;
        }// end function

        public function showMovie(param1:MovieClip) : void
        {
            param1.visible = true;
            param1.gotoAndPlay(1);
            return;
        }// end function

        public function show() : void
        {
            layer.addChild(view);
            showMovie(view.movie1);
            hideMovie(view.movie2);
            hideMovie(view.movie3);
            hideLanguage(view.japanese, view.english);
            setLanguage(view.japanese, view.english);
            language.gotoFirstFrame();
            language.mc.visible = true;
            mainFunction = play;
            return;
        }// end function

        public function play() : void
        {
            if (!mouseEventChecker.isDowned())
            {
                return;
            }
            switchMovie();
            if (!language.isLastFrame())
            {
                SoundMixer.playTap();
                language.nextFrame();
            }
            else
            {
                mainFunction = finish;
            }
            return;
        }// end function

        public function hideMovie(param1:MovieClip) : void
        {
            param1.visible = false;
            param1.stop();
            return;
        }// end function

        public function hide() : void
        {
            layer.removeChild(view);
            return;
        }// end function

    }
}
