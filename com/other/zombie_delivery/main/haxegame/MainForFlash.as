package haxegame
{
    import com.dango_itimi.as3.*;
    import flash.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import haxegame.game.*;
    import haxegame.se.*;

    public class MainForFlash extends Main
    {
        public var preloader:Loader;
        public var loaded:Boolean;
        public var current:MovieClip;
        public var assetsLoader:Loader;
        public static var PRELOADER_SWF:String;
        public static var ASSETS_SWF:String;

        public function MainForFlash() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            initialize({});
            return;
        }// end function

        override public function preload() : void
        {
            if (loaded)
            {
                initializeToLoadAssets();
            }
            return;
        }// end function

        public function onLoadComplete(event:Event) : void
        {
            loaded = true;
            return;
        }// end function

        override public function loadAssets() : void
        {
            if (loaded)
            {
                destroyToLoadAssets();
            }
            return;
        }// end function

        override public function initializeMain() : void
        {
            new SoundMixerForFlash();
            initializeMain();
            return;
        }// end function

        override public function initializeChildToLoadAssets() : void
        {
            loaded = false;
            assetsLoader = new Loader();
            assetsLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);
            assetsLoader.load(new URLRequest("view.swf"));
            return;
        }// end function

        override public function initializeChildPreload() : void
        {
            preloader = new Loader();
            preloader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);
            preloader.load(new URLRequest("preloader.swf"));
            return;
        }// end function

        override public function initialize(param1:Object) : void
        {
            current = Lib.current;
            stage = current.stage;
            stage.align = "";
            stage.addEventListener(Event.ENTER_FRAME, run);
            frameRate = stage.frameRate;
            CommonClassRegister.initialize();
            gameClass = GameForFlash;
            initialize({});
            return;
        }// end function

        public static function main() : void
        {
            new MainForFlash();
            return;
        }// end function

    }
}
