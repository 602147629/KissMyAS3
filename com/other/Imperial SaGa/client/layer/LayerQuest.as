package layer
{

    public class LayerQuest extends LayerBase
    {
        public static const MAIN:int = 0;
        public static const BATTLE:int = 1;
        public static const ENCOUNT:int = 2;
        public static const MINI_TITLE:int = 3;
        public static const EVENT:int = 4;
        public static const DIALOG:int = 5;
        public static const ANIMATION:int = 6;
        public static const MAX:int = 7;

        public function LayerQuest()
        {
            super(MAX);
            return;
        }// end function

    }
}
