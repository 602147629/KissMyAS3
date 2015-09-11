package haxegame.tutorial._Tutorial
{
    import com.dango_itimi.as3_and_createjs.*;
    import com.dango_itimi.as3_and_createjs.display.*;
    import com.dango_itimi.as3_and_createjs.event.*;
    import com.dango_itimi.as3_and_createjs.utils.*;
    import flash.*;
    import haxegame.se.*;
    import haxegame.tutorial.*;

    public class Scene1 extends Scene
    {
        public var view:View1;
        public var movieclip:IMovieClipUtil;

        public function Scene1(param1:IDisplayObjectContainer = undefined, param2:MouseEventChecker = undefined) : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            mouseEventChecker = param2;
            layer = param1;
            view = new View1();
            movieclip = CommonClassSet.createMovieClipUtil(view);
            movieclip.mc.stop();
            hideLanguage(view.japanese, view.english);
            return;
        }// end function

        public function start() : void
        {
            if (!movieclip.isLastFrame())
            {
                movieclip.nextFrame();
            }
            else
            {
                initializeToPlay();
            }
            return;
        }// end function

        public function show() : void
        {
            layer.addChild(view);
            movieclip.gotoFirstFrame();
            hideLanguage(view.japanese, view.english);
            setLanguage(view.japanese, view.english);
            language.mc.visible = false;
            mainFunction = start;
            return;
        }// end function

        public function play() : void
        {
            if (!mouseEventChecker.isDowned())
            {
                return;
            }
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

        public function initializeToPlay() : void
        {
            language.gotoFirstFrame();
            language.mc.visible = true;
            mainFunction = play;
            return;
        }// end function

        public function hide() : void
        {
            layer.removeChild(view);
            return;
        }// end function

    }
}
