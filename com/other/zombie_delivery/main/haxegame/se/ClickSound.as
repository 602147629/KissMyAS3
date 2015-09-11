package haxegame.se
{
    import flash.*;
    import flash.media.*;
    import flash.net.*;

    public class ClickSound extends Sound
    {

        public function ClickSound(param1:URLRequest = undefined, param2:SoundLoaderContext = undefined) : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            super(param1, param2);
            return;
        }// end function

    }
}
