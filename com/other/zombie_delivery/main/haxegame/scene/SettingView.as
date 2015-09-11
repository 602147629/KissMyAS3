package haxegame.scene
{
    import flash.*;
    import flash.display.*;

    public class SettingView extends Sprite
    {
        public var onButton:MovieClip;
        public var onActive:MovieClip;
        public var offButton:MovieClip;
        public var offActive:MovieClip;
        public var japaneseButton:MovieClip;
        public var japaneseActive:MovieClip;
        public var englishButton:MovieClip;
        public var englishActive:MovieClip;
        public var backButton:MovieClip;

        public function SettingView() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            return;
        }// end function

    }
}
